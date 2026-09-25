import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../practice/presentation/bloc/requests_bloc.dart';
import '../shell_tabs.dart';
import '../widgets/adaptive_shell.dart';

@RoutePage()
class ProShellPage extends StatelessWidget {
  const ProShellPage({super.key});

  static const _routes = <PageRouteInfo>[
    ProDashboardRoute(),
    ProRequestsRoute(),
    ProContentRoute(),
    MessagesRoute(),
    ProfileRoute(),
    ProCalendarRoute(),
    ProClientsRoute(),
    ProEarningsRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<RequestsBloc>()..add(const RequestsEvent.load()),
      child: BlocBuilder<RequestsBloc, RequestsState>(
        builder: (context, s) {
          ShellDestination d(ProTab t, {bool tablet = false}) => ShellDestination(
                index: t.index,
                label: tablet ? t.tabletLabel : t.label,
                icon: t.icon,
                badge: t == ProTab.requests ? s.pendingCount : 0,
              );
          return AdaptiveShell(
            routes: _routes,
            subtitle: 'Practice',
            phone: [for (final t in ProTab.phone) d(t)],
            tablet: [for (final t in ProTab.tablet) d(t, tablet: true)],
          );
        },
      ),
    );
  }
}
