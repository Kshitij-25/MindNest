/* MindNest — Discover & Learn (repurposed content feed, no social) */
window.SCREENS = window.SCREENS || {};
const { useState: fUS, useContext: fUC } = React;

const CAT_COLOR = {
  'Wellness Article': 'var(--topic-1)', 'AI Insight': 'var(--topic-4)', 'Mood Education': 'var(--topic-5)',
  'Habit Tip': 'var(--streak)', 'Reflection Prompt': 'var(--primary)',
};
function catColor(c) { return CAT_COLOR[c] || 'var(--moss-500)'; }

/* ================= DISCOVER & LEARN ================= */
window.SCREENS.tabFeed = function DiscoverLearn({ params }) {
  const ctx = fUC(AppCtx);
  const [cat, setCat] = fUS('For you');
  const CATS = ['For you', 'Wellness Article', 'AI Insight', 'Mood Education', 'Habit Tip'];
  const empty = params.empty;
  const list = ARTICLES.filter(a => cat === 'For you' || a.cat === cat);

  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 8px` }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 12 }}>
          <h1 className="t-title1" style={{ flex: 1 }}>Discover &amp; Learn</h1>
          <button className="nav-btn" onClick={() => ctx.push('notifications')} style={{ position: 'relative' }}>
            <Icon name="bell" size={20} stroke={1.9} />
            <span style={{ position: 'absolute', top: 9, right: 10, width: 8, height: 8, borderRadius: '50%', background: 'var(--clay)', border: '2px solid var(--bg)' }} /></button>
        </div>
        <div style={{ display: 'flex', gap: 8, overflowX: 'auto', margin: '0 -20px', padding: '0 20px 4px', scrollbarWidth: 'none' }}>
          {CATS.map(c => <button key={c} onClick={() => setCat(c)} className={'chip' + (cat === c ? ' active' : ' outline')}>{c}</button>)}
        </div>
      </div>

      {empty || list.length === 0 ? (
        <EmptyState icon="layers" title={empty ? 'Nothing here yet' : 'No items in this topic'}
          body={empty ? 'Wellness articles, prompts and AI insights will appear here as we learn more about you.' : 'Try another topic to explore more.'}
          action={empty ? null : 'Back to For you'} onAction={() => setCat('For you')} />
      ) : (
        <div className="stagger" style={{ padding: '10px 20px 24px', display: 'flex', flexDirection: 'column', gap: 14 }}>
          {/* featured prompt */}
          {cat === 'For you' && (() => { const p = ARTICLES.find(a => a.prompt); return (
            <button className="card pressable anim-up" onClick={() => ctx.push('postDetail', { id: p.id })} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 18, background: 'linear-gradient(125deg, var(--primary-tint), var(--surface) 78%)' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 10 }}>
                <IconTile icon="feather" color="var(--primary)" size={40} />
                <div className="t-cap" style={{ color: 'var(--primary)', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.04em' }}>Today’s reflection prompt</div>
              </div>
              <div className="t-serif" style={{ fontSize: 21, lineHeight: 1.25 }}>{p.title}</div>
            </button>
          ); })()}

          {list.filter(a => !(cat === 'For you' && a.prompt)).map(a => (
            <button key={a.id} className="card pressable anim-up" onClick={() => ctx.push('postDetail', { id: a.id })} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 12 }}>
                <span className="t-cap" style={{ color: catColor(a.cat), fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{a.cat}</span>
                <span style={{ width: 3, height: 3, borderRadius: '50%', background: 'var(--ink-4)' }} />
                <span className="t-cap muted-3">{a.read} min</span>
              </div>
              {a.image && <div style={{ position: 'relative', height: 150, borderRadius: 16, overflow: 'hidden', marginBottom: 13 }}><PhotoPlaceholder name={a.topic + a.id} label="article image" /></div>}
              <h3 className="t-title3" style={{ marginBottom: 6, lineHeight: 1.25 }}>{a.title}</h3>
              <p className="t-callout muted" style={{ lineHeight: 1.5, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{a.body}</p>
              <div className="t-cap muted-3" style={{ marginTop: 10, display: 'flex', alignItems: 'center', gap: 6 }}>
                <Icon name="sparkle" size={13} color="var(--ink-4)" stroke={2} />{a.source}
              </div>
            </button>
          ))}
        </div>
      )}
    </div>
  );
};

/* ================= ARTICLE DETAIL ================= */
window.SCREENS.postDetail = function ArticleDetail({ params }) {
  const ctx = fUC(AppCtx);
  const a = article(params.id);
  const [saved, setSaved] = fUS(false);
  return (
    <div className="mn-screen">
      <NavHeader onBack={ctx.pop} transparent
        right={<button className="nav-btn" onClick={() => setSaved(s => !s)}><Icon name="bookmark" size={18} color={saved ? 'var(--primary)' : 'currentColor'} fill={saved ? 'var(--primary)' : 'none'} stroke={1.9} /></button>} />
      <div className="mn-scroll" style={{ padding: '4px 22px 30px' }}>
        <div className="anim-up" style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 14 }}>
          <span className="t-cap" style={{ color: catColor(a.cat), fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.03em' }}>{a.cat}</span>
          <span style={{ width: 3, height: 3, borderRadius: '50%', background: 'var(--ink-4)' }} />
          <span className="t-cap muted-3">{a.read} min read</span>
        </div>
        <h1 className="t-title1 anim-up" style={{ marginBottom: 12, lineHeight: 1.18 }}>{a.title}</h1>
        {a.image && <div className="anim-up" style={{ position: 'relative', height: 200, borderRadius: 20, overflow: 'hidden', marginBottom: 20 }}><PhotoPlaceholder name={a.topic + a.id} label="article image" /></div>}
        <p className="t-body anim-up" style={{ fontSize: 17, lineHeight: 1.7, color: 'var(--ink-2)', whiteSpace: 'pre-wrap' }}>{a.body}</p>

        {a.prompt && (
          <button className="card-flat pressable anim-up" onClick={() => ctx.goTab('journal')} style={{ width: '100%', textAlign: 'left', border: 0, cursor: 'pointer', fontFamily: 'var(--font-ui)', padding: 16, marginTop: 22, display: 'flex', alignItems: 'center', gap: 12 }}>
            <IconTile icon="pen" color="var(--primary)" size={44} />
            <div style={{ flex: 1 }}><div className="t-headline">Write about this</div><div className="t-foot muted" style={{ marginTop: 2 }}>Open your journal with this prompt</div></div>
            <Icon name="chevR" size={20} color="var(--ink-4)" />
          </button>
        )}

        <div className="card-flat anim-up" style={{ padding: 16, marginTop: 22, display: 'flex', alignItems: 'center', gap: 12 }}>
          <IconTile icon="sparkle" color="var(--primary)" size={42} />
          <div style={{ flex: 1 }}>
            <div className="t-foot" style={{ fontWeight: 700 }}>{a.source}</div>
            <div className="t-cap muted-3">Curated for your wellbeing</div>
          </div>
        </div>
      </div>
    </div>
  );
};
