import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/text.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/common.dart';
import 'package:mindnest_app/core/widgets/controls.dart';
import 'package:mindnest_app/core/widgets/icon.dart';
import 'package:mindnest_app/core/widgets/nav.dart';
import 'package:mindnest_app/core/network/wellness_api.dart';
import 'package:mindnest_app/shared/api/wellness_repo.dart';
import 'package:mindnest_app/shared/sample/wellness_sample.dart';
import 'package:mindnest_app/core/navigation/screen_nav.dart';
import 'package:mindnest_app/core/widgets/loaded.dart';
import 'package:mindnest_app/core/widgets/scroll_page.dart';
import 'package:mindnest_app/core/widgets/wellness.dart';

// ════════════════════ RECOMMENDATION CENTRE ════════════════════

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});
  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  /// id -> 'done' | 'dismissed'
  final _states = <String, String>{};

  /// Records the user's choice locally and reports it to the closed feedback
  /// loop (`POST /recommendations/{id}/feedback`) so future suggestions adapt.
  void _act(String id, String state) {
    setState(() => _states[id] = state);
    final action = state == 'dismissed' ? 'dismissed' : 'completed';
    // Fire-and-forget — UI doesn't block on the feedback round-trip.
    wellnessApi.recommendationFeedback(id, action).ignore();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MvpPage(
      title: 'Recommendations',
      children: [
        Text(
          'Gentle, personalised suggestions based on what your check-ins and journals are showing.',
          style: MnText.callout.copyWith(color: c.ink2, height: 1.5),
        ),
        const SizedBox(height: 18),
        Loaded<List<Rec>>(
          fetch: wellnessRepo.recommendations,
          isEmpty: (all) =>
              all.where((r) => _states[r.id] != 'dismissed').isEmpty,
          emptyIcon: 'checkCircle',
          emptyTitle: 'All caught up',
          emptyBody:
              'New suggestions arrive as we learn more about your week.',
          builder: (context, all) {
            final list =
                all.where((r) => _states[r.id] != 'dismissed').toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final r in list) ...[
                  _RecCard(
                    r: r,
                    done: _states[r.id] == 'done',
                    onOpen: () => context.pushScreen('recDetail', {'id': r.id}),
                    onAction: (v) => _act(r.id, v),
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _RecCard extends StatelessWidget {
  const _RecCard({
    required this.r,
    required this.done,
    required this.onOpen,
    required this.onAction,
  });
  final Rec r;
  final bool done;
  final VoidCallback onOpen;
  final ValueChanged<String> onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final col = context.token(r.color);
    return Opacity(
      opacity: done ? 0.7 : 1,
      child: MnCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onOpen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTile(icon: r.icon, color: col, size: 48),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.kind.toUpperCase(),
                                style: MnText.cap.copyWith(
                                    color: col, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                            const SizedBox(height: 3),
                            Text(r.title, style: MnText.headline),
                          ],
                        ),
                      ),
                      if (done) const Badge2('Done', kind: BadgeKind.accept),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MnCard(
                    kind: MnCardKind.inset,
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MnIcon('info', size: 14, color: c.ink3),
                            const SizedBox(width: 7),
                            Text('WHY THIS',
                                style: MnText.cap.copyWith(
                                    color: c.ink3, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(r.reason, style: MnText.foot.copyWith(color: c.ink2, height: 1.45)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Chip2(r.duration, outline: true, height: 26,
                          leading: MnIcon('clock', size: 13, color: c.ink3)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('· ${r.insight}',
                            style: MnText.cap.copyWith(color: col, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!done) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: MnButton(
                      label: 'Dismiss',
                      variant: MnVariant.secondary,
                      small: true,
                      onPressed: () => onAction('dismissed'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: MnButton(
                      label: 'Mark complete',
                      small: true,
                      onPressed: () => onAction('done'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ════════════════════ RECOMMENDATION DETAIL ════════════════════

class RecDetailScreen extends StatefulWidget {
  const RecDetailScreen({super.key, required this.id});
  final String id;
  @override
  State<RecDetailScreen> createState() => _RecDetailScreenState();
}

class _RecDetailScreenState extends State<RecDetailScreen> {
  String? _feedback;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;

    if (_done) {
      return MnScaffold(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SuccessCheck(),
                const SizedBox(height: 24),
                const Text('Nicely done', style: MnText.title2),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Text('We’ve logged this. Was it helpful?',
                      textAlign: TextAlign.center,
                      style: MnText.body.copyWith(color: c.ink2)),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MnButton(
                      label: 'Helpful',
                      small: true,
                      expand: false,
                      variant: _feedback == 'yes' ? MnVariant.primary : MnVariant.secondary,
                      onPressed: () {
                        setState(() => _feedback = 'yes');
                        wellnessApi
                            .recommendationFeedback(widget.id, 'helpful')
                            .ignore();
                      },
                    ),
                    const SizedBox(width: 10),
                    MnButton(
                      label: 'Not helpful',
                      small: true,
                      expand: false,
                      variant: _feedback == 'no' ? MnVariant.primary : MnVariant.secondary,
                      onPressed: () {
                        setState(() => _feedback = 'no');
                        wellnessApi
                            .recommendationFeedback(widget.id, 'not_helpful')
                            .ignore();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                MnButton(
                  label: 'Back to home',
                  variant: MnVariant.ghost,
                  expand: false,
                  onPressed: () => context.goShellHome(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Loaded<Rec>(
      fetch: () => wellnessRepo.recommendation(widget.id),
      title: 'Recommendation',
      builder: (context, r) {
        final c = context.c;
        final col = context.token(r.color);
        return MnScaffold(
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(title: r.kind, onBack: () => context.popScreen()),
          Expanded(
            child: NoGlow(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        IconTile(icon: r.icon, color: col, size: 72, radius: 20),
                        const SizedBox(height: 16),
                        Text(r.title, textAlign: TextAlign.center, style: MnText.title2),
                        const SizedBox(height: 12),
                        Chip2(r.duration, outline: true,
                            leading: MnIcon('clock', size: 14, color: c.ink3)),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _Section(
                      title: 'Why we’re suggesting this',
                      child: Text(r.reason, style: MnText.body.copyWith(color: c.ink2, height: 1.55)),
                    ),
                    _Section(
                      title: 'Expected benefit',
                      child: Text(r.benefit, style: MnText.body.copyWith(color: c.ink2, height: 1.55)),
                    ),
                    _Section(
                      title: 'Related insight',
                      child: MnCard(
                        kind: MnCardKind.flat,
                        onTap: () => context.pushScreen('insightsHub'),
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            IconTile(icon: 'sparkle', color: c.topic[3], size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(r.insight,
                                  style: MnText.callout.copyWith(
                                      fontWeight: FontWeight.w600, color: c.ink2)),
                            ),
                            MnIcon('chevR', size: 18, color: c.ink4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(22, 12, 22, safeBottom(context) + 22),
            decoration: BoxDecoration(
              color: c.bg,
              border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: MnButton(
                    label: 'Dismiss',
                    variant: MnVariant.secondary,
                    onPressed: () => context.popScreen(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: MnButton(
                    label: 'Start now',
                    onPressed: () {
                      setState(() => _done = true);
                      wellnessApi
                          .recommendationFeedback(widget.id, 'accepted')
                          .ignore();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MnText.title3),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
