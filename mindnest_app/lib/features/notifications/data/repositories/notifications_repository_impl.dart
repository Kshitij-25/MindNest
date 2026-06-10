import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl();

  @override
  Future<Result<List<AppNotification>>> getNotifications() async {
    try {
      final raw = await wellnessApi.notifications();
      return Ok(raw.map(_fromJson).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  AppNotification _fromJson(Map<String, dynamic> j) {
    String s(Object? v, [String d = '']) => v is String ? v : d;
    final type = s(j['type']) == 'mood'
        ? NotificationType.mood
        : NotificationType.content;
    return AppNotification(
      id: s(j['id']),
      type: type,
      title: s(j['title']),
      body: s(j['body']),
      time: s(j['relativeTime'], 'now'),
      unread: j['unread'] == true,
    );
  }
}
