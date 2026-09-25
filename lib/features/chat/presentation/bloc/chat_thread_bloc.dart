import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/chat_usecases.dart';

part 'chat_thread_bloc.freezed.dart';

@freezed
sealed class ChatThreadEvent with _$ChatThreadEvent {
  const factory ChatThreadEvent.opened({
    String? conversationId,
    String? participantId,
  }) = ChatThreadOpened;
  const factory ChatThreadEvent.sent(String text) = ChatThreadSent;
}

@freezed
abstract class ChatThreadState with _$ChatThreadState {
  const factory ChatThreadState({
    @Default(LoadStatus.initial) LoadStatus status,
    Conversation? conversation,
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(false) bool otherTyping,
    String? error,
  }) = _ChatThreadState;
}

@injectable
class ChatThreadBloc extends Bloc<ChatThreadEvent, ChatThreadState> {
  ChatThreadBloc(this._open, this._send, this._watch)
    : super(const ChatThreadState()) {
    on<ChatThreadOpened>(_onOpened, transformer: restartable());
    on<ChatThreadSent>(_onSent, transformer: sequential());
  }

  final OpenConversation _open;
  final SendMessage _send;
  final WatchConversation _watch;

  Future<void> _onOpened(
    ChatThreadOpened e,
    Emitter<ChatThreadState> emit,
  ) async {
    emit(const ChatThreadState(status: LoadStatus.loading));
    final res = await _open(
      OpenConversationParams(
        conversationId: e.conversationId,
        participantId: e.participantId,
      ),
    );
    final opened = res.fold((f) {
      emit(state.copyWith(status: LoadStatus.failure, error: f.message));
      return null;
    }, (r) => r);
    if (opened == null) return;
    final (conv, msgs) = opened;
    emit(
      state.copyWith(
        status: LoadStatus.success,
        conversation: conv,
        messages: msgs,
      ),
    );
    // Live updates for as long as this thread is open.
    await emit.forEach<ThreadUpdate>(
      _watch(conv.id),
      onData: (u) => switch (u) {
        ThreadTyping(:final typing) => state.copyWith(otherTyping: typing),
        ThreadRead() => state.copyWith(
          messages: [
            for (final m in state.messages)
              m.fromMe ? m.copyWith(read: true) : m,
          ],
        ),
        ThreadMessage(:final message) => state.copyWith(
          messages: [...state.messages, message],
        ),
      },
    );
  }

  Future<void> _onSent(ChatThreadSent e, Emitter<ChatThreadState> emit) async {
    final conv = state.conversation;
    if (conv == null) return;
    final res = await _send(SendMessageParams(conv.id, e.text));
    res.fold(
      (f) => emit(state.copyWith(error: f.message)),
      (m) => emit(state.copyWith(messages: [...state.messages, m])),
    );
  }
}
