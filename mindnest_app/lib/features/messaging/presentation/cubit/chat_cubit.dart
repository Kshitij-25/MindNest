import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/usecases/messaging_usecases.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.typing = false,
    this.name = '',
  });
  final List<Message> messages;
  final bool typing;
  final String name;

  ChatState copyWith({List<Message>? messages, bool? typing, String? name}) =>
      ChatState(
        messages: messages ?? this.messages,
        typing: typing ?? this.typing,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [messages, typing, name];
}

@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._getMessages) : super(const ChatState());
  final GetMessages _getMessages;

  static const _replies = [
    'That makes a lot of sense. Thank you for sharing that with me.',
    'I hear you. Let’s gently unpack that together.',
    'You’re doing the work, and it shows. 🌱',
  ];

  Future<void> load({
    required String conversationId,
    required bool asPro,
    required String fallbackName,
  }) async {
    final result = await _getMessages(
      GetMessagesParams(conversationId, asProfessional: asPro),
    );
    final messages = result.valueOrNull ?? const <Message>[];
    emit(
      ChatState(
        messages: messages,
        name: asPro ? 'Jordan Mills' : fallbackName,
      ),
    );
  }

  void send(String text, String time) {
    if (text.trim().isEmpty) return;
    final mine = Message(
      id: 'x${DateTime.now().millisecondsSinceEpoch}',
      fromMe: true,
      text: text.trim(),
      time: time,
    );
    emit(state.copyWith(messages: [...state.messages, mine]));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (isClosed) return;
      emit(state.copyWith(typing: true));
    });
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (isClosed) return;
      final read = state.messages
          .map((m) => m.fromMe ? m.copyWith(read: true) : m)
          .toList();
      final reply = Message(
        id: 'r${DateTime.now().millisecondsSinceEpoch}',
        fromMe: false,
        text: _replies[Random().nextInt(_replies.length)],
        time: time,
      );
      emit(state.copyWith(typing: false, messages: [...read, reply]));
    });
  }
}
