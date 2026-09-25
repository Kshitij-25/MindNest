// Seeds demo professionals (as real sign-in accounts), their posts and
// reviews. Safe to re-run. Usage: npm run seed
import { FieldValue, Timestamp } from 'firebase-admin/firestore';
import { auth, db } from './admin.mjs';

const PASSWORD = 'MindNest-demo-1';
const slots = ['09:00', '10:00', '11:30', '13:00', '14:30', '16:00', '17:30'];
const hours = (off = []) =>
  Object.fromEntries([1, 2, 3, 4, 5].filter((d) => !off.includes(d)).map((d) => [String(d), slots]));
const ago = (h) => Timestamp.fromDate(new Date(Date.now() - h * 36e5));

const pros = [
  {
    email: 'amara@demo.mindnest.app', name: 'Dr. Amara Okafor', title: 'Clinical Psychologist', spec: 'Anxiety & Stress',
    tags: ['Anxiety', 'Stress', 'CBT'], rating: 4.9, reviews: 214, years: 11, price: 90, location: 'Remote · London',
    langs: ['English', 'Yoruba'], hours: hours(),
    about: 'I help people untangle anxious thinking and rebuild a steadier relationship with everyday life. My approach is warm, structured, and paced to you.',
    quals: ['PhD Clinical Psychology, UCL', 'HCPC Registered', 'Certified CBT Practitioner'],
  },
  {
    email: 'daniel@demo.mindnest.app', name: 'Daniel Mercer', title: 'Psychotherapist', spec: 'Depression & Mood',
    tags: ['Depression', 'Mood', 'Mindfulness'], rating: 4.8, reviews: 156, years: 8, price: 75, location: 'Remote · Manchester',
    langs: ['English'], types: ['Video', 'Chat'], hours: hours([3]),
    about: 'A calm, non-judgemental space to work through low mood and find small footholds back toward the things that matter to you.',
    quals: ['MSc Psychotherapy', 'BACP Accredited', 'Mindfulness-Based CT'],
  },
  {
    email: 'priya@demo.mindnest.app', name: 'Dr. Priya Nair', title: 'Counselling Psychologist', spec: 'Sleep & Burnout',
    tags: ['Sleep', 'Burnout', 'Work stress'], rating: 5.0, reviews: 98, years: 13, price: 110, location: 'Remote · Edinburgh',
    langs: ['English', 'Hindi'], types: ['Video'], hours: hours([1, 5]),
    about: 'I work with high-functioning burnout and sleep difficulties, blending CBT-I with compassion-focused techniques.',
    quals: ['DPsych Counselling Psychology', 'HCPC Registered', 'CBT-I Certified'],
  },
  {
    email: 'sofia@demo.mindnest.app', name: 'Sofia Almeida', title: 'Therapist', spec: 'Relationships',
    tags: ['Relationships', 'Self-esteem'], rating: 4.7, reviews: 132, years: 6, price: 70, location: 'Remote · Lisbon',
    langs: ['English', 'Portuguese'], hours: hours([2]),
    about: 'Relationship and self-worth work in a gentle, collaborative style. We move at a pace that feels safe for you.',
    quals: ['MA Integrative Counselling', 'BACP Registered'],
  },
];

const posts = [
  { by: 0, topic: 'Anxiety', h: 2, image: true, read: 4, likes: 128, views: 1240, title: 'The 3-3-3 rule for an anxious mind',
    body: 'When anxiety spikes, try this gentle grounding tool. Name three things you can see, three sounds you can hear, and move three parts of your body. It won’t erase the feeling — but it gently reminds your nervous system that you’re here, and you’re safe.\n\nThe goal isn’t to force calm. It’s to give your attention somewhere kinder to land.' },
  { by: 2, topic: 'Sleep', h: 5, read: 3, likes: 94, views: 870, title: 'Why “trying harder” to sleep backfires',
    body: 'Sleep is a letting-go, not a doing. The more we chase it, the more alert we become. Tonight, instead of trying to sleep, try simply resting — no goal, no clock-watching. Rest is restorative on its own.' },
  { by: 1, topic: 'Mindfulness', h: 26, image: true, read: 5, likes: 211, views: 2890, title: 'A 60-second reset for busy days',
    body: 'You don’t need an hour to come back to yourself. One slow breath, a hand on your chest, and a single kind sentence: “This is hard, and I’m doing my best.” Repeat as needed.' },
  { by: 3, topic: 'Relationships', h: 50, read: 4, likes: 76, views: 640, title: 'Boundaries are a form of care',
    body: 'Saying no isn’t shutting someone out — it’s being honest about what you can hold. A clear boundary, kindly stated, protects the relationship as much as it protects you.' },
];

const reviews = [
  { name: 'Jordan M.', rating: 5, days: 14, text: 'Genuinely changed how I handle stressful weeks. I feel heard and never rushed.' },
  { name: 'Leah K.', rating: 5, days: 30, text: 'Patient, warm, and practical. The tools we built actually stuck.' },
  { name: 'Sam R.', rating: 4, days: 60, text: 'A really safe space. Sessions always leave me a little lighter.' },
];

async function ensureUser(email, name) {
  try {
    return await auth.getUserByEmail(email);
  } catch {
    return auth.createUser({ email, password: PASSWORD, displayName: name, emailVerified: true });
  }
}

const uids = [];
for (const p of pros) {
  const u = await ensureUser(p.email, p.name);
  uids.push(u.uid);
  const { email, ...profile } = p;
  await db.doc(`users/${u.uid}`).set({
    name: p.name, email, role: 'professional', onboarded: true, verification: 'verified',
    title: p.title, phone: '', bio: '', createdAt: FieldValue.serverTimestamp(),
  }, { merge: true });
  await db.doc(`therapists/${u.uid}`).set({
    ...profile, types: p.types ?? ['Video', 'Voice', 'Chat'], verified: true, acceptingClients: true,
    createdAt: FieldValue.serverTimestamp(),
  }, { merge: true });
  for (const [i, r] of reviews.entries()) {
    await db.doc(`therapists/${u.uid}/reviews/seed-${i}`).set({
      name: r.name, rating: r.rating, text: r.text, createdAt: Timestamp.fromDate(new Date(Date.now() - r.days * 864e5)),
    });
  }
  console.log(`✔ ${p.name} <${email}>`);
}

for (const [i, p] of posts.entries()) {
  const pro = pros[p.by];
  const ref = db.doc(`posts/seed-${i}`);
  await ref.set({
    authorId: uids[p.by],
    author: { name: pro.name, title: pro.title, spec: pro.spec, verified: true },
    topic: p.topic, title: p.title, body: p.body, image: !!p.image, read: p.read,
    likes: p.likes, comments: 0, views: p.views, status: 'published', publishedAt: ago(p.h),
  });
  const comments = [
    { name: 'Leah K.', text: 'Needed this today. Thank you.' },
    { name: 'Sam R.', text: 'Tried it this morning and it genuinely helped.' },
  ];
  for (const [j, c] of comments.entries()) {
    await ref.collection('comments').doc(`seed-${j}`).set({ authorId: 'seed', ...c, likedBy: [], createdAt: ago(p.h - 0.5 - j * 0.2) });
  }
  await ref.update({ comments: comments.length });
}
console.log(`✔ ${posts.length} posts`);
if (process.argv.includes('--demo-client')) await seedDemoClient();
console.log(`\nDemo logins use password: ${PASSWORD}`);

// A fully populated client (mood history, journal, bookings, chat…) for
// demos and screenshots: maya@demo.mindnest.app
async function seedDemoClient() {
  const u = await ensureUser('maya@demo.mindnest.app', 'Maya Chen');
  const me = u.uid, pro = uids[0], proName = pros[0].name;
  const day = (d, h = 9, m = 0) => { const t = new Date(); t.setHours(h, m, 0, 0); t.setDate(t.getDate() + d); return Timestamp.fromDate(t); };
  await db.doc(`users/${me}`).set({ name: 'Maya Chen', email: 'maya@demo.mindnest.app', role: 'client', onboarded: true,
    verification: 'none', title: null, phone: '+44 7700 900892', bio: 'Learning to slow down and be kinder to myself.' });
  await db.doc(`users/${me}/private/assessment`).set({ mood: 3, stress: 6, anxiety: 2, sleep: 3, goals: ['Reduce anxiety', 'Sleep better'] });

  const levels = [3, 4, 4, 3, 2, 4, 5, 4, 3, 4, 4, 5, 5, 4, 3, 2, 3, 4, 5, 4, 4, 3, 4, 2, 4, 5, 4, 4];
  const factors = [['Sleep', 'Exercise'], ['Work'], ['Family'], ['Exercise'], ['Relationships']];
  for (const [i, l] of levels.entries()) {
    await db.doc(`users/${me}/moods/seed-${i}`).set({ level: l, factors: factors[i % 5], note: i === 27 ? 'Slept well and had a calm morning walk.' : '', createdAt: day(i - 27, 9, 24) });
  }
  const journal = [
    [0, 'A slower morning', 'Woke up before the alarm and let myself lie still for a few minutes. Small win: I didn’t reach for my phone straight away.', ['Calm', 'Gratitude'], 4, true],
    [-1, 'Session reflections', 'Reframed the “I’m behind” feeling as “I’m carrying a lot” and it landed. Trying to hold that gentler story.', ['Therapy', 'Growth'], 5, false],
    [-3, 'Heavy day', 'Deadlines piled up. Naming it here so it doesn’t sit in my chest overnight.', ['Stress'], 2, false],
    [-5, 'Morning walk', 'Twenty minutes by the canal before work. The cold air helped. Keep choosing this.', ['Self-care', 'Calm'], 4, false],
  ];
  for (const [i, [d, title, body, tags, mood, fav]] of journal.entries()) {
    await db.doc(`users/${me}/journal/seed-${i}`).set({ title, body, tags, mood, favourite: fav, draft: false, createdAt: day(d, 20, 10) });
  }

  const appt = (id, d, h, status, extra = {}) => db.doc(`appointments/${id}`).set({
    clientId: me, clientName: 'Maya Chen', therapistId: pro, therapistName: proName, startsAt: day(d, h), type: 'video', minutes: 50,
    status, recurrence: 'weekly', reminders: ['24h', '1h'], price: 90, reason: 'Anxiety & work stress', note: '', newClient: false,
    createdAt: day(d - 3), ...(status !== 'pending' ? { respondedAt: day(d - 2) } : {}), ...extra });
  await appt('seed-up1', 2, 16, 'accepted');
  await appt('seed-req', 4, 11, 'pending', { note: 'Could we also talk about sleep next time?', recurrence: 'oneTime' });
  for (const w of [1, 2, 3, 4]) await appt(`seed-past${w}`, -7 * w, 16, 'accepted');
  for (const [id, d, h] of [['seed-up1', 2, 16], ['seed-req', 4, 11]]) {
    const t = day(d, h).toDate();
    const key = `${t.getFullYear()}${String(t.getMonth() + 1).padStart(2, '0')}${String(t.getDate()).padStart(2, '0')}${String(t.getHours()).padStart(2, '0')}00`;
    await db.doc(`therapists/${pro}/busy/${key}`).set({ appointmentId: id, clientId: me, startsAt: day(d, h) });
  }
  await db.doc(`therapists/${pro}/clients/${me}`).set({ name: 'Maya Chen', focus: 'Anxiety & work stress', since: day(-60), status: 'improving' });
  await db.doc(`therapists/${pro}/clients/${me}/notes/seed-1`).set({ date: day(-7, 16), tag: 'Session 4', text: 'Reframed “I’m behind” as “I’m carrying a lot.” Homework: 3-3-3 grounding before stand-ups. Sleep improving.' });
  await db.doc(`therapists/${pro}/clients/${me}/notes/seed-2`).set({ date: day(-14, 16), tag: 'Session 3', text: 'Work pressure peaked midweek. Practised a boundary-setting script with manager.' });
  for (const [i, [text, done]] of [['Practise 3-3-3 grounding daily', true], ['Set one work boundary this week', true], ['Sleep before 11pm, 5 nights', false]].entries()) {
    await db.doc(`therapists/${pro}/clients/${me}/goals/seed-${i}`).set({ text, done, createdAt: day(-20 + i) });
  }

  const conv = db.doc(`conversations/${me}_${pro}`);
  const msgs = [[pro, 'Hi Maya — how have you been since our last session?', -50], [me, 'A bit up and down, but I tried the grounding exercise twice.', -41], [pro, 'That sounds like real progress — well done this week.', -35]];
  await conv.set({ participants: [me, pro], clientId: me, proId: pro,
    members: { [me]: { name: 'Maya Chen', subtitle: 'Anxiety & work stress', verified: false }, [pro]: { name: proName, subtitle: pros[0].title, verified: true } },
    last: msgs[2][1], updatedAt: Timestamp.fromDate(new Date(Date.now() - 35 * 6e4)), unread: { [me]: 1, [pro]: 0 },
    lastRead: { [pro]: Timestamp.now() }, session: { title: 'Session confirmed', at: day(2, 16), status: 'Accepted' } });
  for (const [i, [from, text, min]] of msgs.entries()) {
    await conv.collection('messages').doc(`seed-${i}`).set({ senderId: from, text, sentAt: Timestamp.fromDate(new Date(Date.now() + min * 6e4)) });
  }
  const notes = [
    ['booking', 'Booking confirmed', `${proName} accepted your upcoming session.`, 0.1, true],
    ['message', 'New message', `${proName}: “That sounds like real progress — well done this week.”`, 0.6, true],
    ['content', 'New from Dr. Nair', '“Why trying harder to sleep backfires” — a 2-minute read.', 5, false],
    ['booking', 'Session reminder', `Your session with ${proName} is in 2 days.`, 26, false],
  ];
  for (const [i, [type, title, body, h, unread]] of notes.entries()) {
    await db.doc(`users/${me}/notifications/seed-${i}`).set({ type, title, body, targetId: null, senderId: pro, unread, createdAt: ago(h) });
  }
  await db.doc(`users/${pro}/notifications/seed-0`).set({ type: 'booking', title: 'New session request', body: 'Maya Chen requested a video session.', targetId: 'seed-req', senderId: me, unread: true, createdAt: ago(0.3) });
  console.log('✔ Demo client maya@demo.mindnest.app');
}
