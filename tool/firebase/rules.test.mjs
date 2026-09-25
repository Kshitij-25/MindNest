// Firestore security-rules tests. Run with: npm run test:rules
// Each test mirrors a write the app performs (see lib/**/data/datasources)
// and the abuse the rules must block.
import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  Timestamp,
  arrayUnion,
  doc,
  getDoc,
  getDocs,
  collection,
  increment,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  writeBatch,
} from 'firebase/firestore';

let env;
const inAWeek = () => Timestamp.fromDate(new Date(Date.now() + 7 * 864e5));

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mindnest',
    firestore: { rules: readFileSync('../../firestore.rules', 'utf8') },
  });
});
after(() => env.cleanup());

beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'users/alice'), { role: 'client', name: 'Alice', verification: 'none', onboarded: true });
    await setDoc(doc(db, 'users/bob'), { role: 'client', name: 'Bob', verification: 'none', onboarded: true });
    await setDoc(doc(db, 'users/pro'), { role: 'professional', name: 'Dr Pro', verification: 'verified', onboarded: true });
    await setDoc(doc(db, 'therapists/pro'), { name: 'Dr Pro', verified: true, rating: 4.9, reviews: 10, price: 90 });
    await setDoc(doc(db, 'therapists/newpro'), { name: 'New Pro', verified: false, rating: 0, reviews: 0 });
    await setDoc(doc(db, 'posts/p1'), { authorId: 'pro', status: 'published', likes: 0, comments: 0, views: 0, title: 't', body: 'b' });
    await setDoc(doc(db, 'posts/draft'), { authorId: 'pro', status: 'draft', likes: 0, comments: 0, views: 0 });
    await setDoc(doc(db, 'posts/p1/comments/c1'), { authorId: 'bob', text: 'hi', likedBy: [] });
  });
});

const as = (uid) => env.authenticatedContext(uid).firestore();

function book(db, { client = 'alice', therapist = 'pro', slot = '202612011000', id = 'a1' } = {}) {
  const b = writeBatch(db);
  b.set(doc(db, `appointments/${id}`), {
    clientId: client, therapistId: therapist, status: 'pending', startsAt: inAWeek(), createdAt: serverTimestamp(),
  });
  b.set(doc(db, `therapists/${therapist}/busy/${slot}`), { appointmentId: id, clientId: client, startsAt: inAWeek() });
  return b.commit();
}

describe('users', () => {
  test('sign-up creates own profile only', async () => {
    const db = as('carol');
    await assertSucceeds(setDoc(doc(db, 'users/carol'), { role: 'client', verification: 'none', onboarded: false, name: 'C' }));
    await assertFails(setDoc(doc(db, 'users/dave'), { role: 'client', verification: 'none', onboarded: false }));
  });
  test('cannot self-verify or change role', async () => {
    const db = as('carol');
    await assertFails(setDoc(doc(db, 'users/carol'), { role: 'professional', verification: 'verified', onboarded: false }));
    const pro = as('pro');
    await env.withSecurityRulesDisabled((c) => updateDoc(doc(c.firestore(), 'users/pro'), { verification: 'none' }));
    await assertSucceeds(updateDoc(doc(pro, 'users/pro'), { verification: 'pending' }));
    await assertFails(updateDoc(doc(pro, 'users/pro'), { verification: 'verified' }));
    await assertFails(updateDoc(doc(as('alice'), 'users/alice'), { role: 'professional' }));
  });
  test('profiles and private data are owner-only', async () => {
    await assertFails(getDoc(doc(as('bob'), 'users/alice')));
    await assertFails(getDoc(doc(as('bob'), 'users/alice/moods/m1')));
    await assertSucceeds(setDoc(doc(as('alice'), 'users/alice/journal/j1'), { body: 'x' }));
    await assertFails(setDoc(doc(as('alice'), 'users/alice/secrets/s1'), { x: 1 }));
  });
});

describe('therapists', () => {
  test('pro cannot mark themselves verified or edit rating', async () => {
    await assertSucceeds(updateDoc(doc(as('newpro'), 'therapists/newpro'), { about: 'Hello' }));
    await assertFails(updateDoc(doc(as('newpro'), 'therapists/newpro'), { verified: true }));
    await assertFails(updateDoc(doc(as('pro'), 'therapists/pro'), { rating: 5 }));
  });
  test('client records are practitioner-only', async () => {
    await assertSucceeds(setDoc(doc(as('pro'), 'therapists/pro/clients/alice'), { name: 'Alice' }));
    await assertFails(getDoc(doc(as('alice'), 'therapists/pro/clients/alice')));
  });
});

describe('booking', () => {
  test('client books a verified pro; slot cannot be double-booked', async () => {
    await assertSucceeds(book(as('alice')));
    await assertFails(book(as('bob'), { client: 'bob', id: 'a2' }));
  });
  test('cannot book an unverified pro, or on someone else’s behalf', async () => {
    await assertFails(book(as('alice'), { therapist: 'newpro' }));
    await assertFails(book(as('bob'), { client: 'alice', id: 'a3' }));
  });
  test('only the participants can read an appointment', async () => {
    await book(as('alice'));
    await assertSucceeds(getDoc(doc(as('pro'), 'appointments/a1')));
    await assertFails(getDoc(doc(as('bob'), 'appointments/a1')));
    await assertSucceeds(getDocs(query(collection(as('alice'), 'appointments'), where('clientId', '==', 'alice'))));
    await assertFails(getDocs(collection(as('bob'), 'appointments')));
  });
  test('pro accepts/declines, client only cancels', async () => {
    await book(as('alice'));
    await assertFails(updateDoc(doc(as('alice'), 'appointments/a1'), { status: 'accepted', respondedAt: serverTimestamp() }));
    await assertSucceeds(updateDoc(doc(as('pro'), 'appointments/a1'), { status: 'accepted', respondedAt: serverTimestamp() }));
    await assertFails(updateDoc(doc(as('pro'), 'appointments/a1'), { status: 'declined', respondedAt: serverTimestamp() }));
    const alice = as('alice');
    const b = writeBatch(alice);
    b.update(doc(alice, 'appointments/a1'), { status: 'cancelled', cancelledAt: serverTimestamp() });
    b.delete(doc(alice, 'therapists/pro/busy/202612011000'));
    await assertSucceeds(b.commit());
  });
});

describe('chat', () => {
  const conv = { participants: ['alice', 'pro'], clientId: 'alice', proId: 'pro', members: {}, last: '', unread: {} };
  test('participants create, message and read a thread', async () => {
    const alice = as('alice');
    await assertSucceeds(getDoc(doc(alice, 'conversations/alice_pro'))); // existence check
    await assertSucceeds(setDoc(doc(alice, 'conversations/alice_pro'), conv));
    const b = writeBatch(alice);
    b.set(doc(alice, 'conversations/alice_pro/messages/m1'), { senderId: 'alice', text: 'Hi', sentAt: serverTimestamp() });
    b.update(doc(alice, 'conversations/alice_pro'), { last: 'Hi', 'unread.pro': increment(1) });
    await assertSucceeds(b.commit());
    await assertSucceeds(getDocs(query(collection(as('pro'), 'conversations'), where('participants', 'array-contains', 'pro'))));
  });
  test('outsiders are locked out and cannot spoof senders', async () => {
    await env.withSecurityRulesDisabled((c) => setDoc(doc(c.firestore(), 'conversations/alice_pro'), conv));
    await assertFails(getDoc(doc(as('bob'), 'conversations/alice_pro')));
    await assertFails(getDocs(collection(as('bob'), 'conversations/alice_pro/messages')));
    await assertFails(setDoc(doc(as('bob'), 'conversations/bob_pro'), { ...conv, participants: ['alice', 'pro'] }));
    await assertFails(setDoc(doc(as('alice'), 'conversations/alice_pro/messages/m2'), { senderId: 'pro', text: 'fake' }));
  });
});

describe('feed', () => {
  test('like toggles must pair the counter with the marker doc', async () => {
    const db = as('alice');
    const like = writeBatch(db);
    like.update(doc(db, 'posts/p1'), { likes: increment(1) });
    like.set(doc(db, 'users/alice/likedPosts/p1'), { at: serverTimestamp() });
    await assertSucceeds(like.commit());
    await assertFails(updateDoc(doc(db, 'posts/p1'), { likes: increment(1) })); // no new marker
    await assertFails(updateDoc(doc(as('bob'), 'posts/p1'), { likes: increment(5) }));
  });
  test('comments: own likes only; drafts hidden', async () => {
    await assertSucceeds(updateDoc(doc(as('alice'), 'posts/p1/comments/c1'), { likedBy: arrayUnion('alice') }));
    await assertFails(updateDoc(doc(as('alice'), 'posts/p1/comments/c1'), { likedBy: ['alice', 'bob'] }));
    await assertFails(getDoc(doc(as('alice'), 'posts/draft')));
    await assertSucceeds(getDoc(doc(as('pro'), 'posts/draft')));
  });
  test('only verified pros publish', async () => {
    const post = (uid) => ({ authorId: uid, status: 'published', likes: 0, comments: 0, views: 0, title: 't', body: 'b' });
    await assertSucceeds(setDoc(doc(as('pro'), 'posts/new'), post('pro')));
    await assertFails(setDoc(doc(as('newpro'), 'posts/new2'), post('newpro')));
    await assertFails(setDoc(doc(as('alice'), 'posts/new3'), post('alice')));
  });
});

describe('notifications', () => {
  const n = (from) => ({ type: 'booking', title: 'Hi', body: 'b', targetId: null, senderId: from, unread: true, createdAt: serverTimestamp() });
  test('anyone can notify, but only as themselves', async () => {
    await assertSucceeds(setDoc(doc(as('alice'), 'users/pro/notifications/n1'), n('alice')));
    await assertFails(setDoc(doc(as('alice'), 'users/pro/notifications/n2'), n('bob')));
    await assertFails(getDoc(doc(as('alice'), 'users/pro/notifications/n1')));
  });
  test('owner can only mark read', async () => {
    await env.withSecurityRulesDisabled((c) => setDoc(doc(c.firestore(), 'users/pro/notifications/n1'), n('alice')));
    await assertSucceeds(updateDoc(doc(as('pro'), 'users/pro/notifications/n1'), { unread: false }));
    await assertFails(updateDoc(doc(as('pro'), 'users/pro/notifications/n1'), { title: 'edited' }));
  });
});
