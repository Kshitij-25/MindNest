// Shared Admin SDK bootstrap. Credentials: ./service-account.json (Firebase
// console → Project settings → Service accounts → Generate new private key)
// or GOOGLE_APPLICATION_CREDENTIALS. The Admin SDK bypasses security rules.
import { existsSync, readFileSync } from 'node:fs';
import { cert, initializeApp, applicationDefault } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getFirestore } from 'firebase-admin/firestore';

const keyFile = new URL('./service-account.json', import.meta.url);
const emulator = !!process.env.FIRESTORE_EMULATOR_HOST;
if (!emulator && !existsSync(keyFile) && !process.env.GOOGLE_APPLICATION_CREDENTIALS) {
  console.error(
    'Missing admin credentials.\n' +
      'Firebase console → Project settings → Service accounts → Generate new private key,\n' +
      'then save it as tool/firebase/service-account.json (git-ignored).',
  );
  process.exit(1);
}
initializeApp({
  ...(emulator ? {} : { credential: existsSync(keyFile) ? cert(JSON.parse(readFileSync(keyFile, 'utf8'))) : applicationDefault() }),
  projectId: 'mental-health-cecad',
});

export const auth = getAuth();
export const db = getFirestore();
