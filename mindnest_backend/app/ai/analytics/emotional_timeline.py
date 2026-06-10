"""Emotional timeline — *why* emotion changed over a window.

Pure compute: given dimension trends (drift over the window) and the recurring
topics/factors the user mentioned, attribute the notable drifts to likely
drivers. e.g. "Stress rose 18 points over 30 days; recurring themes: Work,
Sleep." A heuristic association (frequency), not a causal claim.
"""
from __future__ import annotations

from app.core.dimensions import POSITIVE_DIMENSIONS

_DRIFT_MIN = 6.0


def build(trends: list[dict], drivers: list[dict], days: int) -> dict:
    """``trends`` = ``insights_service.trends`` items; ``drivers`` = ranked
    ``{name, count, kind}`` topics/factors over the window."""
    movers = [t for t in trends if abs(t.get("drift", 0.0)) >= _DRIFT_MIN]
    movers.sort(key=lambda t: abs(t["drift"]), reverse=True)
    driver_names = [d["name"] for d in drivers[:3]]

    changes = []
    for t in movers[:4]:
        dim = t["dimension"]
        drift = t["drift"]
        positive_dim = dim in POSITIVE_DIMENSIONS
        rising = drift > 0
        improving = (rising and positive_dim) or (not rising and not positive_dim)
        verb = "rose" if rising else "eased"
        tail = (
            f" recurring themes: {', '.join(driver_names)}."
            if driver_names and not improving else
            (" a positive shift." if improving else ".")
        )
        note = f"{t['label']} {verb} {abs(drift):.0f} points over {days} days —{tail}"
        changes.append({
            "dimension": dim,
            "label": t["label"],
            "drift": drift,
            "direction": t.get("direction", "stable"),
            "current": t.get("current", 0.0),
            "improving": improving,
            "drivers": [] if improving else driver_names,
            "note": note,
        })

    return {"days": days, "changes": changes, "drivers": drivers[:6]}
