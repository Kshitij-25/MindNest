import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/entities/therapist_filter.dart';

/// Advanced filter sheet. Returns the chosen filter, or null if dismissed.
Future<TherapistFilter?> showFilterSheet(BuildContext context, TherapistFilter initial) =>
    showMnSheet<TherapistFilter>(context, builder: (_) => _FilterSheet(initial: initial));

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.initial});
  final TherapistFilter initial;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late TherapistFilter f = widget.initial;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 4, 22, 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text('Filters', style: context.text.title3)),
              MnIconButton(
                icon: MnIcons.x,
                tooltip: 'Close',
                background: Colors.transparent,
                color: c.ink3,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Group(
                    label: 'Specialization',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final s in filterSpecialties)
                          MnChip(
                            label: s,
                            outline: true,
                            selected: f.specializations.contains(s),
                            onTap: () => setState(() {
                              final l = [...f.specializations];
                              l.contains(s) ? l.remove(s) : l.add(s);
                              f = f.copyWith(specializations: l);
                            }),
                          ),
                      ],
                    ),
                  ),
                  _Group(
                    label: 'Max price · £${f.maxPrice}',
                    child: MnSlider(
                      value: f.maxPrice,
                      min: 40,
                      max: 150,
                      semanticLabel: 'Maximum price',
                      onChanged: (v) => setState(() => f = f.copyWith(maxPrice: v)),
                    ),
                  ),
                  _Group(
                    label: 'Minimum rating',
                    child: MnSegmented<String>(
                      options: ratingOptions,
                      value: f.minRating,
                      labelOf: (s) => s,
                      onChanged: (v) => setState(() => f = f.copyWith(minRating: v)),
                    ),
                  ),
                  _Group(
                    label: 'Session type',
                    child: MnSegmented<String>(
                      options: sessionTypeOptions,
                      value: f.sessionType,
                      labelOf: (s) => s,
                      onChanged: (v) => setState(() => f = f.copyWith(sessionType: v)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: MnButton.secondary(
                  label: 'Reset',
                  onPressed: () => setState(() => f = TherapistFilter(query: f.query, specialty: f.specialty)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: MnButton(label: 'Show results', onPressed: () => Navigator.pop(context, f))),
            ],
          ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label, style: context.text.foot.copyWith(fontWeight: FontWeight.w700, color: context.colors.ink2)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      );
}
