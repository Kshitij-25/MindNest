/* MindNest — chat list + active conversation */
window.SCREENS = window.SCREENS || {};
const { useState: cUS, useContext: cUC, useEffect: cUE, useRef: cURf } = React;

/* ================= AI COACH (repurposed messages) ================= */
window.SCREENS.tabChats = function AICoach({ params }) {
  const ctx = cUC(AppCtx);
  const [msgs, setMsgs] = cUS(COACH_MESSAGES);
  const [text, setText] = cUS('');
  const [typing, setTyping] = cUS(false);
  const [showContext, setShowContext] = cUS(false);
  const endRef = cURf(null);
  const scrollDown = () => {
    const el = endRef.current; if (!el) return;
    let p = el.parentElement;
    while (p && !p.classList.contains('mn-scroll')) p = p.parentElement;
    if (p) p.scrollTop = p.scrollHeight;
  };
  cUE(() => { scrollDown(); }, [msgs, typing]);

  const REPLIES = [
    'That makes sense. Given your week, going gently with yourself seems wise.',
    'I hear you. Want me to pull up the breathing exercise that helped you last deadline?',
    'Noticing that is real progress. Your journals show you’re getting kinder to yourself. 🌱',
  ];
  const send = (preset) => {
    const value = (preset || text).trim();
    if (!value) return;
    const t0 = new Date().toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
    setMsgs(m => [...m, { id: 'x' + Date.now(), from: 'me', text: value, time: t0, read: false }]);
    setText('');
    setTimeout(() => setTyping(true), 500);
    setTimeout(() => {
      setTyping(false);
      setMsgs(m => [...m.map(x => x.from === 'me' ? { ...x, read: true } : x), { id: 'r' + Date.now(), from: 'them', text: REPLIES[Math.floor(Math.random() * REPLIES.length)], time: t0 }]);
    }, 2000);
  };

  return (
    <div style={{ minHeight: '100%', display: 'flex', flexDirection: 'column' }}>
      {/* header */}
      <div style={{ position: 'sticky', top: 0, zIndex: 6, padding: `${SAFE_TOP}px 16px 12px`, background: 'color-mix(in srgb, var(--bg) 90%, transparent)', backdropFilter: 'blur(16px)', borderBottom: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'center', gap: 11 }}>
        <div style={{ width: 42, height: 42, borderRadius: '50%', background: 'linear-gradient(150deg, #7C9D6B, var(--primary))', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
          <Icon name="sparkle" size={22} color="#fff" stroke={2} />
        </div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div className="t-headline">MindNest Coach</div>
          <div className="t-cap" style={{ color: 'var(--green)', fontWeight: 600 }}>Aware of your mood, journals &amp; insights</div>
        </div>
        <button className="nav-btn" onClick={() => setShowContext(true)}><Icon name="info" size={20} stroke={2} /></button>
      </div>

      {/* messages */}
      <div style={{ flex: 1, padding: '16px 16px 8px', display: 'flex', flexDirection: 'column', gap: 4 }}>
        <div className="card-flat" style={{ padding: 14, marginBottom: 12 }}>
          <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 9 }}>Context the coach is using</div>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 7 }}>
            {COACH_CONTEXT.used.map(c => <span key={c} className="chip outline" style={{ height: 28, fontSize: 12.5, gap: 5 }}><span style={{ width: 6, height: 6, borderRadius: '50%', background: 'var(--primary)' }} />{c}</span>)}
          </div>
        </div>
        {msgs.map((m, i) => <Bubble key={m.id} m={m} last={i === msgs.length - 1} />)}
        {typing && (
          <div style={{ alignSelf: 'flex-start', background: 'var(--surface)', borderRadius: '20px 20px 20px 6px', padding: '14px 16px', boxShadow: 'var(--sh-sm)', display: 'flex', gap: 5 }}>
            {[0, 1, 2].map(i => <span key={i} style={{ width: 7, height: 7, borderRadius: '50%', background: 'var(--ink-4)', animation: `typing 1.2s ${i * 0.15}s infinite` }} />)}
          </div>
        )}
        <div ref={endRef} />
      </div>

      {/* sticky composer */}
      <div style={{ position: 'sticky', bottom: 0, background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)', paddingTop: 8 }}>
        <div style={{ padding: '0 14px', display: 'flex', gap: 8, overflowX: 'auto', scrollbarWidth: 'none', marginBottom: 8 }}>
          {COACH_SUGGESTIONS.map(s => (
            <button key={s} onClick={() => send(s)} className="chip outline" style={{ flexShrink: 0, gap: 6 }}>
              <Icon name="sparkle" size={14} color="var(--primary)" stroke={2} />{s}
            </button>
          ))}
        </div>
        <div style={{ padding: '0 14px 14px', display: 'flex', alignItems: 'flex-end', gap: 10 }}>
          <textarea value={text} onChange={e => setText(e.target.value)} placeholder="Tell your coach how you’re doing…" rows={1}
            onKeyDown={e => { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); send(); } }}
            style={{ flex: 1, resize: 'none', border: 0, background: 'var(--surface)', borderRadius: 22, padding: '12px 16px', fontFamily: 'var(--font-ui)', fontSize: 16, color: 'var(--ink)', outline: 'none', maxHeight: 90, boxShadow: 'inset 0 0 0 1.5px var(--hairline)' }} />
          <button onClick={() => send()} disabled={!text.trim()} style={{ flexShrink: 0, width: 44, height: 44, borderRadius: '50%', border: 0, cursor: text.trim() ? 'pointer' : 'default', background: text.trim() ? 'var(--primary)' : 'var(--fill-2)', display: 'flex', alignItems: 'center', justifyContent: 'center', transition: 'all .2s', transform: text.trim() ? 'scale(1)' : 'scale(0.9)' }}>
            <Icon name="send" size={20} color={text.trim() ? 'var(--on-primary)' : 'var(--ink-4)'} stroke={2} />
          </button>
        </div>
      </div>

      {showContext && <CoachContextSheet onClose={() => setShowContext(false)} />}
    </div>
  );
};

function CoachContextSheet({ onClose }) {
  const ctx = cUC(AppCtx);
  return (
    <>
      <div className="scrim" onClick={onClose} />
      <div className="sheet" style={{ maxHeight: '78%', overflowY: 'auto', scrollbarWidth: 'none' }}>
        <div className="sheet-grab" />
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 4 }}>
          <h2 className="t-title3" style={{ flex: 1 }}>What your coach knows</h2>
          <button onClick={onClose} style={{ ...iconBtn, color: 'var(--ink-3)' }}><Icon name="x" size={22} /></button>
        </div>
        <p className="t-callout muted" style={{ marginBottom: 18 }}>Your coach draws on your private data to give grounded, personal replies. Nothing is shared.</p>

        <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 9 }}>Recent mood</div>
        <div className="card-inset" style={{ padding: '12px 14px', marginBottom: 16, display: 'flex', alignItems: 'center', gap: 10 }}>
          <MoodFace level={4} size={36} /><span className="t-callout" style={{ fontWeight: 600 }}>{COACH_CONTEXT.recentMood}</span>
        </div>

        <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 9 }}>Related memories</div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 16 }}>
          {COACH_CONTEXT.memories.map(m => (
            <div key={m} className="card-inset" style={{ padding: '11px 14px', display: 'flex', alignItems: 'center', gap: 10 }}>
              <Icon name="bookOpen" size={17} color="var(--primary)" stroke={1.9} /><span className="t-callout" style={{ color: 'var(--ink-2)' }}>{m}</span>
            </div>
          ))}
        </div>

        <div className="t-cap muted-3" style={{ fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 9 }}>Recent insights</div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 8 }}>
          {COACH_CONTEXT.insights.map(m => (
            <div key={m} className="card-inset" style={{ padding: '11px 14px', display: 'flex', alignItems: 'center', gap: 10 }}>
              <Icon name="sparkle" size={17} color="var(--topic-4)" stroke={1.9} /><span className="t-callout" style={{ color: 'var(--ink-2)' }}>{m}</span>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}

/* ================= ACTIVE CHAT ================= */
window.SCREENS.chat = function Chat({ params }) {
  const ctx = cUC(AppCtx);
  const conv = CONVERSATIONS.find(c => c.id === params.id) || CONVERSATIONS[0];
  const t = therapist(conv.tid);
  const name = params.pro ? 'Jordan Mills' : t.name;
  const seed = (MESSAGES[params.id] || MESSAGES.c1).map(m => params.pro ? { ...m, from: m.from === 'me' ? 'them' : 'me' } : m);
  const [msgs, setMsgs] = cUS(seed);
  const [text, setText] = cUS('');
  const [typing, setTyping] = cUS(false);
  const scrollRef = cURf(null);
  const scrollDown = () => { const el = scrollRef.current; if (el) el.scrollTop = el.scrollHeight; };
  cUE(() => { scrollDown(); }, [msgs, typing]);

  const REPLIES = ['That makes a lot of sense. Thank you for sharing that with me.', 'I hear you. Let’s gently unpack that together.', 'You’re doing the work, and it shows. 🌱'];
  const send = () => {
    if (!text.trim()) return;
    const t0 = new Date().toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
    setMsgs(m => [...m, { id: 'x' + Date.now(), from: 'me', text: text.trim(), time: t0, read: false }]);
    setText('');
    setTimeout(() => setTyping(true), 600);
    setTimeout(() => {
      setTyping(false);
      setMsgs(m => [...m.map(x => x.from === 'me' ? { ...x, read: true } : x), { id: 'r' + Date.now(), from: 'them', text: REPLIES[Math.floor(Math.random() * REPLIES.length)], time: t0 }]);
    }, 2200);
  };

  return (
    <div className="mn-screen">
      {/* header */}
      <div style={{ padding: `${SAFE_TOP}px 12px 10px`, background: 'color-mix(in srgb, var(--bg) 88%, transparent)', backdropFilter: 'blur(16px)', borderBottom: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'center', gap: 10, zIndex: 5 }}>
        <button className="nav-btn" onClick={ctx.pop}><Icon name="back" size={22} stroke={2.2} /></button>
        <Avatar name={name} size={40} photo />
        <div style={{ flex: 1, minWidth: 0 }}>
          <div className="t-headline" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{name}</div>
          <div className="t-cap" style={{ color: typing ? 'var(--primary)' : 'var(--green)', fontWeight: 600 }}>{typing ? 'typing…' : 'Online'}</div>
        </div>
        <button className="nav-btn"><Icon name="phone" size={19} stroke={1.9} /></button>
        <button className="nav-btn"><Icon name="video" size={20} stroke={1.9} /></button>
      </div>

      {/* messages */}
      <div className="mn-scroll" ref={scrollRef} style={{ padding: '16px 16px 8px', display: 'flex', flexDirection: 'column', gap: 4 }}>
        <div style={{ textAlign: 'center', margin: '4px 0 14px' }}>
          <span className="t-cap muted-3" style={{ background: 'var(--fill)', padding: '5px 12px', borderRadius: 999 }}>Today</span>
        </div>
        {!params.pro && (
          <div className="card-flat" style={{ padding: 12, marginBottom: 12, display: 'flex', gap: 10, alignItems: 'center' }}>
            <div style={{ width: 36, height: 36, borderRadius: 10, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Icon name="calendar" size={18} color="var(--primary)" /></div>
            <div style={{ flex: 1 }}><div className="t-foot" style={{ fontWeight: 700 }}>Session confirmed</div><div className="t-cap muted-3">Thu, 5 June · 4:00 PM</div></div>
            <span className="badge badge-accept">Accepted</span>
          </div>
        )}
        {msgs.map((m, i) => <Bubble key={m.id} m={m} last={i === msgs.length - 1} />)}
        {typing && (
          <div style={{ alignSelf: 'flex-start', background: 'var(--surface)', borderRadius: '20px 20px 20px 6px', padding: '14px 16px', boxShadow: 'var(--sh-sm)', display: 'flex', gap: 5 }}>
            {[0, 1, 2].map(i => <span key={i} style={{ width: 7, height: 7, borderRadius: '50%', background: 'var(--ink-4)', animation: `typing 1.2s ${i * 0.15}s infinite` }} />)}
          </div>
        )}
      </div>

      {/* input */}
      <div style={{ padding: '10px 14px calc(env(safe-area-inset-bottom,0) + 16px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'flex-end', gap: 10 }}>
        <button className="nav-btn" style={{ flexShrink: 0 }}><Icon name="plus" size={22} stroke={2} /></button>
        <textarea value={text} onChange={e => setText(e.target.value)} placeholder="Message…" rows={1}
          onKeyDown={e => { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); send(); } }}
          style={{ flex: 1, resize: 'none', border: 0, background: 'var(--surface)', borderRadius: 22, padding: '12px 16px', fontFamily: 'var(--font-ui)', fontSize: 16, color: 'var(--ink)', outline: 'none', maxHeight: 90, boxShadow: 'inset 0 0 0 1.5px var(--hairline)' }} />
        <button onClick={send} disabled={!text.trim()} style={{ flexShrink: 0, width: 44, height: 44, borderRadius: '50%', border: 0, cursor: text.trim() ? 'pointer' : 'default', background: text.trim() ? 'var(--primary)' : 'var(--fill-2)', display: 'flex', alignItems: 'center', justifyContent: 'center', transition: 'all .2s', transform: text.trim() ? 'scale(1)' : 'scale(0.9)' }}>
          <Icon name="send" size={20} color={text.trim() ? 'var(--on-primary)' : 'var(--ink-4)'} stroke={2} />
        </button>
      </div>
    </div>
  );
};

function Bubble({ m, last }) {
  const me = m.from === 'me';
  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: me ? 'flex-end' : 'flex-start', animation: 'fadeUp .35s var(--ease-out) both' }}>
      <div style={{
        maxWidth: '78%', padding: '11px 15px', fontSize: 15.5, lineHeight: 1.4,
        background: me ? 'var(--primary)' : 'var(--surface)', color: me ? 'var(--on-primary)' : 'var(--ink)',
        borderRadius: me ? '20px 20px 6px 20px' : '20px 20px 20px 6px',
        boxShadow: me ? '0 4px 12px var(--primary-ring)' : 'var(--sh-sm)',
      }}>{m.text}</div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 4, margin: '4px 6px 6px' }}>
        <span className="t-cap muted-3">{m.time}</span>
        {me && last && <span className="t-cap" style={{ color: m.read ? 'var(--primary)' : 'var(--ink-4)', fontWeight: 600 }}>· {m.read ? 'Read' : 'Sent'}</span>}
      </div>
    </div>
  );
}
