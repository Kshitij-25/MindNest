"""Mood profile finalization, persistence and retrieval.

At assessment completion this builds the durable ``MoodProfile`` snapshot,
writes normalized ``EmotionalHistory`` rows (for fast trends) and, if the
embedding model is available, stores a vector of the free-text for the
similarity memory. The natural-language summary comes from the local LLM
(Ollama) when reachable, otherwise a deterministic template.
"""
from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import select

from app.ai.embeddings import cosine_similarity, embedder
from app.ai.llm import ollama
from app.core.dimensions import (
    DIMENSION_LABELS,
    DIMENSIONS,
    POSITIVE_DIMENSIONS,
    is_high,
)
from app.core.utils import utcnow
from app.models import (
    Answer,
    Assessment,
    AssessmentStatus,
    Embedding,
    EmotionalHistory,
    MoodProfile,
    User,
)
from app.services import assessment_service


# ---- completion --------------------------------------------------------------


async def complete_assessment(db, user: User, assessment_id: str) -> dict:
    assessment = await assessment_service.get_owned_assessment(db, user, assessment_id)

    # Idempotent: if already completed, return the existing profile.
    existing = await _profile_for_assessment(db, assessment_id)
    if existing is not None:
        return profile_to_summary(existing)

    answers = await assessment_service._load_answers(db, assessment_id)
    if not answers:
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST, "Cannot complete an empty assessment"
        )

    state = assessment_service.compute_state(answers)
    corpus = _free_text_corpus(answers)

    summary, source = await _generate_summary(state, corpus)

    profile = MoodProfile(
        user_id=user.id,
        assessment_id=assessment_id,
        overall_mood=state["overall_mood"],
        valence=state["valence"],
        arousal=state["arousal"],
        confidence=state["overall_confidence"],
        dimensions=state["scores"],
        dimension_confidence=state["confidence"],
        derived=state["derived"],
        top_emotions=state["top_emotions"],
        contradictions=state["contradictions"],
        summary=summary,
        summary_source=source,
    )
    db.add(profile)

    for dim in DIMENSIONS:
        db.add(EmotionalHistory(
            user_id=user.id,
            assessment_id=assessment_id,
            dimension=dim,
            score=state["scores"][dim],
            confidence=state["confidence"].get(dim, 0.0),
        ))

    if corpus:
        vec = embedder.embed(corpus)
        if vec:
            db.add(Embedding(
                user_id=user.id,
                assessment_id=assessment_id,
                source="assessment",
                text=corpus[:2000],
                model=embedder._model.__class__.__name__ if embedder._model else "",
                dim=len(vec),
                vector=vec,
            ))

    assessment.status = AssessmentStatus.COMPLETED
    assessment.completed_at = utcnow()
    await db.commit()
    await db.refresh(profile)
    return profile_to_summary(profile)


def _free_text_corpus(answers: list[Answer]) -> str:
    parts = []
    for a in answers:
        raw = a.raw_value or {}
        if raw.get("text"):
            parts.append(raw["text"].strip())
    return "\n".join(parts).strip()


# ---- retrieval ---------------------------------------------------------------


async def _profile_for_assessment(db, assessment_id: str) -> MoodProfile | None:
    res = await db.execute(
        select(MoodProfile).where(MoodProfile.assessment_id == assessment_id)
    )
    return res.scalar_one_or_none()


async def latest_profile(db, user: User) -> MoodProfile:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(1)
    )
    profile = res.scalar_one_or_none()
    if profile is None:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, "No completed assessments yet"
        )
    return profile


async def summary_for_assessment(db, user: User, assessment_id: str) -> dict:
    """The mood profile for one owned, completed assessment (404 otherwise)."""
    await assessment_service.get_owned_assessment(db, user, assessment_id)
    profile = await _profile_for_assessment(db, assessment_id)
    if profile is None:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, "No result for this assessment yet"
        )
    return profile_to_summary(profile)


async def history(db, user: User, limit: int = 30) -> list[MoodProfile]:
    res = await db.execute(
        select(MoodProfile)
        .where(MoodProfile.user_id == user.id)
        .order_by(MoodProfile.created_at.desc())
        .limit(limit)
    )
    return list(res.scalars().all())


async def find_similar(db, user: User, query_vec: list[float], exclude_assessment: str | None = None, top_k: int = 3) -> list[dict]:
    """Cosine-similarity search over stored assessment embeddings."""
    if not query_vec:
        return []
    res = await db.execute(
        select(Embedding).where(Embedding.user_id == user.id)
    )
    scored = []
    for emb in res.scalars().all():
        if exclude_assessment and emb.assessment_id == exclude_assessment:
            continue
        sim = cosine_similarity(query_vec, emb.vector or [])
        if sim > 0:
            scored.append({"assessment_id": emb.assessment_id,
                           "created_at": emb.created_at, "similarity": round(sim, 3)})
    scored.sort(key=lambda d: d["similarity"], reverse=True)
    return scored[:top_k]


# ---- serialization -----------------------------------------------------------


def profile_to_summary(p: MoodProfile) -> dict:
    dims = []
    for d in DIMENSIONS:
        score = (p.dimensions or {}).get(d, 0.0)
        dims.append({
            "dimension": d,
            "label": DIMENSION_LABELS[d],
            "score": score,
            "confidence": (p.dimension_confidence or {}).get(d, 0.0),
            "elevated": is_high(d, score),
        })
    return {
        "assessment_id": p.assessment_id,
        "created_at": p.created_at,
        "overall_mood": p.overall_mood,
        "valence": p.valence,
        "arousal": p.arousal,
        "confidence": p.confidence,
        "summary": p.summary,
        "summary_source": p.summary_source,
        "dimensions": dims,
        "top_emotions": p.top_emotions or [],
        "derived": p.derived or {},
        "contradictions": p.contradictions or [],
    }


# ---- summary generation ------------------------------------------------------


async def _generate_summary(state: dict, corpus: str) -> tuple[str, str]:
    llm = await _llm_summary(state, corpus)
    if llm:
        return llm, "llm"
    return _template_summary(state), "template"


def _elevated_labels(state: dict) -> list[str]:
    """Human phrases for the notable signals.

    A *positive* dimension is notable when it's LOW, so we say e.g.
    "low motivation" rather than just "motivation".
    """
    out = []
    for t in state["top_emotions"]:
        if not t["elevated"]:
            continue
        label = t["label"].lower()
        if t["dimension"] in POSITIVE_DIMENSIONS:
            out.append(f"low {label}")
        else:
            out.append(label)
    return out


def _template_summary(state: dict) -> str:
    mood = state["overall_mood"]
    elevated = _elevated_labels(state)
    derived = state["derived"]
    parts = [f"Overall you seem **{mood.lower()}**."]

    if elevated:
        if len(elevated) == 1:
            parts.append(f"The strongest signal is {elevated[0]}.")
        else:
            parts.append(
                "The strongest signals are "
                + ", ".join(elevated[:-1]) + f" and {elevated[-1]}."
            )
    else:
        parts.append("No single emotion stands out strongly right now.")

    if derived["burnout_risk"] >= 55:
        parts.append(
            f"Burnout risk looks {derived['burnout_label']} — worth protecting "
            "your rest and easing your load where you can."
        )

    if state["contradictions"]:
        parts.append(
            "Some of your answers pointed in different directions, so this read "
            "is a little tentative — that mix can be normal during an unsettled week."
        )

    conf = state["overall_confidence"]
    if conf < 0.5:
        parts.append("Confidence in this snapshot is modest; another check-in will sharpen it.")

    parts.append(
        "Be gentle with yourself. If difficult feelings persist or intensify, "
        "consider reaching out to someone you trust or a professional."
    )
    return " ".join(parts)


def _join_phrases(items: list[str]) -> str:
    if not items:
        return "no single emotion standing out strongly"
    if len(items) == 1:
        return items[0]
    return ", ".join(items[:-1]) + f" and {items[-1]}"


async def _llm_summary(state: dict, corpus: str) -> str | None:
    """Ask the local LLM for a prose reflection.

    The prompt deliberately avoids dumping the numeric score table — small
    local models tend to *parrot* structured input back as a list. Feeding
    the salient feelings as prose and demanding sentences yields far better
    output on models like TinyLlama / Phi-3.
    """
    if not ollama.enabled:
        return None

    feelings = _join_phrases(_elevated_labels(state))
    burnout = state["derived"]
    burnout_clause = (
        f" Their burnout risk looks {burnout['burnout_label']}."
        if burnout["burnout_risk"] >= 55 else ""
    )
    tension = (
        " Some of their answers pulled in different directions, so the picture "
        "is a little mixed." if state["contradictions"] else ""
    )
    journal = f' In their own words: "{corpus[:400]}".' if corpus else ""

    system = (
        "You are MindNest, a warm wellbeing companion. You are not a clinician "
        "and never diagnose. Reply with ONLY 3 to 4 supportive sentences written "
        "directly to the person as 'you'. No lists, no headings, no numbers and "
        "no preamble. Do not begin with a greeting or salutation and do not "
        "sign off. Acknowledge their main feelings, gently note any mixed "
        "signals, and offer one small practical suggestion. Keep a calm, "
        "non-alarming tone."
    )
    prompt = (
        f"A person just did an emotional check-in. Overall they seem "
        f"{state['overall_mood'].lower()}. Their most notable feelings are "
        f"{feelings}.{burnout_clause}{tension}{journal}\n\n"
        "Write your short supportive reflection to them now:"
    )
    return await ollama.generate(prompt, system=system)
