// Approves a professional's verification so they appear in the directory.
//   npm run approve -- someone@example.com
import { auth, db } from './admin.mjs';

const email = process.argv[2];
if (!email) {
  console.error('Usage: npm run approve -- <email>');
  process.exit(1);
}
const user = await auth.getUserByEmail(email);
const profile = await db.doc(`users/${user.uid}`).get();
if (profile.get('role') !== 'professional') {
  console.error(`${email} is not a professional account.`);
  process.exit(1);
}
await db.batch()
  .update(db.doc(`users/${user.uid}`), { verification: 'verified' })
  .set(db.doc(`therapists/${user.uid}`), { verified: true, verifiedAt: new Date() }, { merge: true })
  .commit();
console.log(`✔ ${email} is verified and listed in the directory.`);
