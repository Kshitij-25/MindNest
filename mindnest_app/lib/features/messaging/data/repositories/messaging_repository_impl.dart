import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/error_mapper.dart';
import 'package:mindnest_app/core/error/result.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/repositories/messaging_repository.dart';
import '../datasource/messaging_local_data_source.dart';
import '../mappers/messaging_mappers.dart';

@LazySingleton(as: MessagingRepository)
class MessagingRepositoryImpl implements MessagingRepository {
  MessagingRepositoryImpl(this._local);
  final MessagingLocalDataSource _local;

  @override
  Future<Result<List<Conversation>>> getConversations() async {
    try {
      final models = await _local.getConversations();
      return Ok(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }

  @override
  Future<Result<List<Message>>> getMessages(
    String conversationId, {
    bool asProfessional = false,
  }) async {
    try {
      final models = await _local.getMessages(conversationId);
      var messages = models.map((m) => m.toEntity());
      if (asProfessional) {
        // From the professional's perspective, sender/recipient flip.
        messages = messages.map(
          (m) => Message(
            id: m.id,
            fromMe: !m.fromMe,
            text: m.text,
            time: m.time,
            read: m.read,
          ),
        );
      }
      return Ok(messages.toList());
    } catch (e) {
      return Err(mapErrorToFailure(e));
    }
  }
}
