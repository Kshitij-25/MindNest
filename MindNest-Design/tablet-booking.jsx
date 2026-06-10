/* MindNest — Tablet · Advanced booking (client sessions + pro calendar) */
window.TABLET_SCREENS = window.TABLET_SCREENS || {};
const { useState: bUS } = React;

const UPCOMING = [
  { id: 'u1', tid: 't1', date: 'Thu, 5 Jun', time: '4:00 PM', type: 'Video', mins: 50, recurring: 'Weekly', reminders: true },
  { id: 'u2', tid: 't3', date: 'Thu, 12 Jun', time: '4:00 PM', type: 'Video', mins: 50, recurring: 'Weekly', reminders: true },
];
const PAST = [
  { id: 'pa1', tid: 't1', date: '24 May', time: '4:00 PM', type: 'Video', mins: 50 },
  { id: 'pa2', tid: 't1', date: '17 May', time: '4:00 PM', type: 'Video', mins: 50 },
];
const SLOTS = ['9:00', '10:00', '11:00', '1:00', '2:00', '3:00', '4:00', '5:00'];

/* ============================================================
   CLIENT — Sessions (manage + book)
   ============================================================ */
window.TABLET_SCREENS.sessions = function TabSessions({ params = {}, scrollRef }) {
  const [booking, setBooking] = bUS(params.book ? therapist(params.book) : null);
  const [cancelId, setCancelId] = bUS(null);
  const [list, setList] = bUS(UPCOMING.map(u => ({ ...u })));
  const doCancel = (id) => { setList(l => l.filter(x => x.id !== id)); setCancelId(null); };

  return (
    <React.Fragment>
    <div className="tb-scroll" ref={scrollRef}>
      <div className="tb-page tb-anim">
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 22 }}>
          <div><h1 className="tt-h1">Your sessions</h1><p className="tt-sub muted-3" style={{ marginTop: 4 }}>Manage upcoming appointments, reminders and recurring bookings.</p></div>
          <button className="btn btn-primary btn-sm" style={{ width: 'auto', padding: '0 20px' }} onClick={() => setBooking(therapist('t1'))}><Icon name="plus" size={18} stroke={2.4} /> Book a session</button>
        </div>

        <TSection title="Upcoming">
          {list.length === 0 ? (
            <div className="tb-card" style={{ padding: '48px 24px', textAlign: 'center' }}>
              <div style={{ width: 84, height: 84, borderRadius: '50%', background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 18px', animation: 'breatheSlow 4s var(--ease) infinite' }}>
                <Icon name="calendar" size={38} color="var(--primary)" stroke={1.7} /></div>
              <h3 className="tt-h3">No sessions booked yet</h3>
              <p className="tt-body muted" style={{ marginTop: 8, maxWidth: 360, marginInline: 'auto' }}>When you’re ready, booking a session takes less than a minute. Your therapist will confirm shortly after.</p>
              <button className="btn btn-primary btn-sm" style={{ width: 'auto', margin: '20px auto 0', padding: '0 24px' }} onClick={() => setBooking(therapist('t1'))}>Find a therapist</button>
            </div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
              {list.map(u => {
                const t = therapist(u.tid);
                return (
                  <div key={u.id} className="tb-card" style={{ padding: 20 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                      <div style={{ textAlign: 'center', minWidth: 64, padding: '8px 0', borderRadius: 14, background: 'var(--primary-tint)' }}>
                        <div className="tt-cap" style={{ color: 'var(--primary)', fontWeight: 800, textTransform: 'uppercase' }}>{u.date.split(',')[0]}</div>
                        <div className="tt-h2 tt-num" style={{ color: 'var(--primary)', lineHeight: 1 }}>{u.date.match(/\d+/)[0]}</div>
                      </div>
                      <Avatar name={t.name} size={52} photo />
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}><span className="tt-head">{t.name}</span><Verified size={14} /></div>
                        <div className="tt-sub muted" style={{ marginTop: 2 }}>{u.time} · {u.type} · {u.mins} min</div>
                        <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
                          {u.recurring !== 'One-time' && <span className="tb-chip" style={{ height: 26, background: 'var(--clay-tint)', color: 'var(--clay)' }}><Icon name="clock" size={13} stroke={2} /> {u.recurring}</span>}
                          {u.reminders && <span className="tb-chip" style={{ height: 26 }}><Icon name="bell" size={13} stroke={2} /> Reminders on</span>}
                        </div>
                      </div>
                      <div style={{ display: 'flex', flexDirection: 'column', gap: 8, width: 130 }}>
                        <button className="btn btn-primary btn-sm" onClick={() => setBooking(t)}><Icon name="video" size={16} stroke={2} /> Join</button>
                        <button className="btn btn-secondary btn-sm" onClick={() => setBooking(t)}>Reschedule</button>
                        <button className="btn btn-ghost btn-sm" style={{ color: 'var(--red)' }} onClick={() => setCancelId(u.id)}>Cancel</button>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </TSection>

        <TSection title="Past sessions">
          <div className="tb-card" style={{ padding: 6 }}>
            {PAST.map((p, i) => {
              const t = therapist(p.tid);
              return (
                <div key={p.id} className="tb-row" style={{ borderBottom: i < PAST.length - 1 ? '0.5px solid var(--hairline)' : 'none', borderRadius: 0 }}>
                  <Avatar name={t.name} size={40} photo />
                  <div style={{ flex: 1 }}><div className="tt-sub" style={{ fontWeight: 700 }}>{t.name}</div><div className="tt-cap muted-3">{p.date} · {p.time} · {p.mins} min</div></div>
                  <span className="badge badge-accept">Completed</span>
                  <button className="btn btn-secondary btn-sm" style={{ width: 'auto', padding: '0 14px' }} onClick={() => setBooking(t)}>Book again</button>
                </div>
              );
            })}
          </div>
        </TSection>
      </div>
    </div>

      {booking && <BookingFlow t={booking} onClose={() => setBooking(null)} />}
      {cancelId && <CancelSheet onClose={() => setCancelId(null)} onConfirm={() => doCancel(cancelId)} onReschedule={() => { setCancelId(null); setBooking(therapist('t1')); }} />}
    </React.Fragment>
  );
};

/* ---------- Booking flow (recurring + reminders) ---------- */
function BookingFlow({ t, onClose }) {
  const [step, setStep] = bUS(1);
  const [day, setDay] = bUS(3);
  const [slot, setSlot] = bUS('4:00');
  const [recur, setRecur] = bUS('Weekly');
  const [reminders, setReminders] = bUS({ '24h': true, '1h': true, '10m': false });
  const days = ['Mon 2', 'Tue 3', 'Wed 4', 'Thu 5', 'Fri 6', 'Sat 7', 'Sun 8'];

  return (
    <div className="scrim" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 40 }} onClick={onClose}>
      <div className="tb-card" style={{ width: 560, maxHeight: '100%', overflow: 'hidden', display: 'flex', flexDirection: 'column', animation: 'scaleIn .4s var(--ease-spring) both' }} onClick={e => e.stopPropagation()}>
        <div style={{ padding: '20px 24px', borderBottom: '0.5px solid var(--hairline)', display: 'flex', alignItems: 'center', gap: 14 }}>
          <Avatar name={t.name} size={48} photo />
          <div style={{ flex: 1 }}><div style={{ display: 'flex', alignItems: 'center', gap: 6 }}><span className="tt-head">{t.name}</span><Verified size={14} /></div><div className="tt-cap muted-3">£{t.price} · {t.spec}</div></div>
          <button className="tb-iconbtn" onClick={onClose}><Icon name="x" size={20} stroke={2.2} /></button>
        </div>

        <div className="tb-scroll" style={{ padding: 24 }}>
          {step === 1 ? (
            <div>
              <h3 className="tt-h3" style={{ marginBottom: 14 }}>Pick a time</h3>
              <div style={{ display: 'flex', gap: 8, overflowX: 'auto', paddingBottom: 8, marginBottom: 18 }}>
                {days.map((d, i) => (
                  <button key={d} onClick={() => setDay(i)} style={{ flexShrink: 0, width: 70, padding: '12px 0', borderRadius: 14, border: 0, cursor: 'pointer',
                    background: day === i ? 'var(--primary)' : 'var(--fill)', color: day === i ? '#fff' : 'var(--ink)', fontFamily: 'var(--font-ui)' }}>
                    <div className="tt-cap" style={{ opacity: 0.8, fontWeight: 600 }}>{d.split(' ')[0]}</div>
                    <div className="tt-h3 tt-num">{d.split(' ')[1]}</div>
                  </button>
                ))}
              </div>
              <div className="tb-grid tb-g4" style={{ gap: 10, marginBottom: 24 }}>
                {SLOTS.map(s => (
                  <button key={s} onClick={() => setSlot(s)} style={{ padding: '12px 0', borderRadius: 12, cursor: 'pointer', fontFamily: 'var(--font-ui)', fontWeight: 600, fontSize: 15,
                    border: slot === s ? '1.5px solid var(--primary)' : '1.5px solid var(--hairline)', background: slot === s ? 'var(--primary-tint)' : 'var(--surface)', color: slot === s ? 'var(--primary)' : 'var(--ink)' }}>{s} PM</button>
                ))}
              </div>

              <h3 className="tt-h3" style={{ marginBottom: 10 }}>Repeat</h3>
              <div style={{ display: 'flex', gap: 8, marginBottom: 22 }}>
                {['One-time', 'Weekly', 'Fortnightly', 'Monthly'].map(r => <button key={r} className={'tb-chip' + (recur === r ? ' active' : '')} onClick={() => setRecur(r)}>{r}</button>)}
              </div>

              <h3 className="tt-h3" style={{ marginBottom: 10 }}>Reminders</h3>
              <div className="tb-card-inset" style={{ padding: 6 }}>
                {[['24h', '24 hours before'], ['1h', '1 hour before'], ['10m', '10 minutes before']].map(([k, label], i, a) => (
                  <div key={k} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '12px 14px', borderBottom: i < a.length - 1 ? '0.5px solid var(--hairline)' : 'none' }}>
                    <Icon name="bell" size={18} color="var(--primary)" stroke={2} />
                    <span className="tt-body" style={{ flex: 1 }}>{label}</span>
                    <Toggle on={reminders[k]} onChange={v => setReminders(s => ({ ...s, [k]: v }))} />
                  </div>
                ))}
              </div>
            </div>
          ) : (
            <div style={{ textAlign: 'center', padding: '20px 0' }}>
              <div style={{ width: 92, height: 92, borderRadius: '50%', background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 20px', animation: 'popIn .5s var(--ease-spring) both' }}>
                <Icon name="check" size={46} color="var(--primary)" stroke={2.6} /></div>
              <h2 className="tt-h2">Session requested</h2>
              <p className="tt-body muted" style={{ marginTop: 8, maxWidth: 360, marginInline: 'auto' }}>{t.name.split(' ').slice(-1)} will confirm shortly. We’ll remind you {recur !== 'One-time' ? `every session (${recur.toLowerCase()})` : 'before it starts'}.</p>
              <div className="tb-card-inset" style={{ padding: 16, margin: '20px auto 0', maxWidth: 340, textAlign: 'left' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 8 }}><span className="tt-sub muted">When</span><span className="tt-sub" style={{ fontWeight: 700 }}>{days[day]} · {slot} PM</span></div>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 8 }}><span className="tt-sub muted">Repeats</span><span className="tt-sub" style={{ fontWeight: 700 }}>{recur}</span></div>
                <div style={{ display: 'flex', justifyContent: 'space-between' }}><span className="tt-sub muted">Reminders</span><span className="tt-sub" style={{ fontWeight: 700 }}>{Object.values(reminders).filter(Boolean).length} set</span></div>
              </div>
            </div>
          )}
        </div>

        <div style={{ padding: '16px 24px', borderTop: '0.5px solid var(--hairline)', display: 'flex', gap: 12, alignItems: 'center' }}>
          {step === 1 ? (
            <React.Fragment>
              <div style={{ flex: 1 }}><div className="tt-cap muted-3">Total</div><div className="tt-head tt-num">£{t.price}{recur !== 'One-time' ? ' / session' : ''}</div></div>
              <button className="btn btn-primary btn-sm" style={{ width: 'auto', padding: '0 28px' }} onClick={() => setStep(2)}>Confirm booking</button>
            </React.Fragment>
          ) : (
            <button className="btn btn-primary btn-sm" onClick={onClose}>Done</button>
          )}
        </div>
      </div>
    </div>
  );
}

/* ---------- Cancellation handling ---------- */
function CancelSheet({ onClose, onConfirm, onReschedule }) {
  return (
    <div className="scrim" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 40 }} onClick={onClose}>
      <div className="tb-card" style={{ width: 440, padding: 28, animation: 'scaleIn .35s var(--ease-spring) both' }} onClick={e => e.stopPropagation()}>
        <div style={{ width: 60, height: 60, borderRadius: '50%', background: 'color-mix(in srgb, var(--red) 14%, transparent)', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 18 }}>
          <Icon name="info" size={30} color="var(--red)" stroke={2} /></div>
        <h2 className="tt-h2">Cancel this session?</h2>
        <p className="tt-body muted" style={{ marginTop: 8 }}>You’re cancelling more than 24 hours ahead, so there’s <strong style={{ color: 'var(--ink)' }}>no charge</strong>. Would you like to reschedule instead?</p>
        <div className="tb-card-inset" style={{ padding: 14, margin: '18px 0', display: 'flex', gap: 10, alignItems: 'center' }}>
          <Icon name="info" size={17} color="var(--ink-3)" stroke={2} />
          <span className="tt-cap muted">Cancellations within 24 hours are charged 50% of the session fee.</span>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          <button className="btn btn-primary btn-sm" onClick={onReschedule}>Reschedule instead</button>
          <button className="btn btn-secondary btn-sm" style={{ color: 'var(--red)' }} onClick={onConfirm}>Cancel session</button>
          <button className="btn btn-ghost btn-sm" onClick={onClose}>Keep it</button>
        </div>
      </div>
    </div>
  );
}

/* ============================================================
   PRO — Calendar (week grid + requests)
   ============================================================ */
const CAL_DAYS = ['Mon 2', 'Tue 3', 'Wed 4', 'Thu 5', 'Fri 6'];
const CAL_HOURS = ['9', '10', '11', '12', '1', '2', '3', '4', '5'];
const CAL_EVENTS = [
  { day: 0, start: 1, len: 1, name: 'Leah Karim', type: 'Video', recurring: true },
  { day: 0, start: 5, len: 1, name: 'Sam Rivera', type: 'Chat' },
  { day: 1, start: 2, len: 1, name: 'Jordan Mills', type: 'Video', recurring: true },
  { day: 2, start: 0, len: 1, name: 'Noah Bennett', type: 'Intro' },
  { day: 3, start: 7, len: 1, name: 'Priya Shah', type: 'Video', recurring: true },
  { day: 4, start: 4, len: 1, name: 'Group session', type: 'Video' },
];

window.TABLET_SCREENS.calendar = function ProCalendar() {
  const [reqs, setReqs] = bUS(REQUESTS.map(r => ({ ...r })));
  const act = (id, status) => setReqs(rs => rs.map(r => r.id === id ? { ...r, status } : r));
  const typeColor = { Video: 'var(--primary)', Chat: 'var(--topic-1)', Intro: 'var(--clay)' };

  return (
    <div className="tb-split" style={{ gridTemplateColumns: '1fr 320px' }}>
      {/* calendar */}
      <div className="tb-pane">
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '16px 24px', borderBottom: '0.5px solid var(--hairline)' }}>
          <h2 className="tt-h2" style={{ flex: 1 }}>June 2026</h2>
          <button className="tb-iconbtn"><Icon name="chevL" size={20} stroke={2.2} /></button>
          <button className="tb-iconbtn"><Icon name="chevR" size={20} stroke={2.2} /></button>
          <div style={{ width: 180 }}><Segmented options={['Day', 'Week', 'Month']} value="Week" onChange={() => {}} /></div>
        </div>
        <div className="tb-scroll">
          {/* day header */}
          <div style={{ display: 'grid', gridTemplateColumns: '48px repeat(5, 1fr)', position: 'sticky', top: 0, background: 'var(--bg)', zIndex: 5, borderBottom: '0.5px solid var(--hairline)' }}>
            <div />
            {CAL_DAYS.map((d, i) => (
              <div key={d} style={{ padding: '12px 0', textAlign: 'center', borderLeft: '0.5px solid var(--hairline)' }}>
                <div className="tt-cap muted-3" style={{ fontWeight: 700 }}>{d.split(' ')[0]}</div>
                <div className="tt-h3 tt-num" style={{ marginTop: 2, color: i === 3 ? 'var(--primary)' : 'var(--ink)' }}>{d.split(' ')[1]}</div>
              </div>
            ))}
          </div>
          {/* grid */}
          <div style={{ display: 'grid', gridTemplateColumns: '48px repeat(5, 1fr)', position: 'relative' }}>
            {/* hour labels + cells */}
            {CAL_HOURS.map((h, hi) => (
              <React.Fragment key={h}>
                <div style={{ height: 64, paddingRight: 8, textAlign: 'right', paddingTop: 4 }}><span className="tt-cap muted-3">{h}{hi >= 3 ? 'pm' : 'am'}</span></div>
                {CAL_DAYS.map((d, di) => (
                  <div key={d + h} style={{ height: 64, borderLeft: '0.5px solid var(--hairline)', borderBottom: '0.5px solid var(--hairline)', position: 'relative' }} />
                ))}
              </React.Fragment>
            ))}
            {/* events overlay */}
            {CAL_EVENTS.map((e, i) => (
              <div key={i} style={{ position: 'absolute', top: e.start * 64 + 3, height: e.len * 64 - 6,
                left: `calc(48px + ${e.day} * (100% - 48px) / 5 + 3px)`, width: `calc((100% - 48px) / 5 - 6px)`,
                background: `color-mix(in srgb, ${typeColor[e.type]} 15%, var(--surface))`, borderLeft: `3px solid ${typeColor[e.type]}`,
                borderRadius: 8, padding: '6px 8px', cursor: 'pointer', overflow: 'hidden' }}>
                <div className="tt-cap" style={{ fontWeight: 700, color: typeColor[e.type], whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{e.name}</div>
                <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginTop: 2 }}>
                  <Icon name={e.type === 'Chat' ? 'message' : 'video'} size={11} color="var(--ink-3)" stroke={2} />
                  {e.recurring && <Icon name="clock" size={11} color="var(--ink-3)" stroke={2} />}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* requests rail */}
      <div className="tb-pane" style={{ borderLeft: '0.5px solid var(--hairline)' }}>
        <div style={{ padding: '16px 18px', borderBottom: '0.5px solid var(--hairline)' }}>
          <h3 className="tt-h3">Booking requests</h3>
          <p className="tt-cap muted-3" style={{ marginTop: 2 }}>{reqs.filter(r => r.status === 'Pending').length} awaiting response</p>
        </div>
        <div className="tb-scroll" style={{ padding: 14 }}>
          {reqs.map(r => (
            <div key={r.id} className="tb-card-flat" style={{ padding: 16, marginBottom: 12 }}>
              <div style={{ display: 'flex', gap: 12, alignItems: 'center', marginBottom: 12 }}>
                <Avatar name={r.name} size={44} photo />
                <div style={{ flex: 1, minWidth: 0 }}><div className="tt-sub" style={{ fontWeight: 700 }}>{r.name}</div><div className="tt-cap muted-3">{r.reason}</div></div>
              </div>
              <div className="tb-card-inset" style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '9px 12px', marginBottom: 12 }}>
                <Icon name="calendar" size={15} color="var(--primary)" stroke={2} /><span className="tt-cap" style={{ fontWeight: 600 }}>{r.when}</span>
              </div>
              {r.status === 'Pending' ? (
                <div style={{ display: 'flex', gap: 8 }}>
                  <button className="btn btn-secondary btn-sm" style={{ flex: 1, color: 'var(--red)' }} onClick={() => act(r.id, 'Rejected')}>Decline</button>
                  <button className="btn btn-primary btn-sm" style={{ flex: 1.3 }} onClick={() => act(r.id, 'Accepted')}>Accept</button>
                </div>
              ) : (
                <div className={'badge ' + (r.status === 'Accepted' ? 'badge-accept' : 'badge-reject')} style={{ height: 28, width: '100%', justifyContent: 'center' }}>
                  {r.status === 'Accepted' ? '✓ Confirmed & added to calendar' : 'Declined'}
                </div>
              )}
            </div>
          ))}

          <div className="tb-card-inset" style={{ padding: 16, marginTop: 4 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 10 }}><Icon name="clock" size={18} color="var(--clay)" stroke={2} /><span className="tt-sub" style={{ fontWeight: 700 }}>Recurring sessions</span></div>
            <p className="tt-cap muted">3 weekly slots are auto-held for returning clients. Manage in availability settings.</p>
          </div>
        </div>
      </div>
    </div>
  );
};
