/* MindNest — app shell: router, transitions, tab shells, review sidebar */

window.SCREENS = window.SCREENS || {};
const AppCtx = React.createContext({});
window.AppCtx = AppCtx;
const SAFE_TOP = 56;
window.SAFE_TOP = SAFE_TOP;

/* ----------------------------------------------------------------
   Layer — renders a screen by name
   ---------------------------------------------------------------- */
function Layer({ layer, className }) {
  const Cmp = window.SCREENS[layer.name];
  return (
    <div className={'layer ' + (className || '')}>
      {Cmp ? <Cmp params={layer.params || {}} /> : <div className="mn-screen" style={{ padding: 80 }}>Missing: {layer.name}</div>}
    </div>
  );
}

/* ----------------------------------------------------------------
   Tab bar
   ---------------------------------------------------------------- */
function TabBar({ tabs, active, onSelect }) {
  return (
    <div className="tabbar">
      {tabs.map(t => (
        <div key={t.id} className={'tab' + (active === t.id ? ' active' : '')} onClick={() => onSelect(t.id)}>
          <Icon name={t.icon} size={25} stroke={active === t.id ? 2.3 : 2} />
          <span style={{ fontSize: 10.5, fontWeight: 650, letterSpacing: '-0.01em' }}>{t.label}</span>
          <span className="tab-dot" />
        </div>
      ))}
    </div>
  );
}

/* ----------------------------------------------------------------
   Tab shell (user + pro)
   ---------------------------------------------------------------- */
function TabShell({ tabs, initial, params }) {
  const ctx = React.useContext(AppCtx);
  const [tab, setTab] = React.useState(params.tab || initial);
  const Page = window.SCREENS[tabs.find(t => t.id === tab).screen];
  const scrollRef = React.useRef(null);
  React.useEffect(() => { if (ctx.tabRef) ctx.tabRef.current = setTab; });
  React.useEffect(() => { if (scrollRef.current) scrollRef.current.scrollTop = 0; }, [tab]);
  return (
    <div className="mn-screen">
      <div className="mn-scroll" ref={scrollRef}>
        <div key={tab} className="tab-page">
          <Page params={params} />
        </div>
      </div>
      <TabBar tabs={tabs} active={tab} onSelect={setTab} />
    </div>
  );
}

const USER_TABS = [
  { id: 'home', label: 'Home', icon: 'home', screen: 'tabHome' },
  { id: 'feed', label: 'Learn', icon: 'layers', screen: 'tabFeed' },
  { id: 'journal', label: 'Journal', icon: 'bookOpen', screen: 'tabJournal' },
  { id: 'chats', label: 'Coach', icon: 'message', screen: 'tabChats' },
  { id: 'profile', label: 'Profile', icon: 'user', screen: 'tabProfile' },
];
const PRO_TABS = [
  { id: 'home', label: 'Today', icon: 'home', screen: 'proHome' },
  { id: 'requests', label: 'Requests', icon: 'calendar', screen: 'proRequests' },
  { id: 'content', label: 'Content', icon: 'feather', screen: 'proContent' },
  { id: 'chats', label: 'Clients', icon: 'message', screen: 'proChats' },
  { id: 'profile', label: 'Profile', icon: 'user', screen: 'proProfile' },
];

window.SCREENS.userApp = ({ params }) => <TabShell tabs={USER_TABS} initial="home" params={params} />;
window.SCREENS.proApp = ({ params }) => <TabShell tabs={PRO_TABS} initial="home" params={params} />;

/* ----------------------------------------------------------------
   Root App — nav stack + theme + sidebar
   ---------------------------------------------------------------- */
function App() {
  const [theme, setTheme] = React.useState('light');
  const [role, setRole] = React.useState('user');
  const [device, setDevice] = React.useState('phone');
  const [a11y, setA11yState] = React.useState({ type: 1, motion: true, contrast: false });
  const setA11y = (patch) => setA11yState(s => ({ ...s, ...patch }));
  const [tabletTarget, setTabletTarget] = React.useState({ screen: null, key: 1 });
  const keyRef = React.useRef(1);
  const tabRef = React.useRef(null);
  const tabletRef = React.useRef(null);
  const mk = (name, params) => ({ name, params: params || {}, key: keyRef.current++ });
  const [stack, setStack] = React.useState([mk('splash')]);
  const [trans, setTrans] = React.useState(null);
  const busy = React.useRef(false);

  const push = React.useCallback((name, params) => {
    if (busy.current) return; busy.current = true;
    setTrans({ type: 'push' });
    setStack(s => [...s, mk(name, params)]);
    setTimeout(() => { setTrans(null); busy.current = false; }, 440);
  }, []);

  const pop = React.useCallback(() => {
    setStack(s => {
      if (s.length <= 1 || busy.current) return s;
      busy.current = true;
      setTrans({ type: 'pop', leaving: s[s.length - 1] });
      setTimeout(() => { setTrans(null); busy.current = false; }, 440);
      return s.slice(0, -1);
    });
  }, []);

  const reset = React.useCallback((name, params) => {
    busy.current = false; setTrans(null);
    setStack([mk(name, params)]);
  }, []);

  const setStackTo = React.useCallback((arr) => {
    busy.current = false; setTrans(null);
    setStack(arr.map(x => typeof x === 'string' ? mk(x) : mk(x.name, x.params)));
  }, []);

  const goTablet = React.useCallback((screen, r) => {
    if (r) setRole(r);
    setTabletTarget(t => ({ screen, key: t.key + 1 }));
    setDevice('tablet');
  }, []);

  const ctx = {
    push, pop, reset, setStackTo, theme, setTheme,
    toggleTheme: () => setTheme(t => t === 'light' ? 'dark' : 'light'),
    role, setRole, depth: stack.length, tabRef, tabletRef,
    goTab: (id) => { if (tabRef.current) tabRef.current(id); },
    device, setDevice, a11y, setA11y,
    goTablet,
  };

  const top = stack.length - 1;
  const leaving = trans && trans.type === 'pop' ? trans.leaving : null;

  const [scale, setScale] = React.useState(1);
  React.useEffect(() => {
    const fit = () => {
      const h = window.innerHeight, w = window.innerWidth;
      const isTab = device === 'tablet';
      const fw = isTab ? 878 : 430, fh = isTab ? 1238 : 906;
      const s = Math.min(1, (h - 28) / fh, (w - 250 - 40) / fw);
      setScale(s > 0.28 ? s : 0.45);
    };
    fit(); window.addEventListener('resize', fit);
    return () => window.removeEventListener('resize', fit);
  }, [device]);

  return (
    <AppCtx.Provider value={ctx}>
      <div className="mn" style={{
        minHeight: '100vh', height: '100vh', display: 'flex', alignItems: 'stretch', overflow: 'hidden',
        background: 'radial-gradient(120% 90% at 80% 0%, #EEF1EA 0%, #E5E8E1 55%, #DDE1D8 100%)',
        fontFamily: 'var(--font-ui)',
      }}>
        <Sidebar />
        <div style={{
          flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center',
          padding: 20, minWidth: 0, overflow: 'hidden',
        }}>
          <div className={'mn' + (theme === 'dark' ? ' theme-dark' : '')} style={{ transform: `scale(${scale})`, transformOrigin: 'center center' }}>
            {device === 'tablet' ? (
              <IPadDevice dark={theme === 'dark'}>
                <TabletShell key={tabletTarget.key} params={{ screen: tabletTarget.screen }} />
              </IPadDevice>
            ) : (
              <IOSDevice dark={theme === 'dark'}>
                <div style={{ position: 'relative', height: '100%', overflow: 'hidden', background: 'var(--bg)' }}>
                  {stack.map((layer, i) => {
                    let cls = '';
                    if (trans && trans.type === 'push' && i === top) cls = 'l-push-in layer-shadow';
                    else if (trans && trans.type === 'push' && i === top - 1) cls = 'l-push-out';
                    else if (trans && trans.type === 'pop' && i === top) cls = 'l-pop-in';
                    return <Layer key={layer.key} layer={layer} className={cls} />;
                  })}
                  {leaving && <Layer key={leaving.key} layer={leaving} className="l-pop-out layer-shadow" />}
                </div>
              </IOSDevice>
            )}
          </div>
        </div>
      </div>
    </AppCtx.Provider>
  );
}

/* ----------------------------------------------------------------
   Review sidebar — jump to any screen, toggle theme/role
   ---------------------------------------------------------------- */
const NAV_INDEX = [
  { group: 'Onboarding', items: [
    ['Splash', s => s.reset('splash')],
    ['Role selection', s => s.reset('roleSelect')],
    ['Log in', s => s.setStackTo(['roleSelect', 'login'])],
    ['Sign up', s => s.setStackTo(['roleSelect', { name: 'signup', params: { role: 'user' } }])],
    ['Forgot password', s => s.setStackTo(['roleSelect', 'login', 'forgot'])],
    ['OTP verification', s => s.setStackTo(['roleSelect', { name: 'otp', params: {} }])],
    ['Questionnaire', s => s.reset('questionnaire')],
    ['Welcome', s => s.reset('welcome')],
  ]},
  { group: 'User · Core', items: [
    ['Home dashboard', s => s.reset('userApp', { tab: 'home' })],
    ['Notifications', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'notifications'])],
    ['Notifications · empty', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, { name: 'notifications', params: { empty: true } }])],
  ]},
  { group: 'User · Mood', items: [
    ['Track mood', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'moodTrack'])],
    ['Mood insights', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'moodInsights'])],
    ['Mood history', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'moodHistory'])],
  ]},
  { group: 'User · Journal', items: [
    ['Journal list', s => s.reset('userApp', { tab: 'journal' })],
    ['Journal · empty', s => s.reset('userApp', { tab: 'journal', empty: true })],
    ['Calendar history', s => s.reset('userApp', { tab: 'journal', view: 'calendar' })],
    ['Write journal', s => s.setStackTo([{ name: 'userApp', params: { tab: 'journal' } }, { name: 'journalWrite', params: { type: 'guided' } }])],
    ['Journal + AI analysis', s => s.setStackTo([{ name: 'userApp', params: { tab: 'journal' } }, { name: 'journalEntry', params: { id: 'j1' } }])],
    ['Analysis · pending', s => s.setStackTo([{ name: 'userApp', params: { tab: 'journal' } }, { name: 'journalEntry', params: { id: 'j4' } }])],
  ]},
  { group: 'User · Discover & Learn', items: [
    ['Library', s => s.reset('userApp', { tab: 'feed' })],
    ['Library · empty', s => s.reset('userApp', { tab: 'feed', empty: true })],
    ['Article detail', s => s.setStackTo([{ name: 'userApp', params: { tab: 'feed' } }, { name: 'postDetail', params: { id: 'a1' } }])],
    ['Reflection prompt', s => s.setStackTo([{ name: 'userApp', params: { tab: 'feed' } }, { name: 'postDetail', params: { id: 'a5' } }])],
  ]},
  { group: 'User · Insights', items: [
    ['Insights hub', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'discover'])],
    ['Wellness score', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'wellnessScore'])],
    ['Emotional profile', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'emotionalProfile'])],
    ['Assessments', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'assessments'])],
    ['Emotional timeline', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'timeline'])],
    ['Pattern detector', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'patterns'])],
    ['Memory highlights', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'memory'])],
    ['Insight detail · burnout', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, { name: 'insightDetail', params: { type: 'burnout' } }])],
    ['Weekly wellness report', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'weeklyReport'])],
    ['Personal analytics', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'analytics'])],
    ['Habits', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'habits'])],
  ]},
  { group: 'User · Recommendations', items: [
    ['Recommendation centre', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, 'recommendations'])],
    ['Recommendation detail', s => s.setStackTo([{ name: 'userApp', params: { tab: 'home' } }, { name: 'recDetail', params: { id: 'rc1' } }])],
  ]},
  { group: 'User · Coach & Profile', items: [
    ['AI Coach', s => s.reset('userApp', { tab: 'chats' })],
    ['Profile', s => s.reset('userApp', { tab: 'profile' })],
    ['Edit profile', s => s.setStackTo([{ name: 'userApp', params: { tab: 'profile' } }, 'editProfile'])],
    ['Settings & AI', s => s.setStackTo([{ name: 'userApp', params: { tab: 'profile' } }, 'settings'])],
  ]},
  { group: 'Professional · MVP 2', items: [
    ['Pro dashboard', s => { s.setRole('pro'); s.reset('proApp', { tab: 'home' }); }],
    ['Booking requests', s => { s.setRole('pro'); s.reset('proApp', { tab: 'requests' }); }],
    ['My content', s => { s.setRole('pro'); s.reset('proApp', { tab: 'content' }); }],
    ['Pro clients', s => { s.setRole('pro'); s.reset('proApp', { tab: 'chats' }); }],
  ]},
  { group: 'System', items: [
    ['Design system', s => { s.setDevice('phone'); s.reset('designSystem'); }],
  ]},
  { group: 'Tablet · Client', items: [
    ['Home dashboard', s => s.goTablet('home', 'user')],
    ['Sessions & booking', s => s.goTablet('sessions', 'user')],
    ['Journal · split view', s => s.goTablet('journal', 'user')],
    ['Messages · split view', s => s.goTablet('messages', 'user')],
    ['Content feed', s => s.goTablet('feed', 'user')],
  ]},
  { group: 'Tablet · Professional', items: [
    ['Dashboard & analytics', s => s.goTablet('dash', 'pro')],
    ['Calendar & booking', s => s.goTablet('calendar', 'pro')],
    ['Clients · split + notes', s => s.goTablet('clients', 'pro')],
    ['Earnings & payouts', s => s.goTablet('earnings', 'pro')],
    ['Content studio', s => s.goTablet('content', 'pro')],
  ]},
  { group: 'Tablet · System', items: [
    ['Accessibility · live demo', s => s.goTablet('a11y', s.role)],
    ['Motion system', s => s.goTablet('motion', s.role)],
    ['Accessibility guidelines', s => s.goTablet('guidelines', s.role)],
  ]},
];

function Sidebar() {
  const ctx = React.useContext(AppCtx);
  const [open, setOpen] = React.useState(true);
  if (!open) {
    return (
      <button onClick={() => setOpen(true)} style={sb.fab} title="Open index">
        <Icon name="grid" size={20} color="#E8EDE4" />
      </button>
    );
  }
  return (
    <aside style={sb.aside}>
      <div style={sb.head}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={sb.logo}><Leaf size={18} color="#fff" /></div>
          <div>
            <div style={{ fontWeight: 700, fontSize: 16, color: '#EAF0E5', letterSpacing: '-0.01em' }}>MindNest</div>
            <div style={{ fontSize: 11.5, color: '#8A957F' }}>V3 · Prototype</div>
          </div>
        </div>
        <button onClick={() => setOpen(false)} style={sb.collapse}><Icon name="chevL" size={16} color="#8A957F" /></button>
      </div>

      <div style={sb.controls}>
        <button style={{ ...sb.ctrlBtn, ...(ctx.theme === 'light' ? sb.ctrlActive : {}) }} onClick={() => ctx.setTheme('light')}>
          <Icon name="sun" size={16} color={ctx.theme === 'light' ? '#1F2519' : '#8A957F'} /> Light
        </button>
        <button style={{ ...sb.ctrlBtn, ...(ctx.theme === 'dark' ? sb.ctrlActive : {}) }} onClick={() => ctx.setTheme('dark')}>
          <Icon name="moon" size={16} color={ctx.theme === 'dark' ? '#1F2519' : '#8A957F'} /> Dark
        </button>
      </div>

      <div style={sb.controls}>
        <button style={{ ...sb.ctrlBtn, ...(ctx.device === 'phone' ? sb.ctrlActive : {}) }} onClick={() => ctx.setDevice('phone')}>
          <Icon name="phone" size={15} color={ctx.device === 'phone' ? '#1F2519' : '#8A957F'} /> Phone
        </button>
        <button style={{ ...sb.ctrlBtn, ...(ctx.device === 'tablet' ? sb.ctrlActive : {}) }} onClick={() => ctx.goTablet(ctx.role === 'pro' ? 'dash' : 'home', ctx.role)}>
          <Icon name="grid" size={15} color={ctx.device === 'tablet' ? '#1F2519' : '#8A957F'} /> Tablet
        </button>
      </div>

      {ctx.device === 'tablet' && (
        <div style={sb.a11yBox}>
          <div style={sb.a11yLabel}>Accessibility · live</div>
          <div style={{ display: 'flex', gap: 6, marginBottom: 7 }}>
            {[['A', 0.9], ['A', 1], ['A', 1.15], ['A', 1.3]].map(([t, v], i) => (
              <button key={i} onClick={() => ctx.setA11y({ type: v })}
                style={{ ...sb.a11yBtn, ...(Math.abs(ctx.a11y.type - v) < 0.01 ? sb.a11yOn : {}), fontSize: 11 + i * 2.5 }}>{t}</button>
            ))}
          </div>
          <div style={{ display: 'flex', gap: 6 }}>
            <button onClick={() => ctx.setA11y({ motion: !ctx.a11y.motion })}
              style={{ ...sb.a11yWide, ...(!ctx.a11y.motion ? sb.a11yOn : {}) }}>{ctx.a11y.motion ? 'Motion on' : 'Reduced'}</button>
            <button onClick={() => ctx.setA11y({ contrast: !ctx.a11y.contrast })}
              style={{ ...sb.a11yWide, ...(ctx.a11y.contrast ? sb.a11yOn : {}) }}>{ctx.a11y.contrast ? 'High contrast' : 'Contrast'}</button>
          </div>
        </div>
      )}

      <div style={sb.scroll}>
        {NAV_INDEX.map(grp => (
          <div key={grp.group} style={{ marginBottom: 16 }}>
            <div style={sb.grpLabel}>{grp.group}</div>
            {grp.items.map(([label, fn]) => (
              <button key={label} style={sb.link} onClick={() => fn(ctx)}
                onMouseEnter={e => e.currentTarget.style.background = 'rgba(255,255,255,0.06)'}
                onMouseLeave={e => e.currentTarget.style.background = 'transparent'}>
                {label}
              </button>
            ))}
          </div>
        ))}
      </div>
      <div style={sb.foot}>Tap any entry to jump · use the in-app back arrows to navigate flows</div>
    </aside>
  );
}

function Leaf({ size = 20, color = '#fff' }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none">
      <path d="M5 19c0-7 5-13 14-14 1 9-3 15-10 15-1.5 0-2.7-.4-4-1Z" fill={color} opacity="0.95" />
      <path d="M5 19C8 14 11 11 16 8.5" stroke={color === '#fff' ? '#5C7C45' : '#fff'} strokeWidth="1.4" strokeLinecap="round" opacity="0.5" />
    </svg>
  );
}
window.Leaf = Leaf;

const sb = {
  aside: { width: 248, flexShrink: 0, background: '#1A1F16', display: 'flex', flexDirection: 'column',
    borderRight: '1px solid rgba(255,255,255,0.06)', height: '100vh', position: 'sticky', top: 0 },
  head: { display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '20px 16px 14px' },
  logo: { width: 34, height: 34, borderRadius: 10, background: 'linear-gradient(150deg,#7C9D6B,#5C7C45)',
    display: 'flex', alignItems: 'center', justifyContent: 'center', boxShadow: '0 4px 12px rgba(92,124,69,0.4)' },
  collapse: { width: 28, height: 28, borderRadius: 8, border: 0, background: 'rgba(255,255,255,0.05)',
    display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' },
  controls: { display: 'flex', gap: 8, padding: '0 16px 14px' },
  ctrlBtn: { flex: 1, height: 38, borderRadius: 10, border: 0, background: 'rgba(255,255,255,0.05)',
    color: '#8A957F', fontWeight: 600, fontSize: 13, cursor: 'pointer', display: 'flex', alignItems: 'center',
    justifyContent: 'center', gap: 6, fontFamily: 'var(--font-ui)' },
  ctrlActive: { background: '#C9D9BF', color: '#1F2519' },
  a11yBox: { margin: '0 16px 14px', padding: '11px 12px', borderRadius: 12, background: 'rgba(255,255,255,0.04)', border: '1px solid rgba(255,255,255,0.06)' },
  a11yLabel: { fontSize: 10.5, fontWeight: 700, color: '#6E7A63', textTransform: 'uppercase', letterSpacing: '0.06em', marginBottom: 8 },
  a11yBtn: { width: 38, height: 34, borderRadius: 9, border: 0, background: 'rgba(255,255,255,0.05)', color: '#C2CBB8', fontWeight: 700, cursor: 'pointer', fontFamily: 'var(--font-ui)' },
  a11yWide: { flex: 1, height: 32, borderRadius: 9, border: 0, background: 'rgba(255,255,255,0.05)', color: '#C2CBB8', fontWeight: 600, fontSize: 12, cursor: 'pointer', fontFamily: 'var(--font-ui)' },
  a11yOn: { background: '#C9D9BF', color: '#1F2519' },
  scroll: { flex: 1, overflowY: 'auto', padding: '4px 10px' },
  grpLabel: { fontSize: 11, fontWeight: 700, color: '#6E7A63', textTransform: 'uppercase',
    letterSpacing: '0.06em', padding: '6px 8px 4px' },
  link: { display: 'block', width: '100%', textAlign: 'left', border: 0, background: 'transparent',
    color: '#C2CBB8', fontSize: 13.5, fontWeight: 500, padding: '8px 10px', borderRadius: 8, cursor: 'pointer',
    fontFamily: 'var(--font-ui)', transition: 'background .15s' },
  foot: { padding: '12px 16px 16px', fontSize: 11, color: '#5C6553', lineHeight: 1.5, borderTop: '1px solid rgba(255,255,255,0.06)' },
  fab: { position: 'fixed', left: 16, top: 16, zIndex: 100, width: 44, height: 44, borderRadius: 12,
    border: 0, background: '#1A1F16', display: 'flex', alignItems: 'center', justifyContent: 'center',
    cursor: 'pointer', boxShadow: '0 6px 20px rgba(0,0,0,0.25)' },
};

window.App = App;
