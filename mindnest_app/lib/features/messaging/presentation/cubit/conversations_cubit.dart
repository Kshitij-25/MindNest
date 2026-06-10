import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/usecases/messaging_usecases.dart';

class ConversationsState extends Equatable {
  const ConversationsState({
    this.status = ViewStatus.initial,
    this.conversations = const [],
    this.failure,
  });
  final ViewStatus status;
  final List<Conversation> conversations;
  final Failure? failure;
  @override
  List<Object?> get props => [status, conversations, failure];
}

@injectable
class ConversationsCubit extends Cubit<ConversationsState> {
  ConversationsCubit(this._getConversations)
    : super(const ConversationsState());
  final GetConversations _getConversations;

  Future<void> load() async {
    emit(const ConversationsState(status: ViewStatus.loading));
    final result = await _getConversations(const NoParams());
    result.fold(
      (failure) =>
          emit(ConversationsState(status: ViewStatus.error, failure: failure)),
      (conversations) => emit(
        ConversationsState(
          status: ViewStatus.loaded,
          conversations: conversations,
        ),
      ),
    );
  }
}
