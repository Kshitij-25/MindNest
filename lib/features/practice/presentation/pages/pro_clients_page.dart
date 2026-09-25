import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../shell/presentation/shell_tabs.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/clients_cubit.dart';
import '../widgets/client_detail_view.dart';
import '../widgets/practice_widgets.dart';

void _message(BuildContext context, Client c) => context.router.push(ChatRoute(therapistId: c.id));

/// Client roster with private notes. Tablet: split list + detail.
@RoutePage()
class ProClientsPage extends StatelessWidget {
  const ProClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClientsCubit>()..load(),
      child: BlocBuilder<ClientsCubit, ClientsState>(
        builder: (context, s) {
          final cubit = context.read<ClientsCubit>();
          Widget list({required bool split}) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            if (isPushedPage(context)) ...[
                              MnIconButton(icon: MnIcons.back, tooltip: 'Back', onPressed: () => context.router.maybePop()),
                              const SizedBox(width: 4),
                            ],
                            Text('Clients', style: split ? context.text.title2 : context.text.title1),
                          ],
                        ),
                        const SizedBox(height: 12),
                        MnSearchField(hint: 'Search clients', onChanged: cubit.search),
                      ],
                    ),
                  ),
                  if (split) const Hairline(),
                  Expanded(
                    child: s.status.isLoading
                        ? const LoadingView()
                        : ListView(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8 + MediaQuery.paddingOf(context).bottom),
                            children: [
                              for (final cl in s.visible)
                                _ClientTile(
                                  client: cl,
                                  selected: split && cl.id == s.effectiveSelection,
                                  onTap: () => split
                                      ? cubit.select(cl.id)
                                      : context.router.push(ProClientDetailRoute(clientId: cl.id)),
                                ),
                            ],
                          ),
                  ),
                ],
              );

          return Scaffold(
            body: SafeArea(
              bottom: false,
              child: ResponsiveLayout(
                phone: (_) => list(split: false),
                tablet: (context) => Row(
                  children: [
                    SizedBox(width: context.isWide ? 380 : 320, child: list(split: true)),
                    Container(width: .5, color: context.colors.hairline),
                    Expanded(
                      child: s.effectiveSelection == null
                          ? const SizedBox()
                          : BlocProvider(
                              key: ValueKey(s.effectiveSelection),
                              create: (_) => getIt<ClientDetailCubit>()..load(s.effectiveSelection!),
                              child: ClientDetailView(onMessage: (c) => _message(context, c)),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ClientTile extends StatelessWidget {
  const _ClientTile({required this.client, required this.selected, required this.onTap});
  final Client client;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .98,
      semanticLabel: '${client.name}, ${client.focus}, ${client.status.label}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(color: selected ? c.primaryTint : Colors.transparent, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            MnAvatar(name: client.name, size: 46, photo: true, online: client.online),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client.name, style: context.text.sub.copyWith(fontWeight: FontWeight.w700)),
                  Text(client.focus, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.text.cap.copyWith(color: c.ink3)),
                ],
              ),
            ),
            Container(width: 8, height: 8, decoration: BoxDecoration(color: clientStatusColor(c, client.status), shape: BoxShape.circle)),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class ProClientDetailPage extends StatelessWidget {
  const ProClientDetailPage({super.key, @PathParam('id') required this.clientId});
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClientDetailCubit>()..load(clientId),
      child: Scaffold(
        body: Column(
          children: [
            const MnNavHeader(title: 'Client'),
            Expanded(
              child: ClientDetailView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                onMessage: (c) => _message(context, c),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
