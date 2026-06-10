/* MindNest — profile, edit profile, settings */
window.SCREENS = window.SCREENS || {};
const { useState: sUS, useContext: sUC } = React;

/* ================= PROFILE ================= */
window.SCREENS.tabProfile = function TabProfile() {
  const ctx = sUC(AppCtx);
  const MENU = [
    ['trend', 'Mood insights', () => ctx.push('moodInsights')],
    ['compass', 'Insights hub', () => ctx.push('discover')],
    ['target', 'Habits', () => ctx.push('habits')],
    ['bookOpen', 'My journal', () => ctx.goTab('journal')],
    ['bookmark', 'Saved articles', () => ctx.goTab('feed')],
    ['edit', 'Edit profile', () => ctx.push('editProfile')],
    ['bell', 'Notifications', () => ctx.push('notifications')],
    ['sliders', 'Settings & AI', () => ctx.push('settings')],
  ];
  return (
    <div style={{ padding: `${SAFE_TOP}px 20px 24px` }}>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: 24 }}>
        <h1 className="t-title1" style={{ flex: 1 }}>Profile</h1>
        <button className="nav-btn" onClick={() => ctx.push('settings')}><Icon name="sliders" size={20} stroke={1.9} /></button>
      </div>

      <div className="card anim-up" style={{ padding: 22, textAlign: 'center', marginBottom: 18 }}>
        <div style={{ position: 'relative', width: 84, height: 84, margin: '0 auto 14px' }}>
          <Avatar name="Maya Levine" size={84} ring />
          <button style={{ position: 'absolute', bottom: -2, right: -2, width: 30, height: 30, borderRadius: '50%', border: '3px solid var(--surface)', background: 'var(--primary)', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}>
            <Icon name="camera" size={15} color="#fff" stroke={2} /></button>
        </div>
        <div className="t-title3">Maya Levine</div>
        <div className="t-callout muted" style={{ marginTop: 2 }}>maya.levine@email.com</div>
        <div style={{ display: 'flex', marginTop: 20 }}>
          {[['24', 'Check-ins'], ['18', 'Entries'], ['12', 'Day streak']].map(([v, k], i) => (
            <div key={k} style={{ flex: 1, borderLeft: i ? '1px solid var(--hairline)' : 'none' }}>
              <div className="t-title3" style={{ color: 'var(--primary)' }}>{v}</div>
              <div className="t-cap muted-3" style={{ marginTop: 2 }}>{k}</div>
            </div>
          ))}
        </div>
      </div>

      {/* activity overview */}
      <div className="anim-up" style={{ marginBottom: 18 }}>
        <SectionHead title="This week" action="Insights" onAction={() => ctx.push('moodInsights')} />
        <div className="card" style={{ padding: 18 }}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 14, marginBottom: 16 }}>
            {[['heart', '6', 'Check-ins', 'var(--clay)'], ['feather', '4', 'Journal entries', 'var(--topic-4)'], ['smile', '3', 'Assessments', 'var(--primary)'], ['sparkle', '9', 'Insights', 'var(--topic-1)']].map(([ic, v, k, col]) => (
              <div key={k} style={{ display: 'flex', alignItems: 'center', gap: 11 }}>
                <div style={{ width: 38, height: 38, borderRadius: 11, background: `color-mix(in srgb, ${col} 14%, transparent)`, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                  <Icon name={ic} size={18} color={col} stroke={1.9} /></div>
                <div><div className="t-headline" style={{ fontSize: 17 }}>{v}</div><div className="t-cap muted-3">{k}</div></div>
              </div>
            ))}
          </div>
          <div className="hr" style={{ marginBottom: 14 }} />
          <MoodStrip data={MOOD_HISTORY} />
        </div>
      </div>

      <div className="card anim-up" style={{ padding: 6, marginBottom: 18 }}>
        {MENU.map(([ic, label, fn]) => (
          <div key={label} className="row" onClick={fn} style={{ borderRadius: 18 }}>
            <div style={{ width: 38, height: 38, borderRadius: 11, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Icon name={ic} size={19} color="var(--primary)" stroke={1.9} /></div>
            <span className="t-body" style={{ flex: 1, fontWeight: 500 }}>{label}</span>
            <Icon name="chevR" size={18} color="var(--ink-4)" />
          </div>
        ))}
      </div>

      <button className="btn btn-secondary anim-up" onClick={() => ctx.reset('splash')} style={{ color: 'var(--red)' }}>
        <Icon name="logout" size={20} stroke={2} /> Log out
      </button>
      <p className="t-cap muted-3 anim-up" style={{ textAlign: 'center', marginTop: 18 }}>MindNest V2 · 2.0.0</p>
    </div>
  );
};

/* ================= EDIT PROFILE ================= */
window.SCREENS.editProfile = function EditProfile() {
  const ctx = sUC(AppCtx);
  const [f, setF] = sUS({ name: 'Maya Levine', email: 'maya.levine@email.com', phone: '+44 7700 900892', bio: 'Learning to slow down and be kinder to myself.' });
  const upd = k => v => setF(s => ({ ...s, [k]: v }));
  return (
    <div className="mn-screen">
      <NavHeader title="Edit profile" onBack={ctx.pop}
        right={<button onClick={ctx.pop} style={{ ...linkBtn, marginRight: 6 }}>Save</button>} />
      <div className="mn-scroll" style={{ padding: '8px 24px 30px' }}>
        <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 26 }}>
          <div style={{ position: 'relative' }}>
            <Avatar name={f.name} size={96} />
            <button style={{ position: 'absolute', bottom: 0, right: 0, width: 32, height: 32, borderRadius: '50%', border: '3px solid var(--bg)', background: 'var(--primary)', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}>
              <Icon name="camera" size={16} color="#fff" stroke={2} /></button>
          </div>
        </div>
        {[['Full name', 'name', 'user', 'text'], ['Email', 'email', 'mail', 'email'], ['Phone', 'phone', 'phone', 'tel']].map(([lbl, k, ic, ty]) => (
          <div key={k} style={{ marginBottom: 18 }}>
            <label className="t-foot" style={{ fontWeight: 700, color: 'var(--ink-2)', display: 'block', marginBottom: 8, paddingLeft: 2 }}>{lbl}</label>
            <Field icon={ic} type={ty} value={f[k]} onChange={upd(k)} />
          </div>
        ))}
        <div style={{ marginBottom: 18 }}>
          <label className="t-foot" style={{ fontWeight: 700, color: 'var(--ink-2)', display: 'block', marginBottom: 8, paddingLeft: 2 }}>About you</label>
          <textarea value={f.bio} onChange={e => upd('bio')(e.target.value)} rows={3} className="field" style={{ resize: 'none', minHeight: 90, lineHeight: 1.5, fontFamily: 'var(--font-ui)' }} />
        </div>
      </div>
    </div>
  );
};

/* ================= SETTINGS ================= */
window.SCREENS.settings = function Settings() {
  const ctx = sUC(AppCtx);
  const [push, setPush] = sUS(true);
  const [reminders, setReminders] = sUS(true);
  const [emails, setEmails] = sUS(false);
  const [biometric, setBiometric] = sUS(true);
  const [ai, setAi] = sUS({ analysis: true, coach: true, patterns: true, reports: true });
  const [notif, setNotif] = sUS({ mood: true, journal: true, report: true, insight: true, rec: false });
  const setAiK = k => v => setAi(s => ({ ...s, [k]: v }));
  const setNotifK = k => v => setNotif(s => ({ ...s, [k]: v }));
  return (
    <div className="mn-screen">
      <NavHeader title="Settings &amp; AI" onBack={ctx.pop} />
      <div className="mn-scroll" style={{ padding: '8px 20px 30px' }}>
        <Group label="Appearance">
          <div style={{ padding: '14px 16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 14 }}>
              <SettingIcon name={ctx.theme === 'dark' ? 'moon' : 'sun'} />
              <span className="t-body" style={{ flex: 1, fontWeight: 500 }}>Theme</span>
            </div>
            <Segmented options={['Light', 'Dark']} value={ctx.theme === 'dark' ? 'Dark' : 'Light'} onChange={v => ctx.setTheme(v === 'Dark' ? 'dark' : 'light')} />
          </div>
        </Group>

        <Group label="AI features">
          <SettingRow icon="sparkle" label="Journal AI analysis" trailing={<Toggle on={ai.analysis} onChange={setAiK('analysis')} />} />
          <SettingRow icon="message" label="AI Coach" trailing={<Toggle on={ai.coach} onChange={setAiK('coach')} />} />
          <SettingRow icon="pulse" label="Pattern detection" trailing={<Toggle on={ai.patterns} onChange={setAiK('patterns')} />} />
          <SettingRow icon="doc" label="Weekly wellness reports" trailing={<Toggle on={ai.reports} onChange={setAiK('reports')} />} last />
        </Group>

        <Group label="Notifications">
          <SettingRow icon="bell" label="Push notifications" trailing={<Toggle on={push} onChange={setPush} />} />
          <SettingRow icon="heart" label="Mood reminder" trailing={<Toggle on={notif.mood} onChange={setNotifK('mood')} />} />
          <SettingRow icon="pen" label="Journal reminder" trailing={<Toggle on={notif.journal} onChange={setNotifK('journal')} />} />
          <SettingRow icon="doc" label="Weekly report ready" trailing={<Toggle on={notif.report} onChange={setNotifK('report')} />} />
          <SettingRow icon="sparkle" label="Insight available" trailing={<Toggle on={notif.insight} onChange={setNotifK('insight')} />} />
          <SettingRow icon="feather" label="Recommendation available" trailing={<Toggle on={notif.rec} onChange={setNotifK('rec')} />} last />
        </Group>

        <Group label="Reminder settings">
          <SettingRow icon="clock" label="Mood reminder time" trailing={<span className="t-callout muted">9:00 AM</span>} />
          <SettingRow icon="clock" label="Journal reminder time" trailing={<span className="t-callout muted">9:00 PM</span>} last />
        </Group>

        <Group label="Privacy &amp; data">
          <SettingRow icon="lock" label="Face ID lock" trailing={<Toggle on={biometric} onChange={setBiometric} />} />
          <SettingRow icon="shield" label="Privacy policy" trailing={<Chev />} />
          <SettingRow icon="upload" label="Export my data" trailing={<Chev />} />
          <SettingRow icon="doc" label="Delete account &amp; data" trailing={<Chev />} last />
        </Group>

        <div className="card" style={{ padding: 18, margin: '4px 0 18px', display: 'flex', gap: 12, alignItems: 'center', background: 'var(--clay-tint)' }}>
          <div style={{ width: 40, height: 40, borderRadius: 12, background: 'var(--clay)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
            <Icon name="phone" size={20} color="#fff" stroke={2} /></div>
          <div style={{ flex: 1 }}>
            <div className="t-foot" style={{ fontWeight: 700, color: 'var(--ink)' }}>In crisis? You’re not alone</div>
            <div className="t-cap muted" style={{ marginTop: 2 }}>Reach 24/7 confidential support now.</div>
          </div>
          <button className="btn btn-sm" style={{ background: 'var(--clay)', color: '#fff' }}>Call</button>
        </div>

        <button className="btn btn-secondary" onClick={() => ctx.reset('splash')} style={{ color: 'var(--red)' }}>
          <Icon name="logout" size={20} stroke={2} /> Log out
        </button>
      </div>
    </div>
  );
};

function Group({ label, children }) {
  return (
    <div style={{ marginBottom: 22 }}>
      <div className="t-cap muted-3" style={{ textTransform: 'uppercase', padding: '0 6px 8px', fontWeight: 700, letterSpacing: '0.04em' }}>{label}</div>
      <div className="card" style={{ overflow: 'hidden' }}>{children}</div>
    </div>
  );
}
function SettingIcon({ name }) {
  return <div style={{ width: 32, height: 32, borderRadius: 9, background: 'var(--primary-tint)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
    <Icon name={name} size={17} color="var(--primary)" stroke={1.9} /></div>;
}
function SettingRow({ icon, label, trailing, last }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '13px 16px', borderBottom: last ? 'none' : '0.5px solid var(--hairline)' }}>
      <SettingIcon name={icon} />
      <span className="t-body" style={{ flex: 1, fontWeight: 500 }}>{label}</span>
      {trailing}
    </div>
  );
}
function Chev() { return <Icon name="chevR" size={18} color="var(--ink-4)" />; }
Object.assign(window, { SettingIcon, Group, SettingRow });
