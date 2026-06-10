import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

import '../../domain/entities/therapist.dart';

/// Arguments passed via GoRouter `extra` to the booking-success page.
class BookingSuccessArgs {
  const BookingSuccessArgs({
    required this.therapist,
    required this.dayLabel,
    required this.dateLabel,
    required this.slot,
    required this.type,
  });
  final Therapist therapist;
  final String dayLabel, dateLabel, slot, type;
}

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key, required this.args});
  final BookingSuccessArgs args;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final t = args.therapist;
    final rows = [
      ('calendar', '${args.dayLabel}, ${args.dateLabel} June'),
      ('clock', '${args.slot} PM · 50 min'),
      ('video', '${args.type} session'),
    ];
    return MnScaffold(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.75),
          radius: 0.9,
          colors: [c.primaryTint, c.bg],
          stops: const [0, 0.48],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: NoGlow(
              child: ListView(
                padding: EdgeInsets.fromLTRB(24, safeTop(context) + 20, 24, 0),
                children: [
                  Column(
                    children: [
                      const SuccessCheck(),
                      const SizedBox(height: 26),
                      Text(
                        'Request sent',
                        style: MnText.title1.copyWith(color: c.ink),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 290),
                        child: Text(
                          'We’ve let ${t.firstName} know. You’ll be notified the moment it’s confirmed.',
                          textAlign: TextAlign.center,
                          style: MnText.body.copyWith(color: c.ink2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Badge2(
                        'Pending confirmation',
                        kind: BadgeKind.pending,
                        height: 28,
                        fontSize: 13,
                        leading: MnIcon(
                          'clock',
                          size: 14,
                          color: c.amber,
                          stroke: 2.2,
                        ),
                      ),
                      const SizedBox(height: 26),
                      MnCard(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: SizedBox(
                                    width: 46,
                                    height: 46,
                                    child: PhotoPlaceholder(t.name),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.name,
                                      style: MnText.headline.copyWith(
                                        color: c.ink,
                                      ),
                                    ),
                                    Text(
                                      t.spec,
                                      style: MnText.foot.copyWith(
                                        color: c.ink2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            for (final r in rows)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7,
                                ),
                                child: Row(
                                  children: [
                                    MnIcon(
                                      r.$1,
                                      size: 18,
                                      color: c.primary,
                                      stroke: 1.9,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      r.$2,
                                      style: MnText.callout.copyWith(
                                        color: c.ink2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, safeBottom(context) + 16),
            child: Column(
              children: [
                MnButton(
                  label: 'Message ${t.firstName}',
                  onPressed: () => context.pushNamed(
                    RouteNames.chat,
                    pathParameters: {'id': 'c1'},
                  ),
                ),
                const SizedBox(height: 10),
                MnButton(
                  label: 'Back to home',
                  variant: MnVariant.ghost,
                  onPressed: () => context.goNamed(RouteNames.userShell),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
