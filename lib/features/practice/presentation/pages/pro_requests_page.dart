import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/requests_bloc.dart';
import '../widgets/request_card.dart';

@RoutePage()
class ProRequestsPage extends StatelessWidget {
  const ProRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RequestsBloc>()..add(const RequestsEvent.load()),
      child: BlocBuilder<RequestsBloc, RequestsState>(
        builder: (context, s) {
          final bloc = context.read<RequestsBloc>();
          final pending = s.requests.where((r) => r.status == RequestStatus.pending).toList();
          final handled = s.requests.where((r) => r.status != RequestStatus.pending).toList();
          Widget card(SessionRequest r) => RequestCard(
                request: r,
                onOpen: () => context.router.push(ProRequestDetailRoute(requestId: r.id)),
                onRespond: (st) {
                  Adaptive.success(context);
                  bloc.add(RequestsEvent.responded(r.id, st));
                },
              );
          return MnPage(
            maxWidth: 1000,
            padding: EdgeInsets.fromLTRB(context.gutter, 16, context.gutter, 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LargeTitle(title: 'Booking requests'),
                const SizedBox(height: 4),
                Text(
                  pending.isEmpty ? 'You’re all caught up.' : '${pending.length} awaiting your response',
                  style: context.text.sub.copyWith(color: context.colors.ink3),
                ),
                const SizedBox(height: 16),
                if (s.status.isLoading && s.requests.isEmpty)
                  const LoadingView()
                else if (s.requests.isEmpty)
                  const EmptyState(icon: MnIcons.calendar, title: 'No requests yet', message: 'New booking requests from clients will appear here.')
                else ...[
                  ResponsiveGrid(
                    columns: responsive(context, phone: 1, tablet: 2),
                    spacing: 14,
                    runSpacing: 14,
                    children: [for (final r in pending) FadeUp(child: card(r))],
                  ),
                  if (handled.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Handled'),
                    ResponsiveGrid(
                      columns: responsive(context, phone: 1, tablet: 2),
                      spacing: 14,
                      runSpacing: 14,
                      children: [for (final r in handled) card(r)],
                    ),
                  ],
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
