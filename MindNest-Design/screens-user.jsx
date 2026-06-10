/* MindNest — user home, mood tracking */
window.SCREENS = window.SCREENS || {};
const { useState: uUS, useContext: uUC, useEffect: uUE } = React;

/* shared: appointment card */
function AppointmentCard({ appt, onClick }) {
  const t = therapist(appt.tid);
  return (
    <div className="card pressable" onClick={onClick} style={{ padding: 0, overflow: 'hidden' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 13, padding: 16 }}>
        <Avatar name={t.name} size={52} photo />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div className="t-headline" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{t.name}</div>
          <div className="t-callout muted" style={{ marginTop: 2 }}>{appt.type} · {appt.mins} min</div>
        </div>
        <span className="badge badge-accept">Accepted</span>
      </div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '12px 16px', background: 'var(--primary-tint)', color: 'var(--primary)' }}>
        <Icon name="calendar" size={18} stroke={2} />
        <span className="t-headline" style={{ color: 'var(--primary)' }}>{appt.date}</span>
        <span style={{ width: 3, height: 3, borderRadius: '50%', background: 'currentColor', opacity: 0.5 }} />
        <span className="t-headline" style={{ color: 'var(--primary)' }}>{appt.time}</span>
        <div style={{ flex: 1 }} />
        <Icon name="video" size={18} stroke={2} />
      </div>
    </div>
  );
}
window.AppointmentCard = AppointmentCard;

/* shared: therapist mini card (horizontal) */
function TherapistMini({ t, onClick }) {
  return (
    <div className="card-flat pressable" onClick={onClick} style={{ width: 168, flexShrink: 0, padding: 14 }}>
      <div style={{ position: 'relative', width: '100%', height: 96, borderRadius: 16, overflow: 'hidden', marginBottom: 12 }}>
        <PhotoPlaceholder name={t.name} />
        {t.verified && <span style={{ position: 'absolute', top: 8, right: 8, background: 'var(--surface)', borderRadius: 999, padding: 3, display: 'flex', boxShadow: 'var(--sh-sm)' }}><Verified size={15} /></span>}
      </div>
      <div className="t-headline" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{t.name}</div>
      <div className="t-foot muted" style={{ marginTop: 2, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{t.spec}</div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 8 }}>
        <Stars value={t.rating} size={12} />
        <span className="t-foot muted-3">· £{t.price}</span>
      </div>
    </div>
  );
}
window.TherapistMini = TherapistMini;

/* striped photo placeholder */
function PhotoPlaceholder({ name = '', label, style }) {
  const hue = avaHue(name);
  return (
    <div style={{
      position: 'absolute', inset: 0,
      background: `repeating-linear-gradient(135deg, ${hue}22, ${hue}22 8px, ${hue}33 8px, ${hue}33 16px)`,
      display: 'flex', alignItems: 'center', justifyContent: 'center', ...style,
    }}>
      <div style={{ width: '38%', aspectRatio: '1', borderRadius: '50%', background: `${hue}55`, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <Icon name="user" size={26} color={hue} stroke={1.6} />
      </div>
      {label && <span style={{ position: 'absolute', bottom: 8, fontSize: 9.5, fontFamily: 'ui-monospace, monospace', color: hue, opacity: 0.8 }}>{label}</span>}
    </div>
  );
}
window.PhotoPlaceholder = PhotoPlaceholder;

/* mood strip (7-day) */
function MoodStrip({ data }) {
  return (
    <div style={{ display: 'flex', gap: 6, alignItems: 'flex-end' }}>
      {data.map((d, i) => (
        <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6 }}>
          <div style={{ width: '100%', height: 8 + d.level * 9, borderRadius: 999, background: MOOD_VARS[d.level - 1],
            opacity: i === data.length - 1 ? 1 : 0.85, transition: 'height .4s var(--ease-out)' }} />
          <span className="t-cap muted-3" style={{ fontWeight: 600 }}>{d.day[0]}</span>
        </div>
      ))}
    </div>
  );
}
window.MoodStrip = MoodStrip;

/* ================= HOME — WELLNESS DASHBOARD ================= */
window.SCREENS.tabHome = function TabHome() {
  const ctx = uUC(AppCtx);
  const w = WELLNESS;
  const rec0 = RECS[0];
  const j0 = JOURNALS[0];
  const find0 = FINDINGS[0];
  const topEmotions = EMOTIONS.slice(0, 4);
  return (
    <div style={{ padding: `${SAFE_TOP}px 20px 24px` }}>
      {/* greeting */}
      <div className="anim-up" style={{ display: 'flex', alignItems: 'center', marginBottom: 20 }}>
        <div style={{ flex: 1 }}>
          <div className="t-foot muted-3" style={{ fontWeight: 600 }}>Good morning</div>
          <h1 className="t-serif" style={{ fontSize: 30, marginTop: 2 }}>Hello, Maya</h1>
        </div>
        <button className="nav-btn" style={{ position: 'relative' }} onClick={() => ctx.push('notifications')}>
          <Icon name="bell" size={21} stroke={1.9} />
          <span style={{ position: 'absolute', top: 9, right: 10, width: 8, height: 8, borderRadius: '50%', background: 'var(--clay)', border: '2px solid var(--bg)' }} />
        </button>
      </div>

      {/* WELLNESS SCORE — hero */}
      <button className="card pressable anim-up" onClick={() => ctx.push('wellnessScore')} style={{
        width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)',
        padding: 20, marginBottom: 16, background: 'linear-gradient(135deg, var(--primary-tint), var(--surface) 70%)' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 18 }}>
          <RadialScore value={w.score} size={108} stroke={10} sub="of 100" />
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="t-cap muted-3" style={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>Wellness score</div>
            <div className="t-title2" style={{ marginTop: 3 }}>{w.band}</div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 10, flexWrap: 'wrap' }}>
              <TrendPill dir={w.trend}>+{w.weeklyChange} this week</TrendPill>
              <Confidence value={w.confidence} size="sm" />
            </div>
          </div>
        </div>
        <div className="hr" style={{ margin: '16px 0 12px' }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{ flex: 1 }}><Spark data={w.spark} /></div>
          <span className="t-foot" style={{ color: 'var(--primary)', fontWeight: 700, display: 'flex', alignItems: 'center', gap: 3 }}>Breakdown <Icon name="chevR" size={16} color="var(--primary)" /></span>
        </div>
      </button>

      {/* TODAY'S MOOD + STREAK */}
      <div className="card anim-up" style={{ padding: 18, marginBottom: 16 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <MoodFace level={4} size={56} />
          <div style={{ flex: 1 }}>
            <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Today’s mood</div>
            <div className="t-title3" style={{ marginTop: 3 }}>Feeling good</div>
          </div>
          <button className="btn btn-tonal btn-sm" onClick={() => ctx.push('moodTrack')}>Check in</button>
        </div>
        <div className="hr" style={{ margin: '16px 0 14px' }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{ width: 32, height: 32, borderRadius: 10, background: 'color-mix(in srgb, var(--streak) 16%, transparent)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
            <Icon name="flame" size={18} color="var(--streak)" stroke={1.9} /></div>
          <span className="t-callout" style={{ flex: 1, color: 'var(--ink-2)' }}><b style={{ color: 'var(--ink)' }}>12-day</b> check-in streak</span>
          <button onClick={() => ctx.push('moodInsights')} style={linkBtn}>Trends</button>
        </div>
      </div>

      {/* EMOTIONAL PROFILE */}
      <div className="anim-up" style={{ marginBottom: 16 }}>
        <SectionHead title="Emotional profile" action="View all" onAction={() => ctx.push('emotionalProfile')} />
        <button className="card pressable" onClick={() => ctx.push('emotionalProfile')} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 18 }}>
          {topEmotions.map(e => <EmotionBar key={e.key} label={e.key} value={e.value} color={e.color} trend={e.trend} />)}
        </button>
      </div>

      {/* LATEST RECOMMENDATION */}
      <div className="anim-up" style={{ marginBottom: 16 }}>
        <SectionHead title="Recommended for you" action="See all" onAction={() => ctx.push('recommendations')} />
        <button className="card pressable" onClick={() => ctx.push('recommendations')} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16 }}>
          <div style={{ display: 'flex', gap: 13 }}>
            <IconTile icon={rec0.icon} color={rec0.color} size={46} />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div className="t-cap" style={{ color: rec0.color, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{rec0.kind}</div>
              <div className="t-headline" style={{ marginTop: 3 }}>{rec0.title}</div>
              <div className="t-foot muted" style={{ marginTop: 5, lineHeight: 1.4 }}>{rec0.reason}</div>
            </div>
          </div>
        </button>
      </div>

      {/* RECENT JOURNAL */}
      <div className="anim-up" style={{ marginBottom: 16 }}>
        <SectionHead title="Recent journal" action="All entries" onAction={() => ctx.goTab('journal')} />
        <button className="card-flat pressable" onClick={() => ctx.push('journalEntry', { id: j0.id })} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16, display: 'flex', gap: 14 }}>
          <MoodFace level={j0.mood} size={44} />
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="t-headline t-serif" style={{ fontSize: 18 }}>{j0.title}</div>
            <p className="t-foot muted" style={{ marginTop: 4, lineHeight: 1.45, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{j0.body}</p>
            <div style={{ marginTop: 8 }}><AnalysisStatus status="ready" /></div>
          </div>
        </button>
      </div>

      {/* WEEKLY TREND */}
      <div className="card anim-up" style={{ padding: 18, marginBottom: 16 }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 14 }}>
          <span className="t-headline" style={{ flex: 1 }}>Weekly trend</span>
          <TrendPill dir="up">Mood +8%</TrendPill>
        </div>
        <MoodStrip data={MOOD_HISTORY} />
      </div>

      {/* LATEST INSIGHT */}
      <button className="card pressable anim-up" onClick={() => ctx.push('discover')} style={{
        width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 18,
        display: 'flex', alignItems: 'center', gap: 14, background: 'linear-gradient(120deg, color-mix(in srgb, var(--topic-4) 12%, var(--surface)), var(--surface) 75%)' }}>
        <IconTile icon="sparkle" color="var(--topic-4)" size={46} />
        <div style={{ flex: 1 }}>
          <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Latest insight · {find0.confidence}% confidence</div>
          <div className="t-headline" style={{ marginTop: 4, lineHeight: 1.35 }}>{find0.text}</div>
        </div>
        <Icon name="chevR" size={20} color="var(--ink-4)" />
      </button>
    </div>
  );
};

/* ================= MOOD TRACK ================= */
window.SCREENS.moodTrack = function MoodTrack() {
  const ctx = uUC(AppCtx);
  const [mood, setMood] = uUS(4);
  const [factors, setFactors] = uUS([]);
  const [note, setNote] = uUS('');
  const [saved, setSaved] = uUS(false);
  const FACTORS = ['Work', 'Sleep', 'Family', 'Health', 'Money', 'Relationships', 'Exercise', 'Solitude'];
  const toggle = f => setFactors(s => s.includes(f) ? s.filter(x => x !== f) : [...s, f]);

  if (saved) return (
    <div className="mn-screen" style={{ alignItems: 'center', justifyContent: 'center', padding: 28 }}>
      <SuccessCheck />
      <h1 className="t-title2 anim-up" style={{ marginTop: 24 }}>Mood logged</h1>
      <p className="t-body muted anim-up" style={{ marginTop: 8, textAlign: 'center', maxWidth: 280 }}>
        Thanks for checking in. Small moments of awareness add up.
      </p>
      <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', gap: 10, marginTop: 32, width: '100%' }}>
        <button className="btn btn-primary" onClick={() => ctx.push('moodHistory')}>View mood history</button>
        <button className="btn btn-ghost" onClick={ctx.pop}>Back to home</button>
      </div>
    </div>
  );

  return (
    <div className="mn-screen">
      <NavHeader title="Track mood" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 24px 30px' }}>
        <div style={{ display: 'flex', justifyContent: 'center', margin: '10px 0 18px' }}>
          <div key={mood} style={{ animation: 'popIn .4s var(--ease-spring) both' }}><MoodFace level={mood} size={120} /></div>
        </div>
        <div className="t-title2" style={{ textAlign: 'center', color: MOOD_VARS[mood - 1], marginBottom: 22 }}>{MOOD_LABELS[mood - 1]}</div>
        <div style={{ display: 'flex', justifyContent: 'space-between', gap: 8, marginBottom: 30 }}>
          {[1, 2, 3, 4, 5].map(l => (
            <button key={l} onClick={() => setMood(l)} style={{ border: 0, background: 'none', cursor: 'pointer', padding: 0, borderRadius: '50%',
              transform: mood === l ? 'scale(1.1)' : 'scale(0.92)', opacity: mood === l ? 1 : 0.45, transition: 'all .25s var(--ease-spring)',
              boxShadow: mood === l ? '0 0 0 3px var(--surface),0 0 0 5px var(--primary-ring)' : 'none' }}>
              <MoodFace level={l} size={48} /></button>
          ))}
        </div>
        <h3 className="t-headline" style={{ marginBottom: 12 }}>What’s shaping it?</h3>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 9, marginBottom: 26 }}>
          {FACTORS.map(f => <button key={f} onClick={() => toggle(f)} className={'chip' + (factors.includes(f) ? ' active' : ' outline')}>{f}</button>)}
        </div>
        <h3 className="t-headline" style={{ marginBottom: 12 }}>Add a note <span className="t-callout muted-3">(optional)</span></h3>
        <textarea value={note} onChange={e => setNote(e.target.value)} placeholder="What’s on your mind today?" rows={3}
          className="field" style={{ resize: 'none', minHeight: 90, lineHeight: 1.5, fontFamily: 'var(--font-ui)' }} />
      </div>
      <div style={{ padding: '12px 24px calc(env(safe-area-inset-bottom,0) + 24px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)' }}>
        <button className="btn btn-primary" onClick={() => setSaved(true)}>Save check-in</button>
      </div>
    </div>
  );
};

function SuccessCheck() {
  return (
    <div style={{ position: 'relative', width: 96, height: 96 }}>
      <div style={{ position: 'absolute', inset: 0, borderRadius: '50%', background: 'var(--primary-ring)', animation: 'ripple 1.8s var(--ease-out) infinite' }} />
      <div style={{ position: 'absolute', inset: 0, borderRadius: '50%', background: 'var(--primary)', display: 'flex', alignItems: 'center', justifyContent: 'center', animation: 'popIn .5s var(--ease-spring) both' }}>
        <svg width="46" height="46" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round">
          <path d="M4 12.5 9.5 18 20 6.5" style={{ strokeDasharray: 30, strokeDashoffset: 30, animation: 'drawCheck .5s .25s var(--ease-out) forwards' }} />
        </svg>
      </div>
    </div>
  );
}
window.SuccessCheck = SuccessCheck;

/* ================= MOOD HISTORY ================= */
window.SCREENS.moodHistory = function MoodHistory() {
  const ctx = uUC(AppCtx);
  const month = [4, 3, 4, 5, 4, 2, 3, 4, 4, 5, 5, 4, 3, 4, 4, 5, 4, 3, 2, 4, 5, 4, 4, 5, 3, 4, 5, 4];
  const avg = (month.reduce((a, b) => a + b, 0) / month.length);
  const entries = [
    { day: 'Today', time: '9:24 AM', level: 4, note: 'Slept well and had a calm morning walk.', factors: ['Sleep', 'Exercise'] },
    { day: 'Yesterday', time: '8:10 PM', level: 5, note: 'Great session with Dr. Okafor.', factors: ['Therapy'] },
    { day: 'Wed', time: '7:45 AM', level: 2, note: 'Deadline stress got to me.', factors: ['Work'] },
  ];
  return (
    <div className="mn-screen">
      <NavHeader title="Mood history" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <div className="card anim-up" style={{ padding: 20, marginBottom: 22 }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 18 }}>
            <div>
              <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>30-day average</div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginTop: 6 }}>
                <MoodFace level={Math.round(avg)} size={40} />
                <span className="t-title1">{MOOD_LABELS[Math.round(avg) - 1]}</span>
              </div>
            </div>
            <div className="chip outline" style={{ gap: 5 }}><Icon name="trend" size={15} color="var(--green)" /> +12%</div>
          </div>
          {/* month bars */}
          <div style={{ display: 'flex', gap: 3, alignItems: 'flex-end', height: 80 }}>
            {month.map((l, i) => <div key={i} style={{ flex: 1, height: `${l * 18}%`, borderRadius: 3, background: MOOD_VARS[l - 1], opacity: 0.9 }} />)}
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 8 }}>
            <span className="t-cap muted-3">4 weeks ago</span><span className="t-cap muted-3">Today</span>
          </div>
        </div>
        <SectionHead title="Recent entries" />
        <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
          {entries.map((e, i) => (
            <div key={i} className="card-flat anim-up" style={{ padding: 16, display: 'flex', gap: 14 }}>
              <MoodFace level={e.level} size={48} />
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', alignItems: 'baseline', gap: 8 }}>
                  <span className="t-headline">{e.day}</span>
                  <span className="t-foot muted-3">{e.time}</span>
                </div>
                <p className="t-callout muted" style={{ marginTop: 4 }}>{e.note}</p>
                <div style={{ display: 'flex', gap: 6, marginTop: 10, flexWrap: 'wrap' }}>
                  {e.factors.map(f => <span key={f} className="chip outline" style={{ height: 26, fontSize: 12 }}>{f}</span>)}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
