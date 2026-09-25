import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/practice_entities.dart';
import '../bloc/requests_bloc.dart';
import '../widgets/practice_widgets.dart';

@RoutePage()
class ProRequestDetailPage extends StatelessWidget {
  const ProRequestDetailPage({super.key, @PathParam('id') required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocProvider.value(
      value: getIt<RequestsBloc>(),
      child: BlocBuilder<RequestsBloc, RequestsState>(
        builder: (context, s) {
          final r = s.byId(requestId);
          if (r == null) return const Scaffold(body: LoadingView());
          final bloc = context.read<RequestsBloc>();
          void respond(RequestStatus st) {
            Adaptive.success(context);
            bloc.add(RequestsEvent.responded(r.id, st));
          }

          final rows = [
            (MnIcons.calendar, 'Requested time', whenLabel(r.requestedAt)),
            (MnIcons.clock, 'Duration', '${r.minutes} minutes'),
            (MnIcons.brain, 'Focus', r.reason),
            (MnIcons.video, 'Type', '${r.type} session'),
          ];
          return MnPage(
            maxWidth: 600,
            header: const MnNavHeader(title: 'Request'),
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeUp(
                  child: MnCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        MnAvatar(name: r.clientName, size: 76, photo: true),
                        const SizedBox(height: 14),
                        Text(r.clientName, style: context.text.title3),
                        const SizedBox(height: 2),
                        Text(r.newClient ? 'New client' : 'Returning client', style: context.text.callout.copyWith(color: c.ink2)),
                        if (r.status != RequestStatus.pending) ...[
                          const SizedBox(height: 12),
                          MnBadge.status(r.status.label),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                MnCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      for (final (i, row) in rows.indexed) ...[
                        if (i > 0) const Hairline(indent: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                          child: Row(
                            children: [
                              IconTile(size: 32, radius: 9, child: MnIcon(row.$1, size: 17, color: c.primary)),
                              const SizedBox(width: 13),
                              Expanded(child: Text(row.$2, style: context.text.callout.copyWith(color: c.ink2))),
                              Flexible(child: Text(row.$3, textAlign: TextAlign.right, style: context.text.headline)),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                MnCard(
                  style: MnCardStyle.flat,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NOTE FROM CLIENT', style: context.text.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text('“${r.note}”', style: context.text.body.copyWith(color: c.ink2, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
            bottom: r.status == RequestStatus.pending
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MnButton(label: 'Accept request', onPressed: () => respond(RequestStatus.accepted)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: MnButton.secondary(
                              label: 'Reschedule',
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Suggested new times sent to ${r.clientName.split(' ').first}')),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MnButton(
                              label: 'Decline',
                              variant: MnButtonVariant.danger,
                              onPressed: () async {
                                final ok = await Adaptive.confirm(
                                  context,
                                  title: 'Decline this request?',
                                  message: '${r.clientName.split(' ').first} will be notified.',
                                  confirmLabel: 'Decline',
                                  destructive: true,
                                );
                                if (ok) respond(RequestStatus.declined);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : MnButton(
                    label: 'Message ${r.clientName.split(' ').first}',
                    onPressed: () => context.router.push(ChatRoute(therapistId: r.clientId)),
                  ),
          );
        },
      ),
    );
  }
}
