import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/chat_thread_bloc.dart';
import '../widgets/chat_widgets.dart';

/// Opens a thread by [conversationId], or by the other person's id
/// ([therapistId] for clients, a client id for professionals).
@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key, this.conversationId, this.therapistId});

  final String? conversationId;
  final String? therapistId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatThreadBloc>()
        ..add(
          ChatThreadEvent.opened(
            conversationId: conversationId,
            participantId: therapistId,
          ),
        ),
      child: const Scaffold(body: ChatThreadView()),
    );
  }
}
