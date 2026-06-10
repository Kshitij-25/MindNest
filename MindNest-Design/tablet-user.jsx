/* MindNest — Tablet · Client screens (home, journal split, messages split, feed) */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: uUS, useContext: uUC, useRef: uUR } = React;

/* soft imagery placeholder (premium gradient, not a wireframe stripe) */
function TImage({ seed = 0, h = 130, r = 16, label }) {
  const hues = [['#A8C49A', '#7C9D6B'], ['#9BBCC4', '#6E9AA6'], ['#C9B79A', '#A6886B'], ['#B6A9C9', '#8B8FB0'], ['#C4A0A6', '#B0848B']];
  const [a, b] = hues[seed % hues.length];
  return (
    <div style={{ height: h, borderRadius: r, position: 'relative', overflow: 'hidden',
      background: `linear-gradient(135deg, ${a}, ${b})` }}>
      <div style={{ position: 'absolute', inset: 0, background: 'radial-gradient(120% 80% at 80% 10%, rgba(255,255,255,0.28), transparent 60%)' }} />
      <div style={{ position: 'absolute', right: 12, bottom: 10, opacity: 0.6 }}><Icon name="image" size={18} color="#fff" stroke={1.8} /></div>
      {label && <div style={{ position: 'absolute', left: 14, bottom: 12, color: '#fff', fontWeight: 700, fontSize: 13, textShadow: '0 1px 4px rgba(0,0,0,0.2)' }}>{label}</div>}
    </div>
  );
}
window.TImage = TImage;

/* ============================================================
   HOME — multi-column dashboard
   ============================================================ */
window.TABLET_SCREENS.home = function TabHome({ go, scrollRef }) {
  const [mood, setMood] = uUS(null);
  const [saved, setSaved] = uUS(false);
  const next = APPOINTMENTS[0], t = therapist(next.tid);
  const pickMood = (lv) => { setMood(lv); setSaved(true); setTimeout(() => setSaved(false), 2200); };

  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        {/* greeting */}
        <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 22 }}>
          <div>
            <div className="tt-sub muted-3" style={{ fontWeight: 600 }}>Saturday, 31 May</div>
            <h1 className="tt-display" style={{ marginTop: 4 }}>Good morning, Maya</h1>
            <p className="tt-body muted" style={{ marginTop: 6, maxWidth: 440 }}>You’re on a 42-day streak. Here’s a gentle look at your week.</p>
          </div>
          <div style={{ position: 'relative' }}>
            <Avatar name="Maya Chen" size={56} photo ring />
            <span style={{ position: 'absolute', bottom: -2, right: -2, background: 'var(--streak)', color: '#fff',
              borderRadius: 999, padding: '2px 7px', fontSize: 11, fontWeight: 800, border: '2px solid var(--bg)' }}>42</span>
          </div>
        </div>

        {/* mood check-in */}
        <div className="tb-card" style={{ padding: 22, marginBottom: 20 }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 16 }}>
            <div>
              <h3 className="tt-h3">How are you feeling?</h3>
              <div className="tt-sub muted-3" style={{ marginTop: 2 }}>{saved ? 'Saved — thank you for checking in' : 'Tap to log your mood for today'}</div>
            </div>
            {saved && <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6, color: 'var(--green)', fontWeight: 700, fontSize: 14, animation: 'popIn .4s var(--ease-spring) both' }}><Icon name="checkCircle" size={18} stroke={2.2} /> Logged</span>}
          </div>
          <div style={{ display: 'flex', gap: 12 }}>
            {[1, 2, 3, 4, 5].map(lv => (
              <button key={lv} onClick={() => pickMood(lv)} style={{ flex: 1, border: 0, background: 'transparent', cursor: 'pointer',
                display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 8, padding: '6px 0',
                transform: mood === lv ? 'scale(1.04)' : 'none', transition: 'transform .25s var(--ease-spring)' }}>
                <div style={{ position: 'relative' }}>
                  <MoodFace level={lv} size={62} soft={mood !== lv} />
                  {mood === lv && <span style={{ position: 'absolute', inset: -4, borderRadius: '50%', border: '2.5px solid var(--primary)', animation: 'popIn .35s var(--ease-spring) both' }} />}
                </div>
                <span className="tt-cap" style={{ color: mood === lv ? 'var(--ink)' : 'var(--ink-3)', fontWeight: 700 }}>{MOOD_LABELS[lv - 1]}</span>
              </button>
            ))}
          </div>
        </div>

        {/* two-column body */}
        <div className="tb-grid tb-g2" style={{ marginBottom: 4 }}>
          {/* col A */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
            <div className="tb-card" style={{ padding: 0, overflow: 'hidden' }}>
              <div style={{ padding: '16px 20px 14px', borderBottom: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'center', gap: 8 }}>
                <Icon name="calendar" size={18} color="var(--primary)" stroke={2} />
                <span className="tt-head" style={{ flex: 1 }}>Next session</span>
                <span className="tt-cap" style={{ color: 'var(--primary)', fontWeight: 700 }}>In 5 days</span>
              </div>
              <div style={{ padding: 20 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginBottom: 16 }}>
                  <Avatar name={t.name} size={52} photo />
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 5 }}><span className="tt-head">{t.name}</span><Verified size={15} /></div>
                    <div className="tt-sub muted">{next.type} · {next.mins} min</div>
                  </div>
                </div>
                <div className="tb-card-inset" style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '12px 14px', marginBottom: 14 }}>
                  <Icon name="clock" size={17} color="var(--primary)" stroke={2} />
                  <span className="tt-sub" style={{ fontWeight: 700 }}>{next.date} · {next.time}</span>
                </div>
                <div style={{ display: 'flex', gap: 10 }}>
                  <button className="btn btn-primary btn-sm" style={{ flex: 1 }} onClick={() => go('messages')}><Icon name="video" size={17} stroke={2} /> Join</button>
                  <button className="btn btn-secondary btn-sm" style={{ flex: 1 }} onClick={() => go('sessions')}>Manage</button>
                </div>
              </div>
            </div>

            <div className="tb-card" style={{ padding: 20 }}>
              <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', marginBottom: 6 }}>
                <h3 className="tt-h3">This week</h3>
                <button onClick={() => go('journal')} style={{ border: 0, background: 'none', color: 'var(--primary)', fontWeight: 600, fontSize: 14, cursor: 'pointer' }}>Details</button>
              </div>
              <div className="tt-sub muted-3" style={{ marginBottom: 12 }}>Average mood trending up</div>
              <LineChart values={WEEK_MOOD} height={120} labels={['M', 'T', 'W', 'T', 'F', 'S', 'S']} />
            </div>
          </div>

          {/* col B */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
            <div className="tb-card" style={{ padding: 20, background: 'linear-gradient(150deg, var(--primary), var(--moss-700))' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 14 }}>
                <div style={{ width: 38, height: 38, borderRadius: 11, background: 'rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="pen" size={19} color="#fff" stroke={2} /></div>
                <span style={{ color: 'rgba(255,255,255,0.85)', fontWeight: 700, fontSize: 13 }}>TODAY’S PROMPT</span>
              </div>
              <p className="tt-serif" style={{ color: '#fff', fontSize: `calc(20px * var(--ts))`, lineHeight: 1.3 }}>What is one small thing that felt good today?</p>
              <button className="btn btn-sm" onClick={() => go('journal', { compose: true })} style={{ width: '100%', marginTop: 16, background: 'rgba(255,255,255,0.92)', color: 'var(--primary)' }}><Icon name="feather" size={16} stroke={2} /> Start writing</button>
            </div>

            <div className="tb-grid tb-g2" style={{ gap: 14 }}>
              <div className="tb-stat"><DonutRing value={84} size={64} stroke={8}><span className="tt-num" style={{ fontWeight: 800, fontSize: 16 }}>84%</span></DonutRing>
                <div className="tt-sub" style={{ fontWeight: 700, marginTop: 10 }}>Goals met</div><div className="tt-cap muted-3">This week</div></div>
              <div className="tb-stat"><div style={{ display: 'flex', alignItems: 'center', gap: 8 }}><Icon name="flame" size={26} color="var(--streak)" stroke={2} /><span className="tt-h1 tt-num">42</span></div>
                <div className="tt-sub" style={{ fontWeight: 700, marginTop: 10 }}>Day streak</div><div className="tt-cap muted-3">Keep it going</div></div>
            </div>

            <div className="tb-card" style={{ padding: 18 }}>
              <h3 className="tt-h3" style={{ marginBottom: 12 }}>Recommended reading</h3>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                {POSTS.slice(0, 2).map((p, i) => (
                  <div key={p.id} className="tb-row" style={{ padding: 8 }} onClick={() => go('feed')}>
                    <TImage seed={i + 1} h={56} r={12} />
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div className="tt-cap" style={{ color: topicColor(p.topic), fontWeight: 800, textTransform: 'uppercase' }}>{p.topic}</div>
                      <div className="tt-sub" style={{ fontWeight: 650, marginTop: 2, lineHeight: 1.3 }}>{p.title}</div>
                      <div className="tt-cap muted-3" style={{ marginTop: 2 }}>{p.read} min read</div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>

        {/* discover strip */}
        <TSection title="Find your therapist" sub="Matched to your goals" action="See all" onAction={() => go('sessions')} style={{ marginTop: 24 }}>
          <div className="tb-grid tb-g3">
            {THERAPISTS.slice(0, 3).map(th => (
              <div key={th.id} className="tb-card-flat" style={{ padding: 16, cursor: 'pointer' }} onClick={() => go('sessions', { book: th.id })}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12 }}>
                  <Avatar name={th.name} size={46} photo />
                  <div style={{ minWidth: 0 }}>
                    <div className="tt-sub" style={{ fontWeight: 700, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{th.name}</div>
                    <div className="tt-cap muted-3">{th.spec}</div>
                  </div>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <Stars value={th.rating} size={12} />
                  <span className="tt-cap" style={{ fontWeight: 700, color: 'var(--primary)' }}>Next: {th.next}</span>
                </div>
              </div>
            ))}
          </div>
        </TSection>
      </div>
    </div>
  );
};

/* ============================================================
   JOURNAL — split list / entry
   ============================================================ */
window.TABLET_SCREENS.journal = function TabJournal({ params = {} }) {
  const [sel, setSel] = uUS(JOURNALS[0].id);
  const [compose, setCompose] = uUS(!!params.compose);
  const entry = journal(sel);

  return (
    <div className="tb-split">
      {/* list */}
      <div className="tb-pane tb-pane-l">
        <div style={{ padding: '18px 18px 12px', borderBottom: '0.5px solid var(--hairline)' }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
            <h2 className="tt-h2">Journal</h2>
            <button className="tb-iconbtn" style={{ width: 40, height: 40, background: 'var(--primary)', color: '#fff' }} onClick={() => setCompose(true)}><Icon name="plus" size={20} stroke={2.4} /></button>
          </div>
          <div style={{ display: 'flex', gap: 8 }}>
            <span className="tb-chip active">All</span><span className="tb-chip">Favourites</span><span className="tb-chip">Drafts</span>
          </div>
        </div>
        <div className="tb-scroll" style={{ padding: 10 }}>
          {JOURNALS.map(j => (
            <button key={j.id} onClick={() => { setSel(j.id); setCompose(false); }} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
              background: sel === j.id && !compose ? 'var(--primary-tint)' : 'transparent', borderRadius: 14, padding: 14, marginBottom: 4, fontFamily: 'var(--font-ui)',
              transition: 'background .18s' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 6 }}>
                <MoodFace level={j.mood} size={30} />
                <span className="tt-cap muted-3" style={{ flex: 1, fontWeight: 600 }}>{j.day} · {j.time}</span>
                {j.draft && <span className="badge badge-pending">Draft</span>}
              </div>
              <div className="tt-sub" style={{ fontWeight: 700, color: sel === j.id && !compose ? 'var(--primary)' : 'var(--ink)' }}>{j.title || 'Untitled entry'}</div>
              <div className="tt-cap muted" style={{ marginTop: 3, lineHeight: 1.4, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{j.body}</div>
            </button>
          ))}
        </div>
      </div>

      {/* detail / compose */}
      <div className="tb-pane">
        {compose ? (
          <div className="tb-scroll" style={{ padding: '32px 40px' }}>
            <div className="tt-sub muted-3" style={{ fontWeight: 600, marginBottom: 16 }}>New entry · Saturday, 31 May</div>
            <input className="field" placeholder="Give it a title…" autoFocus style={{ border: 0, padding: 0, fontSize: `calc(28px * var(--ts))`, fontWeight: 700, fontFamily: 'var(--font-serif)', minHeight: 'auto', marginBottom: 16, background: 'transparent' }} />
            <div style={{ display: 'flex', gap: 14, marginBottom: 20 }}>
              {[1, 2, 3, 4, 5].map(lv => <MoodFace key={lv} level={lv} size={40} soft />)}
            </div>
            <textarea className="field" placeholder="What is one small thing that felt good today?" style={{ border: 0, padding: 0, minHeight: 280, resize: 'none', fontSize: `calc(17px * var(--ts))`, lineHeight: 1.6, background: 'transparent' }} />
            <div style={{ display: 'flex', gap: 10, marginTop: 8 }}>
              <span className="tb-chip outline"><Icon name="tag" size={14} stroke={2} /> Add tag</span>
              <span className="tb-chip outline"><Icon name="image" size={14} stroke={2} /> Photo</span>
            </div>
            <div style={{ display: 'flex', gap: 12, marginTop: 28, maxWidth: 320 }}>
              <button className="btn btn-secondary btn-sm" style={{ flex: 1 }} onClick={() => setCompose(false)}>Cancel</button>
              <button className="btn btn-primary btn-sm" style={{ flex: 1.4 }} onClick={() => setCompose(false)}>Save entry</button>
            </div>
          </div>
        ) : (
          <div className="tb-scroll" style={{ padding: '32px 40px' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 20 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <MoodFace level={entry.mood} size={44} />
                <div><div className="tt-sub" style={{ fontWeight: 700 }}>Feeling {MOOD_LABELS[entry.mood - 1].toLowerCase()}</div><div className="tt-cap muted-3">{entry.day} · {entry.date} · {entry.time}</div></div>
              </div>
              <div style={{ display: 'flex', gap: 8 }}>
                <button className="tb-iconbtn"><Icon name="edit" size={18} stroke={1.9} /></button>
                <button className="tb-iconbtn"><Icon name="share" size={18} stroke={1.9} /></button>
              </div>
            </div>
            <h1 className="tt-serif" style={{ fontSize: `calc(32px * var(--ts))`, lineHeight: 1.15, marginBottom: 18 }}>{entry.title || 'Untitled entry'}</h1>
            <p className="tt-body" style={{ fontSize: `calc(17px * var(--ts))`, lineHeight: 1.7, color: 'var(--ink-2)', whiteSpace: 'pre-wrap', maxWidth: 600 }}>{entry.body}</p>
            <div style={{ display: 'flex', gap: 8, marginTop: 24 }}>
              {entry.tags.map(tg => <span key={tg} className="tb-chip" style={{ background: `color-mix(in srgb, ${topicColor(tg)} 16%, transparent)`, color: topicColor(tg) }}>{tg}</span>)}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

/* ============================================================
   MESSAGES — split list / thread
   ============================================================ */
window.TABLET_SCREENS.messages = function TabMessages() {
  const [sel, setSel] = uUS('c1');
  const [draft, setDraft] = uUS('');
  const [msgs, setMsgs] = uUS(MESSAGES.c1.map(m => ({ ...m })));
  const conv = CONVERSATIONS.find(c => c.id === sel) || CONVERSATIONS[0];
  const t = therapist(conv.tid);
  const send = () => { if (!draft.trim()) return; setMsgs(m => [...m, { id: 'x' + m.length, from: 'me', text: draft, time: 'now', read: false }]); setDraft(''); };

  return (
    <div className="tb-split">
      <div className="tb-pane tb-pane-l">
        <div style={{ padding: '18px 16px 12px', borderBottom: '0.5px solid var(--hairline)' }}>
          <h2 className="tt-h2" style={{ marginBottom: 12 }}>Messages</h2>
          <div className="tb-search" style={{ maxWidth: 'none' }}><Icon name="search" size={17} stroke={2} /><span>Search</span></div>
        </div>
        <div className="tb-scroll" style={{ padding: 8 }}>
          {CONVERSATIONS.map(c => {
            const ct = therapist(c.tid);
            return (
              <button key={c.id} onClick={() => setSel(c.id)} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
                background: sel === c.id ? 'var(--primary-tint)' : 'transparent', borderRadius: 14, padding: 12, marginBottom: 2,
                display: 'flex', gap: 12, alignItems: 'center', fontFamily: 'var(--font-ui)', transition: 'background .18s' }}>
                <div style={{ position: 'relative', flexShrink: 0 }}>
                  <Avatar name={ct.name} size={48} photo />
                  {c.online && <span style={{ position: 'absolute', bottom: 1, right: 1, width: 13, height: 13, borderRadius: '50%', background: 'var(--green)', border: '2.5px solid var(--surface)' }} />}
                </div>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ display: 'flex', alignItems: 'baseline', gap: 6 }}>
                    <span className="tt-sub" style={{ flex: 1, fontWeight: 700, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{ct.name}</span>
                    <span className="tt-cap" style={{ color: c.unread ? 'var(--primary)' : 'var(--ink-3)', fontWeight: c.unread ? 700 : 500 }}>{c.time}</span>
                  </div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 2 }}>
                    <span className="tt-cap" style={{ flex: 1, color: c.unread ? 'var(--ink)' : 'var(--ink-3)', fontWeight: c.unread ? 600 : 400, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{c.last}</span>
                    {c.unread > 0 && <span style={{ minWidth: 19, height: 19, padding: '0 6px', borderRadius: 999, background: 'var(--primary)', color: '#fff', fontSize: 11.5, fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>{c.unread}</span>}
                  </div>
                </div>
              </button>
            );
          })}
        </div>
      </div>

      <div className="tb-pane">
        {/* thread header */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '16px 24px', borderBottom: '0.5px solid var(--hairline)' }}>
          <Avatar name={t.name} size={44} photo />
          <div style={{ flex: 1 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 5 }}><span className="tt-head">{t.name}</span><Verified size={14} /></div>
            <div className="tt-cap" style={{ color: conv.online ? 'var(--green)' : 'var(--ink-3)', fontWeight: 600 }}>{conv.online ? 'Online now' : 'Last seen recently'}</div>
          </div>
          <button className="tb-iconbtn"><Icon name="phone" size={19} stroke={1.9} /></button>
          <button className="tb-iconbtn" style={{ background: 'var(--primary)', color: '#fff' }}><Icon name="video" size={19} stroke={1.9} /></button>
        </div>
        {/* messages */}
        <div className="tb-scroll" style={{ padding: '24px 32px', display: 'flex', flexDirection: 'column', gap: 12 }}>
          <div style={{ textAlign: 'center', margin: '4px 0 8px' }}><span className="tt-cap muted-3" style={{ background: 'var(--fill)', padding: '5px 12px', borderRadius: 999, fontWeight: 600 }}>Today</span></div>
          {msgs.map(m => (
            <div key={m.id} style={{ display: 'flex', justifyContent: m.from === 'me' ? 'flex-end' : 'flex-start' }}>
              <div style={{ maxWidth: '64%', padding: '12px 16px', borderRadius: m.from === 'me' ? '20px 20px 6px 20px' : '20px 20px 20px 6px',
                background: m.from === 'me' ? 'var(--primary)' : 'var(--surface)', color: m.from === 'me' ? 'var(--on-primary)' : 'var(--ink)',
                boxShadow: m.from === 'me' ? 'none' : 'var(--sh-sm)', animation: 'fadeUp .35s var(--ease-out) both' }}>
                <div className="tt-body" style={{ lineHeight: 1.45 }}>{m.text}</div>
                <div style={{ fontSize: 11, marginTop: 4, color: m.from === 'me' ? 'rgba(255,255,255,0.7)' : 'var(--ink-3)', textAlign: 'right' }}>{m.time}</div>
              </div>
            </div>
          ))}
        </div>
        {/* composer */}
        <div style={{ padding: '14px 24px', borderTop: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'center', gap: 10 }}>
          <button className="tb-iconbtn"><Icon name="plus" size={20} stroke={2.2} /></button>
          <input className="field" value={draft} onChange={e => setDraft(e.target.value)} onKeyDown={e => e.key === 'Enter' && send()} placeholder="Write a message…" style={{ flex: 1, minHeight: 46, borderRadius: 999 }} />
          <button className="tb-iconbtn" style={{ background: 'var(--primary)', color: '#fff' }} onClick={send}><Icon name="send" size={19} stroke={2} /></button>
        </div>
      </div>
    </div>
  );
};

/* ============================================================
   FEED — multi-column content
   ============================================================ */
window.TABLET_SCREENS.feed = function TabFeed({ scrollRef }) {
  const [topic, setTopic] = uUS('For you');
  const topics = ['For you', 'Anxiety', 'Sleep', 'Mindfulness', 'Relationships'];
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page">
        <div style={{ display: 'flex', gap: 8, marginBottom: 22, flexWrap: 'wrap' }}>
          {topics.map(tp => <button key={tp} className={'tb-chip' + (topic === tp ? ' active' : '')} onClick={() => setTopic(tp)}>{tp}</button>)}
        </div>
        {/* featured */}
        <div className="tb-card tb-anim-item" style={{ padding: 0, overflow: 'hidden', marginBottom: 20, cursor: 'pointer' }}>
          <TImage seed={0} h={220} r={0} label="" />
          <div style={{ padding: 22 }}>
            <span className="tt-cap" style={{ color: topicColor('Anxiety'), fontWeight: 800, textTransform: 'uppercase' }}>Anxiety · Featured</span>
            <h2 className="tt-h2" style={{ marginTop: 8 }}>{POSTS[0].title}</h2>
            <p className="tt-body muted" style={{ marginTop: 8, maxWidth: 560 }}>{POSTS[0].body.split('\n')[0]}</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginTop: 16 }}>
              <Avatar name={therapist(POSTS[0].tid).name} size={34} photo />
              <span className="tt-sub" style={{ fontWeight: 600 }}>{therapist(POSTS[0].tid).name}</span>
              <span className="tt-cap muted-3">· {POSTS[0].read} min read</span>
            </div>
          </div>
        </div>
        {/* grid */}
        <div className="tb-grid tb-g2 tb-anim">
          {POSTS.slice(1).concat(POSTS).map((p, i) => (
            <div key={i} className="tb-card-flat" style={{ padding: 0, overflow: 'hidden', cursor: 'pointer' }}>
              {p.image && <TImage seed={i + 2} h={150} r={0} />}
              <div style={{ padding: 18 }}>
                <span className="tt-cap" style={{ color: topicColor(p.topic), fontWeight: 800, textTransform: 'uppercase' }}>{p.topic}</span>
                <h3 className="tt-h3" style={{ marginTop: 6, lineHeight: 1.25 }}>{p.title}</h3>
                <p className="tt-sub muted" style={{ marginTop: 6, lineHeight: 1.5, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{p.body.split('\n')[0]}</p>
                <div style={{ display: 'flex', alignItems: 'center', gap: 16, marginTop: 14, color: 'var(--ink-3)' }}>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600 }}><Icon name="heart" size={16} stroke={2} /> {p.likes}</span>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600 }}><Icon name="chat2" size={16} stroke={2} /> {p.comments}</span>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600, marginLeft: 'auto' }}><Icon name="bookmark" size={16} stroke={2} /></span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
