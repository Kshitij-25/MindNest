// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    _ConversationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      last: json['last'] as String,
      time: json['time'] as String,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
      online: json['online'] as bool? ?? false,
      typing: json['typing'] as bool? ?? false,
    );

Map<String, dynamic> _$ConversationModelToJson(_ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last': instance.last,
      'time': instance.time,
      'unread': instance.unread,
      'online': instance.online,
      'typing': instance.typing,
    };

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String,
      fromMe: json['fromMe'] as bool,
      text: json['text'] as String,
      time: json['time'] as String,
      read: json['read'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromMe': instance.fromMe,
      'text': instance.text,
      'time': instance.time,
      'read': instance.read,
    };
