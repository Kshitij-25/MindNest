import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/chat_repository.dart';

@injectable
class GetConversations implements UseCase<List<Conversation>, bool> {
  const GetConversations(this._repo);
  final ChatRepository _repo;

  /// [asProfessional] selects the practitioner inbox.
  @override
  ResultFuture<List<Conversation>> call(bool asProfessional) =>
      _repo.getConversations(asProfessional: asProfessional);
}

@injectable
class OpenConversation
    implements
        UseCase<(Conversation, List<ChatMessage>), OpenConversationParams> {
  const OpenConversation(this._repo);
  final ChatRepository _repo;

  @override
  ResultFuture<(Conversation, List<ChatMessage>)> call(
    OpenConversationParams p,
  ) async {
    String? id = p.conversationId;
    if (id == null && p.participantId != null) {
      final r = await _repo.conversationWith(p.participantId!);
      id = r.toNullable();
    }
    if (id == null) return const Left(NotFoundFailure('No conversation yet.'));
    final conv = await _repo.getConversation(id);
    final msgs = await _repo.getMessages(id);
    await _repo.markRead(id);
    return conv.flatMap((c) => msgs.map((m) => (c, m)));
  }
}

class OpenConversationParams extends Equatable {
  const OpenConversationParams({this.conversationId, this.participantId});
  final String? conversationId;
  final String? participantId;

  @override
  List<Object?> get props => [conversationId, participantId];
}

class SendMessageParams extends Equatable {
  const SendMessageParams(this.conversationId, this.text);
  final String conversationId;
  final String text;

  @override
  List<Object?> get props => [conversationId, text];
}

@injectable
class SendMessage implements UseCase<ChatMessage, SendMessageParams> {
  const SendMessage(this._repo);
  final ChatRepository _repo;

  @override
  ResultFuture<ChatMessage> call(SendMessageParams p) async {
    final text = p.text.trim();
    if (text.isEmpty) return const Left(ValidationFailure('Message is empty.'));
    return _repo.send(p.conversationId, text);
  }
}

@injectable
class WatchConversation {
  const WatchConversation(this._repo);
  final ChatRepository _repo;

  Stream<ThreadUpdate> call(String conversationId) =>
      _repo.watch(conversationId);
}
