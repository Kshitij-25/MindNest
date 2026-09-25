import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_data_source.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._ds);
  final NotificationsDataSource _ds;

  @override
  ResultFuture<List<AppNotification>> getAll() =>
      guard(() async => (await _ds.list()).map((n) => n.toEntity()).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)));

  @override
  ResultFuture<void> markRead(String id) => guard(() => _ds.markRead(id));

  @override
  ResultFuture<void> markAllRead() => guard(() => _ds.markAllRead());
}
