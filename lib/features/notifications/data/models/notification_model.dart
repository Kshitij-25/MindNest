import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/app_notification.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.unread = false,
    this.targetId,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  bool unread;
  final String? targetId;

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  AppNotification toEntity() =>
      AppNotification(id: id, type: type, title: title, body: body, createdAt: createdAt, unread: unread, targetId: targetId);
}
