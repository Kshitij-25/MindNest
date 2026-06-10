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
import '../cubit/pro_requests_cubit.dart';

class ProRequestDetailPage extends StatelessWidget {
  const ProRequestDetailPage({super.key, required this.requestId});
  final String requestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProRequestsCubit>()..load(),
      child: BlocBuilder<ProRequestsCubit, ProRequestsState>(
        builder: (context, state) {
          if (state.status == ViewStatus.error) {
            return MnScaffold(
              child: Column(
                children: [
                  SizedBox(height: safeTop(context)),
                  NavHeader(title: 'Request', onBack: () => context.pop()),
                  Expanded(
                    child: AppErrorView(
                      failure: state.failure!,
                      onRetry: () => context.read<ProRequestsCubit>().load(),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.status != ViewStatus.loaded) {
            return const MnScaffold(child: AppLoader());
          }
          final request = state.requests.firstWhere(
            (r) => r.id == requestId,
            orElse: () => state.requests.first,
          );
          return _DetailView(request: request);
        },
      ),
    );
  }
}

class _DetailView extends StatefulWidget {
  const _DetailView({required this.request});
  final BookingRequest request;
  @override
  State<_DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<_DetailView> {
  late String _status = widget.request.status;

  void _openChat() => context.pushNamed(
    RouteNames.chat,
    pathParameters: {'id': 'c1'},
    extra: ChatArgs(asProfessional: true, name: widget.request.name),
  );

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final r = widget.request;
    final pending = _status == 'Pending';
    final rows = [
      ('calendar', 'Requested time', r.when),
      ('clock', 'Duration', '${r.mins} minutes'),
      ('brain', 'Focus', r.reason),
      ('video', 'Type', 'Video session'),
    ];
    return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(title: 'Request', onBack: () => context.pop()),
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
                children: [
                  MnCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Avatar(r.name, size: 76, photo: true),
                        const SizedBox(height: 14),
                        Text(
                          r.name,
                          style: MnText.title3.copyWith(color: c.ink),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'New client',
                          style: MnText.foot.copyWith(color: c.ink3),
                        ),
                        if (!pending) ...[
                          const SizedBox(height: 12),
                          Badge2(
                            _status == 'Accepted' ? 'Accepted' : 'Declined',
                            kind: _status == 'Accepted'
                                ? BadgeKind.accept
                                : BadgeKind.reject,
                            height: 26,
                            fontSize: 12.5,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  MnCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < rows.length; i++) ...[
                          if (i > 0) const Hairline(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: c.primaryTint,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  alignment: Alignment.center,
                                  child: MnIcon(
                                    rows[i].$1,
                                    size: 18,
                                    color: c.primary,
                                    stroke: 1.9,
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Text(
                                    rows[i].$2,
                                    style: MnText.foot.copyWith(color: c.ink3),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    rows[i].$3,
                                    textAlign: TextAlign.right,
                                    style: MnText.foot.copyWith(
                                      color: c.ink,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  MnCard(
                    kind: MnCardKind.flat,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOTE FROM CLIENT',
                          style: MnText.cap.copyWith(color: c.ink3),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '“I’ve been feeling overwhelmed at work and my sleep has slipped. I’d love some help building a calmer routine and managing the anxious spirals.”',
                          style: MnText.callout.copyWith(
                            color: c.ink2,
                            height: 1.55,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, safeBottom(context) + 12),
            decoration: BoxDecoration(
              color: c.bg.withValues(alpha: 0.95),
              border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
            ),
            child: pending
                ? Column(
                    children: [
                      MnButton(
                        label: 'Accept request',
                        onPressed: () => setState(() => _status = 'Accepted'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: MnButton(
                              label: 'Reschedule',
                              variant: MnVariant.secondary,
                              onPressed: () =>
                                  setState(() => _status = 'Accepted'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MnButton(
                              label: 'Decline',
                              variant: MnVariant.secondary,
                              foreground: c.red,
                              onPressed: () =>
                                  setState(() => _status = 'Rejected'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : MnButton(
                    label: 'Message ${r.firstName}',
                    onPressed: _openChat,
                  ),
          ),
        ],
      ),
    );
  }
}
