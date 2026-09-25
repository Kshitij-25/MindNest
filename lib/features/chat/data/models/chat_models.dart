import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/conversation.dart';

part 'chat_models.g.dart';

@JsonSerializable()
class ParticipantModel {
  const ParticipantModel({
    required this.id,
    required this.name,
    this.subtitle = '',
    this.verified = false,
    this.online = false,
  });
  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  final String id;
  final String name;
  final String subtitle;
  final bool verified;
  final bool online;

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
  Participant toEntity() => Participant(
    id: id,
    name: name,
    subtitle: subtitle,
    verified: verified,
    online: online,
  );
}

@JsonSerializable()
class ConversationModel {
  ConversationModel({
    required this.id,
    required this.participant,
    required this.last,
    required this.updatedAt,
    this.unread = 0,
    this.typing = false,
    this.sessionTitle,
    this.sessionAt,
    this.sessionStatus,
  });
  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  final String id;
  final ParticipantModel participant;
  String last;
  DateTime updatedAt;
  int unread;
  final bool typing;
  final String? sessionTitle;
  final DateTime? sessionAt;
  final String? sessionStatus;

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  Conversation toEntity() => Conversation(
    id: id,
    participant: participant.toEntity(),
    lastMessage: last,
    updatedAt: updatedAt,
    unread: unread,
    typing: typing,
    session: sessionTitle == null
        ? null
        : SessionContext(
            title: sessionTitle!,
            startsAt: sessionAt!,
            status: sessionStatus ?? 'Accepted',
          ),
  );
}

@JsonSerializable()
class ChatMessageModel {
  ChatMessageModel({
    required this.id,
    required this.fromMe,
    required this.text,
    required this.sentAt,
    this.read = false,
  });
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  final String id;
  final bool fromMe;
  final String text;
  final DateTime sentAt;
  bool read;

  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
  ChatMessage toEntity() => ChatMessage(
    id: id,
    fromMe: fromMe,
    text: text,
    sentAt: sentAt,
    read: read,
  );
}
