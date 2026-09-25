import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../shell_tabs.dart';
import '../widgets/adaptive_shell.dart';

@RoutePage()
class ClientShellPage extends StatelessWidget {
  const ClientShellPage({super.key});

  static final _routes = <PageRouteInfo>[
    const HomeRoute(),
    FeedRoute(),
    const JournalRoute(),
    const MessagesRoute(),
    const ProfileRoute(),
    const SessionsRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    ShellDestination d(ClientTab t) => ShellDestination(index: t.index, label: t.label, icon: t.icon);
    return AdaptiveShell(
      routes: _routes,
      subtitle: 'Personal',
      phone: [for (final t in ClientTab.phone) d(t)],
      tablet: [for (final t in ClientTab.tablet) d(t)],
    );
  }
}
