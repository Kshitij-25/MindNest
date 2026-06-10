/* MindNest — V2 notifications + advanced mood insights */
window.SCREENS = window.SCREENS || {};
const { useState: eUS, useContext: eUC } = React;

const NOTIF_META = {
  mood: { icon: 'heart', color: 'var(--clay)', tint: 'var(--clay-tint)' },
  insight: { icon: 'sparkle', color: 'var(--topic-4)', tint: 'color-mix(in srgb, var(--topic-4) 14%, transparent)' },
  rec: { icon: 'feather', color: 'var(--primary)', tint: 'var(--primary-tint)' },
  report: { icon: 'doc', color: 'var(--blue)', tint: 'color-mix(in srgb, var(--blue) 14%, transparent)' },
  journal: { icon: 'pen', color: 'var(--topic-5)', tint: 'color-mix(in srgb, var(--topic-5) 14%, transparent)' },
};

/* ================= NOTIFICATIONS ================= */
window.SCREENS.notifications = function Notifications({ params }) {
  const ctx = eUC(AppCtx);
  const [items, setItems] = eUS(NOTIFICATIONS.map(n => ({ ...n })));
  const empty = params.empty;
  const markAll = () => setItems(it => it.map(n => ({ ...n, unread: false })));
  const open = (n) => {
    setItems(it => it.map(x => x.id === n.id ? { ...x, unread: false } : x));
    if (n.type === 'mood') ctx.push('moodTrack');
    else if (n.type === 'insight') ctx.push('discover');
    else if (n.type === 'rec') ctx.push('recommendations');
    else if (n.type === 'report') ctx.push('weeklyReport');
    else if (n.type === 'journal') ctx.goTab('journal');
  };
  const today = items.filter(n => !n.time.includes('d'));
  const earlier = items.filter(n => n.time.includes('d'));

  return (
    <div className="mn-screen">
      <NavHeader title="Notifications" onBack={ctx.pop}
        right={!empty && items.some(n => n.unread) ? <button onClick={markAll} style={{ ...linkBtn, marginRight: 8, fontSize: 14 }}>Mark all</button> : <span style={{ width: 40 }} />} />
      {empty ? (
        <EmptyState icon="bell" title="You’re all caught up"
          body="Booking updates, messages, and gentle reminders will land here when there’s something new." />
      ) : (
        <div className="mn-scroll" style={{ padding: '6px 16px 24px' }}>
          <NotifGroup label="New" items={today} open={open} />
          {earlier.length > 0 && <NotifGroup label="Earlier" items={earlier} open={open} />}
        </div>
      )}
    </div>
  );
};

function NotifGroup({ label, items, open }) {
  if (!items.length) return null;
  return (
    <div style={{ marginBottom: 18 }}>
      <div className="t-cap muted-3" style={{ textTransform: 'uppercase', fontWeight: 700, padding: '8px 8px 6px', letterSpacing: '0.04em' }}>{label}</div>
      <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
        {items.map(n => {
          const m = NOTIF_META[n.type];
          return (
            <div key={n.id} className="pressable" onClick={() => open(n)} style={{
              display: 'flex', gap: 13, padding: 14, borderRadius: 18, cursor: 'pointer',
              background: n.unread ? 'var(--surface)' : 'transparent',
              boxShadow: n.unread ? 'var(--sh-sm)' : 'none',
            }}>
              <div style={{ width: 44, height: 44, borderRadius: 13, background: m.tint, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <Icon name={m.icon} size={21} color={m.color} stroke={1.9} /></div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <span className="t-headline" style={{ flex: 1, fontSize: 15 }}>{n.title}</span>
                  <span className="t-cap muted-3">{n.time}</span>
                </div>
                <p className="t-callout muted" style={{ marginTop: 3, lineHeight: 1.4, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{n.body}</p>
              </div>
              {n.unread && <span style={{ width: 9, height: 9, borderRadius: '50%', background: 'var(--primary)', flexShrink: 0, marginTop: 6 }} />}
            </div>
          );
        })}
      </div>
    </div>
  );
}

/* ================= ADVANCED MOOD INSIGHTS ================= */
window.SCREENS.moodInsights = function MoodInsights() {
  const ctx = eUC(AppCtx);
  const [range, setRange] = eUS('Week');
  const week = WEEK_MOOD;
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const month = [3, 4, 4, 3, 2, 4, 5, 4, 3, 4, 4, 5, 5, 4, 3, 2, 3, 4, 5, 4, 4, 5, 4, 3, 4, 5, 4, 4];
  const avg = (week.reduce((a, b) => a + b, 0) / week.length);
  const dist = [5, 4, 3, 2, 1].map(l => ({ l, n: month.filter(m => m === l).length }));

  return (
    <div className="mn-screen">
      <NavHeader title="Insights" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '6px 20px 30px' }}>
        {/* streak */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 16, display: 'flex', alignItems: 'center', gap: 18 }}>
          <div style={{ position: 'relative', width: 76, height: 76, flexShrink: 0 }}>
            <svg width="76" height="76" viewBox="0 0 76 76" style={{ transform: 'rotate(-90deg)' }}>
              <circle cx="38" cy="38" r="33" fill="none" stroke="var(--fill-2)" strokeWidth="6" />
              <circle cx="38" cy="38" r="33" fill="none" stroke="var(--streak)" strokeWidth="6" strokeLinecap="round"
                strokeDasharray={2 * Math.PI * 33} strokeDashoffset={2 * Math.PI * 33 * (1 - 12 / 14)} style={{ transition: 'stroke-dashoffset 1s var(--ease-out)' }} />
            </svg>
            <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="flame" size={30} color="var(--streak)" stroke={1.7} /></div>
          </div>
          <div style={{ flex: 1 }}>
            <div className="t-title1" style={{ lineHeight: 1 }}>12 days</div>
            <div className="t-callout muted" style={{ marginTop: 4 }}>Your longest check-in streak yet. Gently does it.</div>
          </div>
        </div>

        <div className="anim-up" style={{ marginBottom: 16 }}><Segmented options={['Week', 'Month']} value={range} onChange={setRange} /></div>

        {/* graph */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 16 }}>
          <div style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'space-between', marginBottom: 18 }}>
            <div>
              <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>Average mood</div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginTop: 6 }}>
                <MoodFace level={Math.round(avg)} size={36} />
                <span className="t-title2">{MOOD_LABELS[Math.round(avg) - 1]}</span>
              </div>
            </div>
            <span className="chip outline" style={{ gap: 5 }}><Icon name="trend" size={15} color="var(--green)" /> +12%</span>
          </div>
          {range === 'Week' ? (
            <div style={{ display: 'flex', gap: 8, alignItems: 'stretch', height: 130 }}>
              {week.map((l, i) => (
                <div key={i} style={{ flex: 1, height: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 8 }}>
                  <div style={{ width: '100%', position: 'relative', flex: 1, display: 'flex', alignItems: 'flex-end' }}>
                    <div style={{ width: '100%', height: `${(l / 5) * 100}%`, borderRadius: 8, background: MOOD_VARS[l - 1], minHeight: 8,
                      animation: `growBar .6s ${i * 0.06}s var(--ease-out) both`, transformOrigin: 'bottom' }} />
                  </div>
                  <span className="t-cap muted-3" style={{ fontWeight: 600 }}>{days[i][0]}</span>
                </div>
              ))}
            </div>
          ) : (
            <LineChart data={month} />
          )}
        </div>

        {/* emotional insights */}
        <SectionHead title="What we’re noticing" />
        <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 24 }}>
          {[['lightbulb', 'Journaling lifts you', 'On days you write an entry, your mood averages a full point higher.', 'var(--topic-4)'],
            ['sleep', 'Midweek dips', 'Wednesdays tend to be your lowest — worth a gentler schedule if you can.', 'var(--topic-3)'],
            ['heart', 'Sessions help', 'Your mood rises for 2–3 days after each therapy session.', 'var(--topic-5)']].map(([ic, t, b, col]) => (
            <div key={t} className="card-flat" style={{ padding: 16, display: 'flex', gap: 13 }}>
              <div style={{ width: 40, height: 40, borderRadius: 12, background: `color-mix(in srgb, ${col} 14%, transparent)`, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <Icon name={ic} size={20} color={col} stroke={1.9} /></div>
              <div style={{ flex: 1 }}>
                <div className="t-headline" style={{ fontSize: 15 }}>{t}</div>
                <p className="t-callout muted" style={{ marginTop: 3, lineHeight: 1.45 }}>{b}</p>
              </div>
            </div>
          ))}
        </div>

        {/* distribution */}
        <SectionHead title="Mood balance · 28 days" />
        <div className="card anim-up" style={{ padding: 18 }}>
          {dist.map(({ l, n }) => (
            <div key={l} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '7px 0' }}>
              <MoodFace level={l} size={30} />
              <div style={{ flex: 1, height: 10, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
                <div style={{ height: '100%', width: `${(n / 28) * 100}%`, borderRadius: 999, background: MOOD_VARS[l - 1], transition: 'width .8s var(--ease-out)' }} />
              </div>
              <span className="t-foot muted-3" style={{ minWidth: 44, textAlign: 'right', fontWeight: 600 }}>{n} days</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

function LineChart({ data }) {
  const w = 320, h = 130, pad = 6;
  const max = 5, min = 1;
  const pts = data.map((v, i) => {
    const x = pad + (i / (data.length - 1)) * (w - pad * 2);
    const y = pad + (1 - (v - min) / (max - min)) * (h - pad * 2);
    return [x, y];
  });
  const path = pts.map((p, i) => (i ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1)).join(' ');
  const area = path + ` L${(w - pad).toFixed(1)} ${h - pad} L${pad} ${h - pad} Z`;
  return (
    <svg viewBox={`0 0 ${w} ${h}`} style={{ width: '100%', height: 130, overflow: 'visible' }}>
      <defs>
        <linearGradient id="moodGrad" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stopColor="var(--primary)" stopOpacity="0.25" />
          <stop offset="100%" stopColor="var(--primary)" stopOpacity="0" />
        </linearGradient>
      </defs>
      <path d={area} fill="url(#moodGrad)" />
      <path d={path} fill="none" stroke="var(--primary)" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"
        style={{ strokeDasharray: 1000, strokeDashoffset: 1000, animation: 'drawLine 1.2s var(--ease-out) forwards' }} />
      {pts.filter((_, i) => i % 4 === 0).map((p, i) => <circle key={i} cx={p[0]} cy={p[1]} r="3" fill="var(--surface)" stroke="var(--primary)" strokeWidth="2" />)}
    </svg>
  );
}
