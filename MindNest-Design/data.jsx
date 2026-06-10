/* MindNest — mock data */

const THERAPISTS = [
  {
    id: 't1', name: 'Dr. Amara Okafor', title: 'Clinical Psychologist',
    spec: 'Anxiety & Stress', tags: ['Anxiety', 'Stress', 'CBT'], rating: 4.9, reviews: 214,
    years: 11, verified: true, price: 90, location: 'Remote · London',
    next: 'Tomorrow', langs: ['English', 'Yoruba'],
    about: 'I help people untangle anxious thinking and rebuild a steadier relationship with everyday life. My approach is warm, structured, and paced to you.',
    quals: ['PhD Clinical Psychology, UCL', 'HCPC Registered', 'Certified CBT Practitioner'],
  },
  {
    id: 't2', name: 'Daniel Mercer', title: 'Psychotherapist',
    spec: 'Depression & Mood', tags: ['Depression', 'Mood', 'Mindfulness'], rating: 4.8, reviews: 156,
    years: 8, verified: true, price: 75, location: 'Remote · Manchester',
    next: 'Today', langs: ['English'],
    about: 'A calm, non-judgemental space to work through low mood and find small footholds back toward the things that matter to you.',
    quals: ['MSc Psychotherapy', 'BACP Accredited', 'Mindfulness-Based CT'],
  },
  {
    id: 't3', name: 'Dr. Priya Nair', title: 'Counselling Psychologist',
    spec: 'Sleep & Burnout', tags: ['Sleep', 'Burnout', 'Work stress'], rating: 5.0, reviews: 98,
    years: 13, verified: true, price: 110, location: 'Remote · Edinburgh',
    next: 'Thu', langs: ['English', 'Hindi'],
    about: 'I work with high-functioning burnout and sleep difficulties, blending CBT-I with compassion-focused techniques.',
    quals: ['DPsych Counselling Psychology', 'HCPC Registered', 'CBT-I Certified'],
  },
  {
    id: 't4', name: 'Sofia Almeida', title: 'Therapist',
    spec: 'Relationships', tags: ['Relationships', 'Self-esteem'], rating: 4.7, reviews: 132,
    years: 6, verified: true, price: 70, location: 'Remote · Lisbon',
    next: 'Fri', langs: ['English', 'Portuguese'],
    about: 'Relationship and self-worth work in a gentle, collaborative style. We move at a pace that feels safe for you.',
    quals: ['MA Integrative Counselling', 'BACP Registered'],
  },
];

const REVIEWS = [
  { id: 'r1', name: 'Jordan M.', rating: 5, time: '2 weeks ago', text: 'Genuinely changed how I handle stressful weeks. I feel heard and never rushed.' },
  { id: 'r2', name: 'Leah K.', rating: 5, time: '1 month ago', text: 'Patient, warm, and practical. The tools we built actually stuck.' },
  { id: 'r3', name: 'Sam R.', rating: 4, time: '2 months ago', text: 'A really safe space. Sessions always leave me a little lighter.' },
];

const CONVERSATIONS = [
  { id: 'c1', tid: 't1', last: 'That sounds like real progress — well done this week.', time: '9:24', unread: 2, online: true, typing: false },
  { id: 'c2', tid: 't2', last: 'See you Thursday. Take it gently until then.', time: 'Yesterday', unread: 0, online: false, typing: false },
  { id: 'c3', tid: 't3', last: 'I’ve shared a short breathing exercise for tonight.', time: 'Mon', unread: 0, online: true, typing: false },
];

const MESSAGES = {
  c1: [
    { id: 'm1', from: 'them', text: 'Hi — how have you been since our last session?', time: '9:10' },
    { id: 'm2', from: 'me', text: 'A bit up and down, but I tried the grounding exercise twice.', time: '9:18', read: true },
    { id: 'm3', from: 'them', text: 'That sounds like real progress — well done this week.', time: '9:24' },
  ],
};

const APPOINTMENTS = [
  { id: 'a1', tid: 't1', date: 'Thu, 5 Jun', time: '4:00 PM', type: 'Video session', status: 'Accepted', mins: 50 },
];

// professional side
const REQUESTS = [
  { id: 'q1', name: 'Jordan Mills', when: 'Fri 6 Jun · 2:00 PM', reason: 'Anxiety & work stress', status: 'Pending', mins: 50 },
  { id: 'q2', name: 'Priya Shah', when: 'Sat 7 Jun · 11:00 AM', reason: 'First consultation', status: 'Pending', mins: 30 },
];
const PRO_SESSIONS = [
  { id: 's1', name: 'Leah Karim', when: 'Today · 1:00 PM', type: 'Video', mins: 50, status: 'Accepted' },
  { id: 's2', name: 'Sam Rivera', when: 'Today · 3:30 PM', type: 'Chat', mins: 50, status: 'Accepted' },
  { id: 's3', name: 'Noah Bennett', when: 'Tomorrow · 10:00 AM', type: 'Video', mins: 50, status: 'Accepted' },
];

// mood history (last 7 days), level 1..5
const MOOD_HISTORY = [
  { day: 'Mon', level: 3 }, { day: 'Tue', level: 4 }, { day: 'Wed', level: 2 },
  { day: 'Thu', level: 4 }, { day: 'Fri', level: 5 }, { day: 'Sat', level: 4 }, { day: 'Sun', level: 4 },
];

function therapist(id) { return THERAPISTS.find(t => t.id === id); }

/* ============================================================
   MVP 1 — AI Wellness data model
   ============================================================ */

/* Wellness score (0–100) + contributing signals */
const WELLNESS = {
  score: 78,
  trend: 'up',          // up | down | flat
  weeklyChange: 4,      // points vs last week
  confidence: 86,       // % model confidence
  band: 'Balanced',     // qualitative band
  // contributing signals, each 0–100 (higher = healthier)
  signals: [
    { key: 'Mood', value: 74, weight: 'High', icon: 'smile' },
    { key: 'Stress', value: 58, weight: 'High', icon: 'pulse', inverse: true },
    { key: 'Anxiety', value: 62, weight: 'Med', icon: 'wind', inverse: true },
    { key: 'Motivation', value: 81, weight: 'Med', icon: 'zap' },
    { key: 'Burnout', value: 66, weight: 'High', icon: 'flame', inverse: true },
    { key: 'Sleep', value: 70, weight: 'Med', icon: 'sleep' },
    { key: 'Habits', value: 84, weight: 'Low', icon: 'repeat' },
  ],
  spark: [71, 69, 72, 70, 74, 76, 78], // last 7 days
};

/* Emotional profile — 8 dimensions, 0–100 */
const EMOTIONS = [
  { key: 'Stress', value: 54, trend: -6, color: 'var(--topic-2)', desc: 'Easing since the weekend' },
  { key: 'Anxiety', value: 41, trend: -3, color: 'var(--topic-1)', desc: 'Lower than your baseline' },
  { key: 'Burnout', value: 38, trend: -12, color: 'var(--streak)', desc: 'Recovering steadily' },
  { key: 'Motivation', value: 76, trend: 8, color: 'var(--topic-4)', desc: 'Climbing this week' },
  { key: 'Happiness', value: 68, trend: 5, color: 'var(--mood-4)', desc: 'Holding well' },
  { key: 'Fatigue', value: 47, trend: -4, color: 'var(--topic-3)', desc: 'Slightly improved' },
  { key: 'Loneliness', value: 33, trend: -2, color: 'var(--topic-5)', desc: 'Below baseline' },
  { key: 'Emotional stability', value: 72, trend: 6, color: 'var(--primary)', desc: 'More even than last week' },
];

/* Adaptive assessments */
const ASSESSMENTS = [
  { id: 'daily', name: 'Daily Check-In', sub: 'Mood, energy & stress', icon: 'smile', freq: 'Every day', last: 'Today, 9:24', confidence: 92, items: 6, done: true, color: 'var(--mood-4)' },
  { id: 'weekly', name: 'Weekly Reflection', sub: 'A deeper look at your week', icon: 'bookOpen', freq: 'Sundays', last: '2 days ago', confidence: 88, items: 12, done: false, color: 'var(--primary)' },
  { id: 'burnout', name: 'Burnout Assessment', sub: 'Maslach-informed signals', icon: 'flame', freq: 'Adaptive', last: '6 days ago', confidence: 81, items: 10, done: false, color: 'var(--streak)' },
  { id: 'motivation', name: 'Motivation Assessment', sub: 'Drive & engagement', icon: 'zap', freq: 'Adaptive', last: '4 days ago', confidence: 79, items: 8, done: false, color: 'var(--topic-4)' },
  { id: 'anxiety', name: 'Anxiety Assessment', sub: 'GAD-informed signals', icon: 'wind', freq: 'Adaptive', last: '1 week ago', confidence: 76, items: 7, done: false, color: 'var(--topic-1)' },
];
const ASSESSMENT_HISTORY = [
  { id: 'h1', name: 'Daily Check-In', date: 'Today · 9:24 AM', score: 'Good', confidence: 92, delta: 'up' },
  { id: 'h2', name: 'Burnout Assessment', date: 'Fri · 8:10 AM', score: 'Moderate', confidence: 81, delta: 'down' },
  { id: 'h3', name: 'Weekly Reflection', date: 'Sun · 7:40 PM', score: 'Steady', confidence: 88, delta: 'flat' },
  { id: 'h4', name: 'Anxiety Assessment', date: 'Mon · 8:02 AM', score: 'Low', confidence: 76, delta: 'up' },
];

/* Recommendations — map to feedback APIs (dismiss / complete / helpful) */
const RECS = [
  { id: 'rc1', kind: 'Reflection Prompt', icon: 'feather', color: 'var(--primary)', title: 'Name one thing within your control today',
    reason: 'Your stress entries spiked around work deadlines this week.', benefit: 'Reduces rumination and restores a sense of agency.', duration: '3 min', insight: 'Work appeared in 43% of stressful entries' },
  { id: 'rc2', kind: 'Breathing Exercise', icon: 'wind', color: 'var(--topic-1)', title: 'Box breathing · 4-4-4-4',
    reason: 'Anxiety signals rose on Wednesday afternoon.', benefit: 'Calms the nervous system within minutes.', duration: '5 min', insight: 'Anxiety peaks mid-week' },
  { id: 'rc3', kind: 'Sleep Suggestion', icon: 'sleep', color: 'var(--topic-3)', title: 'Wind-down 45 minutes earlier tonight',
    reason: 'Your sleep quality dipped and motivation followed.', benefit: 'Better sleep is linked to a +1 mood point for you.', duration: 'Tonight', insight: 'Sleep quality impacts motivation' },
  { id: 'rc4', kind: 'Habit Recommendation', icon: 'repeat', color: 'var(--topic-4)', title: 'Add a 10-minute morning walk',
    reason: 'Exercise days correlate with higher motivation.', benefit: 'Lifts mood and steadies energy through the day.', duration: '10 min', insight: 'Exercise improves motivation' },
  { id: 'rc5', kind: 'Mindfulness Exercise', icon: 'brain', color: 'var(--moss-500)', title: 'A 60-second body scan',
    reason: 'You logged tension three days in a row.', benefit: 'Interrupts the stress loop and grounds attention.', duration: '1 min', insight: 'Tension clusters before deadlines' },
  { id: 'rc6', kind: 'Gratitude Exercise', icon: 'heart', color: 'var(--clay)', title: 'Note three small wins from today',
    reason: 'Gratitude entries lift your happiness score.', benefit: 'Shifts focus toward what’s going well.', duration: '2 min', insight: 'Gratitude raises happiness' },
];

/* Insight findings (confidence-scored discoveries) */
const FINDINGS = [
  { id: 'f1', text: 'Work appeared in 43% of your stressful entries', confidence: 94, tag: 'Stress' },
  { id: 'f2', text: 'Sleep quality strongly impacts next-day motivation', confidence: 81, tag: 'Sleep' },
  { id: 'f3', text: 'Burnout risk decreased 12% over the last two weeks', confidence: 76, tag: 'Burnout' },
  { id: 'f4', text: 'Journaling days average a full mood point higher', confidence: 89, tag: 'Journal' },
];

/* Pattern detector */
const PATTERNS = [
  { id: 'pt1', icon: 'pulse', color: 'var(--topic-2)', title: 'Work drives most of your stress', detail: 'Work appears in 43% of entries you tag as stressful — more than any other theme.', confidence: 94, strength: 'Strong' },
  { id: 'pt2', icon: 'sleep', color: 'var(--topic-3)', title: 'Mood drops on poor-sleep days', detail: 'On nights with under 6 hours, your next-day mood averages 1.4 points lower.', confidence: 83, strength: 'Strong' },
  { id: 'pt3', icon: 'repeat', color: 'var(--topic-4)', title: 'Exercise improves motivation', detail: 'Motivation runs 22% higher on days you log any movement.', confidence: 79, strength: 'Moderate' },
  { id: 'pt4', icon: 'feather', color: 'var(--primary)', title: 'Journaling improves emotional stability', detail: 'Your stability score is steadier in weeks with three or more entries.', confidence: 86, strength: 'Strong' },
];

/* Emotional memory highlights */
const MEMORIES = [
  { id: 'm1', kind: 'Most meaningful journal', icon: 'bookOpen', color: 'var(--primary)', title: 'A slower morning', date: '31 May', snippet: 'I noticed I wasn’t reaching for my phone straight away — small win.' },
  { id: 'm2', kind: 'Recent growth moment', icon: 'sparkle', color: 'var(--topic-4)', title: 'Reframed “I’m behind”', date: '30 May', snippet: 'Held a gentler version of the story: I’m carrying a lot.' },
  { id: 'm3', kind: 'Recurring concern', icon: 'pulse', color: 'var(--topic-2)', title: 'Deadline pressure', date: 'Ongoing', snippet: 'Surfaces most weeks around mid-week work peaks.' },
  { id: 'm4', kind: 'Positive recovery event', icon: 'trend', color: 'var(--green)', title: 'Bounced back by Friday', date: '23 May', snippet: 'Mood recovered two days faster than your average dip.' },
  { id: 'm5', kind: 'Past similar situation', icon: 'clock', color: 'var(--topic-3)', title: 'Last big deadline', date: 'April', snippet: 'You used box breathing and it helped — worth repeating.' },
];

/* Emotional timeline events */
const TIMELINE = [
  { id: 'tl1', period: 'This week', change: 'Stress +18%', dir: 'up', tone: 'warn', drivers: ['Work', 'Sleep', 'Relationships'], note: 'A cluster of deadlines and two short nights lifted stress above your baseline.' },
  { id: 'tl2', period: 'Last week', change: 'Motivation +9%', dir: 'up', tone: 'good', drivers: ['Exercise', 'Mornings'], note: 'Three movement days lined up with a steadier, more driven week.' },
  { id: 'tl3', period: '2 weeks ago', change: 'Burnout −12%', dir: 'down', tone: 'good', drivers: ['Rest', 'Boundaries'], note: 'Protecting evenings helped your burnout signals ease.' },
  { id: 'tl4', period: '3 weeks ago', change: 'Anxiety +7%', dir: 'up', tone: 'warn', drivers: ['Uncertainty', 'Caffeine'], note: 'Anxiety rose around an unresolved decision at work.' },
];

/* Habits */
const HABITS = [
  { id: 'hb1', name: 'Meditation', icon: 'brain', color: 'var(--moss-500)', streak: 8, completion: 86, week: [1,1,0,1,1,1,1], correlation: 'Linked to calmer afternoons' },
  { id: 'hb2', name: 'Exercise', icon: 'repeat', color: 'var(--topic-4)', streak: 3, completion: 57, week: [1,0,1,0,0,1,0], correlation: '+22% motivation on active days' },
  { id: 'hb3', name: 'Hydration', icon: 'droplet', color: 'var(--topic-1)', streak: 12, completion: 92, week: [1,1,1,1,1,1,0], correlation: 'Steadier energy when met' },
  { id: 'hb4', name: 'Sleep', icon: 'sleep', color: 'var(--topic-3)', streak: 5, completion: 71, week: [1,1,0,1,1,1,0], correlation: 'Drives next-day mood' },
  { id: 'hb5', name: 'Reading', icon: 'bookOpen', color: 'var(--primary)', streak: 4, completion: 64, week: [0,1,1,0,1,1,0], correlation: 'Helps your wind-down' },
];

/* Weekly wellness report */
const WEEKLY_REPORT = {
  range: '26 May – 1 Jun',
  moodSummary: { avg: 'Good', avgLevel: 4, change: '+8%', best: 'Friday', hardest: 'Wednesday' },
  emotionalChanges: [
    { key: 'Stress', delta: -6 }, { key: 'Motivation', delta: 8 }, { key: 'Burnout', delta: -12 }, { key: 'Happiness', delta: 5 },
  ],
  topTopics: [ { t: 'Work', n: 9 }, { t: 'Sleep', n: 6 }, { t: 'Relationships', n: 4 }, { t: 'Health', n: 3 } ],
  habitAdherence: 78,
  recFollowThrough: 64,
  burnoutMovement: -12,
  patterns: ['Work drives most of your stress', 'Exercise improves motivation'],
  growthAreas: ['Protect mid-week evenings', 'Earlier wind-down on work nights'],
  suggestedFocus: 'Sleep consistency',
};

/* AI Coach — context-aware conversation */
const COACH_CONTEXT = {
  memories: ['A slower morning · 31 May', 'Reframed “I’m behind” · 30 May'],
  insights: ['Work appeared in 43% of stressful entries', 'Sleep quality impacts motivation'],
  recentMood: 'Good · trending up',
  used: ['Mood history', 'Journals', 'Insights', 'Memory', 'Recommendations'],
};
const COACH_MESSAGES = [
  { id: 'm1', from: 'them', text: 'Morning, Maya. Your wellness score ticked up to 78 this week — nice momentum. How are you feeling today?', time: '9:10' },
  { id: 'm2', from: 'me', text: 'Okay, but a bit wired about the work deadline.', time: '9:18', read: true },
  { id: 'm3', from: 'them', text: 'That tracks — work showed up in most of your stressful entries lately. Want to try the box-breathing exercise that helped you last deadline?', time: '9:19' },
];
const COACH_SUGGESTIONS = ['Try box breathing', 'Reframe the deadline', 'Plan a wind-down'];

function rec(id) { return RECS.find(r => r.id === id); }

Object.assign(window, {
  THERAPISTS, REVIEWS, CONVERSATIONS, MESSAGES, APPOINTMENTS,
  REQUESTS, PRO_SESSIONS, MOOD_HISTORY, therapist,
  WELLNESS, EMOTIONS, ASSESSMENTS, ASSESSMENT_HISTORY, RECS, FINDINGS,
  PATTERNS, MEMORIES, TIMELINE, HABITS, WEEKLY_REPORT,
  COACH_CONTEXT, COACH_MESSAGES, COACH_SUGGESTIONS, rec,
});
