import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

@injectable
class GetNotifications implements UseCase<List<AppNotification>, NoParams> {
  const GetNotifications(this._repo);
  final NotificationsRepository _repo;

  @override
  ResultFuture<List<AppNotification>> call(NoParams _) => _repo.getAll();
}

@injectable
class WatchNotifications {
  const WatchNotifications(this._repo);
  final NotificationsRepository _repo;

  Stream<List<AppNotification>> call() => _repo.watch();
}

@injectable
class MarkNotificationRead implements UseCase<void, String> {
  const MarkNotificationRead(this._repo);
  final NotificationsRepository _repo;

  @override
  ResultFuture<void> call(String id) => _repo.markRead(id);
}

@injectable
class MarkAllNotificationsRead implements UseCase<void, NoParams> {
  const MarkAllNotificationsRead(this._repo);
  final NotificationsRepository _repo;

  @override
  ResultFuture<void> call(NoParams _) => _repo.markAllRead();
}
