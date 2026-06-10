import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/conversation.dart';
import '../cubit/conversations_cubit.dart';
import 'chat_page.dart';

/// Messages tab (user). Hosted inside the user shell.
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return BlocProvider(
      create: (_) => getIt<ConversationsCubit>()..load(),
      child: Column(
        children: [
          Container(
            color: c.bg,
            padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Messages',
                    style: MnText.title1.copyWith(color: c.ink),
                  ),
                ),
                const NavBtn(icon: 'edit', iconSize: 20, stroke: 1.9),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ConversationsCubit, ConversationsState>(
              builder: (context, state) {
                if (state.status != ViewStatus.loaded) return const AppLoader();
                if (state.conversations.isEmpty) {
                  return EmptyState(
                    icon: 'chat2',
                    title: 'No messages yet',
                    body:
                        'When you book or connect with a therapist, your conversations will appear here.',
                    action: 'Find a therapist',
                    onAction: () => context.pushNamed(RouteNames.discover),
                  );
                }
                return NoGlow(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                    children: [
                      for (final conv in state.conversations)
                        ConversationRow(conversation: conv),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationRow extends StatelessWidget {
  const ConversationRow({
    super.key,
    required this.conversation,
    this.asProfessional = false,
  });
  final Conversation conversation;
  final bool asProfessional;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final conv = conversation;
    return Pressable(
      onTap: () => context.pushNamed(
        RouteNames.chat,
        pathParameters: {'id': conv.id},
        extra: ChatArgs(asProfessional: asProfessional, name: conv.name),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Avatar(conv.name, size: 54, photo: true),
                if (conv.online)
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: c.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: c.bg, width: 2.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(
                          conv.name,
                          style: MnText.headline.copyWith(color: c.ink),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        conv.time,
                        style: MnText.cap.copyWith(
                          color: conv.unread > 0 ? c.primary : c.ink3,
                          fontWeight: conv.unread > 0
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv.typing ? 'typing…' : conv.last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: MnText.callout.copyWith(
                            color: conv.typing
                                ? c.primary
                                : (conv.unread > 0 ? c.ink : c.ink3),
                            fontWeight: conv.unread > 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (conv.unread > 0)
                        Container(
                          constraints: const BoxConstraints(minWidth: 20),
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: c.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${conv.unread}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
