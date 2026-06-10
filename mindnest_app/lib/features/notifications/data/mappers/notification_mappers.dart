import '../../domain/entities/app_notification.dart';
import '../models/notification_model.dart';

extension NotificationModelX on NotificationModel {
  AppNotification toEntity() => AppNotification(
    id: id,
    type: NotificationType.values.firstWhere(
      (t) => t.name == type,
      orElse: () => NotificationType.content,
    ),
    title: title,
    body: body,
    time: time,
    unread: unread,
  );
}
