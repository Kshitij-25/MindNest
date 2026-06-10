/* MindNest — shared UI components & icon set */

/* ----------------------------------------------------------------
   Icon — simple stroke icons, 24x24, currentColor
   ---------------------------------------------------------------- */
const ICONS = {
  home: 'M3 10.2 12 3l9 7.2M5 9v10a1 1 0 0 0 1 1h3v-6h6v6h3a1 1 0 0 0 1-1V9',
  compass: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM15.5 8.5l-2 5-5 2 2-5 5-2Z',
  message: 'M21 11.5a8.5 8.5 0 0 1-12.2 7.7L3 21l1.8-5.8A8.5 8.5 0 1 1 21 11.5Z',
  user: 'M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM5 20c.7-3.6 3.5-5.5 7-5.5s6.3 1.9 7 5.5',
  heart: 'M12 20s-7-4.4-9.2-8.4C1.2 8.7 2.6 5.5 5.7 5.1 7.7 4.8 9.4 6 12 8.3c2.6-2.3 4.3-3.5 6.3-3.2 3.1.4 4.5 3.6 2.9 6.5C19 15.6 12 20 12 20Z',
  calendar: 'M7 3v3M17 3v3M3.5 9h17M5 5h14a1.5 1.5 0 0 1 1.5 1.5V19A1.5 1.5 0 0 1 19 20.5H5A1.5 1.5 0 0 1 3.5 19V6.5A1.5 1.5 0 0 1 5 5Z',
  bell: 'M18 8.5a6 6 0 1 0-12 0c0 6-2.5 7.5-2.5 7.5h17S18 14.5 18 8.5ZM10 19.5a2.2 2.2 0 0 0 4 0',
  search: 'M11 18a7 7 0 1 0 0-14 7 7 0 0 0 0 14ZM20 20l-4-4',
  sliders: 'M4 7h10M18 7h2M4 17h2M10 17h10M14 4v6M8 14v6',
  chevL: 'M15 5l-7 7 7 7',
  chevR: 'M9 5l7 7-7 7',
  chevDown: 'M5 9l7 7 7-7',
  plus: 'M12 5v14M5 12h14',
  check: 'M4 12.5 9.5 18 20 6.5',
  x: 'M6 6l12 12M18 6 6 18',
  star: 'M12 3.5l2.5 5.4 5.9.7-4.4 4 1.2 5.8L12 16.6 6.8 19.4 8 13.6l-4.4-4 5.9-.7L12 3.5Z',
  shield: 'M12 3.5 5 6v6c0 4.5 3 7 7 8.5 4-1.5 7-4 7-8.5V6l-7-2.5ZM9 12l2 2 4-4',
  clock: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 7.5V12l3 2',
  camera: 'M4 8.5h3l1.5-2h7L17 8.5h3a1 1 0 0 1 1 1V18a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a1 1 0 0 1 1-1ZM12 16.5a3.2 3.2 0 1 0 0-6.4 3.2 3.2 0 0 0 0 6.4Z',
  upload: 'M12 16V4m0 0L7.5 8.5M12 4l4.5 4.5M5 18.5h14',
  doc: 'M14 3v5h5M14 3H6.5A1.5 1.5 0 0 0 5 4.5v15A1.5 1.5 0 0 0 6.5 21h11a1.5 1.5 0 0 0 1.5-1.5V8l-5-5ZM9 13h6M9 16.5h6',
  mail: 'M3.5 7.5h17v10a1 1 0 0 1-1 1h-15a1 1 0 0 1-1-1v-10ZM4 8l8 6 8-6',
  lock: 'M7 10V8a5 5 0 0 1 10 0v2M5.5 10h13a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1h-13a1 1 0 0 1-1-1v-8a1 1 0 0 1 1-1Z',
  eye: 'M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12ZM12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z',
  eyeOff: 'M4 4l16 16M9.5 9.6A3 3 0 0 0 14.4 14.5M7 7.2C4.3 8.8 2.5 12 2.5 12s3.5 6.5 9.5 6.5c1.6 0 3-.4 4.2-1M11 5.6c.3 0 .7-.1 1-.1 6 0 9.5 6.5 9.5 6.5s-.8 1.4-2.2 2.9',
  send: 'M4.5 12 20 4.5l-4 15.5-4.5-6L17 7M11.5 14l-3 3.5',
  phone: 'M6.5 4h3l1.5 4-2 1.5a11 11 0 0 0 5 5l1.5-2 4 1.5v3a1.5 1.5 0 0 1-1.6 1.5C12 22.5 5.5 16 4.5 9.6A1.5 1.5 0 0 1 6 8',
  video: 'M3.5 7.5h11a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1h-11a1 1 0 0 1-1-1v-7a1 1 0 0 1 1-1ZM15.5 11l5-3v8l-5-3',
  sun: 'M12 16a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM12 2.5v2M12 19.5v2M4.5 4.5l1.5 1.5M18 18l1.5 1.5M2.5 12h2M19.5 12h2M4.5 19.5 6 18M18 6l1.5-1.5',
  moon: 'M20 13.5A8 8 0 1 1 10.5 4 6.5 6.5 0 0 0 20 13.5Z',
  edit: 'M4 20h4L19 9l-4-4L4 16v4ZM14 6l4 4',
  logout: 'M15 12H5m0 0 3.5-3.5M5 12l3.5 3.5M11 5h6a1.5 1.5 0 0 1 1.5 1.5v11A1.5 1.5 0 0 1 17 19h-6',
  sparkle: 'M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8L12 3ZM18.5 14l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8.8-2.2Z',
  sleep: 'M8 6h5l-5 6h5M14 13h4l-4 5h4',
  brain: 'M9 4.5a2.5 2.5 0 0 0-2.5 2.5A2.5 2.5 0 0 0 4.5 9.5 2.5 2.5 0 0 0 6 14a2.5 2.5 0 0 0 3 3.5V4.5ZM15 4.5A2.5 2.5 0 0 1 17.5 7 2.5 2.5 0 0 1 19.5 9.5 2.5 2.5 0 0 1 18 14a2.5 2.5 0 0 1-3 3.5V4.5Z',
  pulse: 'M3 12h3.5l2-6 3.5 12 2.5-7 1.5 1h5',
  filter: 'M3.5 6h17M6.5 12h11M10 18h4',
  arrowR: 'M5 12h14m0 0-6-6m6 6-6 6',
  back: 'M15 5l-7 7 7 7',
  more: 'M5 12h.01M12 12h.01M19 12h.01',
  bookmark: 'M7 4h10a1 1 0 0 1 1 1v15l-6-4-6 4V5a1 1 0 0 1 1-1Z',
  location: 'M12 21s7-5.5 7-11a7 7 0 1 0-14 0c0 5.5 7 11 7 11ZM12 13a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z',
  globe: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM3.5 12h17M12 3c2.5 2.4 3.8 5.6 3.8 9s-1.3 6.6-3.8 9c-2.5-2.4-3.8-5.6-3.8-9S9.5 5.4 12 3Z',
  award: 'M12 14a5 5 0 1 0 0-10 5 5 0 0 0 0 10ZM8.5 13l-1.5 8 5-2.5 5 2.5-1.5-8',
  chat2: 'M4 6.5A1.5 1.5 0 0 1 5.5 5h10A1.5 1.5 0 0 1 17 6.5v6A1.5 1.5 0 0 1 15.5 14H9l-4 3.5V6.5Z',
  grid: 'M4 4h7v7H4zM13 4h7v7h-7zM4 13h7v7H4zM13 13h7v7h-7z',
  trend: 'M4 16l5-5 3 3 7-7m0 0h-4m4 0v4',
  info: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 11v5M12 7.5h.01',
  share: 'M16 6l-4-4-4 4M12 2v13M5 12v6.5a1.5 1.5 0 0 0 1.5 1.5h11a1.5 1.5 0 0 0 1.5-1.5V12',
  pen: 'M5 19l1-4.5L16.5 4a2.1 2.1 0 0 1 3 3L9 17.5 5 19ZM14 6.5l3 3',
  image: 'M4 5h16a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1ZM3.5 16l4.5-4 3 2.5 4.5-4.5 5 5M9 10.5a1.6 1.6 0 1 0 0-3.2 1.6 1.6 0 0 0 0 3.2Z',
  flame: 'M12 21c3.3 0 6-2.3 6-5.6 0-3.7-3-5.2-2.3-9.4C13 7 11 8.6 10.4 11 9 9.6 9 8 9 6.4 6.7 8 6 11 6 13.6 6 17.6 8.7 21 12 21Z',
  layers: 'M12 3l9 4.5-9 4.5-9-4.5 9-4.5ZM3 12.5l9 4.5 9-4.5M3 16.5l9 4.5 9-4.5',
  bookOpen: 'M12 6.4C10.4 5 8 4.6 4 5v13c4-.4 6.4 0 8 1.4M12 6.4C13.6 5 16 4.6 20 5v13c-4-.4-6.4 0-8 1.4M12 6.4V19.4',
  lightbulb: 'M9.5 18.5h5M10.5 21.5h3M12 3a6 6 0 0 0-3.8 10.6c.6.5 1.1 1.1 1.3 1.9h5c.2-.8.7-1.4 1.3-1.9A6 6 0 0 0 12 3Z',
  tag: 'M3.5 11V5.5A2 2 0 0 1 5.5 3.5H11l9.5 9.5-7 7L3.5 11ZM7.5 8a1 1 0 1 0 0-.01',
  checkCircle: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM8 12l3 3 5.5-5.5',
  feather: 'M19 5a5.5 5.5 0 0 0-7.8 0L5 11.2V19h7.8l6.2-6.2A5.5 5.5 0 0 0 19 5ZM5 19l7-7M14 8l-3 3',
  smile: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM8.5 14c.8 1.2 2 2 3.5 2s2.7-.8 3.5-2M9 9.5h.01M15 9.5h.01',
  zap: 'M13 3 5 13h6l-1 8 8-10h-6l1-8Z',
  wind: 'M3 9h11a2.5 2.5 0 1 0-2.5-2.5M3 14h15a2.5 2.5 0 1 1-2.5 2.5M3 12h7',
  droplet: 'M12 3.5c3 3.6 6 6.9 6 10.2A6 6 0 0 1 6 13.7c0-3.3 3-6.6 6-10.2Z',
  repeat: 'M4 9a4 4 0 0 1 4-4h9m0 0-3-3m3 3-3 3M20 15a4 4 0 0 1-4 4H7m0 0 3 3m-3-3 3-3',
  target: 'M12 21a9 9 0 1 0 0-18 9 9 0 0 0 0 18ZM12 16.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM12 12h.01',
};

function Icon({ name, size = 24, stroke = 2, color = 'currentColor', fill = 'none', style }) {
  const d = ICONS[name] || '';
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill={fill} stroke={color}
      strokeWidth={stroke} strokeLinecap="round" strokeLinejoin="round"
      style={{ flexShrink: 0, ...style }}>
      {d.split('M').filter(Boolean).map((seg, i) => <path key={i} d={'M' + seg} />)}
    </svg>
  );
}

/* ----------------------------------------------------------------
   Avatar — initials or photo placeholder
   ---------------------------------------------------------------- */
const AVA_HUES = ['#7C9D6B', '#6FA98C', '#A6886B', '#8B95B0', '#B0848B', '#6E9AA6'];
function avaHue(name = '') {
  let h = 0; for (let i = 0; i < name.length; i++) h = name.charCodeAt(i) + ((h << 5) - h);
  return AVA_HUES[Math.abs(h) % AVA_HUES.length];
}
function initials(name = '') {
  return name.split(' ').filter(Boolean).slice(0, 2).map(w => w[0]).join('').toUpperCase();
}
function Avatar({ name = '', size = 48, photo = false, ring = false, style }) {
  const fs = Math.round(size * 0.38);
  return (
    <div className="avatar" style={{
      width: size, height: size, fontSize: fs,
      background: photo ? `linear-gradient(150deg, ${avaHue(name)}, ${avaHue(name + 'x')})` : avaHue(name),
      boxShadow: ring ? '0 0 0 3px var(--surface), 0 0 0 4.5px var(--primary-ring)' : 'none',
      position: 'relative', ...style,
    }}>
      {photo
        ? <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Icon name="user" size={size * 0.5} color="rgba(255,255,255,0.92)" stroke={1.6} />
          </div>
        : initials(name)}
    </div>
  );
}

/* ----------------------------------------------------------------
   MoodFace — 5 soft expressions (circle + dots + mouth arc)
   ---------------------------------------------------------------- */
const MOOD_LABELS = ['Struggling', 'Low', 'Okay', 'Good', 'Great'];
const MOOD_VARS = ['var(--mood-1)', 'var(--mood-2)', 'var(--mood-3)', 'var(--mood-4)', 'var(--mood-5)'];
// mouth path per level (1..5)
const MOUTHS = {
  1: 'M9 17c1-2 5-2 6 0',     // frown
  2: 'M9 16.2c1-1 5-1 6 0',   // slight frown
  3: 'M9 16h6',               // flat
  4: 'M9 15.5c1 1.4 5 1.4 6 0',  // smile
  5: 'M8.5 15c1.2 2.4 5.8 2.4 7 0', // big smile
};
function MoodFace({ level = 3, size = 56, color, soft = true, style }) {
  const c = color || MOOD_VARS[level - 1];
  const eyeY = level >= 4 ? 10.5 : 11;
  return (
    <div style={{
      width: size, height: size, borderRadius: '50%',
      background: soft ? `color-mix(in srgb, ${c} 26%, var(--surface))` : c,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      ...style,
    }}>
      <svg width={size * 0.62} height={size * 0.62} viewBox="0 0 24 24" fill="none"
        stroke={soft ? c : 'rgba(255,255,255,0.95)'} strokeWidth="1.9" strokeLinecap="round">
        <circle cx="9" cy={eyeY} r="0.6" fill={soft ? c : 'rgba(255,255,255,0.95)'} stroke="none" />
        <circle cx="15" cy={eyeY} r="0.6" fill={soft ? c : 'rgba(255,255,255,0.95)'} stroke="none" />
        <path d={MOUTHS[level]} />
      </svg>
    </div>
  );
}

/* ----------------------------------------------------------------
   Stars rating
   ---------------------------------------------------------------- */
function Stars({ value = 5, size = 13, showNum = false }) {
  return (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 3 }}>
      <Icon name="star" size={size} color="var(--moss-500)" fill="var(--moss-500)" stroke={0} />
      <span style={{ fontWeight: 700, fontSize: size + 1 }}>{value.toFixed(1)}</span>
    </span>
  );
}

/* ----------------------------------------------------------------
   Verified badge
   ---------------------------------------------------------------- */
function Verified({ size = 16 }) {
  return (
    <span style={{ display: 'inline-flex', color: 'var(--primary)' }} title="Verified professional">
      <Icon name="shield" size={size} color="var(--primary)" stroke={2} />
    </span>
  );
}

/* ----------------------------------------------------------------
   iOS toggle
   ---------------------------------------------------------------- */
function Toggle({ on, onChange }) {
  return (
    <button onClick={() => onChange && onChange(!on)} style={{
      width: 51, height: 31, borderRadius: 999, border: 0, padding: 2, cursor: 'pointer',
      background: on ? 'var(--primary)' : 'var(--hairline-2)',
      transition: 'background .3s var(--ease)', position: 'relative', flexShrink: 0,
      WebkitTapHighlightColor: 'transparent',
    }}>
      <span style={{
        display: 'block', width: 27, height: 27, borderRadius: '50%', background: '#fff',
        boxShadow: '0 2px 4px rgba(0,0,0,0.2)',
        transform: on ? 'translateX(20px)' : 'translateX(0)',
        transition: 'transform .3s var(--ease-spring)',
      }} />
    </button>
  );
}

/* ----------------------------------------------------------------
   Segmented control
   ---------------------------------------------------------------- */
function Segmented({ options, value, onChange }) {
  const idx = Math.max(0, options.indexOf(value));
  return (
    <div className="seg">
      <span className="seg-thumb" style={{
        width: `calc((100% - 6px) / ${options.length})`,
        transform: `translateX(${idx * 100}%)`,
      }} />
      {options.map(o => (
        <div key={o} className={'seg-opt' + (o === value ? ' active' : '')} onClick={() => onChange(o)}>{o}</div>
      ))}
    </div>
  );
}

/* ----------------------------------------------------------------
   Field with leading icon
   ---------------------------------------------------------------- */
function Field({ icon, type = 'text', placeholder, value, onChange, trailing, autoFocus, onFocus }) {
  return (
    <div className="field-wrap">
      {icon && <span className="field-icon" style={{ left: 15, color: 'var(--ink-3)' }}><Icon name={icon} size={20} stroke={1.9} /></span>}
      <input className="field" type={type} placeholder={placeholder} value={value} autoFocus={autoFocus}
        onFocus={onFocus}
        onChange={e => onChange && onChange(e.target.value)}
        style={{ paddingLeft: icon ? 46 : 16, paddingRight: trailing ? 46 : 16 }} />
      {trailing && <span className="field-icon" style={{ right: 12 }}>{trailing}</span>}
    </div>
  );
}

/* ----------------------------------------------------------------
   Section header
   ---------------------------------------------------------------- */
function SectionHead({ title, action, onAction }) {
  return (
    <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', padding: '0 2px 12px' }}>
      <h3 className="t-title3">{title}</h3>
      {action && <button onClick={onAction} style={{
        border: 0, background: 'none', color: 'var(--primary)', fontWeight: 600,
        fontSize: 15, cursor: 'pointer', fontFamily: 'var(--font-ui)',
      }}>{action}</button>}
    </div>
  );
}

/* ----------------------------------------------------------------
   Nav header (back / title / action)
   ---------------------------------------------------------------- */
function NavHeader({ title, onBack, right, large, transparent }) {
  return (
    <div className="nav" style={{ background: transparent ? 'transparent' : 'var(--bg)' }}>
      {onBack
        ? <button className="nav-btn" onClick={onBack}><Icon name="back" size={22} stroke={2.2} /></button>
        : <span style={{ width: 40 }} />}
      {!large && <div className="nav-title">{title}</div>}
      {large && <div style={{ flex: 1 }} />}
      {right || <span style={{ width: 40 }} />}
    </div>
  );
}

/* ----------------------------------------------------------------
   MVP-1 wellness components
   ---------------------------------------------------------------- */

/* Radial score ring — 0–100, with center label */
function RadialScore({ value = 78, size = 132, stroke = 11, color = 'var(--primary)', track = 'var(--fill-2)', label, sub }) {
  const r = (size - stroke) / 2;
  const c = 2 * Math.PI * r;
  return (
    <div style={{ position: 'relative', width: size, height: size, flexShrink: 0 }}>
      <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`} style={{ transform: 'rotate(-90deg)' }}>
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke={track} strokeWidth={stroke} />
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke={color} strokeWidth={stroke} strokeLinecap="round"
          strokeDasharray={c} strokeDashoffset={c * (1 - value / 100)} style={{ transition: 'stroke-dashoffset 1.1s var(--ease-out)' }} />
      </svg>
      <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
        <div className="t-title1" style={{ lineHeight: 1, fontSize: size * 0.27 }}>{label != null ? label : value}</div>
        {sub && <div className="t-cap muted-3" style={{ marginTop: 4, fontWeight: 600 }}>{sub}</div>}
      </div>
    </div>
  );
}

/* Trend pill — direction + value */
function TrendPill({ dir = 'up', children, invert }) {
  const good = invert ? dir === 'down' : dir === 'up';
  const col = dir === 'flat' ? 'var(--ink-3)' : good ? 'var(--green)' : 'var(--clay)';
  const icon = dir === 'flat' ? 'arrowR' : dir === 'up' ? 'trend' : 'trend';
  return (
    <span className="chip outline" style={{ gap: 5, color: col, height: 28, fontSize: 13, fontWeight: 700 }}>
      <Icon name={icon} size={14} color={col} stroke={2.2} style={dir === 'down' ? { transform: 'scaleY(-1)' } : null} />
      {children}
    </span>
  );
}

/* Confidence chip */
function Confidence({ value = 90, size = 'md' }) {
  const sm = size === 'sm';
  return (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6, height: sm ? 24 : 28, padding: sm ? '0 9px' : '0 11px',
      borderRadius: 999, background: 'var(--primary-tint)', color: 'var(--primary)', fontWeight: 700, fontSize: sm ? 12 : 13 }}>
      <Icon name="sparkle" size={sm ? 12 : 14} color="var(--primary)" stroke={2} />{value}% confidence
    </span>
  );
}

/* Emotion bar — labelled horizontal meter */
function EmotionBar({ label, value, color = 'var(--primary)', trend, desc }) {
  return (
    <div style={{ padding: '9px 0' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 7 }}>
        <span className="t-callout" style={{ flex: 1, fontWeight: 600, color: 'var(--ink-2)' }}>{label}</span>
        {trend != null && <span className="t-cap" style={{ fontWeight: 700, color: trend < 0 ? 'var(--green)' : trend > 0 ? 'var(--clay)' : 'var(--ink-3)' }}>{trend > 0 ? '+' : ''}{trend}</span>}
        <span className="t-foot" style={{ fontWeight: 700, minWidth: 30, textAlign: 'right' }}>{value}</span>
      </div>
      <div style={{ height: 8, borderRadius: 999, background: 'var(--fill-2)', overflow: 'hidden' }}>
        <div style={{ height: '100%', width: `${value}%`, borderRadius: 999, background: color, transition: 'width .9s var(--ease-out)' }} />
      </div>
      {desc && <div className="t-cap muted-3" style={{ marginTop: 6 }}>{desc}</div>}
    </div>
  );
}

/* Sparkline */
function Spark({ data = [], color = 'var(--primary)', w = 120, h = 36, fill = true }) {
  const max = Math.max(...data), min = Math.min(...data), span = max - min || 1, pad = 3;
  const pts = data.map((v, i) => [pad + (i / (data.length - 1)) * (w - pad * 2), pad + (1 - (v - min) / span) * (h - pad * 2)]);
  const path = pts.map((p, i) => (i ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1)).join(' ');
  const area = path + ` L${(w - pad).toFixed(1)} ${h - pad} L${pad} ${h - pad} Z`;
  const gid = 'sp' + Math.random().toString(36).slice(2, 7);
  return (
    <svg viewBox={`0 0 ${w} ${h}`} style={{ width: '100%', height: h, overflow: 'visible' }}>
      <defs><linearGradient id={gid} x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stopColor={color} stopOpacity="0.22" /><stop offset="100%" stopColor={color} stopOpacity="0" />
      </linearGradient></defs>
      {fill && <path d={area} fill={`url(#${gid})`} />}
      <path d={path} fill="none" stroke={color} strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round" />
      <circle cx={pts[pts.length - 1][0]} cy={pts[pts.length - 1][1]} r="3" fill="var(--surface)" stroke={color} strokeWidth="2" />
    </svg>
  );
}

/* Week dots — 7-day completion */
function WeekDots({ week = [], color = 'var(--primary)', labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'] }) {
  return (
    <div style={{ display: 'flex', gap: 6 }}>
      {week.map((on, i) => (
        <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6 }}>
          <div style={{ width: '100%', maxWidth: 30, aspectRatio: '1', borderRadius: 9, background: on ? color : 'var(--fill-2)',
            display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            {on ? <Icon name="check" size={14} color="#fff" stroke={2.6} /> : null}
          </div>
          <span className="t-cap muted-3" style={{ fontWeight: 600 }}>{labels[i]}</span>
        </div>
      ))}
    </div>
  );
}

/* Analysis status pill */
function AnalysisStatus({ status = 'ready' }) {
  const map = {
    ready: ['checkCircle', 'var(--green)', 'Analysis ready'],
    pending: ['clock', 'var(--topic-3)', 'Analysing…'],
    failed: ['info', 'var(--clay)', 'Analysis failed'],
  };
  const [ic, col, txt] = map[status] || map.ready;
  return (
    <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6, height: 26, padding: '0 10px', borderRadius: 999,
      background: `color-mix(in srgb, ${col} 13%, transparent)`, color: col, fontWeight: 700, fontSize: 12.5 }}>
      <Icon name={ic} size={14} color={col} stroke={2} />{txt}
    </span>
  );
}

/* Icon tile */
function IconTile({ icon, color = 'var(--primary)', size = 44, round = 13 }) {
  return (
    <div style={{ width: size, height: size, borderRadius: round, flexShrink: 0,
      background: `color-mix(in srgb, ${color} 14%, transparent)`, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <Icon name={icon} size={size * 0.46} color={color} stroke={1.9} />
    </div>
  );
}

Object.assign(window, {
  Icon, ICONS, Avatar, avaHue, initials, MoodFace, MOOD_LABELS, MOOD_VARS,
  Stars, Verified, Toggle, Segmented, Field, SectionHead, NavHeader,
  RadialScore, TrendPill, Confidence, EmotionBar, Spark, WeekDots, AnalysisStatus, IconTile,
});
