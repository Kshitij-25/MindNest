/* MindNest — Tablet · Professional screens (dashboard, earnings, clients+notes, content) */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: pTUS } = React;

const EARN_WEEK = [
  { label: 'Mon', value: 270 }, { label: 'Tue', value: 180, hi: true }, { label: 'Wed', value: 360 },
  { label: 'Thu', value: 225 }, { label: 'Fri', value: 405 }, { label: 'Sat', value: 90 }, { label: 'Sun', value: 0 },
];
const SESSIONS_TREND = [28, 31, 26, 34, 30, 38, 42, 39];
const TRANSACTIONS = [
  { name: 'Leah Karim', type: 'Video · 50 min', date: 'Today', amt: 90 },
  { name: 'Sam Rivera', type: 'Chat · 50 min', date: 'Today', amt: 90 },
  { name: 'Jordan Mills', type: 'Video · 50 min', date: 'Yesterday', amt: 90 },
  { name: 'Noah Bennett', type: 'Intro · 30 min', date: '29 May', amt: 45 },
  { name: 'Priya Shah', type: 'Video · 50 min', date: '28 May', amt: 90 },
];
const PRO_CLIENTS = [
  { id: 'pc1', name: 'Jordan Mills', focus: 'Anxiety & work stress', sessions: 8, since: 'Jan 2026', next: 'Fri 6 Jun', risk: 'Stable', online: true },
  { id: 'pc2', name: 'Leah Karim', focus: 'Sleep & burnout', sessions: 12, since: 'Nov 2025', next: 'Thu 5 Jun', risk: 'Improving', online: false },
  { id: 'pc3', name: 'Sam Rivera', focus: 'Low mood', sessions: 5, since: 'Mar 2026', next: 'Mon 9 Jun', risk: 'Monitor', online: true },
  { id: 'pc4', name: 'Noah Bennett', focus: 'Relationships', sessions: 2, since: 'May 2026', next: 'Tue 10 Jun', risk: 'New', online: false },
];
const CLIENT_NOTES = {
  pc1: [
    { date: '24 May', tag: 'Session 8', text: 'Reframed “I’m behind” as “I’m carrying a lot.” Homework: 3-3-3 grounding before stand-ups. Sleep improving.' },
    { date: '17 May', tag: 'Session 7', text: 'Work pressure peaked midweek. Practised boundary-setting script with manager — felt empowering.' },
  ],
};

/* ============================================================
   PRO DASHBOARD — analytics
   ============================================================ */
window.TABLET_SCREENS.dash = function ProDash({ go, scrollRef, ctx }) {
  const [period, setPeriod] = pTUS('Week');
  const [avail, setAvail] = pTUS(true);
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 24 }}>
          <div>
            <div className="tt-sub muted-3" style={{ fontWeight: 600 }}>Saturday, 31 May</div>
            <h1 className="tt-display" style={{ marginTop: 4 }}>Good morning, Dr. Hale</h1>
          </div>
          <div className="tb-card-flat" style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '10px 16px' }}>
            <span style={{ width: 9, height: 9, borderRadius: '50%', background: avail ? 'var(--green)' : 'var(--ink-4)', boxShadow: avail ? '0 0 0 4px color-mix(in srgb, var(--green) 22%, transparent)' : 'none' }} />
            <div><div className="tt-sub" style={{ fontWeight: 700 }}>{avail ? 'Accepting clients' : 'Unavailable'}</div></div>
            <Toggle on={avail} onChange={setAvail} />
          </div>
        </div>

        {/* KPI row */}
        <div className="tb-grid tb-g4" style={{ marginBottom: 24 }}>
          <TStat icon="calendar" value="3" label="Sessions today" delta="+1" />
          <TStat icon="trend" color="var(--green)" value="£1,240" label="This week" delta="+18%" />
          <TStat icon="star" color="var(--moss-500)" value="4.9" label="Avg. rating" delta="+0.1" />
          <TStat icon="pulse" color="var(--clay)" value="96%" label="Response rate" delta="+4%" />
        </div>

        <div className="tb-grid" style={{ gridTemplateColumns: '1.5fr 1fr' }}>
          {/* main col */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
            <div className="tb-card" style={{ padding: 22 }}>
              <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 18 }}>
                <div>
                  <h3 className="tt-h3">Earnings overview</h3>
                  <div style={{ display: 'flex', alignItems: 'baseline', gap: 8, marginTop: 6 }}>
                    <span className="tt-h1 tt-num">£1,240</span>
                    <span style={{ color: 'var(--green)', fontWeight: 700, fontSize: 14 }}>↑ 18% vs last week</span>
                  </div>
                </div>
                <div style={{ width: 200 }}><Segmented options={['Week', 'Month', 'Year']} value={period} onChange={setPeriod} /></div>
              </div>
              <BarChart data={EARN_WEEK} height={170} fmt={v => '£' + v} />
            </div>

            <div className="tb-card" style={{ padding: 22 }}>
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 16 }}>
                <h3 className="tt-h3">Today’s schedule</h3>
                <button onClick={() => go('calendar')} style={{ border: 0, background: 'none', color: 'var(--primary)', fontWeight: 600, fontSize: 14, cursor: 'pointer' }}>Open calendar</button>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
                {PRO_SESSIONS.map(s => (
                  <div key={s.id} className="tb-row" style={{ padding: 12 }} onClick={() => go('clients')}>
                    <div style={{ textAlign: 'center', minWidth: 56 }}>
                      <div className="tt-head" style={{ color: 'var(--primary)' }}>{s.when.split('· ')[1].split(' ')[0]}</div>
                      <div className="tt-cap muted-3">{s.when.includes('Today') ? s.when.split(' ').pop() : s.when.split(' ')[0]}</div>
                    </div>
                    <div style={{ width: 1, alignSelf: 'stretch', background: 'var(--hairline)' }} />
                    <Avatar name={s.name} size={42} photo />
                    <div style={{ flex: 1, minWidth: 0 }}>
                      <div className="tt-head">{s.name}</div>
                      <div className="tt-sub muted">{s.type} · {s.mins} min</div>
                    </div>
                    <span className="tb-chip outline"><Icon name={s.type === 'Video' ? 'video' : 'message'} size={14} stroke={2} /> {s.type}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* side col */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
            <div className="tb-card pressable" onClick={() => go('calendar')} style={{ padding: 18, display: 'flex', alignItems: 'center', gap: 14, background: 'var(--primary)' }}>
              <div style={{ width: 44, height: 44, borderRadius: 12, background: 'rgba(255,255,255,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="bell" size={21} color="#fff" stroke={2} /></div>
              <div style={{ flex: 1 }}><div className="tt-head" style={{ color: '#fff' }}>2 booking requests</div><div className="tt-cap" style={{ color: 'rgba(255,255,255,0.85)' }}>Awaiting your response</div></div>
              <Icon name="chevR" size={20} color="#fff" />
            </div>

            <div className="tb-card" style={{ padding: 22, display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
              <h3 className="tt-h3" style={{ alignSelf: 'flex-start', marginBottom: 16 }}>Client engagement</h3>
              <DonutRing value={78} size={130} stroke={14}>
                <span className="tt-h1 tt-num">78%</span>
                <span className="tt-cap muted-3">active</span>
              </DonutRing>
              <div style={{ display: 'flex', gap: 22, marginTop: 18 }}>
                <div style={{ textAlign: 'center' }}><div className="tt-h3 tt-num">42</div><div className="tt-cap muted-3">Active clients</div></div>
                <div style={{ width: 1, background: 'var(--hairline)' }} />
                <div style={{ textAlign: 'center' }}><div className="tt-h3 tt-num">11</div><div className="tt-cap muted-3">New this month</div></div>
              </div>
            </div>

            <div className="tb-card" style={{ padding: 22 }}>
              <h3 className="tt-h3" style={{ marginBottom: 14 }}>Session metrics</h3>
              {[['Completed', '96%', 'var(--green)', 96], ['Attendance', '92%', 'var(--primary)', 92], ['Rebooked', '74%', 'var(--clay)', 74]].map(([k, v, c, pct]) => (
                <div key={k} style={{ marginBottom: 14 }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}><span className="tt-sub muted" style={{ fontWeight: 600 }}>{k}</span><span className="tt-sub tt-num" style={{ fontWeight: 700 }}>{v}</span></div>
                  <div style={{ height: 7, borderRadius: 999, background: 'var(--fill)', overflow: 'hidden' }}><div style={{ height: '100%', width: pct + '%', borderRadius: 999, background: c, transition: 'width 1s var(--ease-out)' }} /></div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

/* ============================================================
   EARNINGS
   ============================================================ */
window.TABLET_SCREENS.earnings = function ProEarnings({ scrollRef }) {
  const [period, setPeriod] = pTUS('Month');
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div className="tb-grid" style={{ gridTemplateColumns: '1.4fr 1fr', marginBottom: 22 }}>
          <div className="tb-card" style={{ padding: 26, background: 'linear-gradient(150deg, var(--moss-700), var(--primary))' }}>
            <div style={{ color: 'rgba(255,255,255,0.8)', fontWeight: 700, fontSize: 13, letterSpacing: '0.04em' }}>AVAILABLE TO WITHDRAW</div>
            <div className="tt-num" style={{ color: '#fff', fontSize: `calc(46px * var(--ts))`, fontWeight: 800, marginTop: 6, lineHeight: 1 }}>£4,860</div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 12, color: 'rgba(255,255,255,0.85)', fontSize: 14 }}>
              <Icon name="info" size={15} stroke={2} /> Next automatic payout in 3 days
            </div>
            <button className="btn btn-sm" style={{ width: 'auto', marginTop: 18, background: '#fff', color: 'var(--primary)', padding: '0 22px' }}><Icon name="arrowR" size={17} stroke={2.2} /> Withdraw funds</button>
          </div>
          <div className="tb-card" style={{ padding: 22, display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: 16 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{ width: 42, height: 42, borderRadius: 11, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="trend" size={20} color="var(--primary)" stroke={2} /></div>
              <div><div className="tt-h2 tt-num">£18,420</div><div className="tt-cap muted-3">Total earned in 2026</div></div>
            </div>
            <div style={{ height: 0.5, background: 'var(--hairline)' }} />
            <div style={{ display: 'flex', justifyContent: 'space-between' }}>
              <div><div className="tt-h3 tt-num">204</div><div className="tt-cap muted-3">Sessions</div></div>
              <div><div className="tt-h3 tt-num">£90</div><div className="tt-cap muted-3">Avg. rate</div></div>
              <div><div className="tt-h3 tt-num">£1,240</div><div className="tt-cap muted-3">This week</div></div>
            </div>
          </div>
        </div>

        <div className="tb-card" style={{ padding: 22, marginBottom: 22 }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 18 }}>
            <h3 className="tt-h3">Income trend</h3>
            <div style={{ width: 220 }}><Segmented options={['Week', 'Month', 'Year']} value={period} onChange={setPeriod} /></div>
          </div>
          <LineChart values={[2100, 2480, 2260, 2890, 3120, 2980, 3460, 3840]} height={190} color="var(--green)"
            labels={['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May']} />
        </div>

        <div className="tb-grid" style={{ gridTemplateColumns: '1.4fr 1fr' }}>
          <div className="tb-card" style={{ padding: 22 }}>
            <h3 className="tt-h3" style={{ marginBottom: 14 }}>Recent transactions</h3>
            {TRANSACTIONS.map((tx, i) => (
              <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 14, padding: '12px 0', borderBottom: i < TRANSACTIONS.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
                <Avatar name={tx.name} size={40} photo />
                <div style={{ flex: 1 }}><div className="tt-sub" style={{ fontWeight: 700 }}>{tx.name}</div><div className="tt-cap muted-3">{tx.type} · {tx.date}</div></div>
                <span className="tt-head tt-num" style={{ color: 'var(--green)' }}>+£{tx.amt}</span>
              </div>
            ))}
          </div>
          <div className="tb-card" style={{ padding: 22 }}>
            <h3 className="tt-h3" style={{ marginBottom: 16 }}>By session type</h3>
            {[['Video sessions', 68, 'var(--primary)'], ['Chat sessions', 22, 'var(--topic-1)'], ['Intro calls', 10, 'var(--clay)']].map(([k, pct, c]) => (
              <div key={k} style={{ marginBottom: 16 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}><span className="tt-sub" style={{ fontWeight: 600 }}>{k}</span><span className="tt-sub tt-num" style={{ fontWeight: 700 }}>{pct}%</span></div>
                <div style={{ height: 8, borderRadius: 999, background: 'var(--fill)', overflow: 'hidden' }}><div style={{ height: '100%', width: pct + '%', borderRadius: 999, background: c }} /></div>
              </div>
            ))}
            <div className="tb-card-inset" style={{ padding: 14, marginTop: 8, display: 'flex', gap: 10, alignItems: 'center' }}>
              <Icon name="info" size={17} color="var(--ink-3)" stroke={2} />
              <span className="tt-cap muted">Payouts processed every Friday via Stripe.</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

/* ============================================================
   CLIENTS — split list / detail with session notes
   ============================================================ */
window.TABLET_SCREENS.clients = function ProClients() {
  const [sel, setSel] = pTUS('pc1');
  const [tab, setTab] = pTUS('Notes');
  const [notes, setNotes] = pTUS(CLIENT_NOTES);
  const [draft, setDraft] = pTUS('');
  const c = PRO_CLIENTS.find(x => x.id === sel);
  const list = notes[sel] || [];
  const addNote = () => { if (!draft.trim()) return; setNotes(n => ({ ...n, [sel]: [{ date: 'Today', tag: 'New note', text: draft }, ...(n[sel] || [])] })); setDraft(''); };
  const riskColor = { Stable: 'var(--primary)', Improving: 'var(--green)', Monitor: 'var(--amber)', New: 'var(--topic-1)' };

  return (
    <div className="tb-split">
      <div className="tb-pane tb-pane-l">
        <div style={{ padding: '18px 16px 12px', borderBottom: '0.5px solid var(--hairline)' }}>
          <h2 className="tt-h2" style={{ marginBottom: 12 }}>Clients</h2>
          <div className="tb-search" style={{ maxWidth: 'none' }}><Icon name="search" size={17} stroke={2} /><span>Search clients</span></div>
        </div>
        <div className="tb-scroll" style={{ padding: 8 }}>
          {PRO_CLIENTS.map(cl => (
            <button key={cl.id} onClick={() => setSel(cl.id)} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
              background: sel === cl.id ? 'var(--primary-tint)' : 'transparent', borderRadius: 14, padding: 12, marginBottom: 2,
              display: 'flex', gap: 12, alignItems: 'center', fontFamily: 'var(--font-ui)', transition: 'background .18s' }}>
              <div style={{ position: 'relative', flexShrink: 0 }}>
                <Avatar name={cl.name} size={46} photo />
                {cl.online && <span style={{ position: 'absolute', bottom: 0, right: 0, width: 12, height: 12, borderRadius: '50%', background: 'var(--green)', border: '2.5px solid var(--surface)' }} />}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div className="tt-sub" style={{ fontWeight: 700, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{cl.name}</div>
                <div className="tt-cap muted-3" style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{cl.focus}</div>
              </div>
              <span style={{ width: 8, height: 8, borderRadius: '50%', background: riskColor[cl.risk], flexShrink: 0 }} />
            </button>
          ))}
        </div>
      </div>

      <div className="tb-pane">
        <div className="tb-scroll">
          {/* header */}
          <div style={{ padding: '28px 32px 0' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
              <Avatar name={c.name} size={64} photo ring />
              <div style={{ flex: 1 }}>
                <h1 className="tt-h1">{c.name}</h1>
                <div className="tt-sub muted" style={{ marginTop: 2 }}>{c.focus}</div>
              </div>
              <button className="btn btn-secondary btn-sm" style={{ width: 'auto', padding: '0 16px' }}><Icon name="message" size={17} stroke={2} /> Message</button>
              <button className="btn btn-primary btn-sm" style={{ width: 'auto', padding: '0 16px' }}><Icon name="video" size={17} stroke={2} /> Start session</button>
            </div>
            <div className="tb-grid tb-g4" style={{ margin: '22px 0 18px', gap: 12 }}>
              {[['Sessions', c.sessions], ['Client since', c.since], ['Next', c.next], ['Status', c.risk]].map(([k, v]) => (
                <div key={k} className="tb-card-inset" style={{ padding: '12px 14px' }}><div className="tt-cap muted-3" style={{ fontWeight: 600 }}>{k}</div><div className="tt-head" style={{ marginTop: 3, color: k === 'Status' ? riskColor[c.risk] : 'var(--ink)' }}>{v}</div></div>
              ))}
            </div>
            <div style={{ width: 280 }}><Segmented options={['Notes', 'History', 'Goals']} value={tab} onChange={setTab} /></div>
          </div>

          {/* tab body */}
          <div style={{ padding: '20px 32px 40px' }}>
            {tab === 'Notes' && (
              <div>
                <div className="tb-card" style={{ padding: 16, marginBottom: 18 }}>
                  <textarea value={draft} onChange={e => setDraft(e.target.value)} placeholder="Add a private session note…" className="field"
                    style={{ border: 0, padding: 0, minHeight: 64, resize: 'none', background: 'transparent', fontSize: `calc(15px * var(--ts))`, lineHeight: 1.5 }} />
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 8 }}>
                    <span className="tb-chip outline"><Icon name="tag" size={14} stroke={2} /> Tag</span>
                    <span className="tt-cap muted-3" style={{ display: 'inline-flex', alignItems: 'center', gap: 5 }}><Icon name="lock" size={13} stroke={2} /> Private &amp; encrypted</span>
                    <button className="btn btn-primary btn-sm" style={{ width: 'auto', marginLeft: 'auto', padding: '0 18px' }} onClick={addNote}>Save note</button>
                  </div>
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                  {list.map((n, i) => (
                    <div key={i} className="tb-card-flat" style={{ padding: 18, animation: 'fadeUp .4s var(--ease-out) both' }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 8 }}>
                        <span className="badge badge-verify">{n.tag}</span><span className="tt-cap muted-3">{n.date}</span>
                      </div>
                      <p className="tt-body" style={{ lineHeight: 1.6, color: 'var(--ink-2)' }}>{n.text}</p>
                    </div>
                  ))}
                </div>
              </div>
            )}
            {tab === 'History' && (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 0 }}>
                {['Session 8 · 24 May · Completed', 'Session 7 · 17 May · Completed', 'Session 6 · 10 May · Completed', 'Session 5 · 3 May · Completed'].map((h, i, a) => (
                  <div key={i} style={{ display: 'flex', gap: 14, paddingBottom: i < a.length - 1 ? 18 : 0 }}>
                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                      <span style={{ width: 12, height: 12, borderRadius: '50%', background: 'var(--primary)', flexShrink: 0 }} />
                      {i < a.length - 1 && <div style={{ width: 2, flex: 1, background: 'var(--hairline)', marginTop: 4 }} />}
                    </div>
                    <div style={{ paddingBottom: 2 }}><div className="tt-head">{h.split(' · ')[0]}</div><div className="tt-cap muted-3">{h.split(' · ').slice(1).join(' · ')}</div></div>
                  </div>
                ))}
              </div>
            )}
            {tab === 'Goals' && (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                {[['Practise 3-3-3 grounding daily', true], ['Set one work boundary this week', true], ['Sleep before 11pm, 5 nights', false]].map(([g, done], i) => (
                  <div key={i} className="tb-card-flat" style={{ padding: 16, display: 'flex', alignItems: 'center', gap: 14 }}>
                    <span style={{ width: 26, height: 26, borderRadius: '50%', background: done ? 'var(--primary)' : 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>{done && <Icon name="check" size={15} color="#fff" stroke={3} />}</span>
                    <span className="tt-body" style={{ flex: 1, color: done ? 'var(--ink-3)' : 'var(--ink)', textDecoration: done ? 'line-through' : 'none' }}>{g}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

/* ============================================================
   CONTENT STUDIO
   ============================================================ */
window.TABLET_SCREENS.content = function ProContent({ scrollRef }) {
  const [filter, setFilter] = pTUS('All');
  const list = PRO_POSTS.filter(p => filter === 'All' || (filter === 'Published' ? p.status === 'Published' : p.status === 'Draft'));
  return (
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div className="tb-grid tb-g3" style={{ marginBottom: 24 }}>
          <TStat icon="eye" value="4,130" label="Total views" delta="+12%" />
          <TStat icon="heart" color="var(--clay)" value="439" label="Reactions" delta="+9%" />
          <TStat icon="chat2" color="var(--topic-1)" value="49" label="Comments" delta="+6%" />
        </div>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 16 }}>
          <div style={{ display: 'flex', gap: 8 }}>
            {['All', 'Published', 'Draft'].map(f => <button key={f} className={'tb-chip' + (filter === f ? ' active' : '')} onClick={() => setFilter(f)}>{f}</button>)}
          </div>
          <button className="btn btn-primary btn-sm" style={{ width: 'auto', padding: '0 18px' }}><Icon name="feather" size={17} stroke={2} /> Write a post</button>
        </div>
        <div className="tb-grid tb-g2">
          {list.map((p, i) => (
            <div key={p.id} className="tb-card-flat" style={{ padding: 0, overflow: 'hidden' }}>
              {p.image ? <TImage seed={i} h={130} r={0} /> : <div style={{ height: 130, background: 'var(--surface-3)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="feather" size={30} color="var(--ink-4)" stroke={1.6} /></div>}
              <div style={{ padding: 18 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
                  <span className={'badge ' + (p.status === 'Published' ? 'badge-accept' : 'badge-pending')}>{p.status}</span>
                  <span className="tt-cap muted-3">{p.topic} · {p.time}</span>
                </div>
                <h3 className="tt-h3" style={{ lineHeight: 1.25, marginBottom: 12 }}>{p.title}</h3>
                <div style={{ display: 'flex', alignItems: 'center', gap: 16, color: 'var(--ink-3)' }}>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600 }}><Icon name="eye" size={15} stroke={2} /> {p.views}</span>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600 }}><Icon name="heart" size={15} stroke={2} /> {p.likes}</span>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5, fontSize: 13, fontWeight: 600 }}><Icon name="chat2" size={15} stroke={2} /> {p.comments}</span>
                  <button className="tb-iconbtn" style={{ width: 34, height: 34, marginLeft: 'auto' }}><Icon name="more" size={18} stroke={2} /></button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
