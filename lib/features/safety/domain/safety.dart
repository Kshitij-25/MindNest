import '../../../core/usecase/usecase.dart';

enum ReportTarget { post, comment, message, user }

enum ReportReason {
  harassment('Harassment or bullying'),
  hate('Hate speech or abuse'),
  selfHarm('Someone may be at risk of self-harm'),
  spam('Spam or scam'),
  inappropriate('Sexual or inappropriate content'),
  impersonation('Fake credentials or impersonation'),
  other('Something else');

  const ReportReason(this.label);
  final String label;
}

/// What's being reported. [path] is the Firestore document the moderator
/// should look at; [ownerId] is who wrote it.
class ReportSubject {
  const ReportSubject({required this.type, required this.path, required this.ownerId, required this.ownerName});
  final ReportTarget type;
  final String path;
  final String ownerId;
  final String ownerName;
}

class BlockedUser {
  const BlockedUser({required this.id, required this.name, required this.blockedAt});
  final String id;
  final String name;
  final DateTime blockedAt;
}

abstract interface class SafetyRepository {
  ResultFuture<void> report(ReportSubject subject, ReportReason reason, String details);
  ResultFuture<void> block(String userId, String name);
  ResultFuture<void> unblock(String userId);
  ResultFuture<List<BlockedUser>> blockedUsers();
  ResultFuture<bool> isBlocked(String userId);
}
