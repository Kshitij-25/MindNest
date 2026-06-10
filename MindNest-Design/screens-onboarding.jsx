/* MindNest — onboarding flow */
window.SCREENS = window.SCREENS || {};
const { useState: oUS, useEffect: oUE, useRef: oUR, useContext: oUC } = React;

/* ---- pointer slider (shared) ---- */
function Slider({ value, onChange, min = 0, max = 10, color = 'var(--primary)' }) {
  const ref = oUR(null);
  const pct = (value - min) / (max - min);
  const set = (clientX) => {
    const r = ref.current.getBoundingClientRect();
    let p = (clientX - r.left) / r.width; p = Math.max(0, Math.min(1, p));
    onChange(Math.round(min + p * (max - min)));
  };
  const down = (e) => {
    e.preventDefault(); set(e.clientX);
    const move = ev => set(ev.clientX);
    const up = () => { window.removeEventListener('pointermove', move); window.removeEventListener('pointerup', up); };
    window.addEventListener('pointermove', move); window.addEventListener('pointerup', up);
  };
  return (
    <div ref={ref} onPointerDown={down} style={{ height: 44, display: 'flex', alignItems: 'center', cursor: 'pointer', touchAction: 'none' }}>
      <div style={{ position: 'relative', width: '100%', height: 10, borderRadius: 999, background: 'var(--fill-2)' }}>
        <div style={{ position: 'absolute', inset: 0, width: `${pct * 100}%`, borderRadius: 999, background: color, transition: 'width .15s var(--ease)' }} />
        <div style={{
          position: 'absolute', top: '50%', left: `${pct * 100}%`, width: 28, height: 28,
          transform: 'translate(-50%,-50%)', borderRadius: '50%', background: 'var(--surface)',
          boxShadow: '0 2px 8px rgba(0,0,0,0.18), 0 0 0 1px var(--hairline)', transition: 'left .15s var(--ease)',
        }} />
      </div>
    </div>
  );
}
window.Slider = Slider;

const Logo = ({ size = 64, breathe = true }) => (
  <div style={{
    width: size, height: size, borderRadius: size * 0.32,
    background: 'linear-gradient(155deg, var(--moss-400), var(--primary))',
    display: 'flex', alignItems: 'center', justifyContent: 'center',
    boxShadow: '0 12px 32px var(--primary-ring)',
    animation: breathe ? 'breatheSlow 5s var(--ease) infinite' : 'none',
  }}>
    <Leaf size={size * 0.5} color="#fff" />
  </div>
);
window.Logo = Logo;

/* ================= SPLASH ================= */
window.SCREENS.splash = function Splash() {
  const ctx = oUC(AppCtx);
  const [show, setShow] = oUS(false);
  oUE(() => { const t = setTimeout(() => setShow(true), 1400); return () => clearTimeout(t); }, []);
  return (
    <div className="mn-screen" onClick={() => show && ctx.push('roleSelect')} style={{
      alignItems: 'center', justifyContent: 'center',
      background: 'radial-gradient(120% 80% at 50% 18%, var(--primary-tint) 0%, var(--bg) 55%)',
    }}>
      {/* ambient rings */}
      <div style={{ position: 'absolute', top: '20%', width: 320, height: 320, borderRadius: '50%',
        border: '1px solid var(--hairline)', animation: 'breathe 6s var(--ease) infinite' }} />
      <div style={{ position: 'absolute', top: '24%', width: 220, height: 220, borderRadius: '50%',
        border: '1px solid var(--hairline)', animation: 'breathe 6s var(--ease) infinite .4s' }} />
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 22, zIndex: 1 }}>
        <div className="anim-scale"><Logo size={92} /></div>
        <div style={{ textAlign: 'center' }} className="anim-up">
          <div className="t-serif" style={{ fontSize: 40, color: 'var(--ink)' }}>MindNest</div>
          <div className="t-body muted" style={{ marginTop: 4 }}>A calmer space for your mind</div>
        </div>
      </div>
      <div style={{ position: 'absolute', bottom: 70, left: 28, right: 28, opacity: show ? 1 : 0,
        transform: show ? 'none' : 'translateY(12px)', transition: 'all .6s var(--ease-out)' }}>
        <button className="btn btn-primary" onClick={() => ctx.push('roleSelect')}>Get started</button>
        <div className="t-foot muted-3" style={{ textAlign: 'center', marginTop: 14 }}>Private & encrypted · You’re in control</div>
      </div>
      {!show && <div style={{ position: 'absolute', bottom: 88, width: 26, height: 26, borderRadius: '50%',
        border: '2.5px solid var(--hairline-2)', borderTopColor: 'var(--primary)', animation: 'spin 0.9s linear infinite' }} />}
    </div>
  );
};

/* ================= ROLE SELECT ================= */
window.SCREENS.roleSelect = function RoleSelect() {
  const ctx = oUC(AppCtx);
  const choose = (r) => { ctx.setRole(r); ctx.push('login', { role: r }); };
  const Card = ({ r, icon, title, sub, soon }) => (
    <button className="card pressable" onClick={() => choose(r)} style={{
      border: 0, textAlign: 'left', padding: 22, display: 'flex', alignItems: 'center', gap: 16,
      width: '100%', cursor: 'pointer', fontFamily: 'var(--font-ui)',
    }}>
      <div style={{ width: 60, height: 60, borderRadius: 18, flexShrink: 0,
        background: r === 'user' ? 'var(--primary-tint)' : 'var(--clay-tint)',
        display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <Icon name={icon} size={28} color={r === 'user' ? 'var(--primary)' : 'var(--clay)'} stroke={1.9} />
      </div>
      <div style={{ flex: 1 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div className="t-title3" style={{ color: 'var(--ink)' }}>{title}</div>
          {soon && <span className="badge badge-pending" style={{ flexShrink: 0 }}>MVP 2</span>}
        </div>
        <div className="t-callout muted" style={{ marginTop: 3 }}>{sub}</div>
      </div>
      <Icon name="chevR" size={20} color="var(--ink-4)" />
    </button>
  );
  return (
    <div className="mn-screen" style={{ padding: `${SAFE_TOP + 24}px 24px 0` }}>
      <div className="anim-up" style={{ marginBottom: 30 }}>
        <Logo size={50} breathe={false} />
        <h1 className="t-title1" style={{ marginTop: 22 }}>Welcome to MindNest</h1>
        <p className="t-body muted" style={{ marginTop: 8 }}>How would you like to use MindNest today?</p>
      </div>
      <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
        <Card r="user" icon="heart" title="I’m seeking support" sub="Track your mood, journal & get AI-guided insights" />
        <Card r="pro" icon="award" title="I’m a professional" sub="Guided sessions planned for a future release" soon />
      </div>
      <div style={{ flex: 1 }} />
      <p className="t-foot muted-3" style={{ textAlign: 'center', padding: '0 16px 30px' }}>
        By continuing you agree to our Terms & Privacy Policy.
      </p>
    </div>
  );
};

/* ================= LOGIN ================= */
window.SCREENS.login = function Login({ params }) {
  const ctx = oUC(AppCtx);
  const role = params.role || ctx.role;
  const [email, setEmail] = oUS(''); const [pw, setPw] = oUS(''); const [showPw, setShowPw] = oUS(false);
  const go = () => ctx.reset(role === 'pro' ? 'proApp' : 'userApp', { tab: 'home' });
  return (
    <div className="mn-screen">
      <NavHeader onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 24px 40px' }}>
        <div className="anim-up">
          <Logo size={46} breathe={false} />
          <h1 className="t-title1" style={{ marginTop: 20 }}>Welcome back</h1>
          <p className="t-body muted" style={{ marginTop: 6 }}>Sign in to continue your journey.</p>
        </div>
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14, marginTop: 28 }}>
          <Field icon="mail" type="email" placeholder="Email address" value={email} onChange={setEmail} />
          <Field icon="lock" type={showPw ? 'text' : 'password'} placeholder="Password" value={pw} onChange={setPw}
            trailing={<button onClick={() => setShowPw(s => !s)} style={iconBtn}><Icon name={showPw ? 'eyeOff' : 'eye'} size={20} color="var(--ink-3)" /></button>} />
          <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
            <button onClick={() => ctx.push('forgot')} style={linkBtn}>Forgot password?</button>
          </div>
          <button className="btn btn-primary" onClick={go} style={{ marginTop: 4 }}>Sign in</button>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, margin: '24px 0' }}>
          <div className="hr" style={{ flex: 1 }} /><span className="t-foot muted-3">or</span><div className="hr" style={{ flex: 1 }} />
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
          <button className="btn btn-outline" onClick={go}><AppleGlyph /> Continue with Apple</button>
          <button className="btn btn-outline" onClick={go}><GoogleGlyph /> Continue with Google</button>
        </div>
        <div style={{ textAlign: 'center', marginTop: 26 }}>
          <span className="t-callout muted">New to MindNest? </span>
          <button onClick={() => ctx.push('signup', { role })} style={linkBtn}>Create account</button>
        </div>
      </div>
    </div>
  );
};

/* ================= SIGNUP ================= */
window.SCREENS.signup = function Signup({ params }) {
  const ctx = oUC(AppCtx);
  const role = params.role || ctx.role;
  const [f, setF] = oUS({ name: '', email: '', pw: '' });
  const upd = k => v => setF(s => ({ ...s, [k]: v }));
  const valid = f.name && f.email.includes('@') && f.pw.length >= 6;
  const next = () => ctx.push('otp', { role, next: role === 'pro' ? 'proCredentials' : 'questionnaire' });
  return (
    <div className="mn-screen">
      <NavHeader onBack={ctx.pop} title={role === 'pro' ? 'Professional sign up' : 'Create account'} />
      <div className="mn-scroll" style={{ padding: '6px 24px 40px' }}>
        <p className="t-body muted anim-up" style={{ marginBottom: 24 }}>
          {role === 'pro' ? 'Set up your practitioner account. You’ll verify your credentials next.' : 'A few details and you’re ready to begin.'}
        </p>
        <div className="stagger" style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
          <Field icon="user" placeholder={role === 'pro' ? 'Full professional name' : 'Full name'} value={f.name} onChange={upd('name')} />
          <Field icon="mail" type="email" placeholder="Email address" value={f.email} onChange={upd('email')} />
          <Field icon="lock" type="password" placeholder="Create password" value={f.pw} onChange={upd('pw')} />
          <PwStrength pw={f.pw} />
        </div>
        <label style={{ display: 'flex', gap: 12, marginTop: 20, alignItems: 'flex-start', cursor: 'pointer' }}>
          <CheckMini />
          <span className="t-callout muted" style={{ lineHeight: 1.4 }}>I agree to MindNest’s Terms of Service and Privacy Policy.</span>
        </label>
        <button className="btn btn-primary" disabled={!valid} onClick={next} style={{ marginTop: 24 }}>Continue</button>
        <div style={{ textAlign: 'center', marginTop: 22 }}>
          <span className="t-callout muted">Already have an account? </span>
          <button onClick={ctx.pop} style={linkBtn}>Sign in</button>
        </div>
      </div>
    </div>
  );
};

function PwStrength({ pw }) {
  const score = Math.min(3, Math.floor(pw.length / 3) + (/[0-9]/.test(pw) ? 1 : 0));
  const labels = ['Too short', 'Weak', 'Good', 'Strong'];
  const colors = ['var(--ink-4)', 'var(--amber)', 'var(--moss-500)', 'var(--green)'];
  if (!pw) return null;
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '0 4px' }}>
      <div style={{ display: 'flex', gap: 4, flex: 1 }}>
        {[0, 1, 2, 3].map(i => <div key={i} style={{ flex: 1, height: 4, borderRadius: 999,
          background: i <= score ? colors[score] : 'var(--fill-2)', transition: 'background .3s' }} />)}
      </div>
      <span className="t-foot" style={{ color: colors[score] }}>{labels[score]}</span>
    </div>
  );
}

/* ================= FORGOT ================= */
window.SCREENS.forgot = function Forgot() {
  const ctx = oUC(AppCtx);
  const [email, setEmail] = oUS(''); const [sent, setSent] = oUS(false);
  return (
    <div className="mn-screen">
      <NavHeader onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 24px 40px' }}>
        {!sent ? (
          <div className="anim-up">
            <div style={{ width: 60, height: 60, borderRadius: 18, background: 'var(--primary-tint)',
              display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name="lock" size={28} color="var(--primary)" stroke={1.9} />
            </div>
            <h1 className="t-title1" style={{ marginTop: 22 }}>Forgot password?</h1>
            <p className="t-body muted" style={{ marginTop: 8 }}>Enter your email and we’ll send a secure link to reset it.</p>
            <div style={{ marginTop: 28 }}>
              <Field icon="mail" type="email" placeholder="Email address" value={email} onChange={setEmail} />
            </div>
            <button className="btn btn-primary" disabled={!email.includes('@')} onClick={() => setSent(true)} style={{ marginTop: 18 }}>Send reset link</button>
          </div>
        ) : (
          <div className="anim-scale" style={{ textAlign: 'center', paddingTop: 30 }}>
            <div style={{ width: 84, height: 84, borderRadius: '50%', background: 'var(--primary-tint)',
              display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto', animation: 'popIn .5s var(--ease-spring) both' }}>
              <Icon name="mail" size={40} color="var(--primary)" stroke={1.7} />
            </div>
            <h1 className="t-title2" style={{ marginTop: 24 }}>Check your inbox</h1>
            <p className="t-body muted" style={{ marginTop: 10, padding: '0 12px' }}>We’ve sent a reset link to <b style={{ color: 'var(--ink)' }}>{email || 'your email'}</b>. It expires in 30 minutes.</p>
            <button className="btn btn-primary" onClick={ctx.pop} style={{ marginTop: 30 }}>Back to sign in</button>
            <button onClick={() => setSent(false)} style={{ ...linkBtn, marginTop: 18 }}>Use a different email</button>
          </div>
        )}
      </div>
    </div>
  );
};

/* ================= OTP ================= */
window.SCREENS.otp = function OTP({ params }) {
  const ctx = oUC(AppCtx);
  const [code, setCode] = oUS(['', '', '', '', '', '']);
  const [timer, setTimer] = oUS(28);
  oUE(() => { if (timer <= 0) return; const t = setTimeout(() => setTimer(timer - 1), 1000); return () => clearTimeout(t); }, [timer]);
  const filled = code.filter(Boolean).length;
  // simulate auto-typing on mount for delight
  oUE(() => {
    const demo = '482913'.split('');
    demo.forEach((d, i) => setTimeout(() => setCode(c => { const n = [...c]; n[i] = d; return n; }), 500 + i * 220));
  }, []);
  const verify = () => ctx.reset(params.next || 'questionnaire');
  return (
    <div className="mn-screen">
      <NavHeader onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 24px 40px' }}>
        <div className="anim-up">
          <div style={{ width: 60, height: 60, borderRadius: 18, background: 'var(--primary-tint)',
            display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Icon name="message" size={26} color="var(--primary)" stroke={1.9} />
          </div>
          <h1 className="t-title1" style={{ marginTop: 22 }}>Verify your number</h1>
          <p className="t-body muted" style={{ marginTop: 8 }}>Enter the 6-digit code we sent to <b style={{ color: 'var(--ink)' }}>+44 ••• ••892</b>.</p>
        </div>
        <div style={{ display: 'flex', gap: 9, marginTop: 30, justifyContent: 'space-between' }}>
          {code.map((d, i) => (
            <div key={i} style={{
              flex: 1, aspectRatio: '1', maxWidth: 50, borderRadius: 14, display: 'flex', alignItems: 'center', justifyContent: 'center',
              background: 'var(--surface)', border: `1.5px solid ${d ? 'var(--primary)' : 'var(--hairline)'}`,
              boxShadow: d ? '0 0 0 4px var(--primary-ring)' : 'none', transition: 'all .25s var(--ease)',
              fontSize: 24, fontWeight: 700, color: 'var(--ink)',
            }}>{d && <span style={{ animation: 'popIn .3s var(--ease-spring) both' }}>{d}</span>}</div>
          ))}
        </div>
        <div style={{ textAlign: 'center', marginTop: 26 }}>
          {timer > 0
            ? <span className="t-callout muted-3">Resend code in 0:{String(timer).padStart(2, '0')}</span>
            : <button onClick={() => setTimer(28)} style={linkBtn}>Resend code</button>}
        </div>
        <button className="btn btn-primary" disabled={filled < 6} onClick={verify} style={{ marginTop: 28 }}>Verify</button>
      </div>
    </div>
  );
};

/* small glyphs / helpers */
const iconBtn = { border: 0, background: 'none', cursor: 'pointer', padding: 4, display: 'flex' };
const linkBtn = { border: 0, background: 'none', color: 'var(--primary)', fontWeight: 650, fontSize: 15, cursor: 'pointer', fontFamily: 'var(--font-ui)' };
window.linkBtn = linkBtn; window.iconBtn = iconBtn;
function CheckMini() {
  const [on, setOn] = oUS(true);
  return <span onClick={() => setOn(!on)} style={{ width: 22, height: 22, borderRadius: 7, flexShrink: 0, marginTop: 1,
    background: on ? 'var(--primary)' : 'transparent', border: on ? 'none' : '1.5px solid var(--hairline-2)',
    display: 'flex', alignItems: 'center', justifyContent: 'center', transition: 'all .2s' }}>
    {on && <Icon name="check" size={14} color="#fff" stroke={3} />}</span>;
}
const AppleGlyph = () => <svg width="17" height="19" viewBox="0 0 17 19" fill="currentColor"><path d="M14 13.7c-.3.7-.5 1-.9 1.6-.6.9-1.5 2-2.5 2-.9 0-1.2-.6-2.4-.6s-1.5.6-2.4.6c-1 0-1.8-1-2.4-1.9C1.6 13 1.4 9.9 2.5 8.3c.8-1.1 2-1.8 3.1-1.8 1.1 0 1.8.6 2.7.6.9 0 1.4-.6 2.7-.6 1 0 2 .5 2.7 1.4-2.4 1.3-2 4.7.3 5.8ZM10.4 4.3c.5-.6.9-1.5.8-2.4-.8 0-1.7.5-2.2 1.2-.5.6-.9 1.5-.7 2.3.8 0 1.6-.5 2.1-1.1Z" /></svg>;
const GoogleGlyph = () => <svg width="18" height="18" viewBox="0 0 18 18"><path d="M17.6 9.2c0-.6-.1-1.2-.2-1.8H9v3.5h4.8a4.1 4.1 0 0 1-1.8 2.7v2.2h2.9c1.7-1.6 2.7-3.9 2.7-6.6Z" fill="#4285F4"/><path d="M9 18c2.4 0 4.5-.8 6-2.2l-2.9-2.2c-.8.5-1.8.9-3.1.9-2.4 0-4.4-1.6-5.1-3.8H.9v2.3A9 9 0 0 0 9 18Z" fill="#34A853"/><path d="M3.9 10.7a5.4 5.4 0 0 1 0-3.4V5H.9a9 9 0 0 0 0 8l3-2.3Z" fill="#FBBC05"/><path d="M9 3.6c1.3 0 2.5.5 3.4 1.3l2.6-2.6A9 9 0 0 0 .9 5l3 2.3C4.6 5.2 6.6 3.6 9 3.6Z" fill="#EA4335"/></svg>;
