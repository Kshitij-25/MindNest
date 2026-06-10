/* MindNest — V2 mock data (journal, feed, notifications) */

const TOPIC_COLORS = {
  Anxiety: 'var(--topic-1)', Stress: 'var(--topic-2)', Sleep: 'var(--topic-3)',
  Mindfulness: 'var(--topic-4)', Growth: 'var(--topic-4)', Relationships: 'var(--topic-5)',
  Gratitude: 'var(--topic-4)', Calm: 'var(--topic-1)', Therapy: 'var(--topic-5)', 'Self-care': 'var(--topic-2)',
};
function topicColor(t) { return TOPIC_COLORS[t] || 'var(--moss-500)'; }

const JOURNALS = [
  { id: 'j1', day: 'Today', date: '31 May', time: '8:24 AM', mood: 4, title: 'A slower morning',
    body: 'Woke up before the alarm and let myself lie still for a few minutes. The light through the curtains felt soft. I noticed I wasn’t reaching for my phone straight away — small win.',
    tags: ['Calm', 'Gratitude'], draft: false },
  { id: 'j2', day: 'Yesterday', date: '30 May', time: '9:10 PM', mood: 5, title: 'Session reflections',
    body: 'Talked through the work stuff with Dr. Okafor. She reframed the “I’m behind” feeling as “I’m carrying a lot” and it landed. Trying to hold that gentler version of the story.',
    tags: ['Therapy', 'Growth'], draft: false },
  { id: 'j3', day: 'Thu', date: '29 May', time: '7:02 AM', mood: 3, title: '', body: 'Couldn’t sleep again. Mind kept looping on the',
    tags: ['Sleep'], draft: true },
  { id: 'j4', day: 'Wed', date: '28 May', time: '6:40 PM', mood: 2, title: 'Heavy day',
    body: 'Deadlines piled up and I snapped at no one in particular. Naming it here so it doesn’t sit in my chest overnight.',
    tags: ['Stress'], draft: false },
  { id: 'j5', day: 'Mon', date: '26 May', time: '8:00 AM', mood: 4, title: 'Morning walk',
    body: 'Twenty minutes by the canal before work. The cold air helped. Keep choosing this.',
    tags: ['Self-care', 'Calm'], draft: false },
];

const POSTS = [
  { id: 'p1', tid: 't1', topic: 'Anxiety', time: '2h', image: true, read: 4, likes: 128, comments: 18, saved: false, liked: false,
    title: 'The 3-3-3 rule for an anxious mind',
    body: 'When anxiety spikes, try this gentle grounding tool. Name three things you can see, three sounds you can hear, and move three parts of your body. It won’t erase the feeling — but it gently reminds your nervous system that you’re here, and you’re safe.\n\nThe goal isn’t to force calm. It’s to give your attention somewhere kinder to land.' },
  { id: 'p2', tid: 't3', topic: 'Sleep', time: '5h', image: false, read: 3, likes: 94, comments: 12, saved: true, liked: true,
    title: 'Why “trying harder” to sleep backfires',
    body: 'Sleep is a letting-go, not a doing. The more we chase it, the more alert we become. Tonight, instead of trying to sleep, try simply resting — no goal, no clock-watching. Rest is restorative on its own.' },
  { id: 'p3', tid: 't2', topic: 'Mindfulness', time: '1d', image: true, read: 5, likes: 211, comments: 31, saved: false, liked: false,
    title: 'A 60-second reset for busy days',
    body: 'You don’t need an hour to come back to yourself. One slow breath, a hand on your chest, and a single kind sentence: “This is hard, and I’m doing my best.” Repeat as needed.' },
  { id: 'p4', tid: 't4', topic: 'Relationships', time: '2d', image: false, read: 4, likes: 76, comments: 9, saved: false, liked: false,
    title: 'Boundaries are a form of care',
    body: 'Saying no isn’t shutting someone out — it’s being honest about what you can hold. A clear boundary, kindly stated, protects the relationship as much as it protects you.' },
];

const POST_COMMENTS = {
  p1: [
    { id: 'pc1', name: 'Leah K.', time: '1h', text: 'Needed this today. The “somewhere kinder to land” line really got me.', likes: 12 },
    { id: 'pc2', name: 'Sam R.', time: '40m', text: 'Tried it on the train this morning and it genuinely helped.', likes: 5 },
    { id: 'pc3', name: 'Maya L.', time: '12m', text: 'Saving this for my next anxious moment 💚', likes: 2 },
  ],
};

const NOTIFICATIONS = [
  { id: 'n1', type: 'mood', title: 'Time for your daily check-in', body: 'How are you feeling this morning? A quick note keeps your streak alive.', time: '5m', unread: true },
  { id: 'n2', type: 'insight', title: 'New insight available', body: 'We noticed work appears in 43% of your stressful entries — tap to explore.', time: '1h', unread: true },
  { id: 'n3', type: 'rec', title: 'A recommendation for you', body: 'Box breathing might help with the mid-week anxiety we’re seeing.', time: '3h', unread: false },
  { id: 'n4', type: 'report', title: 'Your weekly wellness report is ready', body: 'Mood up 8%, burnout down 12%. See what shaped your week.', time: '5h', unread: false },
  { id: 'n5', type: 'journal', title: 'Journal reminder', body: 'You haven’t written since yesterday — a few lines can help you unwind.', time: '1d', unread: false },
];

// 7-day mood (level) + journal/checkin counts for insights
const WEEK_MOOD = [3, 4, 2, 4, 5, 4, 4];
const PRO_POSTS = [
  { id: 'pp1', topic: 'Anxiety', time: '2h', status: 'Published', image: true, likes: 128, comments: 18, views: 1240, title: 'The 3-3-3 rule for an anxious mind' },
  { id: 'pp2', topic: 'Mindfulness', time: '3d', status: 'Published', image: true, likes: 211, comments: 31, views: 2890, title: 'A 60-second reset for busy days' },
  { id: 'pp3', topic: 'Stress', time: '—', status: 'Draft', image: false, likes: 0, comments: 0, views: 0, title: 'Untangling the “I’m behind” feeling' },
];

function journal(id) { return JOURNALS.find(j => j.id === id); }
function post(id) { return POSTS.find(p => p.id === id); }

/* ---- MVP-1 additions ---- */

/* Journal types (Free / Guided / Gratitude / Reflection) */
const JOURNAL_TYPES = [
  { id: 'free', name: 'Free Journal', sub: 'Write whatever is present', icon: 'feather', color: 'var(--primary)' },
  { id: 'guided', name: 'Guided Journal', sub: 'Prompts to gently lead you', icon: 'compass', color: 'var(--topic-4)' },
  { id: 'gratitude', name: 'Gratitude Journal', sub: 'Notice what went well', icon: 'heart', color: 'var(--clay)' },
  { id: 'reflection', name: 'Reflection Journal', sub: 'Look back and make sense', icon: 'bookOpen', color: 'var(--topic-5)' },
];

/* AI journal analysis, keyed by journal id */
const JOURNAL_ANALYSIS = {
  j1: { status: 'ready', wordCount: 48, type: 'Free Journal',
    summary: 'A calm, self-aware morning entry. You noticed a small behaviour change — not reaching for your phone — and framed it as a win, a sign of growing self-compassion.',
    emotions: [ { k: 'Calm', v: 72, c: 'var(--topic-1)' }, { k: 'Contentment', v: 58, c: 'var(--mood-4)' }, { k: 'Hope', v: 41, c: 'var(--topic-4)' } ],
    topics: ['Morning routine', 'Phone habits', 'Rest'], themes: ['Slowing down', 'Self-compassion'],
    stressors: [], wins: ['Resisted phone first thing', 'Allowed yourself to rest'],
    concerns: [], suggestions: ['Protect this slow morning window', 'Notice the body cue that signals calm'] },
  j2: { status: 'ready', wordCount: 52, type: 'Reflection Journal',
    summary: 'A reflective entry processing a therapy session. You reframed a self-critical story (“I’m behind”) into something kinder (“I’m carrying a lot”), an important cognitive shift.',
    emotions: [ { k: 'Relief', v: 64, c: 'var(--mood-4)' }, { k: 'Self-doubt', v: 38, c: 'var(--topic-2)' }, { k: 'Determination', v: 55, c: 'var(--topic-4)' } ],
    topics: ['Therapy', 'Work', 'Self-talk'], themes: ['Reframing', 'Growth'],
    stressors: ['Feeling behind at work'], wins: ['Reframed a harsh inner narrative'],
    concerns: ['Workload pressure persists'], suggestions: ['Repeat the “I’m carrying a lot” reframe', 'Name one thing within your control'] },
  j4: { status: 'pending', wordCount: 31, type: 'Free Journal',
    summary: '', emotions: [], topics: [], themes: [], stressors: [], wins: [], concerns: [], suggestions: [] },
};
function analysis(id) { return JOURNAL_ANALYSIS[id] || { status: 'ready', wordCount: 0, type: 'Free Journal', summary: 'No analysis available yet.', emotions: [], topics: [], themes: [], stressors: [], wins: [], concerns: [], suggestions: [] }; }

/* Discover & Learn — wellness library (no social, MindNest-authored) */
const ARTICLES = [
  { id: 'a1', cat: 'Wellness Article', topic: 'Anxiety', image: true, read: 4, source: 'MindNest Library',
    title: 'The 3-3-3 rule for an anxious mind',
    body: 'When anxiety spikes, try this gentle grounding tool. Name three things you can see, three sounds you can hear, and move three parts of your body. It won’t erase the feeling — but it gently reminds your nervous system that you’re here, and you’re safe.\n\nThe goal isn’t to force calm. It’s to give your attention somewhere kinder to land.' },
  { id: 'a2', cat: 'AI Insight', topic: 'Sleep', image: false, read: 2, source: 'Generated for you',
    title: 'Your sleep is shaping your motivation',
    body: 'We looked across your recent check-ins: on nights with under six hours of sleep, your next-day motivation runs noticeably lower. Protecting your wind-down may be one of the highest-leverage changes you can make this month.' },
  { id: 'a3', cat: 'Mood Education', topic: 'Mindfulness', image: true, read: 5, source: 'MindNest Library',
    title: 'Why naming an emotion softens it',
    body: 'Labelling what you feel — “this is anxiety”, “this is grief” — engages the thinking brain and gently quiets the alarm system. It’s called affect labelling, and it’s one of the simplest, most reliable tools we have.' },
  { id: 'a4', cat: 'Habit Tip', topic: 'Stress', image: false, read: 3, source: 'MindNest Library',
    title: 'Boundaries are a form of care',
    body: 'Saying no isn’t shutting someone out — it’s being honest about what you can hold. A clear boundary, kindly stated, protects the relationship as much as it protects you.' },
  { id: 'a5', cat: 'Reflection Prompt', topic: 'Mindfulness', image: false, read: 1, source: 'Today’s prompt',
    title: 'What gave you a moment of calm today?', prompt: true,
    body: 'Take sixty seconds. Picture the moment, however small. What were you doing? Who were you with? Write it down — noticing calm helps your mind find it again.' },
];
function article(id) { return ARTICLES.find(a => a.id === id) || ARTICLES[0]; }

Object.assign(window, {
  TOPIC_COLORS, topicColor, JOURNALS, POSTS, POST_COMMENTS, NOTIFICATIONS,
  WEEK_MOOD, PRO_POSTS, journal, post,
  JOURNAL_TYPES, JOURNAL_ANALYSIS, analysis, ARTICLES, article,
});
