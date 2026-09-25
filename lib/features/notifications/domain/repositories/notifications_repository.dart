import '../../../../core/usecase/usecase.dart';
import '../entities/app_notification.dart';

abstract interface class NotificationsRepository {
  ResultFuture<List<AppNotification>> getAll();
  /// Live inbox, newest first.
  Stream<List<AppNotification>> watch();
  ResultFuture<void> markRead(String id);
  ResultFuture<void> markAllRead();
}
