// OPTIONAL — requires the Blaze plan. Not referenced by firebase.json.
// Sends a real device push for every inbox item the app writes to
// users/{uid}/notifications, honouring users/{uid}.notificationPrefs, and
// prunes dead FCM tokens.
//
// To enable: copy this folder to <repo>/functions, run `npm install` there,
// add `"functions": { "source": "functions" }` to firebase.json and run
// `firebase deploy --only functions`.
const { onDocumentWritten } = require('firebase-functions/v2/firestore');
const { initializeApp } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const { getMessaging } = require('firebase-admin/messaging');

initializeApp();
const PREF = { message: 'messageAlerts', booking: 'sessionReminders', content: 'contentUpdates', mood: 'dailyReminders' };

exports.pushOnNotification = onDocumentWritten('users/{uid}/notifications/{nid}', async (event) => {
  const after = event.data?.after?.data();
  if (!after || after.unread !== true) return;
  const before = event.data.before?.data();
  if (before && before.createdAt?.isEqual?.(after.createdAt)) return; // mark-read etc.

  const db = getFirestore();
  const user = await db.doc(`users/${event.params.uid}`).get();
  const pref = PREF[after.type];
  if (pref && user.get(`notificationPrefs.${pref}`) === false) return;

  const tokens = (await db.collection(`users/${event.params.uid}/fcmTokens`).get()).docs.map((d) => d.id);
  if (!tokens.length) return;
  const res = await getMessaging().sendEachForMulticast({
    tokens,
    notification: { title: after.title, body: after.body },
    data: { type: after.type ?? '', targetId: after.targetId ?? '' },
    apns: { payload: { aps: { sound: 'default' } } },
  });
  await Promise.all(res.responses.map((r, i) =>
    !r.success && r.error?.code === 'messaging/registration-token-not-registered'
      ? db.doc(`users/${event.params.uid}/fcmTokens/${tokens[i]}`).delete()
      : null));
});
