import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/conversation.dart';
import '../repositories/messaging_repository.dart';

@lazySingleton
class GetConversations implements UseCase<List<Conversation>, NoParams> {
  GetConversations(this._repo);
  final MessagingRepository _repo;
  @override
  Future<Result<List<Conversation>>> call(NoParams params) =>
      _repo.getConversations();
}

class GetMessagesParams extends Equatable {
  const GetMessagesParams(this.conversationId, {this.asProfessional = false});
  final String conversationId;
  final bool asProfessional;
  @override
  List<Object?> get props => [conversationId, asProfessional];
}

@lazySingleton
class GetMessages implements UseCase<List<Message>, GetMessagesParams> {
  GetMessages(this._repo);
  final MessagingRepository _repo;
  @override
  Future<Result<List<Message>>> call(GetMessagesParams params) =>
      _repo.getMessages(
        params.conversationId,
        asProfessional: params.asProfessional,
      );
}
