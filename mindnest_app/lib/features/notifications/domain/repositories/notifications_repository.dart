import 'package:mindnest_app/core/error/result.dart';

import '../entities/app_notification.dart';

abstract interface class NotificationsRepository {
  Future<Result<List<AppNotification>>> getNotifications();
}
