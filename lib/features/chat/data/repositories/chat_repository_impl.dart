import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_data_source.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._ds);
  final ChatDataSource _ds;

  @override
  ResultFuture<List<Conversation>> getConversations({
    required bool asProfessional,
  }) => guard(
    () async =>
        (await _ds.conversations(asProfessional: asProfessional))
            .map((c) => c.toEntity())
            .toList(),
  );

  @override
  ResultFuture<Conversation> getConversation(String id) =>
      guard(() async => (await _ds.conversation(id)).toEntity());

  @override
  ResultFuture<String> conversationWith(String participantId) =>
      guard(() => _ds.conversationWith(participantId));

  @override
  ResultFuture<List<ChatMessage>> getMessages(String id) => guard(
    () async => (await _ds.messages(id)).map((m) => m.toEntity()).toList(),
  );

  @override
  ResultFuture<ChatMessage> send(String id, String text) =>
      guard(() async => (await _ds.send(id, text)).toEntity());

  @override
  ResultFuture<void> markRead(String id) => guard(() => _ds.markRead(id));

  @override
  Stream<ThreadUpdate> watch(String id) => _ds
      .events(id)
      .map(
        (e) => switch (e) {
          TypingEvent(:final typing) => ThreadTyping(typing),
          MessageEvent(:final message) => ThreadMessage(message.toEntity()),
          ReadEvent() => ThreadRead(),
        },
      );
}
