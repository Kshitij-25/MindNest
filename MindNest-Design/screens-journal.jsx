/* MindNest — V2 journal experience */
window.SCREENS = window.SCREENS || {};
const { useState: jUS, useContext: jUC, useRef: jURf } = React;

/* ================= JOURNAL LIST + CALENDAR ================= */
window.SCREENS.tabJournal = function TabJournal({ params }) {
  const ctx = jUC(AppCtx);
  const [view, setView] = jUS(params.view || 'List');
  const [showTypes, setShowTypes] = jUS(false);
  const empty = params.empty;

  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 10px` }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 14 }}>
          <h1 className="t-title1" style={{ flex: 1 }}>Journal</h1>
          <button className="nav-btn" onClick={() => setShowTypes(true)} style={{ background: 'var(--primary)' }}>
            <Icon name="pen" size={19} color="var(--on-primary)" stroke={2} /></button>
        </div>
        {!empty && <Segmented options={['List', 'Calendar']} value={view} onChange={setView} />}
      </div>

      {empty ? (
        <EmptyState icon="feather" title="Your private space"
          body="Journaling is just for you — a quiet place to notice how you feel. Nothing here is ever shared."
          action="Write your first entry" onAction={() => setShowTypes(true)} />
      ) : view === 'List' ? (
        <div style={{ padding: '12px 20px 24px' }}>
          {/* journal types */}
          <div style={{ display: 'flex', gap: 10, overflowX: 'auto', margin: '0 -20px 16px', padding: '0 20px 4px', scrollbarWidth: 'none' }}>
            {JOURNAL_TYPES.map(jt => (
              <button key={jt.id} className="card-flat pressable" onClick={() => ctx.push('journalWrite', { type: jt.id })} style={{ flexShrink: 0, width: 130, border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 13, textAlign: 'left' }}>
                <IconTile icon={jt.icon} color={jt.color} size={38} />
                <div className="t-foot" style={{ fontWeight: 700, marginTop: 9 }}>{jt.name.replace(' Journal', '')}</div>
                <div className="t-cap muted-3" style={{ marginTop: 2, lineHeight: 1.3 }}>{jt.sub}</div>
              </button>
            ))}
          </div>
          <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
            {JOURNALS.map(j => <JournalRow key={j.id} j={j} onClick={() => ctx.push(j.draft ? 'journalWrite' : 'journalEntry', { id: j.id })} />)}
          </div>
        </div>
      ) : (
        <JournalCalendar onPick={() => ctx.push('journalEntry', { id: 'j1' })} />
      )}

      {showTypes && <JournalTypeSheet onClose={() => setShowTypes(false)} onPick={id => { setShowTypes(false); ctx.push('journalWrite', { type: id }); }} />}
    </div>
  );
};

function JournalTypeSheet({ onClose, onPick }) {
  return (
    <>
      <div className="scrim" onClick={onClose} />
      <div className="sheet">
        <div className="sheet-grab" />
        <h2 className="t-title3" style={{ marginBottom: 6 }}>New entry</h2>
        <p className="t-callout muted" style={{ marginBottom: 18 }}>Choose how you’d like to write today.</p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {JOURNAL_TYPES.map(jt => (
            <button key={jt.id} className="card-flat pressable" onClick={() => onPick(jt.id)} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 14, display: 'flex', alignItems: 'center', gap: 13 }}>
              <IconTile icon={jt.icon} color={jt.color} size={44} />
              <div style={{ flex: 1 }}>
                <div className="t-headline" style={{ fontSize: 16 }}>{jt.name}</div>
                <div className="t-foot muted" style={{ marginTop: 2 }}>{jt.sub}</div>
              </div>
              <Icon name="chevR" size={18} color="var(--ink-4)" />
            </button>
          ))}
        </div>
      </div>
    </>
  );
}

function JournalRow({ j, onClick }) {
  return (
    <div className="card-flat pressable" onClick={onClick} style={{ padding: 16, display: 'flex', gap: 14 }}>
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6, paddingTop: 2 }}>
        <MoodFace level={j.mood} size={44} />
        <span className="t-cap muted-3" style={{ fontWeight: 600 }}>{j.date}</span>
      </div>
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <span className="t-headline t-serif" style={{ flex: 1, fontSize: 18, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
            {j.title || (j.draft ? 'Untitled entry' : 'Reflection')}</span>
          {j.draft && <span className="badge badge-pending" style={{ flexShrink: 0 }}>Draft</span>}
        </div>
        <p className="t-callout muted" style={{ marginTop: 5, lineHeight: 1.45, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{j.body}</p>
        <div style={{ display: 'flex', gap: 6, marginTop: 10, flexWrap: 'wrap' }}>
          {j.tags.map(t => <TopicTag key={t} t={t} sm />)}
        </div>
      </div>
    </div>
  );
}

function TopicTag({ t, sm, onClick, active }) {
  const c = topicColor(t);
  return (
    <span onClick={onClick} style={{
      display: 'inline-flex', alignItems: 'center', gap: 5, cursor: onClick ? 'pointer' : 'default',
      height: sm ? 24 : 32, padding: sm ? '0 9px' : '0 13px', borderRadius: 999,
      fontSize: sm ? 12 : 13.5, fontWeight: 600, letterSpacing: '-0.01em',
      background: active ? c : `color-mix(in srgb, ${c} 14%, transparent)`,
      color: active ? '#fff' : c, transition: 'all .2s var(--ease)',
    }}>
      <span style={{ width: sm ? 5 : 6, height: sm ? 5 : 6, borderRadius: '50%', background: active ? '#fff' : c }} />{t}
    </span>
  );
}
window.TopicTag = TopicTag;

function JournalCalendar({ onPick }) {
  // mood by day-of-month (mock)
  const moods = { 26: 4, 28: 2, 29: 3, 30: 5, 31: 4, 24: 4, 22: 3, 19: 4, 17: 5, 14: 2, 12: 4, 9: 3, 5: 4 };
  const days = []; const startPad = 3; // May 2025 starts Thu-ish (mock)
  for (let i = 0; i < startPad; i++) days.push(null);
  for (let d = 1; d <= 31; d++) days.push(d);
  return (
    <div style={{ padding: '14px 20px 24px' }}>
      <div className="card" style={{ padding: 18 }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 16 }}>
          <h3 className="t-title3" style={{ flex: 1 }}>May 2025</h3>
          <button className="nav-btn" style={{ width: 32, height: 32 }}><Icon name="chevL" size={16} stroke={2.2} /></button>
          <button className="nav-btn" style={{ width: 32, height: 32, marginLeft: 6 }}><Icon name="chevR" size={16} stroke={2.2} /></button>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7,1fr)', gap: 4, marginBottom: 8 }}>
          {['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((d, i) => <div key={i} className="t-cap muted-3" style={{ textAlign: 'center', fontWeight: 700 }}>{d}</div>)}
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7,1fr)', gap: 4 }}>
          {days.map((d, i) => {
            if (!d) return <div key={i} />;
            const m = moods[d];
            return (
              <button key={i} onClick={() => m && onPick()} style={{
                aspectRatio: '1', border: 0, borderRadius: 12, cursor: m ? 'pointer' : 'default',
                background: m ? `color-mix(in srgb, ${MOOD_VARS[m - 1]} 22%, var(--surface))` : 'transparent',
                display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 2,
                fontFamily: 'var(--font-ui)', position: 'relative',
              }}>
                <span className="t-foot" style={{ fontWeight: 600, color: m ? 'var(--ink)' : 'var(--ink-4)' }}>{d}</span>
                {m && <span style={{ width: 6, height: 6, borderRadius: '50%', background: MOOD_VARS[m - 1] }} />}
              </button>
            );
          })}
        </div>
      </div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14, justifyContent: 'center', marginTop: 16 }}>
        {[1, 3, 5].map(l => <div key={l} style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
          <span style={{ width: 8, height: 8, borderRadius: '50%', background: MOOD_VARS[l - 1] }} />
          <span className="t-cap muted-3">{MOOD_LABELS[l - 1]}</span></div>)}
      </div>
    </div>
  );
}

/* ================= WRITE JOURNAL ================= */
window.SCREENS.journalWrite = function JournalWrite({ params }) {
  const ctx = jUC(AppCtx);
  const existing = params.id ? journal(params.id) : null;
  const jType = (JOURNAL_TYPES.find(t => t.id === params.type) || JOURNAL_TYPES[0]);
  const PROMPTS = { free: null, guided: 'What’s been on your mind today, and how did it sit with you?', gratitude: 'Name three things — however small — that you’re grateful for today.', reflection: 'Looking back on your day, what would you do the same, and what differently?' };
  const prompt = !existing ? PROMPTS[params.type] : null;
  const [title, setTitle] = jUS(existing?.title || '');
  const [body, setBody] = jUS(existing?.body || '');
  const [mood, setMood] = jUS(existing?.mood || 4);
  const [tags, setTags] = jUS(existing?.tags || []);
  const [showMood, setShowMood] = jUS(false);
  const [saved, setSaved] = jUS(false);
  const ALL_TAGS = ['Calm', 'Gratitude', 'Stress', 'Sleep', 'Growth', 'Therapy', 'Self-care', 'Anxiety'];
  const toggle = t => setTags(s => s.includes(t) ? s.filter(x => x !== t) : [...s, t]);
  const words = body.trim() ? body.trim().split(/\s+/).length : 0;

  if (saved) return (
    <div className="mn-screen" style={{ alignItems: 'center', justifyContent: 'center', padding: 28 }}>
      <SuccessCheck />
      <h1 className="t-title2 anim-up" style={{ marginTop: 24 }}>Entry saved</h1>
      <p className="t-body muted anim-up" style={{ marginTop: 8, textAlign: 'center', maxWidth: 280 }}>That’s {words} words just for you. Well held.</p>
      <button className="btn btn-primary anim-up" style={{ marginTop: 30 }} onClick={ctx.pop}>Done</button>
    </div>
  );

  return (
    <div className="mn-screen" style={{ background: 'var(--paper)' }}>
      <div className="nav" style={{ paddingTop: SAFE_TOP - 6, background: 'var(--paper)' }}>
        <button className="nav-btn" onClick={ctx.pop} style={{ background: 'var(--fill)' }}><Icon name="chevDown" size={22} stroke={2.2} /></button>
        <div style={{ flex: 1, textAlign: 'center' }}>
          <div className="t-cap muted-3" style={{ display: 'flex', alignItems: 'center', gap: 5, justifyContent: 'center' }}>
            <span style={{ width: 6, height: 6, borderRadius: '50%', background: 'var(--green)' }} />Draft autosaved
          </div>
        </div>
        <button className="btn btn-primary btn-sm" onClick={() => setSaved(true)} disabled={!body.trim()}>Save</button>
      </div>

      <div className="mn-scroll" style={{ padding: '10px 24px 20px' }}>
        <div className="t-foot muted-3" style={{ fontWeight: 600, marginBottom: 12, display: 'flex', alignItems: 'center', gap: 7 }}>
          <span className="chip outline" style={{ height: 24, fontSize: 11.5, gap: 5 }}><Icon name={jType.icon} size={12} color={jType.color} stroke={2} />{jType.name.replace(' Journal', '')}</span>
          Today · {new Date().toLocaleDateString('en-GB', { day: 'numeric', month: 'long' })}
        </div>
        {prompt && (
          <div className="card-inset" style={{ padding: '13px 15px', marginBottom: 16, display: 'flex', gap: 10, alignItems: 'flex-start' }}>
            <Icon name="sparkle" size={16} color={jType.color} stroke={2} style={{ marginTop: 2, flexShrink: 0 }} />
            <span className="t-callout t-serif" style={{ color: 'var(--ink-2)', lineHeight: 1.4, fontStyle: 'italic' }}>{prompt}</span>
          </div>
        )}
        <input value={title} onChange={e => setTitle(e.target.value)} placeholder="Give it a title…"
          className="t-serif" style={{ width: '100%', border: 0, outline: 'none', background: 'transparent', fontSize: 26, fontWeight: 500, color: 'var(--ink)', marginBottom: 14, letterSpacing: '-0.01em' }} />
        <textarea value={body} onChange={e => setBody(e.target.value)} autoFocus placeholder="What’s present for you right now? There’s no wrong way to write here."
          rows={9} style={{ width: '100%', border: 0, outline: 'none', background: 'transparent', resize: 'none', fontFamily: 'var(--font-ui)', fontSize: 17, lineHeight: 1.65, color: 'var(--ink-2)', minHeight: 200 }} />
      </div>

      {/* tools */}
      <div style={{ padding: '12px 16px calc(env(safe-area-inset-bottom,0) + 16px)', background: 'var(--paper)', borderTop: '0.5px solid var(--hairline)' }}>
        {tags.length > 0 && <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', marginBottom: 12 }}>{tags.map(t => <TopicTag key={t} t={t} />)}</div>}
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <button onClick={() => setShowMood(true)} className="pressable" style={{ border: 0, background: 'var(--fill)', borderRadius: 14, padding: '8px 12px', display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontFamily: 'var(--font-ui)' }}>
            <MoodFace level={mood} size={30} /><span className="t-foot" style={{ fontWeight: 600, color: 'var(--ink)' }}>{MOOD_LABELS[mood - 1]}</span>
          </button>
          <div style={{ flex: 1 }} />
          <span className="t-foot muted-3">{words} words</span>
        </div>
        <div style={{ display: 'flex', gap: 8, marginTop: 12, overflowX: 'auto', scrollbarWidth: 'none' }}>
          {ALL_TAGS.map(t => <span key={t} onClick={() => toggle(t)} style={{ flexShrink: 0 }}><TopicTag t={t} active={tags.includes(t)} onClick={() => toggle(t)} /></span>)}
        </div>
      </div>

      {showMood && <MoodPickSheet mood={mood} setMood={m => { setMood(m); setShowMood(false); }} onClose={() => setShowMood(false)} />}
    </div>
  );
};

function MoodPickSheet({ mood, setMood, onClose }) {
  return (
    <>
      <div className="scrim" onClick={onClose} />
      <div className="sheet">
        <div className="sheet-grab" />
        <h2 className="t-title3" style={{ marginBottom: 6 }}>How are you feeling?</h2>
        <p className="t-callout muted" style={{ marginBottom: 20 }}>Tag this entry with a mood.</p>
        <div style={{ display: 'flex', justifyContent: 'space-between', gap: 8 }}>
          {[1, 2, 3, 4, 5].map(l => (
            <button key={l} onClick={() => setMood(l)} style={{ border: 0, background: 'none', cursor: 'pointer', padding: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 8,
              transform: mood === l ? 'scale(1.06)' : 'scale(1)', opacity: mood === l ? 1 : 0.55, transition: 'all .2s var(--ease-spring)' }}>
              <MoodFace level={l} size={52} /><span className="t-cap muted-3" style={{ fontWeight: 600 }}>{MOOD_LABELS[l - 1]}</span>
            </button>
          ))}
        </div>
      </div>
    </>
  );
}

/* ================= JOURNAL ENTRY + AI ANALYSIS ================= */
window.SCREENS.journalEntry = function JournalEntry({ params }) {
  const ctx = jUC(AppCtx);
  const j = journal(params.id) || JOURNALS[0];
  const a = analysis(j.id);
  const words = j.body.trim() ? j.body.trim().split(/\s+/).length : 0;
  return (
    <div className="mn-screen" style={{ background: 'var(--paper)' }}>
      <NavHeader onBack={ctx.pop} transparent
        right={<button className="nav-btn" onClick={() => ctx.push('journalWrite', { id: j.id })}><Icon name="pen" size={18} stroke={1.9} /></button>} />
      <div className="mn-scroll" style={{ padding: '8px 26px 40px' }}>
        <div className="anim-up" style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 18 }}>
          <MoodFace level={j.mood} size={52} />
          <div style={{ flex: 1 }}>
            <div className="t-headline">{MOOD_LABELS[j.mood - 1]}</div>
            <div className="t-foot muted-3">{j.day} · {j.date} · {j.time}</div>
          </div>
        </div>
        {/* meta strip: type · words */}
        <div className="anim-up" style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 16, flexWrap: 'wrap' }}>
          <span className="chip outline" style={{ height: 28, fontSize: 12.5, gap: 5 }}><Icon name="feather" size={14} color="var(--primary)" stroke={2} />{a.type}</span>
          <span className="chip outline" style={{ height: 28, fontSize: 12.5 }}>{words} words</span>
          {j.tags.map(t => <TopicTag key={t} t={t} sm />)}
        </div>

        <h1 className="t-serif anim-up" style={{ fontSize: 30, lineHeight: 1.15, marginBottom: 18 }}>{j.title || 'Reflection'}</h1>
        <p className="t-body anim-up" style={{ fontSize: 17, lineHeight: 1.7, color: 'var(--ink-2)', whiteSpace: 'pre-wrap' }}>{j.body}</p>

        {/* ===== AI ANALYSIS ===== */}
        <div className="hr" style={{ margin: '26px 0 18px' }} />
        <div className="anim-up" style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16 }}>
          <IconTile icon="sparkle" color="var(--primary)" size={40} />
          <div style={{ flex: 1 }}>
            <div className="t-headline" style={{ fontSize: 16 }}>AI analysis</div>
          </div>
          <AnalysisStatus status={a.status} />
        </div>

        {a.status === 'pending' ? (
          <div className="card" style={{ padding: 20, textAlign: 'center' }}>
            <div style={{ display: 'inline-flex', gap: 6, marginBottom: 12 }}>
              {[0, 1, 2].map(i => <span key={i} style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--ink-4)', animation: `typing 1.2s ${i * 0.15}s infinite` }} />)}
            </div>
            <p className="t-callout muted" style={{ lineHeight: 1.5 }}>We’re reading this entry. Your summary, emotions and suggestions will appear here shortly.</p>
          </div>
        ) : a.status === 'failed' ? (
          <div className="card" style={{ padding: 20, textAlign: 'center' }}>
            <Icon name="info" size={28} color="var(--clay)" stroke={1.8} />
            <p className="t-callout muted" style={{ marginTop: 8, lineHeight: 1.5 }}>Analysis couldn’t complete. Pull to retry when you’re back online.</p>
            <button className="btn btn-tonal btn-sm" style={{ width: 'auto', margin: '14px auto 0', padding: '0 22px' }}>Retry</button>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
            {/* summary */}
            <div className="card" style={{ padding: 18 }}>
              <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 8 }}>Summary</div>
              <p className="t-callout" style={{ color: 'var(--ink-2)', lineHeight: 1.55 }}>{a.summary}</p>
            </div>

            {/* emotion analysis */}
            {a.emotions.length > 0 && (
              <div className="card" style={{ padding: 18 }}>
                <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 8 }}>Emotion analysis</div>
                {a.emotions.map(e => <EmotionBar key={e.k} label={e.k} value={e.v} color={e.c} />)}
              </div>
            )}

            {/* topics + themes */}
            <div className="card" style={{ padding: 18 }}>
              <AnalysisChips label="Topics" items={a.topics} color="var(--topic-1)" />
              <AnalysisChips label="Themes" items={a.themes} color="var(--topic-4)" />
            </div>

            {/* stressors / wins / concerns */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              {a.wins.length > 0 && <AnalysisList icon="checkCircle" color="var(--green)" label="Wins" items={a.wins} />}
              {a.stressors.length > 0 && <AnalysisList icon="pulse" color="var(--topic-2)" label="Stressors" items={a.stressors} />}
              {a.concerns.length > 0 && <AnalysisList icon="info" color="var(--clay)" label="Concerns" items={a.concerns} />}
            </div>

            {/* suggestions */}
            {a.suggestions.length > 0 && (
              <div className="card" style={{ padding: 18, background: 'var(--primary-tint)' }}>
                <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 10 }}>Suggestions</div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
                  {a.suggestions.map(s => (
                    <div key={s} style={{ display: 'flex', alignItems: 'flex-start', gap: 10 }}>
                      <Icon name="sparkle" size={17} color="var(--primary)" stroke={2} style={{ marginTop: 1, flexShrink: 0 }} />
                      <span className="t-callout" style={{ color: 'var(--ink-2)', lineHeight: 1.45 }}>{s}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}

        <div className="hr" style={{ margin: '24px 0 16px' }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, color: 'var(--ink-3)' }}>
          <Icon name="lock" size={15} stroke={2} /><span className="t-foot">Private · analysis runs just for you</span>
        </div>
      </div>
    </div>
  );
};

function AnalysisChips({ label, items, color }) {
  if (!items || !items.length) return null;
  return (
    <div style={{ marginBottom: 10 }}>
      <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 8 }}>{label}</div>
      <div style={{ display: 'flex', flexWrap: 'wrap', gap: 7 }}>
        {items.map(t => <span key={t} className="chip" style={{ height: 28, fontSize: 12.5, background: `color-mix(in srgb, ${color} 14%, transparent)`, color }}>{t}</span>)}
      </div>
    </div>
  );
}
function AnalysisList({ icon, color, label, items }) {
  return (
    <div className="card-flat" style={{ padding: 16 }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 10 }}>
        <Icon name={icon} size={17} color={color} stroke={2} />
        <span className="t-cap" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', color: 'var(--ink-3)' }}>{label}</span>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
        {items.map(it => (
          <div key={it} style={{ display: 'flex', alignItems: 'flex-start', gap: 9 }}>
            <span style={{ width: 6, height: 6, borderRadius: '50%', background: color, marginTop: 7, flexShrink: 0 }} />
            <span className="t-callout" style={{ color: 'var(--ink-2)', lineHeight: 1.45 }}>{it}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
