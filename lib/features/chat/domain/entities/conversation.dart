import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';

@freezed
abstract class Participant with _$Participant {
  const factory Participant({
    required String id,
    required String name,
    @Default('') String subtitle,
    @Default(false) bool verified,
    @Default(false) bool online,
  }) = _Participant;
}

@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required Participant participant,
    required String lastMessage,
    required DateTime updatedAt,
    @Default(0) int unread,
    @Default(false) bool typing,

    /// Optional booking context pinned at the top of the thread.
    SessionContext? session,
  }) = _Conversation;
}

@freezed
abstract class SessionContext with _$SessionContext {
  const factory SessionContext({
    required String title,
    required DateTime startsAt,
    required String status,
  }) = _SessionContext;
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required bool fromMe,
    required String text,
    required DateTime sentAt,
    @Default(false) bool read,
  }) = _ChatMessage;
}
