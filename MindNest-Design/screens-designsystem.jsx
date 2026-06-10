/* MindNest — design system showcase */
window.SCREENS = window.SCREENS || {};

window.SCREENS.designSystem = function DesignSystem() {
  const ctx = React.useContext(AppCtx);
  const Swatch = ({ v, name }) => (
    <div style={{ flex: 1 }}>
      <div style={{ height: 52, borderRadius: 12, background: v, boxShadow: 'inset 0 0 0 1px var(--hairline)' }} />
      <div className="t-cap muted-3" style={{ marginTop: 6, textAlign: 'center' }}>{name}</div>
    </div>
  );
  const Block = ({ title, children }) => (
    <div style={{ marginBottom: 30 }} className="anim-up">
      <div className="t-cap muted-3" style={{ textTransform: 'uppercase', letterSpacing: '0.06em', fontWeight: 700, marginBottom: 14 }}>{title}</div>
      {children}
    </div>
  );
  return (
    <div className="mn-screen">
      <NavHeader title="Design system" onBack={ctx.pop}
        right={<button className="nav-btn" onClick={ctx.toggleTheme}><Icon name={ctx.theme === 'dark' ? 'sun' : 'moon'} size={19} stroke={1.9} /></button>} />
      <div className="mn-scroll" style={{ padding: '8px 22px 40px' }}>
        <div className="anim-up" style={{ marginBottom: 28 }}>
          <Logo size={48} breathe={false} />
          <h1 className="t-title1" style={{ marginTop: 16 }}>MindNest UI</h1>
          <p className="t-body muted" style={{ marginTop: 6 }}>The calm, trustworthy foundation behind every screen.</p>
        </div>

        <Block title="Brand · Moss">
          <div style={{ display: 'flex', gap: 8 }}>
            {[['var(--moss-200)', '200'], ['var(--moss-400)', '400'], ['var(--moss-500)', '500'], ['var(--primary)', 'Primary'], ['var(--moss-800)', '800']].map(([v, n]) => <Swatch key={n} v={v} name={n} />)}
          </div>
        </Block>

        <Block title="Surfaces & ink">
          <div style={{ display: 'flex', gap: 8, marginBottom: 8 }}>
            <Swatch v="var(--bg)" name="bg" /><Swatch v="var(--surface)" name="surface" /><Swatch v="var(--surface-3)" name="inset" /><Swatch v="var(--clay)" name="clay" />
          </div>
          <div style={{ display: 'flex', gap: 8 }}>
            <Swatch v="var(--ink)" name="ink" /><Swatch v="var(--ink-2)" name="ink-2" /><Swatch v="var(--ink-3)" name="ink-3" /><Swatch v="var(--ink-4)" name="ink-4" />
          </div>
        </Block>

        <Block title="Mood scale">
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            {[1, 2, 3, 4, 5].map(l => <div key={l} style={{ textAlign: 'center' }}>
              <MoodFace level={l} size={50} />
              <div className="t-cap muted-3" style={{ marginTop: 6 }}>{MOOD_LABELS[l - 1]}</div>
            </div>)}
          </div>
        </Block>

        <Block title="Typography">
          <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
            <div className="t-display">Newsreader Display</div>
            <div className="t-title1">Title · SF Pro 28</div>
            <div className="t-title3">Subtitle · 19 semibold</div>
            <div className="t-body">Body copy stays calm, readable and unhurried at 16px.</div>
            <div className="t-foot muted-3">Footnote · 13 · muted</div>
          </div>
        </Block>

        <Block title="Buttons">
          <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
            <button className="btn btn-primary">Primary action</button>
            <div style={{ display: 'flex', gap: 10 }}>
              <button className="btn btn-tonal">Tonal</button>
              <button className="btn btn-secondary">Secondary</button>
            </div>
            <button className="btn btn-outline">Outline</button>
          </div>
        </Block>

        <Block title="Inputs">
          <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
            <Field icon="mail" placeholder="you@email.com" value="" onChange={() => {}} />
            <Segmented options={['Light', 'Dark']} value={ctx.theme === 'dark' ? 'Dark' : 'Light'} onChange={v => ctx.setTheme(v === 'Dark' ? 'dark' : 'light')} />
          </div>
        </Block>

        <Block title="Chips & badges">
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8, marginBottom: 12 }}>
            <span className="chip active">Selected</span>
            <span className="chip outline">Anxiety</span>
            <span className="chip outline">Sleep</span>
          </div>
          <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
            <span className="badge badge-verify"><Icon name="shield" size={12} /> Verified</span>
            <span className="badge badge-pending">Pending</span>
            <span className="badge badge-accept">Accepted</span>
            <span className="badge badge-reject">Declined</span>
          </div>
        </Block>

        <Block title="Cards & avatars">
          <div className="card" style={{ padding: 16, display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12 }}>
            <Avatar name="Amara Okafor" size={46} photo />
            <div style={{ flex: 1 }}><div className="t-headline">Elevated card</div><div className="t-foot muted">radius 26 · soft shadow</div></div>
            <Stars value={4.9} size={13} />
          </div>
          <div style={{ display: 'flex', gap: 10 }}>
            {['AO', 'DM', 'PN', 'SA'].map((_, i) => <Avatar key={i} name={THERAPISTS[i].name} size={44} photo />)}
          </div>
        </Block>

        <Block title="Topic tags · Spaces">
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
            {['Anxiety', 'Sleep', 'Mindfulness', 'Relationships', 'Stress'].map(t => <TopicTag key={t} t={t} />)}
          </div>
        </Block>

        <Block title="Engagement · streak & insight">
          <div style={{ display: 'flex', gap: 10 }}>
            <div className="card-flat" style={{ flex: 1, padding: 14, display: 'flex', alignItems: 'center', gap: 10 }}>
              <div style={{ width: 36, height: 36, borderRadius: 11, background: 'color-mix(in srgb, var(--streak) 16%, transparent)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="flame" size={19} color="var(--streak)" stroke={1.9} /></div>
              <div><div className="t-headline" style={{ fontSize: 15 }}>12 days</div><div className="t-cap muted-3">Streak</div></div>
            </div>
            <div className="card-flat" style={{ flex: 1, padding: 14, display: 'flex', alignItems: 'center', gap: 10 }}>
              <div style={{ width: 36, height: 36, borderRadius: 11, background: 'color-mix(in srgb, var(--topic-4) 14%, transparent)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="lightbulb" size={19} color="var(--topic-4)" stroke={1.9} /></div>
              <div><div className="t-headline" style={{ fontSize: 15 }}>Insight</div><div className="t-cap muted-3">Gentle nudge</div></div>
            </div>
          </div>
        </Block>

        <Block title="Radius & elevation">
          <div style={{ display: 'flex', gap: 10 }}>
            {[['14', 'var(--r-sm)'], ['20', 'var(--r-md)'], ['26', 'var(--r-lg)']].map(([n, r]) => (
              <div key={n} style={{ flex: 1, textAlign: 'center' }}>
                <div style={{ height: 56, borderRadius: r, background: 'var(--surface)', boxShadow: 'var(--sh-md)' }} />
                <div className="t-cap muted-3" style={{ marginTop: 6 }}>{n}px</div>
              </div>
            ))}
          </div>
        </Block>
      </div>
    </div>
  );
};
