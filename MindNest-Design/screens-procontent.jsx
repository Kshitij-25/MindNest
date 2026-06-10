/* MindNest — V2 professional content creation */
window.SCREENS = window.SCREENS || {};
const { useState: cpUS, useContext: cpUC } = React;

/* ================= PRO CONTENT LIST ================= */
window.SCREENS.proContent = function ProContent() {
  const ctx = cpUC(AppCtx);
  const [tab, setTab] = cpUS('Published');
  const list = PRO_POSTS.filter(p => p.status === (tab === 'Published' ? 'Published' : 'Draft'));
  return (
    <div>
      <div style={{ position: 'sticky', top: 0, zIndex: 10, background: 'var(--bg)', padding: `${SAFE_TOP}px 20px 10px` }}>
        <div style={{ display: 'flex', alignItems: 'center', marginBottom: 14 }}>
          <h1 className="t-title1" style={{ flex: 1 }}>Content</h1>
          <button className="nav-btn" onClick={() => ctx.push('createPost')} style={{ background: 'var(--primary)' }}>
            <Icon name="plus" size={22} color="var(--on-primary)" stroke={2.2} /></button>
        </div>
        <Segmented options={['Published', 'Drafts']} value={tab} onChange={setTab} />
      </div>

      <div style={{ padding: '14px 20px 8px' }}>
        <div className="card anim-up" style={{ display: 'flex', padding: '16px 0', marginBottom: 18 }}>
          {[['3', 'Posts'], ['4.1k', 'Views'], ['339', 'Likes']].map(([v, k], i) => (
            <div key={k} style={{ flex: 1, textAlign: 'center', borderLeft: i ? '1px solid var(--hairline)' : 'none' }}>
              <div className="t-title2" style={{ color: 'var(--primary)' }}>{v}</div>
              <div className="t-cap muted-3" style={{ marginTop: 2 }}>{k}</div>
            </div>
          ))}
        </div>
      </div>

      {list.length === 0 ? (
        <EmptyState icon="feather" title="No drafts"
          body="Start writing a reflection — save it as a draft and publish when it feels ready."
          action="Write a post" onAction={() => ctx.push('createPost')} />
      ) : (
        <div className="stagger" style={{ padding: '0 20px 24px', display: 'flex', flexDirection: 'column', gap: 14 }}>
          {list.map(p => (
            <div key={p.id} className="card pressable" style={{ padding: 14, display: 'flex', gap: 13 }} onClick={() => ctx.push('createPost', { id: p.id })}>
              <div style={{ position: 'relative', width: 64, height: 64, borderRadius: 14, overflow: 'hidden', flexShrink: 0, background: 'var(--fill)' }}>
                {p.image ? <PhotoPlaceholder name={p.topic + p.id} /> : <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}><Icon name="feather" size={24} color="var(--ink-4)" stroke={1.7} /></div>}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                  <TopicTag t={p.topic} sm />
                  {p.status === 'Draft' && <span className="badge badge-pending">Draft</span>}
                </div>
                <div className="t-headline" style={{ fontSize: 15, lineHeight: 1.3, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{p.title}</div>
                {p.status === 'Published' ? (
                  <div style={{ display: 'flex', gap: 14, marginTop: 8 }}>
                    <Metric icon="eye" v={p.views} /><Metric icon="heart" v={p.likes} /><Metric icon="chat2" v={p.comments} />
                  </div>
                ) : <div className="t-cap muted-3" style={{ marginTop: 8 }}>Last edited 2 days ago</div>}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

function Metric({ icon, v }) {
  return <span style={{ display: 'inline-flex', alignItems: 'center', gap: 5 }}>
    <Icon name={icon} size={14} color="var(--ink-3)" stroke={1.9} /><span className="t-cap muted-3" style={{ fontWeight: 600 }}>{v}</span></span>;
}

/* ================= CREATE POST ================= */
window.SCREENS.createPost = function CreatePost({ params }) {
  const ctx = cpUC(AppCtx);
  const existing = params.id ? PRO_POSTS.find(p => p.id === params.id) : null;
  const [title, setTitle] = cpUS(existing?.title || '');
  const [body, setBody] = cpUS(existing && existing.status === 'Draft' ? 'Untangling the “I’m behind” feeling — a few reframes that help when the to-do list feels like proof you’re failing.' : '');
  const [topic, setTopic] = cpUS(existing?.topic || null);
  const [hasImage, setHasImage] = cpUS(existing?.image || false);
  const [published, setPublished] = cpUS(false);
  const TOPICS = ['Anxiety', 'Sleep', 'Mindfulness', 'Stress', 'Relationships', 'Growth'];
  const canPublish = title.trim() && body.trim() && topic;

  if (published) return (
    <div className="mn-screen" style={{ alignItems: 'center', justifyContent: 'center', padding: 28 }}>
      <SuccessCheck />
      <h1 className="t-title2 anim-up" style={{ marginTop: 24 }}>Published</h1>
      <p className="t-body muted anim-up" style={{ marginTop: 8, textAlign: 'center', maxWidth: 290 }}>Your reflection is now live in Spaces for the people who need it.</p>
      <div className="anim-up" style={{ display: 'flex', flexDirection: 'column', gap: 10, marginTop: 30, width: '100%' }}>
        <button className="btn btn-primary" onClick={() => ctx.reset('proApp', { tab: 'content' })}>Back to content</button>
      </div>
    </div>
  );

  return (
    <div className="mn-screen">
      <div className="nav" style={{ paddingTop: SAFE_TOP - 6 }}>
        <button className="nav-btn" onClick={ctx.pop}><Icon name="x" size={22} stroke={2.2} /></button>
        <div className="nav-title" style={{ flex: 1 }}>{existing ? 'Edit post' : 'New post'}</div>
        <button className="btn btn-secondary btn-sm" onClick={() => ctx.pop()}>Save draft</button>
      </div>

      <div className="mn-scroll" style={{ padding: '8px 22px 24px' }}>
        {/* image upload */}
        <button onClick={() => setHasImage(h => !h)} className="pressable" style={{
          width: '100%', height: hasImage ? 180 : 120, borderRadius: 18, marginBottom: 20, cursor: 'pointer',
          border: hasImage ? 'none' : '1.5px dashed var(--hairline-2)', background: 'var(--surface-3)',
          position: 'relative', overflow: 'hidden', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 8,
        }}>
          {hasImage ? (
            <>
              <PhotoPlaceholder name={(topic || 'post') + 'cover'} label="cover image" />
              <div style={{ position: 'absolute', top: 10, right: 10, background: 'rgba(0,0,0,0.5)', borderRadius: 999, padding: 7, display: 'flex' }}><Icon name="x" size={16} color="#fff" stroke={2.4} /></div>
            </>
          ) : (
            <>
              <div style={{ width: 46, height: 46, borderRadius: 14, background: 'var(--fill)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="image" size={24} color="var(--ink-3)" stroke={1.8} /></div>
              <span className="t-foot" style={{ fontWeight: 600, color: 'var(--ink-2)' }}>Add a cover image</span>
            </>
          )}
        </button>

        <input value={title} onChange={e => setTitle(e.target.value)} placeholder="Post title"
          className="t-serif" style={{ width: '100%', border: 0, outline: 'none', background: 'transparent', fontSize: 26, fontWeight: 500, color: 'var(--ink)', marginBottom: 12 }} />
        <textarea value={body} onChange={e => setBody(e.target.value)} placeholder="Share something supportive…" rows={7}
          style={{ width: '100%', border: 0, outline: 'none', background: 'transparent', resize: 'none', fontFamily: 'var(--font-ui)', fontSize: 17, lineHeight: 1.6, color: 'var(--ink-2)', minHeight: 150, marginBottom: 8 }} />

        <div className="hr" style={{ margin: '8px 0 18px' }} />
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 12 }}>
          <Icon name="tag" size={17} color="var(--ink-3)" stroke={1.9} />
          <span className="t-headline" style={{ fontSize: 15 }}>Topic</span>
          <span className="t-foot muted-3">· choose one</span>
        </div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
          {TOPICS.map(t => <span key={t} onClick={() => setTopic(t)}><TopicTag t={t} active={topic === t} onClick={() => setTopic(t)} /></span>)}
        </div>
      </div>

      <div style={{ padding: '12px 22px calc(env(safe-area-inset-bottom,0) + 22px)', background: 'var(--bg)', borderTop: '0.5px solid var(--hairline)', display: 'flex', gap: 12, alignItems: 'center' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 7, color: 'var(--ink-3)' }}>
          <Icon name="globe" size={16} stroke={1.9} /><span className="t-foot">Public</span>
        </div>
        <button className="btn btn-primary" style={{ flex: 1 }} disabled={!canPublish} onClick={() => setPublished(true)}>Publish</button>
      </div>
    </div>
  );
};
