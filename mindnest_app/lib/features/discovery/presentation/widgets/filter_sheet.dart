import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

/// Ephemeral filter UI shown in a bottom sheet (local state only).
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});
  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int _price = 110;
  String _rating = '4.5+';
  String _type = 'Any';
  final _sel = <String>{'Anxiety'};
  static const specs = [
    'Anxiety',
    'Depression',
    'Sleep',
    'Stress',
    'Relationships',
    'Burnout',
    'Grief',
    'Trauma',
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: SheetGrab()),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Filters',
                  style: MnText.title3.copyWith(color: c.ink),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: MnIcon('x', size: 22, color: c.ink3),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Flexible(
            child: NoGlow(
              child: ListView(
                shrinkWrap: true,
                children: [
                  _group(
                    'Specialization',
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final s in specs)
                          Chip2(
                            s,
                            active: _sel.contains(s),
                            outline: !_sel.contains(s),
                            onTap: () => setState(
                              () => _sel.contains(s)
                                  ? _sel.remove(s)
                                  : _sel.add(s),
                            ),
                          ),
                      ],
                    ),
                  ),
                  _group(
                    'Max price · £$_price',
                    MnSlider(
                      value: _price,
                      min: 40,
                      max: 150,
                      onChanged: (v) => setState(() => _price = v),
                    ),
                  ),
                  _group(
                    'Minimum rating',
                    Segmented(
                      options: const ['Any', '4.0+', '4.5+', '4.8+'],
                      value: _rating,
                      onChanged: (v) => setState(() => _rating = v),
                    ),
                  ),
                  _group(
                    'Session type',
                    Segmented(
                      options: const ['Any', 'Video', 'Chat'],
                      value: _type,
                      onChanged: (v) => setState(() => _type = v),
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
                child: MnButton(
                  label: 'Reset',
                  variant: MnVariant.secondary,
                  onPressed: () => setState(() {
                    _sel.clear();
                    _price = 150;
                    _rating = 'Any';
                    _type = 'Any';
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: MnButton(
                  label: 'Show results',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _group(String label, Widget child) => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            label,
            style: MnText.foot.copyWith(
              color: context.c.ink2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        child,
      ],
    ),
  );
}
