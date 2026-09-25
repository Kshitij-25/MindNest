import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/usecases/chat_usecases.dart';

part 'conversations_bloc.freezed.dart';

@freezed
sealed class ConversationsEvent with _$ConversationsEvent {
  const factory ConversationsEvent.load({required bool asProfessional}) =
      ConversationsLoad;
  const factory ConversationsEvent.selected(String id) = ConversationsSelected;
  const factory ConversationsEvent.queryChanged(String query) =
      ConversationsQueryChanged;
}

@freezed
abstract class ConversationsState with _$ConversationsState {
  const factory ConversationsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default(<Conversation>[]) List<Conversation> conversations,
    String? selectedId,
    @Default('') String query,
    String? error,
  }) = _ConversationsState;

  const ConversationsState._();

  List<Conversation> get visible {
    final q = query.trim().toLowerCase();
    return q.isEmpty
        ? conversations
        : conversations
              .where((c) => c.participant.name.toLowerCase().contains(q))
              .toList();
  }

  String? get effectiveSelection =>
      selectedId ?? (conversations.isEmpty ? null : conversations.first.id);
}

@injectable
class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc(this._get) : super(const ConversationsState()) {
    on<ConversationsLoad>((e, emit) async {
      if (state.conversations.isEmpty) {
        emit(state.copyWith(status: LoadStatus.loading));
      }
      final res = await _get(e.asProfessional);
      res.fold(
        (f) =>
            emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
        (list) => emit(
          state.copyWith(status: LoadStatus.success, conversations: list),
        ),
      );
    });
    on<ConversationsSelected>(
      (e, emit) => emit(
        state.copyWith(
          selectedId: e.id,
          conversations: [
            for (final c in state.conversations)
              c.id == e.id ? c.copyWith(unread: 0) : c,
          ],
        ),
      ),
    );
    on<ConversationsQueryChanged>(
      (e, emit) => emit(state.copyWith(query: e.query)),
    );
  }

  final GetConversations _get;
}
