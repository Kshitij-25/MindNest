import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/routes/route_names.dart';

/// Professional profile tab. Hosted inside the pro shell.
class ProProfilePage extends StatefulWidget {
  const ProProfilePage({super.key});

  @override
  State<ProProfilePage> createState() => _ProProfilePageState();
}

class _ProProfilePageState extends State<ProProfilePage> {
  bool _accepting = true;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final stats = [('128', 'Clients'), ('4.9', 'Rating'), ('96%', 'Response')];
    final menu = [
      ('calendar', 'Manage availability'),
      ('award', 'Credentials & verification'),
      ('trend', 'Earnings & payouts'),
      ('star', 'Reviews'),
    ];
    return Column(
      children: [
        Container(
          color: c.bg,
          padding: EdgeInsets.fromLTRB(20, safeTop(context) + 8, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Profile',
                  style: MnText.title1.copyWith(color: c.ink),
                ),
              ),
              NavBtn(
                icon: 'sliders',
                iconSize: 20,
                stroke: 1.9,
                onTap: () => context.pushNamed(RouteNames.settings),
              ),
            ],
          ),
        ),
        Expanded(
          child: NoGlow(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              children: [
                MnCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Avatar(
                        'Evelyn Hale',
                        size: 84,
                        photo: true,
                        ring: true,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dr. Evelyn Hale',
                            style: MnText.title3.copyWith(color: c.ink),
                          ),
                          const SizedBox(width: 6),
                          const Verified(size: 18),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Clinical Psychologist · 9 yrs',
                        style: MnText.foot.copyWith(color: c.ink2),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          for (var i = 0; i < stats.length; i++) ...[
                            if (i > 0)
                              Container(
                                width: 0.5,
                                height: 34,
                                color: c.hairline,
                              ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    stats[i].$1,
                                    style: MnText.title3.copyWith(
                                      color: c.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    stats[i].$2,
                                    style: MnText.cap.copyWith(color: c.ink3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                MnCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: tint(c.green, 0.14),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        alignment: Alignment.center,
                        child: MnIcon(
                          'pulse',
                          size: 20,
                          color: c.green,
                          stroke: 1.9,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Accepting clients',
                              style: MnText.headline.copyWith(
                                color: c.ink,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _accepting
                                  ? 'Your profile is visible in discovery'
                                  : 'Hidden from new client searches',
                              style: MnText.foot.copyWith(color: c.ink3),
                            ),
                          ],
                        ),
                      ),
                      MnToggle(
                        value: _accepting,
                        onChanged: (v) => setState(() => _accepting = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                MnCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Column(
                    children: [
                      for (var i = 0; i < menu.length; i++) ...[
                        if (i > 0) const Hairline(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            children: [
                              MnIcon(
                                menu[i].$1,
                                size: 20,
                                color: c.ink2,
                                stroke: 1.9,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  menu[i].$2,
                                  style: MnText.body.copyWith(color: c.ink),
                                ),
                              ),
                              MnIcon(
                                'chevR',
                                size: 18,
                                color: c.ink4,
                                stroke: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                MnButton(
                  label: 'Log out',
                  variant: MnVariant.secondary,
                  foreground: c.red,
                  leading: MnIcon(
                    'logout',
                    size: 19,
                    color: c.red,
                    stroke: 1.9,
                  ),
                  onPressed: () => context.goNamed(RouteNames.splash),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
