// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      unread: json['unread'] as bool? ?? false,
      targetId: json['targetId'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt.toIso8601String(),
      'unread': instance.unread,
      'targetId': instance.targetId,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.booking: 'booking',
  NotificationType.message: 'message',
  NotificationType.mood: 'mood',
  NotificationType.content: 'content',
};
