import '../../../../core/usecase/usecase.dart';
import '../entities/app_notification.dart';

abstract interface class NotificationsRepository {
  ResultFuture<List<AppNotification>> getAll();
  ResultFuture<void> markRead(String id);
  ResultFuture<void> markAllRead();
}
