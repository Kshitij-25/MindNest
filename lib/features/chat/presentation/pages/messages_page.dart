import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/chat_thread_bloc.dart';
import '../bloc/conversations_bloc.dart';
import '../widgets/chat_widgets.dart';

/// Inbox. Phone: list → push thread. Tablet: split list + live thread.
@RoutePage()
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isPro = context.select((AuthBloc b) => b.state.isPro);
    return BlocProvider(
      create: (_) =>
          getIt<ConversationsBloc>()
            ..add(ConversationsEvent.load(asProfessional: isPro)),
      child: ResponsiveLayout(
        phone: (_) => _PhoneInbox(isPro: isPro),
        tablet: (_) => _SplitInbox(isPro: isPro),
      ),
    );
  }
}

class _PhoneInbox extends StatelessWidget {
  const _PhoneInbox({required this.isPro});
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (context, s) {
        return MnPage(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: LargeTitle(
                  title: isPro ? 'Clients' : 'Messages',
                  trailing: MnIconButton(
                    icon: MnIcons.edit,
                    tooltip: 'New message',
                    iconSize: 20,
                    stroke: 1.9,
                    onPressed: isPro
                        ? null
                        : () => context.router.push(const DiscoverRoute()),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (s.status.isLoading && s.conversations.isEmpty)
                const LoadingView()
              else if (s.conversations.isEmpty)
                EmptyState(
                  icon: MnIcons.chat2,
                  title: 'No messages yet',
                  message: 'When you book or connect with a therapist, your conversations will appear here.',
                  actionLabel: isPro ? null : 'Find a therapist',
                  onAction: () => context.router.push(const DiscoverRoute()),
                )
              else
                Stagger(
                  children: [
                    for (final cv in s.conversations)
                      ConversationTile(
                        conversation: cv,
                        onTap: () {
                          context.read<ConversationsBloc>().add(
                            ConversationsEvent.selected(cv.id),
                          );
                          context.router.push(ChatRoute(conversationId: cv.id));
                        },
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SplitInbox extends StatelessWidget {
  const _SplitInbox({required this.isPro});
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (context, s) {
        final sel = s.effectiveSelection;
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Row(
              children: [
                SizedBox(
                  width: context.isWide ? 400 : 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              isPro ? 'Clients' : 'Messages',
                              style: context.text.title2,
                            ),
                            const SizedBox(height: 12),
                            MnSearchField(
                              onChanged: (q) => context
                                  .read<ConversationsBloc>()
                                  .add(ConversationsEvent.queryChanged(q)),
                            ),
                          ],
                        ),
                      ),
                      const Hairline(),
                      Expanded(
                        child: s.status.isLoading && s.conversations.isEmpty
                            ? const LoadingView()
                            : ListView(
                                padding: const EdgeInsets.all(8),
                                children: [
                                  for (final cv in s.visible)
                                    ConversationTile(
                                      conversation: cv,
                                      dense: true,
                                      selected: cv.id == sel,
                                      onTap: () =>
                                          context.read<ConversationsBloc>().add(
                                            ConversationsEvent.selected(cv.id),
                                          ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                const Hairline(vertical: true),
                Expanded(
                  child: sel == null
                      ? const EmptyState(
                          icon: MnIcons.chat2,
                          title: 'No conversation selected',
                          message: 'Choose a conversation to start messaging.',
                        )
                      : BlocProvider(
                          key: ValueKey(sel),
                          create: (_) => getIt<ChatThreadBloc>()
                            ..add(ChatThreadEvent.opened(conversationId: sel)),
                          child: const ChatThreadView(
                            showBack: false,
                            embedded: true,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
