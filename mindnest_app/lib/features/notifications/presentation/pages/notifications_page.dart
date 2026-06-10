import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/app_notification.dart';
import '../cubit/notifications_cubit.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  ({String icon, Color color, Color tint}) _meta(
    BuildContext context,
    NotificationType type,
  ) {
    final c = context.c;
    return switch (type) {
      NotificationType.booking => (
        icon: 'calendar',
        color: c.primary,
        tint: c.primaryTint,
      ),
      NotificationType.message => (
        icon: 'message',
        color: c.blue,
        tint: tint(c.blue, 0.14),
      ),
      NotificationType.mood => (icon: 'heart', color: c.clay, tint: c.clayTint),
      NotificationType.content => (
        icon: 'layers',
        color: c.topic[3],
        tint: tint(c.topic[3], 0.14),
      ),
    };
  }

  void _open(
    BuildContext context,
    NotificationsCubit cubit,
    AppNotification n,
  ) {
    cubit.markRead(n.id);
    switch (n.type) {
      case NotificationType.message:
        context.pushNamed(RouteNames.chat, pathParameters: {'id': 'c1'});
      case NotificationType.content:
        context.pushNamed(RouteNames.postDetail, pathParameters: {'id': 'p2'});
      case NotificationType.mood:
        context.pushNamed(RouteNames.moodTrack);
      case NotificationType.booking:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsCubit>()..load(),
      child: MnScaffold(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final cubit = context.read<NotificationsCubit>();
            return Column(
              children: [
                SizedBox(height: safeTop(context)),
                NavHeader(
                  title: 'Notifications',
                  onBack: () => context.pop(),
                  right: state.hasUnread
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: LinkBtn(
                            'Mark all',
                            fontSize: 14,
                            onTap: cubit.markAll,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: switch (state.status) {
                    ViewStatus.loaded =>
                      state.items.isEmpty
                          ? const EmptyState(
                              icon: 'bell',
                              title: 'You’re all caught up',
                              body:
                                  'Booking updates, messages, and gentle reminders will land here when there’s something new.',
                            )
                          : NoGlow(
                              child: ListView(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  6,
                                  16,
                                  24,
                                ),
                                children: [
                                  _group(context, cubit, 'New', state.today),
                                  _group(
                                    context,
                                    cubit,
                                    'Earlier',
                                    state.earlier,
                                  ),
                                ],
                              ),
                            ),
                    _ => const AppLoader(),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _group(
    BuildContext context,
    NotificationsCubit cubit,
    String label,
    List<AppNotification> items,
  ) {
    final c = context.c;
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            child: Text(
              label.toUpperCase(),
              style: MnText.cap.copyWith(color: c.ink3, letterSpacing: 0.4),
            ),
          ),
          for (final n in items) _row(context, cubit, n),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    NotificationsCubit cubit,
    AppNotification n,
  ) {
    final c = context.c;
    final m = _meta(context, n.type);
    return Pressable(
      onTap: () => _open(context, cubit, n),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: n.unread ? c.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: n.unread ? c.shSm : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: m.tint,
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: MnIcon(m.icon, size: 21, color: m.color, stroke: 1.9),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          n.title,
                          style: MnText.headline.copyWith(
                            color: c.ink,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(n.time, style: MnText.cap.copyWith(color: c.ink3)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    n.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MnText.callout.copyWith(color: c.ink2, height: 1.4),
                  ),
                ],
              ),
            ),
            if (n.unread)
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(left: 8, top: 6),
                decoration: BoxDecoration(
                  color: c.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
