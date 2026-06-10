import 'package:flutter/material.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/navigation/tab_scope.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';
import 'package:mindnest_app/features/coach/presentation/pages/ai_coach_page.dart';
import 'package:mindnest_app/features/feed/presentation/pages/feed_page.dart';
import 'package:mindnest_app/features/home/presentation/pages/home_page.dart';
import 'package:mindnest_app/features/journal/presentation/pages/journal_list_page.dart';
import 'package:mindnest_app/features/messaging/presentation/pages/messages_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_clients_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_content_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_dashboard_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_profile_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_requests_page.dart';
import 'package:mindnest_app/features/profile/presentation/pages/profile_page.dart';

import '../widgets/app_tab_bar.dart';

/// User bottom-tab shell (Home / Feed / Journal / Messages / Profile).
class UserShellPage extends StatelessWidget {
  const UserShellPage({super.key, this.initialTab = 'home'});
  final String initialTab;

  @override
  Widget build(BuildContext context) => _ShellScaffold(
    initialTab: initialTab,
    // MVP 1: the "Learn" library + an AI "Coach" replace the social feed label
    // and 1:1 messaging. Flip AppPhase.mvp1 to restore Feed + Messages.
    tabs: [
      TabDef('home', 'Home', 'home', (_) => const HomePage()),
      TabDef(
        'feed',
        AppPhase.mvp1 ? 'Learn' : 'Feed',
        'layers',
        (_) => const FeedPage(),
      ),
      TabDef('journal', 'Journal', 'bookOpen', (_) => const JournalListPage()),
      if (AppPhase.mvp1)
        TabDef('chats', 'Coach', 'message', (_) => const AiCoachPage())
      else
        TabDef('chats', 'Messages', 'message', (_) => const MessagesPage()),
      TabDef('profile', 'Profile', 'user', (_) => const ProfilePage()),
    ],
  );
}

/// Professional bottom-tab shell (Today / Requests / Content / Clients / Profile).
class ProShellPage extends StatelessWidget {
  const ProShellPage({super.key, this.initialTab = 'home'});
  final String initialTab;

  @override
  Widget build(BuildContext context) => _ShellScaffold(
    initialTab: initialTab,
    tabs: [
      TabDef('home', 'Today', 'home', (_) => const ProDashboardPage()),
      TabDef(
        'requests',
        'Requests',
        'calendar',
        (_) => const ProRequestsPage(),
      ),
      TabDef('content', 'Content', 'feather', (_) => const ProContentPage()),
      TabDef('chats', 'Clients', 'message', (_) => const ProClientsPage()),
      TabDef('profile', 'Profile', 'user', (_) => const ProProfilePage()),
    ],
  );
}

class _ShellScaffold extends StatefulWidget {
  const _ShellScaffold({required this.tabs, required this.initialTab});
  final List<TabDef> tabs;
  final String initialTab;
  @override
  State<_ShellScaffold> createState() => _ShellScaffoldState();
}

class _ShellScaffoldState extends State<_ShellScaffold> {
  late int _index = widget.tabs
      .indexWhere((t) => t.id == widget.initialTab)
      .clamp(0, widget.tabs.length - 1);

  void _goById(String id) {
    final i = widget.tabs.indexWhere((t) => t.id == id);
    if (i >= 0 && i != _index) setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    return MnScaffold(
      resizeToAvoidBottomInset: false,
      child: TabScope(
        go: _goById,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _index,
                children: [
                  for (final t in widget.tabs)
                    KeyedSubtree(
                      key: ValueKey(t.id),
                      child: Builder(builder: t.builder),
                    ),
                ],
              ),
            ),
            AppTabBar(
              tabs: widget.tabs,
              active: _index,
              onSelect: (i) => setState(() => _index = i),
            ),
          ],
        ),
      ),
    );
  }
}
