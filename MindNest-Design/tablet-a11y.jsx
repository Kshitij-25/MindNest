/* MindNest — Tablet · Accessibility live demo */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: aUS, useRef: aUR, useLayoutEffect: aULE } = React;

const TYPE_STOPS = [
  { v: 0.85, label: 'XS' }, { v: 0.95, label: 'S' }, { v: 1, label: 'M' },
  { v: 1.15, label: 'L' }, { v: 1.3, label: 'XL' }, { v: 1.5, label: 'XXL' },
];

window.TABLET_SCREENS.a11y = function A11yScreen({ ctx, scrollRef }) {
  const a = ctx.a11y, set = ctx.setA11y;
  const typeIdx = TYPE_STOPS.reduce((best, s, i) => Math.abs(s.v - a.type) < Math.abs(TYPE_STOPS[best].v - a.type) ? i : best, 0);

  /* ---- screen reader focus walk ---- */
  const stageRef = aUR(null);
  const tRefs = aUR([]);
  const [sr, setSr] = aUS(false);
  const [idx, setIdx] = aUS(0);
  const [box, setBox] = aUS(null);
  const SR_ITEMS = [
    { label: 'How are you feeling? Heading', role: 'Heading, level 3' },
    { label: 'Good. Mood button. 4 of 5', role: 'Button. Double-tap to log' },
    { label: 'Next session, Thursday 4 PM with Dr. Okafor', role: 'Button' },
    { label: 'Join session', role: 'Button. Double-tap to start video' },
  ];
  aULE(() => {
    if (!sr) { setBox(null); return; }
    const el = tRefs.current[idx], stage = stageRef.current;
    if (!el || !stage) return;
    let x = 0, y = 0, n = el;
    while (n && n !== stage) { x += n.offsetLeft; y += n.offsetTop; n = n.offsetParent; }
    setBox({ top: y - 6, left: x - 6, width: el.offsetWidth + 12, height: el.offsetHeight + 12 });
  }, [sr, idx, a.type, a.contrast]);
  const reg = i => el => { tRefs.current[i] = el; };

  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div style={{ marginBottom: 22 }}>
          <h1 className="tt-h1">Accessibility</h1>
          <p className="tt-body muted" style={{ marginTop: 6, maxWidth: 520 }}>Every control below applies live across the whole tablet experience. MindNest is built to WCAG 2.2 AA.</p>
        </div>

        <div className="tb-grid" style={{ gridTemplateColumns: '1fr 1fr' }}>
          {/* controls */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 18 }}>
            <div className="tb-card" style={{ padding: 22 }}>
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 4 }}>
                <h3 className="tt-h3">Dynamic Type</h3>
                <span className="tt-sub tt-num" style={{ fontWeight: 700, color: 'var(--primary)' }}>{Math.round(a.type * 100)}%</span>
              </div>
              <p className="tt-sub muted-3" style={{ marginBottom: 16 }}>Scales every label, heading and body text.</p>
              <div style={{ display: 'flex', gap: 8 }}>
                {TYPE_STOPS.map((s, i) => (
                  <button key={s.label} onClick={() => set({ type: s.v })} style={{ flex: 1, padding: '10px 0', borderRadius: 11, cursor: 'pointer', fontFamily: 'var(--font-ui)',
                    border: typeIdx === i ? '1.5px solid var(--primary)' : '1.5px solid var(--hairline)', background: typeIdx === i ? 'var(--primary-tint)' : 'var(--surface)',
                    color: typeIdx === i ? 'var(--primary)' : 'var(--ink-2)', fontWeight: 700, fontSize: 11 + i * 1.5 }}>A</button>
                ))}
              </div>
              <div className="tb-card-inset" style={{ marginTop: 16, padding: 16 }}>
                <div className="tt-cap muted-3" style={{ fontWeight: 600, marginBottom: 4 }}>PREVIEW</div>
                <div className="tt-head">A slower morning</div>
                <div className="tt-body muted" style={{ marginTop: 4 }}>Woke up before the alarm and let myself lie still.</div>
              </div>
            </div>

            <ToggleCard icon="pulse" title="Reduced motion" sub="Removes transitions, parallax and looping animations." on={!a.motion} onChange={v => set({ motion: !v })} />
            <ToggleCard icon="eye" title="High contrast" sub="Boosts text and border contrast to 7:1 (AAA)." on={a.contrast} onChange={v => set({ contrast: v })} />
            <ToggleCard icon="message" title="Screen reader hints" sub="Shows VoiceOver labels & focus order in the preview." on={sr} onChange={v => { setSr(v); setIdx(0); }} />
          </div>

          {/* live preview / SR stage */}
          <div className="tb-card" style={{ padding: 22, position: 'relative', overflow: 'hidden' }}>
            <h3 className="tt-h3" style={{ marginBottom: 4 }}>Live preview</h3>
            <p className="tt-sub muted-3" style={{ marginBottom: 16 }}>{sr ? 'VoiceOver is reading the screen' : 'Reflects your settings in real time'}</p>

            <div ref={stageRef} style={{ position: 'relative' }}>
              <div className="tb-card-inset" style={{ padding: 20 }}>
                <h3 ref={reg(0)} className="tt-h3" style={{ marginBottom: 14 }}>How are you feeling?</h3>
                <div style={{ display: 'flex', gap: 10, marginBottom: 20 }}>
                  {[1, 2, 3, 4, 5].map(lv => (
                    <div key={lv} ref={lv === 4 ? reg(1) : null} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6 }}>
                      <MoodFace level={lv} size={44} soft={lv !== 4} />
                      <span className="tt-cap" style={{ color: lv === 4 ? 'var(--ink)' : 'var(--ink-3)', fontWeight: 700 }}>{MOOD_LABELS[lv - 1]}</span>
                    </div>
                  ))}
                </div>
                <div ref={reg(2)} className="tb-card" style={{ padding: 16, display: 'flex', alignItems: 'center', gap: 12, marginBottom: 14 }}>
                  <Avatar name="Amara Okafor" size={44} photo />
                  <div style={{ flex: 1 }}><div className="tt-head">Next session</div><div className="tt-sub muted">Thu, 5 Jun · 4:00 PM</div></div>
                  <Icon name="chevR" size={18} color="var(--ink-4)" />
                </div>
                <button ref={reg(3)} className="btn btn-primary btn-sm"><Icon name="video" size={17} stroke={2} /> Join session</button>
              </div>

              {/* SR focus box + caption */}
              {sr && box && <div className="tb-srbox" style={{ top: box.top, left: box.left, width: box.width, height: box.height }} />}
            </div>

            {sr && (
              <div style={{ marginTop: 16, padding: 16, borderRadius: 14, background: '#12170D', color: '#ECEFE6', display: 'flex', alignItems: 'center', gap: 14 }}>
                <div style={{ width: 36, height: 36, borderRadius: '50%', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}><Icon name="message" size={18} color="#9DBE82" stroke={2} /></div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontWeight: 700, fontSize: 14 }}>{SR_ITEMS[idx].label}</div>
                  <div style={{ fontSize: 12.5, color: '#9AA28C', marginTop: 2 }}>{SR_ITEMS[idx].role}</div>
                </div>
                <button className="tb-iconbtn" style={{ background: 'rgba(255,255,255,0.1)', color: '#fff', width: 38, height: 38 }} onClick={() => setIdx(i => (i - 1 + SR_ITEMS.length) % SR_ITEMS.length)}><Icon name="chevL" size={18} stroke={2.2} /></button>
                <button className="tb-iconbtn" style={{ background: 'var(--primary)', color: '#fff', width: 38, height: 38 }} onClick={() => setIdx(i => (i + 1) % SR_ITEMS.length)}><Icon name="chevR" size={18} stroke={2.2} /></button>
              </div>
            )}
          </div>
        </div>

        {/* compliance row */}
        <div className="tb-grid tb-g4" style={{ marginTop: 22 }}>
          {[['checkCircle', 'WCAG 2.2 AA', 'Contrast, targets, focus'], ['user', 'VoiceOver & TalkBack', 'Full label coverage'], ['sliders', 'Dynamic Type', 'Up to 150% scaling'], ['pulse', 'Reduced motion', 'Honors system setting']].map(([ic, t, s]) => (
            <div key={t} className="tb-card-flat" style={{ padding: 18 }}>
              <div style={{ width: 38, height: 38, borderRadius: 11, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 12 }}><Icon name={ic} size={19} color="var(--primary)" stroke={2} /></div>
              <div className="tt-head">{t}</div><div className="tt-cap muted-3" style={{ marginTop: 3 }}>{s}</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

function ToggleCard({ icon, title, sub, on, onChange }) {
  return (
    <div className="tb-card" style={{ padding: 20, display: 'flex', alignItems: 'center', gap: 14 }}>
      <div style={{ width: 44, height: 44, borderRadius: 12, background: on ? 'var(--primary-tint)' : 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
        <Icon name={icon} size={21} color={on ? 'var(--primary)' : 'var(--ink-3)'} stroke={2} /></div>
      <div style={{ flex: 1 }}><div className="tt-head">{title}</div><div className="tt-sub muted-3" style={{ marginTop: 2 }}>{sub}</div></div>
      <Toggle on={on} onChange={onChange} />
    </div>
  );
}
