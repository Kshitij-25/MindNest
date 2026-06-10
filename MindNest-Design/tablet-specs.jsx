/* MindNest — Tablet · Spec pages (motion system + accessibility guidelines) */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: sUS } = React;

const EASINGS = [
  { name: 'Standard', token: '--ease', css: 'cubic-bezier(.22,.61,.36,1)', cp: [.22, .61, .36, 1], use: 'Most UI — buttons, cards, list moves' },
  { name: 'Decelerate', token: '--ease-out', css: 'cubic-bezier(.16,1,.3,1)', cp: [.16, 1, .3, 1], use: 'Entrances — sheets, pushes, reveals' },
  { name: 'Spring', token: '--ease-spring', css: 'cubic-bezier(.34,1.56,.64,1)', cp: [.34, 1.56, .64, 1], use: 'Delight — toggles, mood pops, badges' },
];
const DURATIONS = [
  { name: 'instant', ms: 0, use: 'State that must feel immediate' },
  { name: 'quick', ms: 150, use: 'Hover, press, small toggles' },
  { name: 'base', ms: 250, use: 'Most transitions, fades' },
  { name: 'slow', ms: 420, use: 'Screen push / pop, sheets' },
  { name: 'expressive', ms: 600, use: 'Hero reveals, celebrations' },
];

function EaseCurve({ cp, playing }) {
  const w = 120, h = 120, p = 10;
  const [x1, y1, x2, y2] = cp;
  const X = x => p + x * (w - 2 * p), Y = y => (h - p) - y * (h - 2 * p);
  return (
    <svg width="100%" height="120" viewBox={`0 0 ${w} ${h}`} style={{ overflow: 'visible' }}>
      <line x1={p} y1={h - p} x2={w - p} y2={h - p} stroke="var(--hairline)" strokeWidth="1" />
      <line x1={p} y1={h - p} x2={p} y2={p} stroke="var(--hairline)" strokeWidth="1" />
      <line x1={X(0)} y1={Y(0)} x2={X(x1)} y2={Y(y1)} stroke="var(--ink-4)" strokeWidth="1" strokeDasharray="3 3" />
      <line x1={X(1)} y1={Y(1)} x2={X(x2)} y2={Y(y2)} stroke="var(--ink-4)" strokeWidth="1" strokeDasharray="3 3" />
      <path d={`M${X(0)} ${Y(0)} C${X(x1)} ${Y(y1)}, ${X(x2)} ${Y(y2)}, ${X(1)} ${Y(1)}`} fill="none" stroke="var(--primary)" strokeWidth="2.5" strokeLinecap="round" />
      <circle cx={X(x1)} cy={Y(y1)} r="3.5" fill="var(--primary)" />
      <circle cx={X(x2)} cy={Y(y2)} r="3.5" fill="var(--primary)" />
    </svg>
  );
}

function MotionDemo({ css, motion }) {
  const [on, setOn] = sUS(false);
  return (
    <div onClick={() => { setOn(o => !o); }} style={{ cursor: 'pointer', padding: '14px 12px', borderRadius: 12, background: 'var(--surface-3)', position: 'relative', overflow: 'hidden' }}>
      <div style={{ height: 28, position: 'relative' }}>
        <div style={{ position: 'absolute', top: 2, left: on ? 'calc(100% - 28px)' : 0, width: 24, height: 24, borderRadius: 7, background: 'var(--primary)',
          transition: motion ? `left .7s ${css}` : 'none' }} />
      </div>
      <div className="tt-cap muted-3" style={{ marginTop: 6, textAlign: 'center' }}>Tap to replay</div>
    </div>
  );
}

window.TABLET_SCREENS.motion = function MotionSpec({ ctx, scrollRef }) {
  const motion = ctx.a11y.motion;
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div style={{ marginBottom: 24 }}>
          <h1 className="tt-h1">Motion system</h1>
          <p className="tt-body muted" style={{ marginTop: 6, maxWidth: 540 }}>Motion in MindNest is calm and purposeful — it guides attention and confirms actions without demanding them. {!motion && <strong style={{ color: 'var(--clay)' }}>Reduced motion is on, so demos are stilled.</strong>}</p>
        </div>

        <TSection title="Easing curves" sub="Three named curves cover every interaction">
          <div className="tb-grid tb-g3">
            {EASINGS.map(e => (
              <div key={e.name} className="tb-card" style={{ padding: 20 }}>
                <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', marginBottom: 8 }}>
                  <h3 className="tt-h3">{e.name}</h3>
                  <code className="tt-cap" style={{ color: 'var(--primary)', fontWeight: 700 }}>{e.token}</code>
                </div>
                <EaseCurve cp={e.cp} />
                <code className="tt-cap muted-3" style={{ display: 'block', marginTop: 8, fontSize: 11 }}>{e.css}</code>
                <div style={{ marginTop: 12 }}><MotionDemo css={e.css} motion={motion} /></div>
                <p className="tt-cap muted" style={{ marginTop: 12, lineHeight: 1.5 }}>{e.use}</p>
              </div>
            ))}
          </div>
        </TSection>

        <TSection title="Duration scale" sub="Shorter for small moves, longer for large surfaces">
          <div className="tb-card" style={{ padding: 22 }}>
            {DURATIONS.map(d => (
              <div key={d.name} style={{ display: 'flex', alignItems: 'center', gap: 18, padding: '12px 0', borderBottom: d.name !== 'expressive' ? '0.5px solid var(--hairline)' : 'none' }}>
                <div style={{ width: 110, flexShrink: 0 }}><div className="tt-head">{d.name}</div><code className="tt-cap muted-3 tt-num">{d.ms}ms</code></div>
                <div style={{ flex: 1, height: 8, borderRadius: 999, background: 'var(--fill)', overflow: 'hidden' }}>
                  <div style={{ height: '100%', width: `${Math.max(4, (d.ms / 600) * 100)}%`, borderRadius: 999, background: 'var(--primary)' }} /></div>
                <span className="tt-sub muted" style={{ width: 230, flexShrink: 0 }}>{d.use}</span>
              </div>
            ))}
          </div>
        </TSection>

        <TSection title="Named transitions" sub="Reusable choreography across the app">
          <div className="tb-grid tb-g2">
            {[['Screen push', 'translateX 100%→0', 'slow · decelerate', 'arrowR'], ['Bottom sheet', 'translateY 100%→0', 'slow · decelerate', 'layers'], ['Tab crossfade', 'opacity + 8px rise', 'base · standard', 'grid'], ['Delight pop', 'scale 0.6→1.08→1', 'expressive · spring', 'sparkle']].map(([t, d, m, ic]) => (
              <div key={t} className="tb-card-flat" style={{ padding: 18, display: 'flex', gap: 14, alignItems: 'center' }}>
                <div style={{ width: 44, height: 44, borderRadius: 12, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}><Icon name={ic} size={20} color="var(--primary)" stroke={2} /></div>
                <div style={{ flex: 1 }}><div className="tt-head">{t}</div><code className="tt-cap muted-3">{d}</code></div>
                <span className="tb-chip outline" style={{ height: 26 }}>{m}</span>
              </div>
            ))}
          </div>
        </TSection>

        <TSection title="Principles">
          <div className="tb-grid tb-g3">
            {[['heart', 'Calm by default', 'Nothing pulses or loops unless it earns it. Wellbeing first.'], ['arrowR', 'Motion has meaning', 'Every animation explains a change in state or space.'], ['checkCircle', 'Always interruptible', 'Honors Reduced Motion — transitions collapse to instant.']].map(([ic, t, s]) => (
              <div key={t} className="tb-card" style={{ padding: 20 }}>
                <Icon name={ic} size={24} color="var(--primary)" stroke={2} />
                <div className="tt-head" style={{ marginTop: 12 }}>{t}</div><p className="tt-sub muted" style={{ marginTop: 6, lineHeight: 1.5 }}>{s}</p>
              </div>
            ))}
          </div>
        </TSection>
      </div>
    </div>
  );
};

/* ============================================================
   ACCESSIBILITY GUIDELINES
   ============================================================ */
const CONTRAST_PAIRS = [
  { fg: 'Ink on background', a: 'var(--ink)', b: 'var(--bg)', ratio: '14.2:1', grade: 'AAA' },
  { fg: 'Secondary text', a: 'var(--ink-2)', b: 'var(--bg)', ratio: '7.4:1', grade: 'AAA' },
  { fg: 'On primary', a: '#fff', b: 'var(--primary)', ratio: '4.9:1', grade: 'AA' },
  { fg: 'Primary on tint', a: 'var(--primary)', b: 'var(--primary-tint)', ratio: '4.6:1', grade: 'AA' },
];

window.TABLET_SCREENS.guidelines = function A11yGuidelines({ go, scrollRef }) {
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div style={{ marginBottom: 24 }}>
          <h1 className="tt-h1">Accessibility guidelines</h1>
          <p className="tt-body muted" style={{ marginTop: 6, maxWidth: 540 }}>MindNest commits to WCAG 2.2 AA across every surface. These are the rules we design and build against.</p>
        </div>

        <TSection title="Colour & contrast" sub="Text meets or exceeds AA at every size">
          <div className="tb-grid tb-g2">
            {CONTRAST_PAIRS.map(c => (
              <div key={c.fg} className="tb-card-flat" style={{ padding: 0, overflow: 'hidden', display: 'flex' }}>
                <div style={{ width: 96, background: c.b, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                  <span style={{ color: c.a, fontWeight: 800, fontSize: 26 }}>Aa</span></div>
                <div style={{ padding: 16, flex: 1 }}>
                  <div className="tt-head">{c.fg}</div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 6 }}>
                    <code className="tt-sub tt-num" style={{ fontWeight: 700 }}>{c.ratio}</code>
                    <span className="badge badge-accept">{c.grade}</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </TSection>

        <div className="tb-grid tb-g2">
          <TSection title="Touch targets">
            <div className="tb-card" style={{ padding: 22 }}>
              <div style={{ display: 'flex', alignItems: 'flex-end', gap: 16, marginBottom: 16 }}>
                <div style={{ width: 44, height: 44, borderRadius: 12, background: 'var(--primary)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="check" size={20} color="#fff" stroke={2.6} /></div>
                <div><div className="tt-h3 tt-num">44 × 44pt</div><div className="tt-cap muted-3">Minimum tappable size</div></div>
              </div>
              <p className="tt-sub muted" style={{ lineHeight: 1.5 }}>Every button, toggle and row hit area is at least 44pt with 8pt of spacing between adjacent targets.</p>
            </div>
          </TSection>
          <TSection title="Focus & keyboard">
            <div className="tb-card" style={{ padding: 22 }}>
              <button style={{ padding: '12px 20px', borderRadius: 12, border: 0, background: 'var(--surface-3)', outline: '3px solid var(--primary)', outlineOffset: 3, fontWeight: 600, fontFamily: 'var(--font-ui)', fontSize: 15, marginBottom: 16 }}>Focused element</button>
              <p className="tt-sub muted" style={{ lineHeight: 1.5 }}>A visible 3px focus ring follows logical order. All flows are operable by keyboard and switch control.</p>
            </div>
          </TSection>
        </div>

        <TSection title="Do & don’t" style={{ marginTop: 8 }}>
          <div className="tb-grid tb-g2">
            <div className="tb-card" style={{ padding: 20, borderTop: '3px solid var(--green)' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 14, color: 'var(--green)' }}><Icon name="checkCircle" size={20} stroke={2.2} /><span className="tt-head">Do</span></div>
              {['Pair colour with text or icons, never colour alone', 'Label every icon-only button for screen readers', 'Let text reflow up to 150% without clipping', 'Keep motion optional and meaningful'].map(d => (
                <div key={d} style={{ display: 'flex', gap: 10, padding: '7px 0' }}><Icon name="check" size={17} color="var(--green)" stroke={2.4} style={{ marginTop: 2, flexShrink: 0 }} /><span className="tt-sub" style={{ color: 'var(--ink-2)' }}>{d}</span></div>
              ))}
            </div>
            <div className="tb-card" style={{ padding: 20, borderTop: '3px solid var(--red)' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 14, color: 'var(--red)' }}><Icon name="x" size={20} stroke={2.2} /><span className="tt-head">Don’t</span></div>
              {['Rely on red/green to convey mood state', 'Trap focus inside modals or sheets', 'Use text under 12pt for body content', 'Auto-play looping motion behind text'].map(d => (
                <div key={d} style={{ display: 'flex', gap: 10, padding: '7px 0' }}><Icon name="x" size={17} color="var(--red)" stroke={2.4} style={{ marginTop: 2, flexShrink: 0 }} /><span className="tt-sub" style={{ color: 'var(--ink-2)' }}>{d}</span></div>
              ))}
            </div>
          </div>
        </TSection>

        <div className="tb-card" style={{ padding: 22, display: 'flex', alignItems: 'center', gap: 16, marginTop: 8 }}>
          <div style={{ width: 48, height: 48, borderRadius: 13, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}><Icon name="eye" size={22} color="var(--primary)" stroke={2} /></div>
          <div style={{ flex: 1 }}><div className="tt-head">Try the live demo</div><div className="tt-sub muted-3">Toggle dynamic type, contrast and reduced motion across the whole app.</div></div>
          <button className="btn btn-primary btn-sm" style={{ width: 'auto', padding: '0 22px' }} onClick={() => go('a11y')}>Open accessibility</button>
        </div>
      </div>
    </div>
  );
};
