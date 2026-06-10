import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/di/injection.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';
import 'package:mindnest_app/shared/models/view_status.dart';
import 'package:mindnest_app/shared/widgets/app_error_view.dart';
import 'package:mindnest_app/shared/widgets/app_loader.dart';

import '../../domain/entities/professional.dart';
import '../cubit/pro_requests_cubit.dart';

/// Booking requests tab. Hosted inside the pro shell.
class ProRequestsPage extends StatelessWidget {
  const ProRequestsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ProRequestsCubit>()..load(),
    child: const _RequestsView(),
  );
}

class _RequestsView extends StatelessWidget {
  const _RequestsView();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final cubit = context.read<ProRequestsCubit>();
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
          child: Text(
            'Booking requests',
            style: MnText.title1.copyWith(color: c.ink),
          ),
        ),
        Expanded(
          child: BlocBuilder<ProRequestsCubit, ProRequestsState>(
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
              if (state.requests.isEmpty) {
                return const EmptyState(
                  icon: 'bell',
                  title: 'No requests',
                  body: 'New booking requests from clients will appear here.',
                );
              }
              return NoGlow(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: state.requests.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => _RequestCard(
                    request: state.requests[i],
                    status: state.statusOf(state.requests[i]),
                    cubit: cubit,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.request,
    required this.status,
    required this.cubit,
  });
  final BookingRequest request;
  final String status;
  final ProRequestsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final r = request;
    final pending = status == 'Pending';
    return MnCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: pending
                ? () => context.pushNamed(
                    RouteNames.proRequestDetail,
                    pathParameters: {'id': r.id},
                  )
                : null,
            child: Row(
              children: [
                Avatar(r.name, size: 50, photo: true),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.name,
                        style: MnText.headline.copyWith(color: c.ink),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        r.reason,
                        style: MnText.foot.copyWith(color: c.ink2),
                      ),
                    ],
                  ),
                ),
                if (!pending)
                  Badge2(
                    status == 'Accepted' ? 'Accepted' : 'Declined',
                    kind: status == 'Accepted'
                        ? BadgeKind.accept
                        : BadgeKind.reject,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          MnCard(
            kind: MnCardKind.inset,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                MnIcon('calendar', size: 17, color: c.primary, stroke: 1.9),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    r.when,
                    style: MnText.foot.copyWith(
                      color: c.ink2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: c.ink4,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${r.mins} min',
                  style: MnText.foot.copyWith(color: c.ink3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (pending)
            Row(
              children: [
                Expanded(
                  child: MnButton(
                    label: 'Decline',
                    variant: MnVariant.secondary,
                    small: true,
                    foreground: c.red,
                    onPressed: () => cubit.act(r.id, 'Rejected'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MnButton(
                    label: 'Reschedule',
                    variant: MnVariant.outline,
                    small: true,
                    onPressed: () => cubit.act(r.id, 'Accepted'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MnButton(
                    label: 'Accept',
                    small: true,
                    onPressed: () => cubit.act(r.id, 'Accepted'),
                  ),
                ),
              ],
            )
          else
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MnIcon(
                    status == 'Accepted' ? 'check' : 'x',
                    size: 15,
                    color: status == 'Accepted' ? c.green : c.red,
                    stroke: 2.2,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    status == 'Accepted'
                        ? 'Session confirmed — added to your calendar'
                        : 'Request declined',
                    style: MnText.foot.copyWith(color: c.ink3),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
