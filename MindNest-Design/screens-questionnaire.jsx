/* MindNest — onboarding questionnaire + welcome */
window.SCREENS = window.SCREENS || {};
const { useState: qUS, useContext: qUC } = React;

window.SCREENS.questionnaire = function Questionnaire() {
  const ctx = qUC(AppCtx);
  const [step, setStep] = qUS(0);
  const [dir, setDir] = qUS(1);
  const [data, setData] = qUS({ mood: 4, stress: 5, anxiety: null, sleep: 3, goals: [] });
  const upd = (k, v) => setData(s => ({ ...s, [k]: v }));
  const STEPS = 5;
  const go = (d) => {
    if (step + d < 0) return ctx.pop();
    if (step + d >= STEPS) return ctx.reset('welcome');
    setDir(d); setStep(step + d);
  };
  const canNext = step === 2 ? data.anxiety !== null : step === 4 ? data.goals.length > 0 : true;

  return (
    <div className="mn-screen">
      <div style={{ padding: `${SAFE_TOP}px 20px 0` }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <button className="nav-btn" onClick={() => go(-1)}><Icon name="back" size={22} stroke={2.2} /></button>
          <div className="progress" style={{ flex: 1 }}><span style={{ width: `${((step + 1) / STEPS) * 100}%` }} /></div>
          <span className="t-foot muted-3" style={{ minWidth: 30, textAlign: 'right' }}>{step + 1}/{STEPS}</span>
        </div>
      </div>

      <div className="mn-scroll" style={{ padding: '20px 24px 0' }}>
        <div key={step} style={{ animation: `${dir > 0 ? 'fadeUp' : 'fadeIn'} .45s var(--ease-out) both` }}>
          {step === 0 && <QMood data={data} upd={upd} />}
          {step === 1 && <QStress data={data} upd={upd} />}
          {step === 2 && <QAnxiety data={data} upd={upd} />}
          {step === 3 && <QSleep data={data} upd={upd} />}
          {step === 4 && <QGoals data={data} upd={upd} />}
        </div>
      </div>

      <div style={{ padding: '14px 24px calc(env(safe-area-inset-bottom,0) + 28px)', background: 'var(--bg)' }}>
        <button className="btn btn-primary" disabled={!canNext} onClick={() => go(1)}>
          {step === STEPS - 1 ? 'Finish' : 'Continue'}
        </button>
      </div>
    </div>
  );
};

function QHead({ title, sub }) {
  return (
    <div style={{ marginBottom: 28 }}>
      <h1 className="t-title1">{title}</h1>
      {sub && <p className="t-body muted" style={{ marginTop: 8 }}>{sub}</p>}
    </div>
  );
}

function QMood({ data, upd }) {
  return (
    <div>
      <QHead title="How are you feeling today?" sub="There’s no wrong answer — just notice what’s true right now." />
      <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 26 }}>
        <div style={{ animation: 'popIn .4s var(--ease-spring) both' }} key={data.mood}>
          <MoodFace level={data.mood} size={132} />
        </div>
      </div>
      <div className="t-title3" style={{ textAlign: 'center', color: MOOD_VARS[data.mood - 1], marginBottom: 24 }}>
        {MOOD_LABELS[data.mood - 1]}
      </div>
      <div style={{ display: 'flex', justifyContent: 'space-between', gap: 8 }}>
        {[1, 2, 3, 4, 5].map(l => (
          <button key={l} onClick={() => upd('mood', l)} style={{
            border: 0, background: 'none', cursor: 'pointer', padding: 0, borderRadius: '50%',
            transform: data.mood === l ? 'scale(1.12)' : 'scale(1)', opacity: data.mood === l ? 1 : 0.5,
            transition: 'all .25s var(--ease-spring)',
            boxShadow: data.mood === l ? '0 0 0 3px var(--surface), 0 0 0 5px var(--primary-ring)' : 'none',
          }}>
            <MoodFace level={l} size={52} />
          </button>
        ))}
      </div>
    </div>
  );
}

function QStress({ data, upd }) {
  const lbl = data.stress <= 2 ? 'Very calm' : data.stress <= 4 ? 'Manageable' : data.stress <= 6 ? 'Noticeable' : data.stress <= 8 ? 'High' : 'Overwhelming';
  return (
    <div>
      <QHead title="How much stress are you carrying?" sub="Slide to reflect your average over the past week." />
      <div className="card" style={{ padding: 28, textAlign: 'center', marginBottom: 24 }}>
        <div className="t-display" style={{ fontSize: 56, color: 'var(--primary)' }}>{data.stress}</div>
        <div className="t-headline muted" style={{ marginTop: 2 }}>{lbl}</div>
      </div>
      <Slider value={data.stress} onChange={v => upd('stress', v)} min={0} max={10} />
      <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: 6 }}>
        <span className="t-foot muted-3">Calm</span><span className="t-foot muted-3">Overwhelmed</span>
      </div>
    </div>
  );
}

function QAnxiety({ data, upd }) {
  const opts = [
    ['Rarely', 'Hardly ever on edge'],
    ['Sometimes', 'A few days a week'],
    ['Often', 'Most days I feel it'],
    ['Almost always', 'It’s with me daily'],
  ];
  return (
    <div>
      <QHead title="How often do you feel anxious?" sub="This helps us pace your recommendations gently." />
      <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
        {opts.map(([t, s], i) => {
          const on = data.anxiety === i;
          return (
            <button key={t} onClick={() => upd('anxiety', i)} className="pressable" style={{
              border: `1.5px solid ${on ? 'var(--primary)' : 'var(--hairline)'}`, textAlign: 'left',
              background: on ? 'var(--primary-tint)' : 'var(--surface)', borderRadius: 'var(--r-md)',
              padding: '16px 18px', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 14,
              boxShadow: on ? '0 0 0 4px var(--primary-ring)' : 'var(--sh-sm)', transition: 'all .2s var(--ease)',
              fontFamily: 'var(--font-ui)',
            }}>
              <div style={{ flex: 1 }}>
                <div className="t-headline" style={{ color: 'var(--ink)' }}>{t}</div>
                <div className="t-callout muted" style={{ marginTop: 2 }}>{s}</div>
              </div>
              <span style={{ width: 24, height: 24, borderRadius: '50%', flexShrink: 0,
                border: on ? 'none' : '2px solid var(--hairline-2)', background: on ? 'var(--primary)' : 'transparent',
                display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                {on && <Icon name="check" size={15} color="#fff" stroke={3} />}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
}

function QSleep({ data, upd }) {
  const labels = { 1: 'Very poor', 2: 'Restless', 3: 'Okay', 4: 'Restful', 5: 'Deep & refreshing' };
  return (
    <div>
      <QHead title="How’s your sleep lately?" sub="Sleep and mood are closely linked." />
      <div className="card" style={{ padding: 28, textAlign: 'center', marginBottom: 26 }}>
        <div style={{ width: 72, height: 72, borderRadius: 22, background: 'var(--primary-tint)', margin: '0 auto 16px',
          display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <Icon name="sleep" size={36} color="var(--primary)" stroke={1.8} />
        </div>
        <div className="t-title2" style={{ color: 'var(--primary)' }}>{labels[data.sleep]}</div>
        <div style={{ display: 'flex', gap: 6, justifyContent: 'center', marginTop: 16 }}>
          {[1, 2, 3, 4, 5].map(i => <div key={i} style={{ width: 10, height: 10, borderRadius: '50%',
            background: i <= data.sleep ? 'var(--primary)' : 'var(--fill-2)', transition: 'background .3s' }} />)}
        </div>
      </div>
      <Slider value={data.sleep} onChange={v => upd('sleep', v)} min={1} max={5} />
    </div>
  );
}

function QGoals({ data, upd }) {
  const goals = ['Reduce anxiety', 'Sleep better', 'Manage stress', 'Feel less alone', 'Build confidence', 'Process grief', 'Work–life balance', 'Improve focus'];
  const toggle = (g) => upd('goals', data.goals.includes(g) ? data.goals.filter(x => x !== g) : [...data.goals, g]);
  return (
    <div>
      <QHead title="What brings you here?" sub="Pick any that resonate — you can change these later." />
      <div style={{ display: 'flex', flexWrap: 'wrap', gap: 10 }}>
        {goals.map(g => {
          const on = data.goals.includes(g);
          return <button key={g} onClick={() => toggle(g)} className={'chip' + (on ? ' active' : ' outline')}
            style={{ height: 44, fontSize: 15, paddingLeft: 18, paddingRight: 18, transition: 'all .2s var(--ease-spring)',
              transform: on ? 'scale(1.03)' : 'scale(1)' }}>
            {on && <Icon name="check" size={15} stroke={3} />}{g}
          </button>;
        })}
      </div>
    </div>
  );
}

/* ================= WELCOME ================= */
window.SCREENS.welcome = function Welcome() {
  const ctx = qUC(AppCtx);
  return (
    <div className="mn-screen" style={{ background: 'radial-gradient(120% 70% at 50% 15%, var(--primary-tint) 0%, var(--bg) 50%)' }}>
      <div className="mn-scroll" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center',
        justifyContent: 'center', padding: `${SAFE_TOP}px 28px 0`, textAlign: 'center' }}>
        <div style={{ position: 'relative', marginBottom: 8 }}>
          <div style={{ position: 'absolute', inset: -20, borderRadius: '50%', background: 'var(--primary-ring)', animation: 'ripple 2.4s var(--ease-out) infinite' }} />
          <div className="anim-scale"><Logo size={96} /></div>
        </div>
        <h1 className="t-title1 anim-up" style={{ marginTop: 30 }}>You’re all set</h1>
        <p className="t-body muted anim-up" style={{ marginTop: 10, maxWidth: 300 }}>
          We’ve tailored MindNest around how you’re feeling. Take it one gentle step at a time.
        </p>
        <div className="card anim-up" style={{ marginTop: 28, padding: 18, width: '100%', textAlign: 'left' }}>
          <div className="t-cap muted-3" style={{ textTransform: 'uppercase', marginBottom: 12 }}>Your starting point</div>
          {[['Mood', 'Good', 'heart'], ['Focus areas', 'Anxiety · Sleep', 'sparkle'], ['Check-ins', 'Daily reminders on', 'bell']].map(([k, v, ic]) => (
            <div key={k} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '8px 0' }}>
              <div style={{ width: 34, height: 34, borderRadius: 10, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <Icon name={ic} size={18} color="var(--primary)" /></div>
              <span className="t-callout muted" style={{ flex: 1 }}>{k}</span>
              <span className="t-headline">{v}</span>
            </div>
          ))}
        </div>
      </div>
      <div style={{ padding: '14px 28px calc(env(safe-area-inset-bottom,0) + 28px)' }}>
        <button className="btn btn-primary" onClick={() => ctx.reset('userApp', { tab: 'home' })}>Enter MindNest</button>
      </div>
    </div>
  );
};
