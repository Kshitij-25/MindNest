/* MindNest — MVP-1 insight screens: timeline, patterns, memory, weekly report, insight detail, analytics */
window.SCREENS = window.SCREENS || {};
const { useState: inUS, useContext: inUC } = React;

/* ================= EMOTIONAL TIMELINE ================= */
window.SCREENS.timeline = function Timeline() {
  const ctx = inUC(AppCtx);
  return (
    <div className="mn-screen">
      <NavHeader title="Emotional timeline" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <p className="t-callout muted anim-up" style={{ marginBottom: 20, lineHeight: 1.5 }}>How your emotions have shifted — and the drivers behind each change.</p>
        <div style={{ position: 'relative', paddingLeft: 8 }}>
          {/* vertical line */}
          <div style={{ position: 'absolute', left: 21, top: 8, bottom: 20, width: 2, background: 'var(--hairline)' }} />
          <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            {TIMELINE.map(t => {
              const col = t.tone === 'good' ? 'var(--green)' : 'var(--clay)';
              return (
                <div key={t.id} className="anim-up" style={{ display: 'flex', gap: 16 }}>
                  <div style={{ width: 28, flexShrink: 0, display: 'flex', justifyContent: 'center', paddingTop: 4 }}>
                    <div style={{ width: 28, height: 28, borderRadius: '50%', background: `color-mix(in srgb, ${col} 16%, var(--surface))`, border: '2px solid var(--bg)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1 }}>
                      <Icon name="trend" size={15} color={col} stroke={2.4} style={t.dir === 'down' ? { transform: 'scaleY(-1)' } : null} />
                    </div>
                  </div>
                  <div className="card" style={{ flex: 1, padding: 16 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
                      <span className="t-cap muted-3" style={{ flex: 1, textTransform: 'uppercase', letterSpacing: '0.04em', fontWeight: 700 }}>{t.period}</span>
                      <span className="t-headline" style={{ color: col }}>{t.change}</span>
                    </div>
                    <p className="t-callout muted" style={{ lineHeight: 1.5, marginBottom: 12 }}>{t.note}</p>
                    <div className="t-cap muted-3" style={{ fontWeight: 700, marginBottom: 7 }}>Main drivers</div>
                    <div style={{ display: 'flex', gap: 7, flexWrap: 'wrap' }}>
                      {t.drivers.map(d => <span key={d} className="chip outline" style={{ height: 28, fontSize: 12.5 }}>{d}</span>)}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
};

/* ================= PATTERN DETECTOR ================= */
window.SCREENS.patterns = function Patterns() {
  const ctx = inUC(AppCtx);
  return (
    <div className="mn-screen">
      <NavHeader title="Patterns" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <p className="t-callout muted anim-up" style={{ marginBottom: 18, lineHeight: 1.5 }}>Recurring connections we’ve noticed across your check-ins, journals and habits.</p>
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          {PATTERNS.map(p => (
            <div key={p.id} className="card anim-up" style={{ padding: 18 }}>
              <div style={{ display: 'flex', gap: 13, marginBottom: 12 }}>
                <IconTile icon={p.icon} color={p.color} size={46} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div className="t-headline" style={{ lineHeight: 1.3 }}>{p.title}</div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 6 }}>
                    <span className="t-cap" style={{ color: p.color, fontWeight: 700 }}>{p.strength}</span>
                    <Confidence value={p.confidence} size="sm" />
                  </div>
                </div>
              </div>
              <p className="t-callout muted" style={{ lineHeight: 1.5 }}>{p.detail}</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

/* ================= EMOTIONAL MEMORY ================= */
window.SCREENS.memory = function Memory() {
  const ctx = inUC(AppCtx);
  return (
    <div className="mn-screen">
      <NavHeader title="Memory highlights" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <p className="t-callout muted anim-up" style={{ marginBottom: 18, lineHeight: 1.5 }}>Moments worth remembering — surfaced from your journals so your coach can hold the bigger picture.</p>
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          {MEMORIES.map(m => (
            <div key={m.id} className="card anim-up" style={{ padding: 16 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 11, marginBottom: 12 }}>
                <IconTile icon={m.icon} color={m.color} size={40} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div className="t-cap" style={{ color: m.color, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{m.kind}</div>
                </div>
                <span className="t-cap muted-3">{m.date}</span>
              </div>
              <div className="t-headline t-serif" style={{ fontSize: 18, marginBottom: 6 }}>{m.title}</div>
              <p className="t-callout muted" style={{ lineHeight: 1.5, fontStyle: 'italic' }}>“{m.snippet}”</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

/* ================= WEEKLY WELLNESS REPORT ================= */
window.SCREENS.weeklyReport = function WeeklyReport() {
  const ctx = inUC(AppCtx);
  const r = WEEKLY_REPORT;
  return (
    <div className="mn-screen" style={{ background: 'radial-gradient(120% 50% at 50% 0%, var(--primary-tint) 0%, var(--bg) 42%)' }}>
      <NavHeader title="Weekly report" onBack={ctx.pop} transparent
        right={<button className="nav-btn"><Icon name="share" size={18} stroke={1.9} /></button>} />
      <div className="mn-scroll" style={{ padding: '4px 20px 30px' }}>
        {/* header */}
        <div className="anim-up" style={{ textAlign: 'center', marginBottom: 22 }}>
          <div className="t-cap muted-3" style={{ textTransform: 'uppercase', letterSpacing: '0.06em', fontWeight: 700 }}>Your week</div>
          <h1 className="t-serif" style={{ fontSize: 30, marginTop: 6 }}>{r.range}</h1>
          <div style={{ display: 'inline-flex', marginTop: 12 }}><TrendPill dir="up">Wellness +{WELLNESS.weeklyChange}</TrendPill></div>
        </div>

        {/* mood summary */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 14 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
            <MoodFace level={r.moodSummary.avgLevel} size={56} />
            <div style={{ flex: 1 }}>
              <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Average mood</div>
              <div className="t-title3" style={{ marginTop: 2 }}>{r.moodSummary.avg} <span className="t-foot" style={{ color: 'var(--green)' }}>{r.moodSummary.change}</span></div>
            </div>
          </div>
          <div style={{ display: 'flex', gap: 10, marginTop: 14 }}>
            <div className="card-inset" style={{ flex: 1, padding: '11px 13px' }}>
              <div className="t-cap muted-3">Best day</div><div className="t-headline" style={{ marginTop: 2, color: 'var(--green)' }}>{r.moodSummary.best}</div>
            </div>
            <div className="card-inset" style={{ flex: 1, padding: '11px 13px' }}>
              <div className="t-cap muted-3">Hardest day</div><div className="t-headline" style={{ marginTop: 2, color: 'var(--clay)' }}>{r.moodSummary.hardest}</div>
            </div>
          </div>
        </div>

        {/* emotional changes */}
        <RepCard title="Emotional changes">
          {r.emotionalChanges.map(e => (
            <div key={e.key} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '8px 0' }}>
              <span className="t-callout" style={{ flex: 1, fontWeight: 600 }}>{e.key}</span>
              <div style={{ width: 100, height: 7, borderRadius: 999, background: 'var(--fill-2)', position: 'relative', overflow: 'hidden' }}>
                <div style={{ position: 'absolute', left: '50%', top: 0, bottom: 0, width: `${Math.min(50, Math.abs(e.delta) * 3)}%`, transform: e.delta < 0 ? 'translateX(-100%)' : 'none', background: e.delta < 0 ? 'var(--green)' : 'var(--clay)' }} />
              </div>
              <span className="t-foot" style={{ fontWeight: 700, minWidth: 34, textAlign: 'right', color: e.delta < 0 ? 'var(--green)' : 'var(--clay)' }}>{e.delta > 0 ? '+' : ''}{e.delta}</span>
            </div>
          ))}
        </RepCard>

        {/* top topics */}
        <RepCard title="Top topics">
          {r.topTopics.map(t => {
            const max = Math.max(...r.topTopics.map(x => x.n));
            return (
              <div key={t.t} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '7px 0' }}>
                <span className="t-callout" style={{ width: 96, fontWeight: 600 }}>{t.t}</span>
                <div style={{ flex: 1, height: 10, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
                  <div style={{ height: '100%', width: `${(t.n / max) * 100}%`, borderRadius: 999, background: 'var(--primary)' }} />
                </div>
                <span className="t-foot muted-3" style={{ minWidth: 22, textAlign: 'right', fontWeight: 600 }}>{t.n}</span>
              </div>
            );
          })}
        </RepCard>

        {/* adherence + follow-through */}
        <div className="anim-up" style={{ display: 'flex', gap: 12, marginBottom: 14 }}>
          {[['Habit adherence', r.habitAdherence, 'var(--streak)'], ['Rec follow-through', r.recFollowThrough, 'var(--primary)']].map(([lbl, v, col]) => (
            <div key={lbl} className="card" style={{ flex: 1, padding: 16, display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center' }}>
              <RadialScore value={v} size={76} stroke={8} color={col} />
              <div className="t-cap muted-3" style={{ marginTop: 8, fontWeight: 600 }}>{lbl}</div>
            </div>
          ))}
        </div>

        {/* burnout movement */}
        <RepCard title="Burnout movement">
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <IconTile icon="flame" color="var(--green)" size={46} />
            <div style={{ flex: 1 }}>
              <div className="t-title3" style={{ color: 'var(--green)' }}>{r.burnoutMovement}%</div>
              <div className="t-foot muted">Burnout risk eased this week — protecting your evenings helped.</div>
            </div>
          </div>
        </RepCard>

        {/* patterns */}
        <RepCard title="Patterns this week">
          {r.patterns.map(p => (
            <div key={p} style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '7px 0' }}>
              <Icon name="checkCircle" size={18} color="var(--primary)" stroke={2} />
              <span className="t-callout" style={{ color: 'var(--ink-2)' }}>{p}</span>
            </div>
          ))}
        </RepCard>

        {/* growth + focus */}
        <RepCard title="Growth areas">
          {r.growthAreas.map(g => (
            <div key={g} style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '7px 0' }}>
              <Icon name="trend" size={18} color="var(--topic-4)" stroke={2} />
              <span className="t-callout" style={{ color: 'var(--ink-2)' }}>{g}</span>
            </div>
          ))}
        </RepCard>

        <div className="card anim-up" style={{ padding: 18, display: 'flex', alignItems: 'center', gap: 13, background: 'var(--primary-tint)' }}>
          <IconTile icon="target" color="var(--primary)" size={46} />
          <div style={{ flex: 1 }}>
            <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Suggested focus</div>
            <div className="t-headline" style={{ marginTop: 3 }}>{r.suggestedFocus}</div>
          </div>
        </div>
      </div>
    </div>
  );
};

function RepCard({ title, children }) {
  return (
    <div className="card anim-up" style={{ padding: 18, marginBottom: 14 }}>
      <div className="t-headline" style={{ marginBottom: 10 }}>{title}</div>
      {children}
    </div>
  );
}

/* ================= PERSONAL ANALYTICS ================= */
window.SCREENS.analytics = function Analytics() {
  const ctx = inUC(AppCtx);
  const [range, setRange] = inUS('30d');
  const stressData = [62, 58, 65, 54, 60, 52, 56, 49, 54];
  const burnoutData = [44, 46, 42, 40, 43, 38, 39, 36, 38];
  return (
    <div className="mn-screen">
      <NavHeader title="Analytics" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <div className="anim-up" style={{ marginBottom: 16 }}><Segmented options={['7d', '30d', '90d']} value={range} onChange={setRange} /></div>

        {/* wellness score */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 14, display: 'flex', alignItems: 'center', gap: 16 }}>
          <RadialScore value={WELLNESS.score} size={92} stroke={9} sub="score" />
          <div style={{ flex: 1 }}>
            <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Wellness score</div>
            <div className="t-title2" style={{ marginTop: 2 }}>{WELLNESS.band}</div>
            <div style={{ marginTop: 8 }}><TrendPill dir="up">+{WELLNESS.weeklyChange} this week</TrendPill></div>
          </div>
        </div>

        {/* mood trend */}
        <AnalyticCard title="Mood trend" trend="up" delta="+8%">
          <Spark data={[3.2, 3.5, 3.1, 3.8, 4.0, 3.7, 4.1, 3.9, 4.2]} h={60} />
        </AnalyticCard>

        {/* stress + burnout */}
        <div className="anim-up" style={{ display: 'flex', gap: 12, marginBottom: 14 }}>
          <div className="card" style={{ flex: 1, padding: 16 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 10 }}><span className="t-foot" style={{ flex: 1, fontWeight: 700 }}>Stress</span><TrendPill dir="down" invert>−9%</TrendPill></div>
            <Spark data={stressData} color="var(--topic-2)" h={48} fill={false} />
          </div>
          <div className="card" style={{ flex: 1, padding: 16 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 10 }}><span className="t-foot" style={{ flex: 1, fontWeight: 700 }}>Burnout</span><TrendPill dir="down" invert>−12%</TrendPill></div>
            <Spark data={burnoutData} color="var(--streak)" h={48} fill={false} />
          </div>
        </div>

        {/* topic analysis */}
        <AnalyticCard title="Topic analysis">
          {WEEKLY_REPORT.topTopics.map(t => {
            const max = Math.max(...WEEKLY_REPORT.topTopics.map(x => x.n));
            return (
              <div key={t.t} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '6px 0' }}>
                <span className="t-callout" style={{ width: 96, fontWeight: 600 }}>{t.t}</span>
                <div style={{ flex: 1, height: 9, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
                  <div style={{ height: '100%', width: `${(t.n / max) * 100}%`, borderRadius: 999, background: 'var(--topic-1)' }} />
                </div>
                <span className="t-foot muted-3" style={{ minWidth: 22, textAlign: 'right', fontWeight: 600 }}>{t.n}</span>
              </div>
            );
          })}
        </AnalyticCard>

        {/* pattern cards */}
        <SectionHead title="Patterns" action="See all" onAction={() => ctx.push('patterns')} />
        <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', gap: 10, marginBottom: 18 }}>
          {PATTERNS.slice(0, 2).map(p => (
            <div key={p.id} className="card-flat" style={{ padding: 14, display: 'flex', alignItems: 'center', gap: 12 }}>
              <IconTile icon={p.icon} color={p.color} size={40} />
              <span className="t-callout" style={{ flex: 1, fontWeight: 600, color: 'var(--ink-2)' }}>{p.title}</span>
              <Confidence value={p.confidence} size="sm" />
            </div>
          ))}
        </div>

        {/* habit adherence */}
        <AnalyticCard title="Habit adherence">
          {HABITS.slice(0, 4).map(h => (
            <div key={h.id} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '7px 0' }}>
              <span className="t-callout" style={{ width: 96, fontWeight: 600 }}>{h.name}</span>
              <div style={{ flex: 1, height: 9, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
                <div style={{ height: '100%', width: `${h.completion}%`, borderRadius: 999, background: h.color }} />
              </div>
              <span className="t-foot muted-3" style={{ minWidth: 34, textAlign: 'right', fontWeight: 600 }}>{h.completion}%</span>
            </div>
          ))}
        </AnalyticCard>

        {/* follow-through + report */}
        <button className="card pressable anim-up" onClick={() => ctx.push('weeklyReport')} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16, display: 'flex', alignItems: 'center', gap: 13 }}>
          <IconTile icon="doc" color="var(--primary)" size={46} />
          <div style={{ flex: 1 }}>
            <div className="t-headline">Weekly wellness report</div>
            <div className="t-foot muted" style={{ marginTop: 2 }}>Recommendation follow-through: {WEEKLY_REPORT.recFollowThrough}%</div>
          </div>
          <Icon name="chevR" size={20} color="var(--ink-4)" />
        </button>
      </div>
    </div>
  );
};

function AnalyticCard({ title, trend, delta, children }) {
  return (
    <div className="card anim-up" style={{ padding: 18, marginBottom: 14 }}>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: 12 }}>
        <span className="t-headline" style={{ flex: 1 }}>{title}</span>
        {trend && <TrendPill dir={trend}>{delta}</TrendPill>}
      </div>
      {children}
    </div>
  );
}
