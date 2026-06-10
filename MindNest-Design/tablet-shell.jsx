/* MindNest — Tablet shell: adaptive sidebar, topbar chrome, a11y wiring + shared widgets */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: tUS, useContext: tUC, useEffect: tUE, useRef: tUR } = React;

/* nav sets per role */
const CLIENT_NAV = [
  { id: 'home', label: 'Home', icon: 'home' },
  { id: 'sessions', label: 'Sessions', icon: 'calendar' },
  { id: 'journal', label: 'Journal', icon: 'bookOpen' },
  { id: 'messages', label: 'Messages', icon: 'message', badge: 2 },
  { id: 'feed', label: 'Feed', icon: 'layers' },
];
const PRO_NAV = [
  { id: 'dash', label: 'Dashboard', icon: 'grid' },
  { id: 'calendar', label: 'Calendar', icon: 'calendar' },
  { id: 'clients', label: 'Clients', icon: 'message', badge: 1 },
  { id: 'earnings', label: 'Earnings', icon: 'trend' },
  { id: 'content', label: 'Content', icon: 'feather' },
];
const DEFAULT_SCREEN = { user: 'home', pro: 'dash' };

/* ----------------------------------------------------------------
   Shared widgets
   ---------------------------------------------------------------- */
function TStat({ icon, color = 'var(--primary)', value, label, delta, deltaUp = true }) {
  return (
    <div className="tb-stat tb-anim-item">
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
        <div style={{ width: 40, height: 40, borderRadius: 12, background: `color-mix(in srgb, ${color} 14%, transparent)`,
          display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <Icon name={icon} size={20} color={color} stroke={2} />
        </div>
        {delta && (
          <span style={{ display: 'inline-flex', alignItems: 'center', gap: 3, fontSize: 13, fontWeight: 700,
            color: deltaUp ? 'var(--green)' : 'var(--red)' }}>
            <Icon name={deltaUp ? 'trend' : 'trend'} size={14} stroke={2.4} style={{ transform: deltaUp ? 'none' : 'scaleY(-1)' }} />
            {delta}
          </span>
        )}
      </div>
      <div className="tt-h2 tt-num">{value}</div>
      <div className="tt-sub muted-3" style={{ marginTop: 3 }}>{label}</div>
    </div>
  );
}

function TSection({ title, sub, action, onAction, children, style }) {
  return (
    <section style={{ marginBottom: 24, ...style }}>
      {(title || action) && (
        <div style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'space-between', marginBottom: 14 }}>
          <div>
            <h3 className="tt-h3">{title}</h3>
            {sub && <div className="tt-sub muted-3" style={{ marginTop: 2 }}>{sub}</div>}
          </div>
          {action && <button onClick={onAction} style={{ border: 0, background: 'none', color: 'var(--primary)',
            fontWeight: 600, fontSize: 15, cursor: 'pointer', fontFamily: 'var(--font-ui)', flexShrink: 0 }}>{action}</button>}
        </div>
      )}
      {children}
    </section>
  );
}

/* Bar chart — array of {label, value, hi?} */
function BarChart({ data, max, height = 150, color = 'var(--primary)', fmt = v => v }) {
  const m = max || Math.max(...data.map(d => d.value)) * 1.15;
  return (
    <div style={{ display: 'flex', alignItems: 'flex-end', gap: 10, height, padding: '0 2px' }}>
      {data.map((d, i) => (
        <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 8, height: '100%' }}>
          <div style={{ flex: 1, width: '100%', display: 'flex', alignItems: 'flex-end' }}>
            <div title={fmt(d.value)} style={{
              width: '100%', borderRadius: '8px 8px 4px 4px', minHeight: 4,
              height: `${(d.value / m) * 100}%`,
              background: d.hi ? color : `color-mix(in srgb, ${color} 30%, var(--surface-3))`,
              transformOrigin: 'bottom', animation: 'growBar .6s var(--ease-out) both', animationDelay: `${i * 0.05}s`,
            }} />
          </div>
          <span className="tt-cap muted-3" style={{ fontWeight: 600 }}>{d.label}</span>
        </div>
      ))}
    </div>
  );
}

/* Line/area chart — values array, fixed viewBox */
function LineChart({ values, height = 160, color = 'var(--primary)', labels }) {
  const w = 600, h = 200, pad = 12;
  const max = Math.max(...values) * 1.1, min = Math.min(...values) * 0.85;
  const x = i => pad + (i * (w - pad * 2)) / (values.length - 1);
  const y = v => h - pad - ((v - min) / (max - min)) * (h - pad * 2);
  const line = values.map((v, i) => `${i ? 'L' : 'M'}${x(i).toFixed(1)} ${y(v).toFixed(1)}`).join(' ');
  const area = `${line} L${x(values.length - 1)} ${h - pad} L${x(0)} ${h - pad} Z`;
  return (
    <div style={{ width: '100%' }}>
      <svg viewBox={`0 0 ${w} ${h}`} width="100%" height={height} preserveAspectRatio="none" style={{ overflow: 'visible' }}>
        <defs>
          <linearGradient id="laFill" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor={color} stopOpacity="0.22" />
            <stop offset="100%" stopColor={color} stopOpacity="0" />
          </linearGradient>
        </defs>
        <path d={area} fill="url(#laFill)" />
        <path d={line} fill="none" stroke={color} strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"
          style={{ strokeDasharray: 2000, strokeDashoffset: 2000, animation: 'drawLine 1.3s var(--ease-out) forwards' }} />
        {values.map((v, i) => (
          <circle key={i} cx={x(i)} cy={y(v)} r={i === values.length - 1 ? 5 : 0} fill={color} stroke="var(--surface)" strokeWidth="2.5" />
        ))}
      </svg>
      {labels && (
        <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 8, padding: '0 4px' }}>
          {labels.map(l => <span key={l} className="tt-cap muted-3" style={{ fontWeight: 600 }}>{l}</span>)}
        </div>
      )}
    </div>
  );
}

/* Donut ring */
function DonutRing({ value, size = 92, stroke = 11, color = 'var(--primary)', children }) {
  const r = (size - stroke) / 2, c = 2 * Math.PI * r;
  return (
    <div style={{ position: 'relative', width: size, height: size }}>
      <svg width={size} height={size} style={{ transform: 'rotate(-90deg)' }}>
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke="var(--fill)" strokeWidth={stroke} />
        <circle cx={size / 2} cy={size / 2} r={r} fill="none" stroke={color} strokeWidth={stroke} strokeLinecap="round"
          strokeDasharray={c} strokeDashoffset={c * (1 - value / 100)}
          style={{ transition: 'stroke-dashoffset 1s var(--ease-out)' }} />
      </svg>
      <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', flexDirection: 'column' }}>
        {children}
      </div>
    </div>
  );
}

Object.assign(window, { TStat, TSection, BarChart, LineChart, DonutRing });

/* ----------------------------------------------------------------
   Topbar
   ---------------------------------------------------------------- */
function TTopbar({ title, ctx, onA11y, search }) {
  return (
    <div className="tb-topbar">
      <h1 className="tt-h2" style={{ flexShrink: 0 }}>{title}</h1>
      {search && (
        <div className="tb-search">
          <Icon name="search" size={18} stroke={2} /><span>Search MindNest</span>
        </div>
      )}
      <div style={{ flex: 1 }} />
      <button className="tb-iconbtn" title="Accessibility" onClick={onA11y} aria-label="Accessibility settings">
        <Icon name="eye" size={20} stroke={1.9} />
      </button>
      <button className="tb-iconbtn" title="Toggle theme" onClick={ctx.toggleTheme} aria-label="Toggle theme">
        <Icon name={ctx.theme === 'dark' ? 'sun' : 'moon'} size={20} stroke={1.9} />
      </button>
      <button className="tb-iconbtn" title="Notifications" aria-label="Notifications" style={{ position: 'relative' }}>
        <Icon name="bell" size={20} stroke={1.9} />
        <span style={{ position: 'absolute', top: 9, right: 10, width: 8, height: 8, borderRadius: '50%',
          background: 'var(--clay)', border: '2px solid var(--bg)' }} />
      </button>
    </div>
  );
}

/* ----------------------------------------------------------------
   Tablet shell
   ---------------------------------------------------------------- */
function TabletShell({ params = {} }) {
  const ctx = tUC(AppCtx);
  const nav = ctx.role === 'pro' ? PRO_NAV : CLIENT_NAV;
  const [screen, setScreen] = tUS(params.screen || DEFAULT_SCREEN[ctx.role]);
  const [sub, setSub] = tUS(params.sub || null);   // sub-params for the screen
  const scrollRef = tUR(null);

  const go = React.useCallback((name, p) => { setScreen(name); setSub(p || null); if (scrollRef.current) scrollRef.current.scrollTop = 0; }, []);

  // expose to review sidebar
  tUE(() => { if (ctx.tabletRef) ctx.tabletRef.current = go; });
  // reset to role default when role flips
  const roleRef = tUR(ctx.role);
  tUE(() => { if (roleRef.current !== ctx.role) { roleRef.current = ctx.role; setScreen(DEFAULT_SCREEN[ctx.role]); setSub(null); } }, [ctx.role]);

  const Screen = window.TABLET_SCREENS[screen] || (() => <div className="tb-page">Missing: {screen}</div>);
  const meta = nav.find(n => n.id === screen);
  const title = (meta && meta.label) || (screen === 'a11y' ? 'Accessibility' : screen === 'motion' ? 'Motion system' : screen === 'guidelines' ? 'Accessibility guidelines' : 'MindNest');
  const a11y = ctx.a11y;

  const profile = ctx.role === 'pro'
    ? { name: 'Dr. Evelyn Hale', sub: 'Clinical Psychologist', photo: true }
    : { name: 'Maya Chen', sub: 'Member · 42-day streak', photo: true };

  return (
    <div className={'tb' + (ctx.theme === 'dark' ? ' theme-dark' : '') + (a11y.contrast ? ' hc' : '') + (a11y.motion ? '' : ' rm')}
      style={{ '--ts': a11y.type }}>
      {/* sidebar */}
      <aside className="tb-rail">
        <div className="tb-railhead">
          <div className="tb-logo"><Leaf size={20} color="#fff" /></div>
          <div>
            <div style={{ fontWeight: 700, fontSize: 17, letterSpacing: '-0.01em' }}>MindNest</div>
            <div className="tt-cap muted-3">{ctx.role === 'pro' ? 'Practice' : 'Personal'}</div>
          </div>
        </div>

        <nav style={{ flex: 1, overflowY: 'auto', paddingTop: 4 }}>
          {nav.map(n => (
            <button key={n.id} className={'tb-navitem' + (screen === n.id ? ' active' : '')} onClick={() => go(n.id)}>
              <Icon name={n.icon} size={21} stroke={screen === n.id ? 2.3 : 2} />
              <span className="tb-navlabel">{n.label}</span>
              {n.badge && <span className="tb-navbadge">{n.badge}</span>}
            </button>
          ))}

          <div style={{ height: 0.5, background: 'var(--hairline)', margin: '14px 20px' }} />
          <button className={'tb-navitem' + (screen === 'a11y' ? ' active' : '')} onClick={() => go('a11y')}>
            <Icon name="eye" size={21} stroke={2} /><span className="tb-navlabel">Accessibility</span>
          </button>
          <button className={'tb-navitem' + (screen === 'motion' ? ' active' : '')} onClick={() => go('motion')}>
            <Icon name="pulse" size={21} stroke={2} /><span className="tb-navlabel">Motion system</span>
          </button>
          <button className={'tb-navitem' + (screen === 'guidelines' ? ' active' : '')} onClick={() => go('guidelines')}>
            <Icon name="checkCircle" size={21} stroke={2} /><span className="tb-navlabel">A11y guidelines</span>
          </button>
        </nav>

        {/* profile / role switcher */}
        <button onClick={() => ctx.setRole(ctx.role === 'pro' ? 'user' : 'pro')}
          style={{ margin: 12, padding: '12px 12px', borderRadius: 15, border: 0, background: 'var(--fill)',
            display: 'flex', alignItems: 'center', gap: 11, cursor: 'pointer', fontFamily: 'var(--font-ui)', textAlign: 'left' }}
          title="Switch role">
          <Avatar name={profile.name} size={40} photo={profile.photo} />
          <div style={{ flex: 1, minWidth: 0 }}>
            <div className="tt-head" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{profile.name}</div>
            <div className="tt-cap muted-3" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{profile.sub}</div>
          </div>
          <Icon name="chevDown" size={16} color="var(--ink-3)" />
        </button>
      </aside>

      {/* main */}
      <div className="tb-main">
        <TTopbar title={title} ctx={ctx} onA11y={() => go('a11y')} search={screen === 'home' || screen === 'feed' || screen === 'dash'} />
        <div key={screen} style={{ flex: 1, minHeight: 0, display: 'flex', flexDirection: 'column', animation: a11y.motion ? 'fadeIn .35s var(--ease) both' : 'none' }}>
          <Screen go={go} params={sub || {}} scrollRef={scrollRef} ctx={ctx} />
        </div>
      </div>
    </div>
  );
}

window.SCREENS = window.SCREENS || {};
window.SCREENS.tabletApp = ({ params }) => <TabletShell params={params || {}} />;
window.TabletShell = TabletShell;
