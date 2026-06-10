import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/features/messaging/presentation/pages/chat_page.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/professional.dart';
import '../cubit/pro_clients_cubit.dart';

/// Clients tab. Hosted inside the pro shell.
class ProClientsPage extends StatelessWidget {
  const ProClientsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProClientsCubit>()..load(),
    child: const _ClientsView(),
  );
}

class _ClientsView extends StatelessWidget {
  const _ClientsView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<ProClientsCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
          child: Text('Clients', style: MnText.title1.copyWith(color: c.ink)),
        ),
        Expanded(
          child: BlocBuilder<ProClientsCubit, ProClientsState>(
            builder: (context, state) {
              if (state.status == ViewStatus.loading ||
                  state.status == ViewStatus.initial) {
                return const AppLoader();
              }
              if (state.status == ViewStatus.error) {
                return AppErrorView(
                  failure: state.failure!,
                  onRetry: cubit.load,
                );
              }
              if (state.clients.isEmpty) {
                return const EmptyState(
                  icon: 'user',
                  title: 'No clients yet',
                  body:
                      'When clients book and message you, they’ll show up here.',
                );
              }
              return NoGlow(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                  children: [
                    for (final client in state.clients)
                      _ClientRow(client: client),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ClientRow extends StatelessWidget {
  const _ClientRow({required this.client});
  final ProClient client;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cl = client;
    return Pressable(
      onTap: () => context.pushNamed(
        RouteNames.chat,
        pathParameters: {'id': cl.id},
        extra: ChatArgs(asProfessional: true, name: cl.name),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Avatar(cl.name, size: 54, photo: true),
                if (cl.online)
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
                          cl.name,
                          style: MnText.headline.copyWith(color: c.ink),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cl.time,
                        style: MnText.cap.copyWith(
                          color: cl.unread > 0 ? c.primary : c.ink3,
                          fontWeight: cl.unread > 0
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
                          cl.last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: MnText.callout.copyWith(
                            color: cl.unread > 0 ? c.ink : c.ink3,
                            fontWeight: cl.unread > 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (cl.unread > 0)
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
                            '${cl.unread}',
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
