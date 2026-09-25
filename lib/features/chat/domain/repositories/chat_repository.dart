import '../../../../core/usecase/usecase.dart';
import '../entities/conversation.dart';

sealed class ThreadUpdate {}

class ThreadTyping extends ThreadUpdate {
  ThreadTyping(this.typing);
  final bool typing;
}

class ThreadMessage extends ThreadUpdate {
  ThreadMessage(this.message);
  final ChatMessage message;
}

class ThreadRead extends ThreadUpdate {}

abstract interface class ChatRepository {
  ResultFuture<List<Conversation>> getConversations({
    required bool asProfessional,
  });
  ResultFuture<Conversation> getConversation(String id);
  ResultFuture<String> conversationWith(String participantId);
  ResultFuture<List<ChatMessage>> getMessages(String conversationId);
  ResultFuture<ChatMessage> send(String conversationId, String text);
  ResultFuture<void> markRead(String conversationId);
  Stream<ThreadUpdate> watch(String conversationId);
}
