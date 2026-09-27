// Moderation queue for user reports (posts, comments, chats, profiles).
//   npm run reports                          list open reports with the reported content
//   npm run reports -- resolve <id> [note]   mark a report handled
//   npm run reports -- remove <id> [note]    delete the reported post/comment, then resolve
// App Store / Play policy: act on reports promptly (we promise users 24 hours).
import { FieldValue } from 'firebase-admin/firestore';
import { db } from './admin.mjs';

const [cmd, id, ...rest] = process.argv.slice(2);
const note = rest.join(' ');

async function resolve(ref, action) {
  await ref.update({ status: 'resolved', action, note, resolvedAt: FieldValue.serverTimestamp() });
  console.log(`✔ report ${ref.id} ${action}`);
}

if (cmd === 'resolve' || cmd === 'remove') {
  const ref = db.doc(`reports/${id}`);
  const report = await ref.get();
  if (!report.exists) throw new Error(`No report ${id}`);
  if (cmd === 'remove') {
    const { targetType, targetPath } = report.data();
    if (!['post', 'comment'].includes(targetType)) throw new Error('Only posts and comments can be removed; resolve it instead.');
    await db.doc(targetPath).delete();
    if (targetType === 'comment') {
      await db.doc(targetPath.split('/comments/')[0]).update({ comments: FieldValue.increment(-1) });
    }
    console.log(`✔ deleted ${targetPath}`);
  }
  await resolve(ref, cmd === 'remove' ? 'removed' : 'no action');
  process.exit(0);
}

const open = await db.collection('reports').where('status', '==', 'open').orderBy('createdAt').get();
if (open.empty) console.log('No open reports.');
for (const r of open.docs) {
  const d = r.data();
  const target = await db.doc(d.targetPath).get().catch(() => null);
  const t = target?.data() ?? {};
  const excerpt = (t.text ?? t.title ?? t.name ?? '(no longer exists)').toString().slice(0, 200);
  console.log(
    `\n[${r.id}] ${d.reason.toUpperCase()} · ${d.targetType} by ${d.targetOwnerName} (${d.targetOwnerId})` +
      `\n  when:    ${d.createdAt?.toDate().toISOString() ?? '?'}` +
      `\n  path:    ${d.targetPath}` +
      `\n  content: ${excerpt}` +
      (d.details ? `\n  details: ${d.details}` : ''),
  );
  if (d.reason === 'selfHarm') console.log('  ⚠ self-harm concern — review first');
}
