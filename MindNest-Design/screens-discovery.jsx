/* MindNest — discovery, therapist profile, booking */
window.SCREENS = window.SCREENS || {};
const { useState: dUS, useContext: dUC, useRef: dUR } = React;

/* full therapist card */
function TherapistCard({ t, onClick }) {
  return (
    <div className="card pressable" onClick={onClick} style={{ padding: 16 }}>
      <div style={{ display: 'flex', gap: 14 }}>
        <div style={{ position: 'relative', width: 72, height: 72, borderRadius: 18, overflow: 'hidden', flexShrink: 0 }}>
          <PhotoPlaceholder name={t.name} />
        </div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
            <span className="t-headline" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{t.name}</span>
            {t.verified && <Verified size={15} />}
          </div>
          <div className="t-callout muted" style={{ marginTop: 2 }}>{t.title}</div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 7 }}>
            <Stars value={t.rating} size={12} />
            <span className="t-foot muted-3">({t.reviews})</span>
            <span style={{ width: 3, height: 3, borderRadius: '50%', background: 'var(--ink-4)' }} />
            <span className="t-foot muted-3">{t.years} yrs</span>
          </div>
        </div>
        <button style={{ alignSelf: 'flex-start', border: 0, background: 'var(--fill)', width: 34, height: 34, borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}>
          <Icon name="bookmark" size={17} color="var(--ink-3)" stroke={1.8} />
        </button>
      </div>
      <div style={{ display: 'flex', gap: 6, marginTop: 12, flexWrap: 'wrap' }}>
        {t.tags.slice(0, 3).map(tag => <span key={tag} className="chip outline" style={{ height: 28, fontSize: 12.5 }}>{tag}</span>)}
      </div>
      <div className="hr" style={{ margin: '14px 0 12px' }} />
      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        <Icon name="clock" size={16} color="var(--green)" stroke={2} />
        <span className="t-foot" style={{ color: 'var(--green)', fontWeight: 600 }}>Next: {t.next}</span>
        <div style={{ flex: 1 }} />
        <span className="t-headline">£{t.price}</span>
        <span className="t-foot muted-3" style={{ marginRight: 4 }}>/session</span>
        <button className="btn btn-primary btn-sm" onClick={e => { e.stopPropagation(); onClick(); }}>View</button>
      </div>
    </div>
  );
}
window.TherapistCard = TherapistCard;

/* ================= INSIGHTS HUB (repurposed Discover) ================= */
const HUB_CARDS = [
  { id: 'burnout', kind: 'Burnout Analysis', icon: 'flame', color: 'var(--streak)', headline: 'Burnout risk easing', sub: 'Down 12% over two weeks', confidence: 81, screen: 'insightDetail', params: { type: 'burnout' } },
  { id: 'report', kind: 'Weekly Wellness Report', icon: 'doc', color: 'var(--primary)', headline: 'Your week, summarised', sub: '26 May – 1 Jun · ready', confidence: 88, screen: 'weeklyReport' },
  { id: 'patterns', kind: 'Pattern Detection', icon: 'pulse', color: 'var(--topic-2)', headline: '4 patterns found', sub: 'Work drives most of your stress', confidence: 94, screen: 'patterns' },
  { id: 'timeline', kind: 'Emotional Timeline', icon: 'trend', color: 'var(--topic-4)', headline: 'Stress +18% this week', sub: 'Driven by work & sleep', confidence: 86, screen: 'timeline' },
  { id: 'memory', kind: 'Memory Highlights', icon: 'sparkle', color: 'var(--topic-5)', headline: '5 moments worth keeping', sub: 'Growth, recovery & recurring themes', confidence: 90, screen: 'memory' },
  { id: 'recs', kind: 'Recommendations', icon: 'feather', color: 'var(--clay)', headline: '6 suggestions for you', sub: 'Reflection, breathing & sleep', confidence: 84, screen: 'recommendations' },
];

window.SCREENS.tabDiscover = function InsightsHub({ params }) {
  const ctx = dUC(AppCtx);
  const open = (c) => ctx.push(c.screen, c.params || {});
  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 10px` }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <button className="nav-btn" onClick={ctx.pop} style={{ marginLeft: -6 }}><Icon name="back" size={22} stroke={2.2} /></button>
          <h1 className="t-title1" style={{ flex: 1 }}>Insights</h1>
        </div>
      </div>
      <div style={{ padding: '8px 20px 24px' }}>
        <p className="t-callout muted anim-up" style={{ marginBottom: 18, lineHeight: 1.5 }}>Everything your check-ins, journals and habits are telling us — in one place.</p>
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          {HUB_CARDS.map(c => (
            <button key={c.id} className="card pressable anim-up" onClick={() => open(c)} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16 }}>
              <div style={{ display: 'flex', gap: 13, alignItems: 'center' }}>
                <IconTile icon={c.icon} color={c.color} size={48} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div className="t-cap" style={{ color: c.color, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{c.kind}</div>
                  <div className="t-headline" style={{ marginTop: 3 }}>{c.headline}</div>
                  <div className="t-foot muted" style={{ marginTop: 3 }}>{c.sub}</div>
                </div>
                <Icon name="chevR" size={20} color="var(--ink-4)" />
              </div>
              <div className="hr" style={{ margin: '13px 0 11px' }} />
              <Confidence value={c.confidence} size="sm" />
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

/* pushable Insights wrapper */
window.SCREENS.discover = function Discover({ params }) {
  return (
    <div className="mn-screen">
      <div className="mn-scroll">
        {React.createElement(window.SCREENS.tabDiscover, { params: params || {} })}
      </div>
    </div>
  );
};

function FilterSheet({ onClose }) {
  const [price, setPrice] = dUS(110);
  const [rating, setRating] = dUS('4.5+');
  const [type, setType] = dUS('Any');
  const [sel, setSel] = dUS(['Anxiety']);
  const SPECS = ['Anxiety', 'Depression', 'Sleep', 'Stress', 'Relationships', 'Burnout', 'Grief', 'Trauma'];
  const toggle = s => setSel(x => x.includes(s) ? x.filter(i => i !== s) : [...x, s]);
  return (
    <>
      <div className="scrim" onClick={onClose} />
      <div className="sheet">
        <div className="sheet-grab" />
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 18 }}>
          <h2 className="t-title3" style={{ flex: 1 }}>Filters</h2>
          <button onClick={onClose} style={{ ...iconBtn, color: 'var(--ink-3)' }}><Icon name="x" size={22} /></button>
        </div>
        <div style={{ maxHeight: 400, overflowY: 'auto', scrollbarWidth: 'none' }}>
          <FilterGroup label="Specialization">
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
              {SPECS.map(s => <button key={s} onClick={() => toggle(s)} className={'chip' + (sel.includes(s) ? ' active' : ' outline')}>{s}</button>)}
            </div>
          </FilterGroup>
          <FilterGroup label={`Max price · £${price}`}>
            <Slider value={price} onChange={setPrice} min={40} max={150} />
          </FilterGroup>
          <FilterGroup label="Minimum rating">
            <Segmented options={['Any', '4.0+', '4.5+', '4.8+']} value={rating} onChange={setRating} />
          </FilterGroup>
          <FilterGroup label="Session type">
            <Segmented options={['Any', 'Video', 'Chat']} value={type} onChange={setType} />
          </FilterGroup>
        </div>
        <div style={{ display: 'flex', gap: 12, marginTop: 18 }}>
          <button className="btn btn-secondary" style={{ flex: 1 }} onClick={() => { setSel([]); setPrice(150); setRating('Any'); setType('Any'); }}>Reset</button>
          <button className="btn btn-primary" style={{ flex: 2 }} onClick={onClose}>Show results</button>
        </div>
      </div>
    </>
  );
}
function FilterGroup({ label, children }) {
  return <div style={{ marginBottom: 22 }}>
    <div className="t-foot" style={{ fontWeight: 700, marginBottom: 12, color: 'var(--ink-2)' }}>{label}</div>
    {children}
  </div>;
}

/* empty state */
function EmptyState({ icon, title, body, action, onAction }) {
  return (
    <div className="anim-scale" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center', padding: '50px 24px' }}>
      <div style={{ width: 96, height: 96, borderRadius: '50%', background: 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 22 }}>
        <Icon name={icon} size={40} color="var(--ink-4)" stroke={1.7} />
      </div>
      <h3 className="t-title3">{title}</h3>
      <p className="t-body muted" style={{ marginTop: 8, maxWidth: 280 }}>{body}</p>
      {action && <button className="btn btn-tonal" style={{ width: 'auto', marginTop: 22, paddingLeft: 26, paddingRight: 26 }} onClick={onAction}>{action}</button>}
    </div>
  );
}
window.EmptyState = EmptyState;

/* ================= INSIGHT DETAIL (repurposed therapist profile) ================= */
const INSIGHT_DETAILS = {
  burnout: {
    title: 'Burnout Analysis', kind: 'Burnout report', icon: 'flame', color: 'var(--streak)',
    headline: 'Your burnout risk is easing', confidence: 81, band: 'Moderate · improving',
    metric: 38, metricLabel: 'Burnout index', metricDelta: -12,
    spark: [52, 50, 48, 47, 44, 41, 39, 38],
    factors: [
      { k: 'Workload pressure', v: 64, c: 'var(--topic-2)' },
      { k: 'Evening recovery', v: 58, c: 'var(--topic-4)' },
      { k: 'Sleep consistency', v: 47, c: 'var(--topic-3)' },
      { k: 'Sense of control', v: 61, c: 'var(--primary)' },
    ],
    recs: ['rc1', 'rc3'],
    context: 'Your burnout signals peaked in early May around a deadline cluster. Protecting your evenings and a steadier sleep window have helped them ease since.',
  },
};

window.SCREENS.insightDetail = function InsightDetail({ params }) {
  const ctx = dUC(AppCtx);
  const d = INSIGHT_DETAILS[params.type] || INSIGHT_DETAILS.burnout;
  return (
    <div className="mn-screen">
      <NavHeader title={d.kind} onBack={ctx.pop}
        right={<button className="nav-btn"><Icon name="share" size={18} stroke={1.9} /></button>} />
      <div className="mn-scroll" style={{ padding: '8px 22px 30px' }}>
        {/* hero */}
        <div className="card anim-up" style={{ padding: 20, marginBottom: 16 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginBottom: 16 }}>
            <IconTile icon={d.icon} color={d.color} size={56} round={16} />
            <div style={{ flex: 1 }}>
              <h1 className="t-title3" style={{ lineHeight: 1.25 }}>{d.headline}</h1>
              <div style={{ marginTop: 8 }}><Confidence value={d.confidence} /></div>
            </div>
          </div>
          <div className="card-inset" style={{ padding: 16 }}>
            <div style={{ display: 'flex', alignItems: 'center', marginBottom: 12 }}>
              <div style={{ flex: 1 }}>
                <div className="t-cap muted-3" style={{ textTransform: 'uppercase' }}>{d.metricLabel}</div>
                <div style={{ display: 'flex', alignItems: 'baseline', gap: 8, marginTop: 3 }}>
                  <span className="t-title1">{d.metric}</span>
                  <span className="t-foot" style={{ color: 'var(--green)', fontWeight: 700 }}>{d.metricDelta}%</span>
                </div>
              </div>
              <span className="chip outline" style={{ height: 28 }}>{d.band}</span>
            </div>
            <Spark data={d.spark} color={d.color} h={56} />
          </div>
        </div>

        {/* contributing factors */}
        <Section title="Contributing factors">
          <div className="card" style={{ padding: 18 }}>
            {d.factors.map(f => <EmotionBar key={f.k} label={f.k} value={f.v} color={f.c} />)}
          </div>
        </Section>

        {/* historical context */}
        <Section title="Historical context">
          <p className="t-body muted" style={{ lineHeight: 1.55 }}>{d.context}</p>
        </Section>

        {/* recommendations */}
        <Section title="Recommendations" action="See all">
          <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
            {d.recs.map(id => { const r = rec(id); return (
              <button key={id} className="card-flat pressable" onClick={() => ctx.push('recDetail', { id })} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 14, display: 'flex', alignItems: 'center', gap: 12 }}>
                <IconTile icon={r.icon} color={r.color} size={40} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div className="t-cap" style={{ color: r.color, fontWeight: 700 }}>{r.kind}</div>
                  <div className="t-callout" style={{ fontWeight: 600, marginTop: 1 }}>{r.title}</div>
                </div>
                <Icon name="chevR" size={18} color="var(--ink-4)" />
              </button>
            ); })}
          </div>
        </Section>
      </div>
    </div>
  );
};
/* alias so legacy references still resolve */
window.SCREENS.therapistProfile = window.SCREENS.insightDetail;

function Section({ title, action, children }) {
  return (
    <div style={{ marginTop: 26 }} className="anim-up">
      <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', marginBottom: 14 }}>
        <h3 className="t-title3">{title}</h3>
        {action && <span className="t-foot muted-3">{action}</span>}
      </div>
      {children}
    </div>
  );
}
window.Section = Section;

/* ================= BOOKING ================= */
window.SCREENS.booking = function Booking({ params }) {
  const ctx = dUC(AppCtx);
  const t = therapist(params.id) || THERAPISTS[0];
  const [date, setDate] = dUS(4);
  const [slot, setSlot] = dUS(null);
  const [type, setType] = dUS('Video');
  const [confirm, setConfirm] = dUS(false);
  const days = [['Mon', '2'], ['Tue', '3'], ['Wed', '4'], ['Thu', '5'], ['Fri', '6'], ['Sat', '7'], ['Sun', '8']];
  const slots = ['9:00', '10:00', '11:30', '1:00', '2:30', '4:00', '5:30'];
  const off = [1, 3];

  return (
    <div className="mn-screen">
      <NavHeader title="Book appointment" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 22px 24px' }}>
        <div className="card-flat" style={{ display: 'flex', gap: 12, alignItems: 'center', padding: 14, marginBottom: 24 }}>
          <div style={{ position: 'relative', width: 48, height: 48, borderRadius: 14, overflow: 'hidden' }}><PhotoPlaceholder name={t.name} /></div>
          <div style={{ flex: 1 }}><div className="t-headline">{t.name}</div><div className="t-foot muted">{t.spec}</div></div>
          <Stars value={t.rating} size={13} />
        </div>

        <h3 className="t-headline" style={{ marginBottom: 14 }}>Select a date · June</h3>
        <div style={{ display: 'flex', gap: 8, overflowX: 'auto', margin: '0 -22px 26px', padding: '0 22px', scrollbarWidth: 'none' }}>
          {days.map(([d, n], i) => {
            const on = date === i, disabled = off.includes(i);
            return <button key={i} disabled={disabled} onClick={() => setDate(i)} style={{
              flexShrink: 0, width: 56, padding: '12px 0', borderRadius: 16, border: 0, cursor: disabled ? 'default' : 'pointer',
              background: on ? 'var(--primary)' : disabled ? 'transparent' : 'var(--surface)', boxShadow: on ? '0 6px 16px var(--primary-ring)' : disabled ? 'none' : 'var(--sh-sm)',
              opacity: disabled ? 0.35 : 1, transition: 'all .2s var(--ease)', fontFamily: 'var(--font-ui)',
            }}>
              <div className="t-cap" style={{ color: on ? 'rgba(255,255,255,0.8)' : 'var(--ink-3)' }}>{d}</div>
              <div className="t-title3" style={{ marginTop: 4, color: on ? '#fff' : 'var(--ink)' }}>{n}</div>
            </button>;
          })}
        </div>

        <h3 className="t-headline" style={{ marginBottom: 14 }}>Available slots</h3>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 26 }}>
          {slots.map((s, i) => {
            const on = slot === s, taken = i === 2 || i === 5;
            return <button key={s} disabled={taken} onClick={() => setSlot(s)} style={{
              padding: '14px 0', borderRadius: 14, cursor: taken ? 'default' : 'pointer', fontFamily: 'var(--font-ui)',
              border: `1.5px solid ${on ? 'var(--primary)' : 'var(--hairline)'}`, fontSize: 15, fontWeight: 600,
              background: on ? 'var(--primary-tint)' : taken ? 'var(--fill)' : 'var(--surface)',
              color: on ? 'var(--primary)' : taken ? 'var(--ink-4)' : 'var(--ink)',
              textDecoration: taken ? 'line-through' : 'none', transition: 'all .18s var(--ease)',
            }}>{s} {i < 3 ? 'AM' : 'PM'}</button>;
          })}
        </div>

        <h3 className="t-headline" style={{ marginBottom: 14 }}>Session type</h3>
        <Segmented options={['Video', 'Voice', 'Chat']} value={type} onChange={setType} />
      </div>

      <div style={{ padding: '12px 22px calc(env(safe-area-inset-bottom,0) + 22px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)' }}>
        <button className="btn btn-primary" disabled={!slot} onClick={() => setConfirm(true)}>
          {slot ? `Confirm · ${days[date][0]} ${slot}` : 'Select a time'}
        </button>
      </div>

      {confirm && <ConfirmSheet t={t} day={days[date]} slot={slot} type={type}
        onClose={() => setConfirm(false)}
        onConfirm={() => ctx.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, { name: 'bookingSuccess', params: { id: t.id, day: days[date], slot, type } }])} />}
    </div>
  );
};

function ConfirmSheet({ t, day, slot, type, onClose, onConfirm }) {
  return (
    <>
      <div className="scrim" onClick={onClose} />
      <div className="sheet">
        <div className="sheet-grab" />
        <h2 className="t-title3" style={{ marginBottom: 18 }}>Confirm booking</h2>
        <div className="card-inset" style={{ padding: 16 }}>
          {[['Therapist', t.name], ['Date', `${day[0]}, ${day[1]} June`], ['Time', `${slot} PM`], ['Type', `${type} session · 50 min`], ['Total', `£${t.price}`]].map(([k, v], i, a) => (
            <div key={k} style={{ display: 'flex', justifyContent: 'space-between', padding: '11px 0', borderBottom: i < a.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
              <span className="t-callout muted">{k}</span>
              <span className="t-headline" style={{ color: k === 'Total' ? 'var(--primary)' : 'var(--ink)' }}>{v}</span>
            </div>
          ))}
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, margin: '16px 4px', color: 'var(--ink-3)' }}>
          <Icon name="info" size={16} stroke={2} />
          <span className="t-foot">Your request is sent to {t.name.split(' ')[0]} to accept.</span>
        </div>
        <button className="btn btn-primary" onClick={onConfirm}>Send booking request</button>
      </div>
    </>
  );
}

/* ================= BOOKING SUCCESS ================= */
window.SCREENS.bookingSuccess = function BookingSuccess({ params }) {
  const ctx = dUC(AppCtx);
  const t = therapist(params.id) || THERAPISTS[0];
  const day = params.day || ['Thu', '5'];
  return (
    <div className="mn-screen" style={{ background: 'radial-gradient(120% 60% at 50% 12%, var(--primary-tint) 0%, var(--bg) 48%)' }}>
      <div className="mn-scroll" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: `${SAFE_TOP + 20}px 24px 0`, textAlign: 'center' }}>
        <SuccessCheck />
        <h1 className="t-title1 anim-up" style={{ marginTop: 26 }}>Request sent</h1>
        <p className="t-body muted anim-up" style={{ marginTop: 8, maxWidth: 290 }}>
          We’ve let {t.name.split(' ')[0]} know. You’ll be notified the moment it’s confirmed.
        </p>
        <span className="badge badge-pending anim-up" style={{ marginTop: 16, height: 28, fontSize: 13, padding: '0 12px' }}>
          <Icon name="clock" size={14} stroke={2.2} /> Pending confirmation</span>

        <div className="card anim-up" style={{ marginTop: 26, padding: 18, width: '100%', textAlign: 'left' }}>
          <div style={{ display: 'flex', gap: 12, alignItems: 'center', marginBottom: 16 }}>
            <div style={{ position: 'relative', width: 46, height: 46, borderRadius: 13, overflow: 'hidden' }}><PhotoPlaceholder name={t.name} /></div>
            <div><div className="t-headline">{t.name}</div><div className="t-foot muted">{t.spec}</div></div>
          </div>
          {[['calendar', `${day[0]}, ${day[1]} June`], ['clock', `${params.slot || '4:00'} PM · 50 min`], ['video', `${params.type || 'Video'} session`]].map(([ic, v]) => (
            <div key={v} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '7px 0' }}>
              <Icon name={ic} size={18} color="var(--primary)" stroke={1.9} /><span className="t-callout" style={{ color: 'var(--ink-2)' }}>{v}</span>
            </div>
          ))}
        </div>
      </div>
      <div style={{ padding: '12px 24px calc(env(safe-area-inset-bottom,0) + 24px)', display: 'flex', flexDirection: 'column', gap: 10 }}>
        <button className="btn btn-primary" onClick={() => ctx.push('chat', { id: 'c1' })}>Message {t.name.split(' ')[0]}</button>
        <button className="btn btn-ghost" onClick={() => ctx.reset('userApp', { tab: 'home' })}>Back to home</button>
      </div>
    </div>
  );
};
