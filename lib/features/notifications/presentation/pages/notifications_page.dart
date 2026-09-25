import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/app_notification.dart';
import '../bloc/notifications_bloc.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  void _open(BuildContext context, AppNotification n) {
    context.read<NotificationsBloc>().add(NotificationsEvent.opened(n.id));
    switch (n.type) {
      case NotificationType.message:
        context.router.push(ChatRoute(conversationId: n.targetId ?? 'c1'));
      case NotificationType.content:
        context.router.push(PostDetailRoute(postId: n.targetId ?? 'p1'));
      case NotificationType.mood:
        context.router.push(const MoodTrackRoute());
      case NotificationType.booking:
        context.router.push(const SessionsRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationsBloc>()..add(const NotificationsEvent.load()),
      child: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, s) {
          return MnPage(
            maxWidth: 640,
            header: MnNavHeader(
              title: 'Notifications',
              trailing: s.hasUnread
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MnLinkButton(
                        label: 'Mark all',
                        fontSize: 14,
                        onPressed: () => context.read<NotificationsBloc>().add(const NotificationsEvent.allRead()),
                      ),
                    )
                  : null,
            ),
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
            body: s.status.isLoading && s.items.isEmpty
                ? const LoadingView()
                : s.items.isEmpty
                    ? const EmptyState(
                        icon: MnIcons.bell,
                        title: 'You’re all caught up',
                        message: 'Booking updates, messages, and gentle reminders will land here when there’s something new.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Group(label: 'New', items: s.recent, onOpen: (n) => _open(context, n)),
                          _Group(label: 'Earlier', items: s.earlier, onOpen: (n) => _open(context, n)),
                        ],
                      ),
          );
        },
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.label, required this.items, required this.onOpen});
  final String label;
  final List<AppNotification> items;
  final ValueChanged<AppNotification> onOpen;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            child: Text(label.toUpperCase(), style: context.text.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700)),
          ),
          Stagger(spacing: 8, children: [for (final n in items) _Tile(n: n, onTap: () => onOpen(n))]),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.n, required this.onTap});
  final AppNotification n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (icon, color, tint) = switch (n.type) {
      NotificationType.booking => (MnIcons.calendar, c.primary, c.primaryTint),
      NotificationType.message => (MnIcons.message, c.blue, c.blue.withValues(alpha: .14)),
      NotificationType.mood => (MnIcons.heart, c.clay, c.clayTint),
      NotificationType.content => (MnIcons.layers, c.topics[3], c.topics[3].withValues(alpha: .14)),
    };
    return Pressable(
      onTap: onTap,
      semanticLabel: '${n.unread ? 'Unread. ' : ''}${n.title}. ${n.body}',
      child: AnimatedContainer(
        duration: MnMotion.base,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: n.unread ? c.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: n.unread ? MnShadows.sm(c) : const [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTile(size: 44, radius: 13, color: tint, child: MnIcon(icon, size: 21, color: color, stroke: 1.9)),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(n.title, style: context.text.headline.copyWith(fontSize: 15))),
                      Text(timeAgo(n.createdAt), style: context.text.cap.copyWith(color: c.ink3)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(n.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.callout.copyWith(color: c.ink2, height: 1.4)),
                ],
              ),
            ),
            if (n.unread)
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(left: 8, top: 6),
                decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle),
              ),
          ],
        ),
      ),
    );
  }
}
