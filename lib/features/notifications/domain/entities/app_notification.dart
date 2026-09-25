import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

enum NotificationType { booking, message, mood, content }

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required NotificationType type,
    required String title,
    required String body,
    required DateTime createdAt,
    @Default(false) bool unread,
    /// Deep-link target id (conversation, post…), if any.
    String? targetId,
  }) = _AppNotification;
}
