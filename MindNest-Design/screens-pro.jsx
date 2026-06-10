/* MindNest — professional flow */
window.SCREENS = window.SCREENS || {};
const { useState: pUS, useContext: pUC } = React;

/* ================= CREDENTIALS UPLOAD ================= */
window.SCREENS.proCredentials = function ProCredentials() {
  const ctx = pUC(AppCtx);
  const [done, setDone] = pUS({ license: true, id: false, certs: false });
  const DOCS = [
    ['license', 'Practising licence', 'HCPC / BACP registration', 'doc'],
    ['id', 'Photo ID', 'Passport or driving licence', 'user'],
    ['certs', 'Qualifications', 'Degree & training certificates', 'award'],
  ];
  const count = Object.values(done).filter(Boolean).length;
  return (
    <div className="mn-screen">
      <NavHeader title="Verify credentials" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 24px 30px' }}>
        <div className="anim-up" style={{ marginBottom: 8 }}>
          <div style={{ width: 56, height: 56, borderRadius: 16, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 16 }}>
            <Icon name="shield" size={28} color="var(--primary)" stroke={1.9} /></div>
          <h1 className="t-title2">Let’s verify you</h1>
          <p className="t-body muted" style={{ marginTop: 8 }}>Upload your documents so clients can trust they’re in safe, qualified hands.</p>
        </div>
        <div className="progress" style={{ margin: '20px 0 8px' }}><span style={{ width: `${(count / 3) * 100}%` }} /></div>
        <div className="t-foot muted-3" style={{ marginBottom: 20, fontWeight: 600 }}>{count} of 3 uploaded</div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
          {DOCS.map(([k, title, sub, ic]) => {
            const up = done[k];
            return (
              <button key={k} onClick={() => setDone(s => ({ ...s, [k]: !s[k] }))} className="pressable" style={{
                border: `1.5px ${up ? 'solid var(--primary)' : 'dashed var(--hairline-2)'}`, textAlign: 'left',
                background: up ? 'var(--primary-tint)' : 'var(--surface)', borderRadius: 'var(--r-md)', padding: 16,
                cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 14, fontFamily: 'var(--font-ui)', transition: 'all .25s var(--ease)',
              }}>
                <div style={{ width: 44, height: 44, borderRadius: 12, background: up ? 'var(--primary)' : 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, transition: 'background .25s' }}>
                  <Icon name={up ? 'check' : ic} size={22} color={up ? '#fff' : 'var(--ink-3)'} stroke={up ? 3 : 1.9} /></div>
                <div style={{ flex: 1 }}>
                  <div className="t-headline">{title}</div>
                  <div className="t-foot muted" style={{ marginTop: 2 }}>{up ? 'Uploaded · tap to remove' : sub}</div>
                </div>
                {!up && <Icon name="upload" size={20} color="var(--primary)" stroke={2} />}
              </button>
            );
          })}
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 18, color: 'var(--ink-3)' }}>
          <Icon name="lock" size={15} stroke={2} /><span className="t-foot">Encrypted & only seen by our verification team.</span>
        </div>
      </div>
      <div style={{ padding: '12px 24px calc(env(safe-area-inset-bottom,0) + 24px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)' }}>
        <button className="btn btn-primary" disabled={count < 3} onClick={() => ctx.reset('proVerify')}>Submit for review</button>
      </div>
    </div>
  );
};

/* ================= VERIFICATION PENDING ================= */
window.SCREENS.proVerify = function ProVerify() {
  const ctx = pUC(AppCtx);
  const steps = [
    ['Documents received', 'Just now', true],
    ['Identity check', 'In progress', 'active'],
    ['Credential review', 'Up to 48 hours', false],
    ['You’re verified', 'Final step', false],
  ];
  return (
    <div className="mn-screen" style={{ background: 'radial-gradient(120% 55% at 50% 12%, var(--primary-tint) 0%, var(--bg) 45%)' }}>
      <div className="mn-scroll" style={{ padding: `${SAFE_TOP + 10}px 28px 0`, display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center' }}>
        <div style={{ position: 'relative', width: 96, height: 96 }}>
          <div style={{ position: 'absolute', inset: 0, borderRadius: '50%', border: '2px solid var(--primary-ring)', borderTopColor: 'var(--primary)', animation: 'spin 1.4s linear infinite' }} />
          <div style={{ position: 'absolute', inset: 12, borderRadius: '50%', background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Icon name="shield" size={38} color="var(--primary)" stroke={1.8} /></div>
        </div>
        <h1 className="t-title1 anim-up" style={{ marginTop: 28 }}>Verification in progress</h1>
        <p className="t-body muted anim-up" style={{ marginTop: 8, maxWidth: 300 }}>
          Thanks, Dr. Hale. Our team is reviewing your credentials — usually within 48 hours.
        </p>

        <div className="card anim-up" style={{ marginTop: 28, padding: '20px 18px', width: '100%', textAlign: 'left' }}>
          {steps.map(([title, sub, state], i) => (
            <div key={title} style={{ display: 'flex', gap: 14, paddingBottom: i < steps.length - 1 ? 18 : 0 }}>
              <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <div style={{ width: 26, height: 26, borderRadius: '50%', flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center',
                  background: state === true ? 'var(--primary)' : state === 'active' ? 'var(--primary-tint)' : 'var(--fill)',
                  border: state === 'active' ? '2px solid var(--primary)' : 'none' }}>
                  {state === true ? <Icon name="check" size={15} color="#fff" stroke={3} />
                    : state === 'active' ? <span style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--primary)', animation: 'breathe 1.6s infinite' }} />
                    : <span style={{ width: 6, height: 6, borderRadius: '50%', background: 'var(--ink-4)' }} />}
                </div>
                {i < steps.length - 1 && <div style={{ width: 2, flex: 1, minHeight: 22, background: state === true ? 'var(--primary)' : 'var(--hairline)', marginTop: 2 }} />}
              </div>
              <div style={{ paddingTop: 2 }}>
                <div className="t-headline" style={{ color: state === false ? 'var(--ink-3)' : 'var(--ink)' }}>{title}</div>
                <div className="t-foot muted-3" style={{ marginTop: 2 }}>{sub}</div>
              </div>
            </div>
          ))}
        </div>
      </div>
      <div style={{ padding: '14px 28px calc(env(safe-area-inset-bottom,0) + 24px)', display: 'flex', flexDirection: 'column', gap: 10 }}>
        <button className="btn btn-primary" onClick={() => ctx.reset('proApp', { tab: 'home' })}>Preview my dashboard</button>
        <button className="btn btn-ghost" onClick={() => ctx.reset('splash')}>Back to start</button>
      </div>
    </div>
  );
};

/* ================= PRO DASHBOARD ================= */
window.SCREENS.proHome = function ProHome() {
  const ctx = pUC(AppCtx);
  return (
    <div style={{ padding: `${SAFE_TOP}px 20px 24px` }}>
      <div className="anim-up" style={{ display: 'flex', alignItems: 'center', marginBottom: 22 }}>
        <div style={{ flex: 1 }}>
          <div className="t-foot muted-3" style={{ fontWeight: 600 }}>Tuesday, 3 June</div>
          <h1 className="t-serif" style={{ fontSize: 28, marginTop: 2 }}>Good morning, Dr. Hale</h1>
        </div>
        <div style={{ position: 'relative' }}><Avatar name="Evelyn Hale" size={46} photo />
          <span style={{ position: 'absolute', bottom: 0, right: 0, background: 'var(--surface)', borderRadius: 999, padding: 2, display: 'flex' }}><Verified size={13} /></span>
        </div>
      </div>

      {/* MVP 2 indicator */}
      <div className="card anim-up" style={{ padding: 16, marginBottom: 22, display: 'flex', alignItems: 'center', gap: 13, background: 'color-mix(in srgb, var(--topic-4) 12%, var(--surface))', border: '1px dashed color-mix(in srgb, var(--topic-4) 45%, transparent)' }}>
        <div style={{ width: 42, height: 42, borderRadius: 12, background: 'color-mix(in srgb, var(--topic-4) 18%, transparent)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
          <Icon name="sparkle" size={20} color="var(--topic-4)" stroke={2} /></div>
        <div style={{ flex: 1 }}>
          <div className="t-headline" style={{ fontSize: 15 }}>Professional Support · Coming Soon</div>
          <div className="t-foot muted" style={{ marginTop: 2, lineHeight: 1.4 }}>Bookings, sessions and client tools arrive in MVP 2. This is a preview layout.</div>
        </div>
        <span className="badge badge-pending" style={{ flexShrink: 0 }}>MVP 2</span>
      </div>

      {/* stats */}
      <div className="anim-up" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12, marginBottom: 22 }}>
        {[['3', 'Sessions today', 'calendar', 'var(--primary)'], ['2', 'New requests', 'bell', 'var(--clay)'], ['4.9', 'Avg. rating', 'star', 'var(--moss-500)'], ['£1,240', 'This week', 'trend', 'var(--green)']].map(([v, k, ic, col]) => (
          <div key={k} className="card-flat" style={{ padding: 16 }}>
            <div style={{ width: 38, height: 38, borderRadius: 11, background: `color-mix(in srgb, ${col} 14%, transparent)`, display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 12 }}>
              <Icon name={ic} size={19} color={col} stroke={2} /></div>
            <div className="t-title2">{v}</div>
            <div className="t-foot muted-3" style={{ marginTop: 2 }}>{k}</div>
          </div>
        ))}
      </div>

      {/* requests banner */}
      <div className="card anim-up pressable" onClick={() => ctx.goTab('requests')} style={{ padding: 16, marginBottom: 22, display: 'flex', alignItems: 'center', gap: 12, background: 'var(--primary)' }}>
        <div style={{ width: 42, height: 42, borderRadius: 12, background: 'rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <Icon name="bell" size={20} color="#fff" stroke={2} /></div>
        <div style={{ flex: 1 }}>
          <div className="t-headline" style={{ color: '#fff' }}>2 booking requests</div>
          <div className="t-foot" style={{ color: 'rgba(255,255,255,0.85)', marginTop: 1 }}>Review and respond</div>
        </div>
        <Icon name="chevR" size={20} color="#fff" />
      </div>

      <SectionHead title="Today’s sessions" action="Calendar" onAction={() => ctx.goTab('requests')} />
      <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
        {PRO_SESSIONS.filter(s => s.when.startsWith('Today')).map(s => (
          <div key={s.id} className="card-flat" style={{ padding: 14, display: 'flex', alignItems: 'center', gap: 13 }}>
            <div style={{ textAlign: 'center', minWidth: 50 }}>
              <div className="t-headline" style={{ color: 'var(--primary)' }}>{s.when.split('· ')[1].split(' ')[0]}</div>
              <div className="t-cap muted-3">{s.when.split(' ').pop()}</div>
            </div>
            <div style={{ width: 1, alignSelf: 'stretch', background: 'var(--hairline)' }} />
            <Avatar name={s.name} size={42} photo />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div className="t-headline" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{s.name}</div>
              <div className="t-foot muted">{s.type} · {s.mins} min</div>
            </div>
            <button className="nav-btn" onClick={() => ctx.push('chat', { id: 'c1', pro: true })}><Icon name={s.type === 'Video' ? 'video' : 'message'} size={19} color="var(--primary)" stroke={1.9} /></button>
          </div>
        ))}
      </div>
    </div>
  );
};

/* ================= REQUESTS ================= */
window.SCREENS.proRequests = function ProRequests() {
  const ctx = pUC(AppCtx);
  const [reqs, setReqs] = pUS(REQUESTS.map(r => ({ ...r })));
  const act = (id, status) => setReqs(rs => rs.map(r => r.id === id ? { ...r, status } : r));
  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 8px` }}>
        <h1 className="t-title1">Booking requests</h1>
      </div>
      <div style={{ padding: '12px 20px 24px', display: 'flex', flexDirection: 'column', gap: 14 }}>
        {reqs.map(r => (
          <div key={r.id} className="card anim-up" style={{ padding: 16 }}>
            <div className="pressable" onClick={() => ctx.push('proRequestDetail', { id: r.id })} style={{ display: 'flex', gap: 13, alignItems: 'center' }}>
              <Avatar name={r.name} size={50} photo />
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="t-headline">{r.name}</div>
                <div className="t-foot muted" style={{ marginTop: 2 }}>{r.reason}</div>
              </div>
              {r.status !== 'Pending' && <span className={'badge ' + (r.status === 'Accepted' ? 'badge-accept' : 'badge-reject')}>{r.status}</span>}
            </div>
            <div className="card-inset" style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '10px 14px', margin: '14px 0' }}>
              <Icon name="calendar" size={17} color="var(--primary)" stroke={2} />
              <span className="t-foot" style={{ fontWeight: 600 }}>{r.when}</span>
              <span style={{ width: 3, height: 3, borderRadius: '50%', background: 'var(--ink-4)' }} />
              <span className="t-foot muted">{r.mins} min</span>
            </div>
            {r.status === 'Pending' ? (
              <div style={{ display: 'flex', gap: 10 }}>
                <button className="btn btn-secondary btn-sm" style={{ flex: 1, color: 'var(--red)' }} onClick={() => act(r.id, 'Rejected')}>Decline</button>
                <button className="btn btn-outline btn-sm" style={{ flex: 1 }} onClick={() => act(r.id, 'Accepted')}>Reschedule</button>
                <button className="btn btn-primary btn-sm" style={{ flex: 1.4 }} onClick={() => act(r.id, 'Accepted')}>Accept</button>
              </div>
            ) : (
              <div className="t-foot muted-3" style={{ textAlign: 'center', padding: '6px 0' }}>
                {r.status === 'Accepted' ? '✓ Session confirmed — added to your calendar' : 'Request declined'}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

/* ================= REQUEST DETAIL ================= */
window.SCREENS.proRequestDetail = function ProRequestDetail({ params }) {
  const ctx = pUC(AppCtx);
  const r = REQUESTS.find(x => x.id === params.id) || REQUESTS[0];
  const [status, setStatus] = pUS('Pending');
  return (
    <div className="mn-screen">
      <NavHeader title="Request" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 22px 24px' }}>
        <div className="card anim-up" style={{ padding: 22, textAlign: 'center', marginBottom: 18 }}>
          <Avatar name={r.name} size={76} photo style={{ margin: '0 auto' }} />
          <div className="t-title3" style={{ marginTop: 14 }}>{r.name}</div>
          <div className="t-callout muted" style={{ marginTop: 2 }}>New client</div>
          {status !== 'Pending' && <span className={'badge ' + (status === 'Accepted' ? 'badge-accept' : 'badge-reject')} style={{ marginTop: 12, height: 26, fontSize: 12.5 }}>{status}</span>}
        </div>

        <div className="card anim-up" style={{ padding: 4, marginBottom: 18 }}>
          {[['calendar', 'Requested time', r.when], ['clock', 'Duration', `${r.mins} minutes`], ['brain', 'Focus', r.reason], ['video', 'Type', 'Video session']].map(([ic, k, v], i, a) => (
            <div key={k} style={{ display: 'flex', alignItems: 'center', gap: 13, padding: '13px 14px', borderBottom: i < a.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
              <SettingIcon name={ic} />
              <span className="t-callout muted" style={{ flex: 1 }}>{k}</span>
              <span className="t-headline" style={{ textAlign: 'right' }}>{v}</span>
            </div>
          ))}
        </div>

        <div className="card-flat anim-up" style={{ padding: 16 }}>
          <div className="t-cap muted-3" style={{ textTransform: 'uppercase', marginBottom: 8, fontWeight: 700 }}>Note from client</div>
          <p className="t-body muted" style={{ lineHeight: 1.5 }}>“I’ve been feeling really stretched at work and would love some tools to manage the pressure. Looking forward to talking.”</p>
        </div>
      </div>
      {status === 'Pending' ? (
        <div style={{ padding: '12px 22px calc(env(safe-area-inset-bottom,0) + 22px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)', display: 'flex', flexDirection: 'column', gap: 10 }}>
          <button className="btn btn-primary" onClick={() => setStatus('Accepted')}>Accept request</button>
          <div style={{ display: 'flex', gap: 10 }}>
            <button className="btn btn-secondary" style={{ flex: 1 }} onClick={() => setStatus('Accepted')}>Reschedule</button>
            <button className="btn btn-secondary" style={{ flex: 1, color: 'var(--red)' }} onClick={() => setStatus('Rejected')}>Decline</button>
          </div>
        </div>
      ) : (
        <div style={{ padding: '12px 22px calc(env(safe-area-inset-bottom,0) + 22px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)' }}>
          <button className="btn btn-primary" onClick={() => ctx.push('chat', { id: 'c1', pro: true })}>Message {r.name.split(' ')[0]}</button>
        </div>
      )}
    </div>
  );
};

/* ================= PRO CLIENTS (chat list) ================= */
window.SCREENS.proChats = function ProChats() {
  const ctx = pUC(AppCtx);
  const clients = [
    { id: 'c1', name: 'Jordan Mills', last: 'Thank you, that really helped today.', time: '9:24', unread: 1, online: true },
    { id: 'c2', name: 'Leah Karim', last: 'See you Thursday!', time: 'Yesterday', unread: 0, online: false },
    { id: 'c3', name: 'Sam Rivera', last: 'I tried the breathing exercise.', time: 'Mon', unread: 0, online: true },
  ];
  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 8px` }}>
        <h1 className="t-title1">Clients</h1>
      </div>
      <div style={{ padding: '8px 12px 24px' }}>
        {clients.map(c => (
          <div key={c.id} className="row" onClick={() => ctx.push('chat', { id: 'c1', pro: true })} style={{ borderRadius: 18 }}>
            <div style={{ position: 'relative', flexShrink: 0 }}>
              <Avatar name={c.name} size={54} photo />
              {c.online && <span style={{ position: 'absolute', bottom: 1, right: 1, width: 14, height: 14, borderRadius: '50%', background: 'var(--green)', border: '2.5px solid var(--bg)' }} />}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: 'flex', alignItems: 'baseline', gap: 8 }}>
                <span className="t-headline" style={{ flex: 1, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{c.name}</span>
                <span className="t-cap" style={{ color: c.unread ? 'var(--primary)' : 'var(--ink-3)', fontWeight: c.unread ? 700 : 500 }}>{c.time}</span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 3 }}>
                <span className="t-callout" style={{ flex: 1, color: c.unread ? 'var(--ink)' : 'var(--ink-3)', fontWeight: c.unread ? 600 : 400, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{c.last}</span>
                {c.unread > 0 && <span style={{ minWidth: 20, height: 20, padding: '0 6px', borderRadius: 999, background: 'var(--primary)', color: '#fff', fontSize: 12, fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>{c.unread}</span>}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

/* ================= PRO PROFILE ================= */
window.SCREENS.proProfile = function ProProfile() {
  const ctx = pUC(AppCtx);
  const [available, setAvailable] = pUS(true);
  return (
    <div style={{ padding: `${SAFE_TOP}px 20px 24px` }}>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: 22 }}>
        <h1 className="t-title1" style={{ flex: 1 }}>Profile</h1>
        <button className="nav-btn" onClick={() => ctx.push('settings')}><Icon name="sliders" size={20} stroke={1.9} /></button>
      </div>
      <div className="card anim-up" style={{ padding: 22, textAlign: 'center', marginBottom: 18 }}>
        <Avatar name="Evelyn Hale" size={84} ring photo style={{ margin: '0 auto 14px' }} />
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6 }}>
          <span className="t-title3">Dr. Evelyn Hale</span><Verified size={18} />
        </div>
        <div className="t-callout muted" style={{ marginTop: 2 }}>Clinical Psychologist · 9 yrs</div>
        <div style={{ display: 'flex', marginTop: 20 }}>
          {[['128', 'Clients'], ['4.9', 'Rating'], ['96%', 'Response']].map(([v, k], i) => (
            <div key={k} style={{ flex: 1, borderLeft: i ? '1px solid var(--hairline)' : 'none' }}>
              <div className="t-title3" style={{ color: 'var(--primary)' }}>{v}</div>
              <div className="t-cap muted-3" style={{ marginTop: 2 }}>{k}</div>
            </div>
          ))}
        </div>
      </div>

      <div className="card anim-up" style={{ padding: '14px 16px', marginBottom: 18, display: 'flex', alignItems: 'center', gap: 12 }}>
        <div style={{ width: 38, height: 38, borderRadius: 11, background: available ? 'var(--primary-tint)' : 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <Icon name="pulse" size={19} color={available ? 'var(--primary)' : 'var(--ink-3)'} stroke={2} /></div>
        <div style={{ flex: 1 }}>
          <div className="t-headline">Accepting clients</div>
          <div className="t-foot muted-3" style={{ marginTop: 1 }}>{available ? 'Visible in discovery' : 'Hidden from search'}</div>
        </div>
        <Toggle on={available} onChange={setAvailable} />
      </div>

      <div className="card anim-up" style={{ padding: 6, marginBottom: 18 }}>
        {[['calendar', 'Manage availability'], ['award', 'Credentials & verification'], ['trend', 'Earnings & payouts'], ['star', 'Reviews']].map(([ic, label]) => (
          <div key={label} className="row" style={{ borderRadius: 18 }}>
            <SettingIcon name={ic} />
            <span className="t-body" style={{ flex: 1, fontWeight: 500 }}>{label}</span>
            <Icon name="chevR" size={18} color="var(--ink-4)" />
          </div>
        ))}
      </div>
      <button className="btn btn-secondary anim-up" onClick={() => ctx.reset('splash')} style={{ color: 'var(--red)' }}>
        <Icon name="logout" size={20} stroke={2} /> Log out
      </button>
    </div>
  );
};
