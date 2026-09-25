// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      verified: json['verified'] as bool? ?? false,
      online: json['online'] as bool? ?? false,
    );

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subtitle': instance.subtitle,
      'verified': instance.verified,
      'online': instance.online,
    };

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as String,
      participant: ParticipantModel.fromJson(
        json['participant'] as Map<String, dynamic>,
      ),
      last: json['last'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      typing: json['typing'] as bool? ?? false,
      sessionTitle: json['sessionTitle'] as String?,
      sessionAt: json['sessionAt'] == null
          ? null
          : DateTime.parse(json['sessionAt'] as String),
      sessionStatus: json['sessionStatus'] as String?,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participant': instance.participant.toJson(),
      'last': instance.last,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'unread': instance.unread,
      'typing': instance.typing,
      'sessionTitle': instance.sessionTitle,
      'sessionAt': instance.sessionAt?.toIso8601String(),
      'sessionStatus': instance.sessionStatus,
    };

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String,
      fromMe: json['fromMe'] as bool,
      text: json['text'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      read: json['read'] as bool? ?? false,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromMe': instance.fromMe,
      'text': instance.text,
      'sentAt': instance.sentAt.toIso8601String(),
      'read': instance.read,
    };
