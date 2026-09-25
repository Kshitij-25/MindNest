import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../../core/utils/context_x.dart';
import '../../../core/widgets/mn_icon.dart';

/// Client shell tabs, in AutoTabsRouter order. The first five appear in the
/// phone tab bar; tablets show every tab in the sidebar.
enum ClientTab {
  home('Home', MnIcons.home),
  feed('Feed', MnIcons.layers),
  journal('Journal', MnIcons.bookOpen),
  messages('Messages', MnIcons.message),
  profile('Profile', MnIcons.user),
  sessions('Sessions', MnIcons.calendar);

  const ClientTab(this.label, this.icon);
  final String label;
  final MnIconData icon;

  static const phone = [home, feed, journal, messages, profile];
  static const tablet = [home, sessions, journal, messages, feed, profile];
}

/// Professional shell tabs.
enum ProTab {
  dashboard('Today', 'Dashboard', MnIcons.grid),
  requests('Requests', 'Requests', MnIcons.bell),
  content('Content', 'Content', MnIcons.feather),
  messages('Clients', 'Messages', MnIcons.message),
  profile('Profile', 'Profile', MnIcons.user),
  calendar('Calendar', 'Calendar', MnIcons.calendar),
  clients('Clients', 'Clients', MnIcons.users),
  earnings('Earnings', 'Earnings', MnIcons.trend);

  const ProTab(this.label, this.tabletLabel, this.icon);
  final String label;
  final String tabletLabel;
  final MnIconData icon;

  static const phone = [dashboard, requests, content, messages, profile];
  static const tablet = [dashboard, calendar, requests, clients, messages, earnings, content, profile];
}

/// Switches the enclosing shell to [tab].
void goToTab(BuildContext context, Enum tab) => AutoTabsRouter.of(context).setActiveIndex(tab.index);

/// Opens a section that is a tab on tablets but a pushed page on phones.
void openSection(BuildContext context, PageRouteInfo route, Enum tab) {
  if (context.isTablet) {
    goToTab(context, tab);
  } else {
    context.router.root.push(route);
  }
}

/// True when the current page was pushed (so it needs its own back button).
bool isPushedPage(BuildContext context) => context.router.canPop();
