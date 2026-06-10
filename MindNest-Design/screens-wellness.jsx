/* MindNest — MVP-1 wellness screens: score, emotional profile, assessments, habits, recommendations */
window.SCREENS = window.SCREENS || {};
const { useState: wUS, useContext: wUC } = React;

/* ================= WELLNESS SCORE DETAIL ================= */
window.SCREENS.wellnessScore = function WellnessScore() {
  const ctx = wUC(AppCtx);
  const w = WELLNESS;
  return (
    <div className="mn-screen">
      <NavHeader title="Wellness score" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        {/* hero ring */}
        <div className="card anim-up" style={{ padding: 24, marginBottom: 16, display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center' }}>
          <RadialScore value={w.score} size={172} stroke={14} sub="of 100" />
          <div className="t-title3" style={{ marginTop: 14 }}>{w.band}</div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
            <TrendPill dir={w.trend}>+{w.weeklyChange} vs last week</TrendPill>
            <Confidence value={w.confidence} />
          </div>
        </div>

        {/* trend */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 16 }}>
          <div style={{ display: 'flex', alignItems: 'center', marginBottom: 14 }}>
            <span className="t-headline" style={{ flex: 1 }}>7-day trend</span>
            <span className="t-foot muted-3">{w.spark[0]} → {w.spark[w.spark.length - 1]}</span>
          </div>
          <Spark data={w.spark} h={64} />
        </div>

        {/* contributing signals */}
        <SectionHead title="What’s shaping it" />
        <div className="card anim-up" style={{ padding: 18, marginBottom: 16 }}>
          {w.signals.map((s, i) => (
            <div key={s.key} style={{ display: 'flex', alignItems: 'center', gap: 13, padding: '11px 0', borderBottom: i < w.signals.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
              <IconTile icon={s.icon} color="var(--primary)" size={40} />
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6 }}>
                  <span className="t-callout" style={{ flex: 1, fontWeight: 600 }}>{s.key}</span>
                  <span className="t-cap muted-3">{s.weight} weight</span>
                  <span className="t-foot" style={{ fontWeight: 700, minWidth: 28, textAlign: 'right' }}>{s.value}</span>
                </div>
                <div style={{ height: 7, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
                  <div style={{ height: '100%', width: `${s.value}%`, borderRadius: 999, background: 'var(--primary)', transition: 'width .9s var(--ease-out)' }} />
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="card-flat anim-up" style={{ padding: 16, display: 'flex', gap: 12, alignItems: 'flex-start' }}>
          <Icon name="info" size={18} color="var(--ink-3)" stroke={2} style={{ marginTop: 1, flexShrink: 0 }} />
          <p className="t-foot muted" style={{ lineHeight: 1.5 }}>Your score blends mood, stress, anxiety, motivation, burnout, sleep and habits. Confidence reflects how much recent data we had to work with.</p>
        </div>
      </div>
    </div>
  );
};

/* ================= EMOTIONAL PROFILE ================= */
window.SCREENS.emotionalProfile = function EmotionalProfile() {
  const ctx = wUC(AppCtx);
  // radial layout of 8 emotions
  const cx = 150, cy = 150, R = 118;
  return (
    <div className="mn-screen">
      <NavHeader title="Emotional profile" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        {/* radial chart */}
        <div className="card anim-up" style={{ padding: 18, marginBottom: 16 }}>
          <svg viewBox="0 0 300 300" style={{ width: '100%', maxWidth: 300, margin: '0 auto', display: 'block' }}>
            {[0.33, 0.66, 1].map((f, i) => (
              <circle key={i} cx={cx} cy={cy} r={R * f} fill="none" stroke="var(--hairline)" strokeWidth="1" />
            ))}
            {(() => {
              const pts = EMOTIONS.map((e, i) => {
                const ang = (-90 + i * (360 / EMOTIONS.length)) * Math.PI / 180;
                const r = R * (e.value / 100);
                return [cx + r * Math.cos(ang), cy + r * Math.sin(ang)];
              });
              const path = pts.map((p, i) => (i ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1)).join(' ') + ' Z';
              return (
                <>
                  <path d={path} fill="color-mix(in srgb, var(--primary) 20%, transparent)" stroke="var(--primary)" strokeWidth="2" strokeLinejoin="round" />
                  {EMOTIONS.map((e, i) => {
                    const ang = (-90 + i * (360 / EMOTIONS.length)) * Math.PI / 180;
                    const lr = R + 6;
                    const lx = cx + lr * Math.cos(ang), ly = cy + lr * Math.sin(ang);
                    return <circle key={i} cx={pts[i][0]} cy={pts[i][1]} r="3.2" fill="var(--primary)" />;
                  })}
                </>
              );
            })()}
          </svg>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, justifyContent: 'center', marginTop: 8 }}>
            {EMOTIONS.map(e => (
              <span key={e.key} className="t-cap" style={{ display: 'inline-flex', alignItems: 'center', gap: 5, color: 'var(--ink-3)', fontWeight: 600 }}>
                <span style={{ width: 7, height: 7, borderRadius: '50%', background: e.color }} />{e.key.split(' ')[0]}
              </span>
            ))}
          </div>
        </div>

        {/* emotion bars */}
        <SectionHead title="Each dimension" />
        <div className="card anim-up" style={{ padding: 18 }}>
          {EMOTIONS.map(e => <EmotionBar key={e.key} label={e.key} value={e.value} color={e.color} trend={e.trend} desc={e.desc} />)}
        </div>
      </div>
    </div>
  );
};

/* ================= ASSESSMENTS ================= */
window.SCREENS.assessments = function Assessments() {
  const ctx = wUC(AppCtx);
  return (
    <div className="mn-screen">
      <NavHeader title="Assessments" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        {/* daily progress */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 18, display: 'flex', alignItems: 'center', gap: 16 }}>
          <RadialScore value={40} size={84} stroke={9} label="2/5" color="var(--primary)" />
          <div style={{ flex: 1 }}>
            <div className="t-headline">Adaptive check-ins</div>
            <p className="t-foot muted" style={{ marginTop: 4, lineHeight: 1.45 }}>Questions adapt to your recent answers, so each one stays short and relevant.</p>
          </div>
        </div>

        <SectionHead title="Available now" />
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 22 }}>
          {ASSESSMENTS.map(a => (
            <button key={a.id} className="card pressable" onClick={() => ctx.push('questionnaire', { assessment: a.id })} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16 }}>
              <div style={{ display: 'flex', gap: 13, alignItems: 'center' }}>
                <IconTile icon={a.icon} color={a.color} size={46} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                    <span className="t-headline" style={{ flex: 1 }}>{a.name}</span>
                    {a.done && <span className="badge badge-accept">Done today</span>}
                  </div>
                  <div className="t-foot muted" style={{ marginTop: 2 }}>{a.sub}</div>
                </div>
              </div>
              <div className="hr" style={{ margin: '13px 0 11px' }} />
              <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <span className="t-cap muted-3" style={{ display: 'inline-flex', alignItems: 'center', gap: 5 }}><Icon name="clock" size={14} stroke={2} color="var(--ink-3)" />{a.freq}</span>
                <span className="t-cap muted-3">· {a.items} items</span>
                <div style={{ flex: 1 }} />
                <Confidence value={a.confidence} size="sm" />
              </div>
            </button>
          ))}
        </div>

        <SectionHead title="History" />
        <div className="card anim-up" style={{ padding: 6 }}>
          {ASSESSMENT_HISTORY.map((h, i) => (
            <div key={h.id} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '13px 12px', borderBottom: i < ASSESSMENT_HISTORY.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="t-callout" style={{ fontWeight: 600 }}>{h.name}</div>
                <div className="t-cap muted-3" style={{ marginTop: 2 }}>{h.date}</div>
              </div>
              <span className="chip outline" style={{ height: 26, fontSize: 12.5 }}>{h.score}</span>
              <TrendPill dir={h.delta}>{h.confidence}%</TrendPill>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

/* ================= HABITS ================= */
window.SCREENS.habits = function Habits() {
  const ctx = wUC(AppCtx);
  const [done, setDone] = wUS({});
  return (
    <div className="mn-screen">
      <NavHeader title="Habits" onBack={ctx.pop}
        right={<button className="nav-btn"><Icon name="plus" size={20} stroke={2.2} /></button>} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <div className="card anim-up" style={{ padding: 20, marginBottom: 18, display: 'flex', alignItems: 'center', gap: 16 }}>
          <RadialScore value={78} size={84} stroke={9} color="var(--streak)" />
          <div style={{ flex: 1 }}>
            <div className="t-headline">This week’s adherence</div>
            <p className="t-foot muted" style={{ marginTop: 4, lineHeight: 1.45 }}>You’ve kept up 78% of your habits — your steadiest week this month.</p>
          </div>
        </div>

        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          {HABITS.map(h => (
            <div key={h.id} className="card anim-up" style={{ padding: 16 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 13, marginBottom: 14 }}>
                <IconTile icon={h.icon} color={h.color} size={44} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div className="t-headline">{h.name}</div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 7, marginTop: 3 }}>
                    <span className="t-cap" style={{ color: 'var(--streak)', fontWeight: 700, display: 'inline-flex', alignItems: 'center', gap: 3 }}><Icon name="flame" size={13} color="var(--streak)" stroke={2} />{h.streak}-day streak</span>
                    <span className="t-cap muted-3">· {h.completion}% complete</span>
                  </div>
                </div>
                <button onClick={() => setDone(d => ({ ...d, [h.id]: !d[h.id] }))} style={{
                  width: 38, height: 38, borderRadius: '50%', border: done[h.id] ? 0 : '2px solid var(--hairline-2)', cursor: 'pointer',
                  background: done[h.id] ? h.color : 'transparent', display: 'flex', alignItems: 'center', justifyContent: 'center', transition: 'all .2s' }}>
                  <Icon name="check" size={20} color={done[h.id] ? '#fff' : 'var(--ink-4)'} stroke={2.6} />
                </button>
              </div>
              <WeekDots week={h.week} color={h.color} />
              <div className="card-inset" style={{ marginTop: 14, padding: '10px 13px', display: 'flex', alignItems: 'center', gap: 9 }}>
                <Icon name="sparkle" size={15} color={h.color} stroke={2} />
                <span className="t-cap" style={{ color: 'var(--ink-2)', fontWeight: 500 }}>{h.correlation}</span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

/* ================= RECOMMENDATION CENTER (repurposed booking) ================= */
window.SCREENS.recommendations = function Recommendations() {
  const ctx = wUC(AppCtx);
  const [states, setStates] = wUS({}); // id -> 'done' | 'dismissed'
  const set = (id, v) => setStates(s => ({ ...s, [id]: v }));
  const list = RECS.filter(r => states[r.id] !== 'dismissed');
  return (
    <div className="mn-screen">
      <NavHeader title="Recommendations" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <p className="t-callout muted anim-up" style={{ marginBottom: 18, lineHeight: 1.5 }}>Gentle, personalised suggestions based on what your check-ins and journals are showing.</p>
        {list.length === 0 ? (
          <EmptyState icon="checkCircle" title="All caught up" body="You’ve worked through today’s recommendations. New ones arrive as we learn more about your week." />
        ) : (
          <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
            {list.map(r => <RecCard key={r.id} r={r} state={states[r.id]} onAction={v => set(r.id, v)} onOpen={() => ctx.push('recDetail', { id: r.id })} />)}
          </div>
        )}
      </div>
    </div>
  );
};

function RecCard({ r, state, onAction, onOpen }) {
  const done = state === 'done';
  return (
    <div className="card" style={{ padding: 16, opacity: done ? 0.7 : 1, transition: 'opacity .3s' }}>
      <button onClick={onOpen} style={{ width: '100%', textAlign: 'left', border: 0, background: 'none', cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 0 }}>
        <div style={{ display: 'flex', gap: 13 }}>
          <IconTile icon={r.icon} color={r.color} size={48} />
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="t-cap" style={{ color: r.color, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{r.kind}</div>
            <div className="t-headline" style={{ marginTop: 3 }}>{r.title}</div>
          </div>
          {done && <span className="badge badge-accept" style={{ flexShrink: 0 }}>Done</span>}
        </div>
        <div className="card-inset" style={{ marginTop: 12, padding: '11px 13px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 7, marginBottom: 5 }}>
            <Icon name="info" size={14} color="var(--ink-3)" stroke={2} />
            <span className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>Why this</span>
          </div>
          <p className="t-foot" style={{ color: 'var(--ink-2)', lineHeight: 1.45 }}>{r.reason}</p>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 11 }}>
          <span className="chip outline" style={{ height: 26, fontSize: 12, gap: 5 }}><Icon name="clock" size={13} stroke={2} color="var(--ink-3)" />{r.duration}</span>
          <span className="t-cap" style={{ color: r.color, fontWeight: 600 }}>· {r.insight}</span>
        </div>
      </button>
      {!done && (
        <div style={{ display: 'flex', gap: 10, marginTop: 14 }}>
          <button className="btn btn-secondary btn-sm" style={{ flex: 1 }} onClick={() => onAction('dismissed')}>Dismiss</button>
          <button className="btn btn-primary btn-sm" style={{ flex: 1.4 }} onClick={() => onAction('done')}>Mark complete</button>
        </div>
      )}
    </div>
  );
}

/* ================= RECOMMENDATION DETAIL ================= */
window.SCREENS.recDetail = function RecDetail({ params }) {
  const ctx = wUC(AppCtx);
  const r = rec(params.id) || RECS[0];
  const [feedback, setFeedback] = wUS(null);
  const [done, setDone] = wUS(false);

  if (done) return (
    <div className="mn-screen" style={{ alignItems: 'center', justifyContent: 'center', padding: 28 }}>
      <SuccessCheck />
      <h1 className="t-title2 anim-up" style={{ marginTop: 24 }}>Nicely done</h1>
      <p className="t-body muted anim-up" style={{ marginTop: 8, textAlign: 'center', maxWidth: 280 }}>We’ve logged this. Was it helpful?</p>
      <div className="anim-up" style={{ display: 'flex', gap: 10, marginTop: 22 }}>
        <button className={'btn btn-sm ' + (feedback === 'yes' ? 'btn-primary' : 'btn-secondary')} onClick={() => setFeedback('yes')} style={{ width: 'auto', padding: '0 20px' }}>Helpful</button>
        <button className={'btn btn-sm ' + (feedback === 'no' ? 'btn-primary' : 'btn-secondary')} onClick={() => setFeedback('no')} style={{ width: 'auto', padding: '0 20px' }}>Not helpful</button>
      </div>
      <button className="btn btn-ghost anim-up" style={{ marginTop: 24 }} onClick={() => ctx.reset('userApp', { tab: 'home' })}>Back to home</button>
    </div>
  );

  return (
    <div className="mn-screen">
      <NavHeader title={r.kind} onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 22px 24px' }}>
        <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center', marginBottom: 22 }}>
          <IconTile icon={r.icon} color={r.color} size={72} round={20} />
          <h1 className="t-title2" style={{ marginTop: 16, lineHeight: 1.2 }}>{r.title}</h1>
          <span className="chip outline" style={{ marginTop: 12, gap: 5 }}><Icon name="clock" size={14} stroke={2} color="var(--ink-3)" />{r.duration}</span>
        </div>

        <Section title="Why we’re suggesting this">
          <p className="t-body muted" style={{ lineHeight: 1.55 }}>{r.reason}</p>
        </Section>
        <Section title="Expected benefit">
          <p className="t-body muted" style={{ lineHeight: 1.55 }}>{r.benefit}</p>
        </Section>
        <Section title="Related insight">
          <button className="card-flat pressable" onClick={() => ctx.push('discover')} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 14, display: 'flex', alignItems: 'center', gap: 12 }}>
            <IconTile icon="sparkle" color="var(--topic-4)" size={40} />
            <span className="t-callout" style={{ flex: 1, fontWeight: 600, color: 'var(--ink-2)' }}>{r.insight}</span>
            <Icon name="chevR" size={18} color="var(--ink-4)" />
          </button>
        </Section>
      </div>
      <div style={{ padding: '12px 22px calc(env(safe-area-inset-bottom,0) + 22px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)', display: 'flex', gap: 12 }}>
        <button className="btn btn-secondary" style={{ flex: 1 }} onClick={ctx.pop}>Dismiss</button>
        <button className="btn btn-primary" style={{ flex: 1.4 }} onClick={() => setDone(true)}>Start now</button>
      </div>
    </div>
  );
};
