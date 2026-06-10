import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

@lazySingleton
class GetNotifications implements UseCase<List<AppNotification>, NoParams> {
  GetNotifications(this._repo);
  final NotificationsRepository _repo;
  @override
  Future<Result<List<AppNotification>>> call(NoParams params) =>
      _repo.getNotifications();
}
