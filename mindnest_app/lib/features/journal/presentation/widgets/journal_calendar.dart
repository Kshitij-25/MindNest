import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

/// Month grid with mood-colored days (mock data).
class JournalCalendar extends StatelessWidget {
  const JournalCalendar({super.key, required this.onPick});
  final VoidCallback onPick;

  static const moods = {
    26: 4,
    28: 2,
    29: 3,
    30: 5,
    31: 4,
    24: 4,
    22: 3,
    19: 4,
    17: 5,
    14: 2,
    12: 4,
    9: 3,
    5: 4,
  };

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final days = <int?>[
      for (var i = 0; i < 3; i++) null,
      for (var d = 1; d <= 31; d++) d,
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        MnCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'May 2025',
                      style: MnText.title3.copyWith(color: c.ink),
                    ),
                  ),
                  const NavBtn(
                    icon: 'chevL',
                    size: 32,
                    iconSize: 16,
                    stroke: 2.2,
                  ),
                  const SizedBox(width: 6),
                  const NavBtn(
                    icon: 'chevR',
                    size: 32,
                    iconSize: 16,
                    stroke: 2.2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  for (final d in ['S', 'M', 'T', 'W', 'T', 'F', 'S'])
                    Expanded(
                      child: Text(
                        d,
                        textAlign: TextAlign.center,
                        style: MnText.cap.copyWith(
                          color: c.ink3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  for (final d in days)
                    if (d == null) const SizedBox() else _day(c, d, moods[d]),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final l in [1, 3, 5]) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: c.moodColor(l),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                moodLabels[l - 1],
                style: MnText.cap.copyWith(color: c.ink3),
              ),
              const SizedBox(width: 14),
            ],
          ],
        ),
      ],
    );
  }

  Widget _day(MnColors c, int d, int? m) => GestureDetector(
    onTap: m != null ? onPick : null,
    child: Container(
      decoration: BoxDecoration(
        color: m != null
            ? mix(c.surface, c.moodColor(m), 0.22)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$d',
            style: MnText.foot.copyWith(
              color: m != null ? c.ink : c.ink4,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (m != null) ...[
            const SizedBox(height: 2),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: c.moodColor(m),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
