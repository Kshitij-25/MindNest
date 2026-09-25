import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

/// Living reference for the MindNest design tokens and components.
@RoutePage()
class DesignSystemPage extends StatefulWidget {
  const DesignSystemPage({super.key});

  @override
  State<DesignSystemPage> createState() => _DesignSystemPageState();
}

class _DesignSystemPageState extends State<DesignSystemPage> {
  bool _toggle = true;
  String _seg = 'Week';
  int _slider = 6;
  String _chip = 'Anxiety';

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget swatch(Color col, String name) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(12), border: Border.all(color: c.hairline)),
            ),
            const SizedBox(height: 6),
            Text(name, style: context.text.cap.copyWith(color: c.ink2)),
          ],
        );
    Widget block(String title, Widget child) => Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title.toUpperCase(), style: context.text.cap.copyWith(color: c.ink3, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              MnCard(child: child),
            ],
          ),
        );

    return MnPage(
      header: const MnNavHeader(title: 'Design system'),
      maxWidth: 820,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          block(
            'Colour',
            ResponsiveGrid(
              columns: responsive(context, phone: 4, tablet: 6),
              spacing: 10,
              runSpacing: 12,
              children: [
                swatch(c.primary, 'Primary'),
                swatch(c.primaryTint, 'Tint'),
                swatch(c.clay, 'Clay'),
                swatch(c.bg, 'Bg'),
                swatch(c.surface, 'Surface'),
                swatch(c.ink, 'Ink'),
                for (var i = 1; i <= 5; i++) swatch(c.mood(i), moodLabel(i)),
                swatch(c.green, 'Green'),
              ],
            ),
          ),
          block(
            'Type',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display serif', style: context.text.display),
                Text('Title 1', style: context.text.title1),
                Text('Title 2', style: context.text.title2),
                Text('Title 3', style: context.text.title3),
                Text('Headline', style: context.text.headline),
                Text('Body — a calmer space for your mind.', style: context.text.body),
                Text('Footnote', style: context.text.foot.copyWith(color: c.ink2)),
                Text('CAPTION', style: context.text.cap.copyWith(color: c.ink3)),
              ],
            ),
          ),
          block(
            'Buttons',
            Column(
              children: [
                MnButton(label: 'Primary', onPressed: () {}),
                const SizedBox(height: 10),
                MnButton.tonal(label: 'Tonal', onPressed: () {}),
                const SizedBox(height: 10),
                MnButton.secondary(label: 'Secondary', onPressed: () {}),
                const SizedBox(height: 10),
                MnButton.outline(label: 'Outline', onPressed: () {}),
                const SizedBox(height: 10),
                const MnButton(label: 'Disabled'),
              ],
            ),
          ),
          block(
            'Controls',
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MnSegmented<String>(options: const ['Day', 'Week', 'Month'], value: _seg, labelOf: (s) => s, onChanged: (v) => setState(() => _seg = v)),
                const SizedBox(height: 16),
                Row(children: [Expanded(child: Text('Toggle', style: context.text.body)), MnToggle(value: _toggle, onChanged: (v) => setState(() => _toggle = v))]),
                MnSlider(value: _slider, onChanged: (v) => setState(() => _slider = v)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final t in ['Anxiety', 'Sleep', 'Stress'])
                      MnChip(label: t, outline: true, selected: _chip == t, onTap: () => setState(() => _chip = t)),
                  ],
                ),
                const SizedBox(height: 14),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    MnBadge(label: 'Verified'),
                    MnBadge(label: 'Pending', tone: MnBadgeTone.pending),
                    MnBadge(label: 'Accepted', tone: MnBadgeTone.accept),
                    MnBadge(label: 'Declined', tone: MnBadgeTone.reject),
                  ],
                ),
                const SizedBox(height: 16),
                const MnTextField(icon: MnIcons.mail, hint: 'Email address'),
              ],
            ),
          ),
          block(
            'Mood & avatars',
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [for (var l = 1; l <= 5; l++) MoodFace(level: l, size: 48)]),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MnAvatar(name: 'Amara Okafor', photo: true),
                    MnAvatar(name: 'Daniel Mercer'),
                    MnAvatar(name: 'Priya Nair', online: true),
                    MnLogo(size: 48),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
