import 'package:mindnest_app/core/error/result.dart';

import '../entities/conversation.dart';

abstract interface class MessagingRepository {
  Future<Result<List<Conversation>>> getConversations();
  Future<Result<List<Message>>> getMessages(
    String conversationId, {
    bool asProfessional = false,
  });
}
