// Downloads a professional's verification documents for review.
//   npm run verification -- someone@example.com
// Files are saved to ./verification/<email>/ (git-ignored). After checking
// them, approve with: npm run approve -- someone@example.com
import { mkdirSync, writeFileSync } from 'node:fs';
import { auth, db } from './admin.mjs';

const email = process.argv[2];
if (!email) {
  console.error('Usage: npm run verification -- <email>');
  process.exit(1);
}
const user = await auth.getUserByEmail(email);
const files = await db.collection(`users/${user.uid}/verificationFiles`).get();
if (files.empty) {
  console.log(`${email} hasn't uploaded any documents.`);
  process.exit(0);
}
const dir = new URL(`./verification/${email}/`, import.meta.url);
mkdirSync(dir, { recursive: true });
for (const f of files.docs) {
  const { name, chunks, size } = f.data();
  const parts = [];
  for (let i = 0; i < chunks; i++) {
    const c = await f.ref.collection('chunks').doc(`${i}`).get();
    if (!c.exists) throw new Error(`${f.id}: chunk ${i} missing — ask them to re-upload`);
    parts.push(Buffer.from(c.get('data').toUint8Array?.() ?? c.get('data')));
  }
  const bytes = Buffer.concat(parts);
  if (bytes.length !== size) console.warn(`⚠ ${f.id}: expected ${size} bytes, got ${bytes.length}`);
  const out = new URL(`${f.id}-${name.replace(/[^\w.-]+/g, '_')}`, dir);
  writeFileSync(out, bytes);
  console.log(`✔ ${f.id}: ${out.pathname}`);
}
