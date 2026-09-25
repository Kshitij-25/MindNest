import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';

class ShellDestination {
  const ShellDestination({required this.index, required this.label, required this.icon, this.badge = 0});
  final int index;
  final String label;
  final MnIconData icon;
  final int badge;
}

/// Hosts an [AutoTabsRouter] and renders a blurred bottom tab bar on phones
/// or a sidebar (full or compact rail) on tablets.
class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({
    super.key,
    required this.routes,
    required this.phone,
    required this.tablet,
    required this.subtitle,
  });

  final List<PageRouteInfo> routes;
  final List<ShellDestination> phone;
  final List<ShellDestination> tablet;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    return AutoTabsRouter(
      routes: routes,
      duration: reduce ? Duration.zero : const Duration(milliseconds: 280),
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: MnMotion.ease),
        child: child,
      ),
      builder: (context, child) {
        final tabs = AutoTabsRouter.of(context);
        if (!context.isTablet) {
          return Scaffold(
            extendBody: true,
            body: child,
            bottomNavigationBar: _TabBar(
              items: phone,
              active: tabs.activeIndex,
              onSelect: (i) => _select(tabs, i),
            ),
          );
        }
        final compact = MediaQuery.sizeOf(context).width < 960;
        return Scaffold(
          body: Row(
            children: [
              _Sidebar(
                items: tablet,
                active: tabs.activeIndex,
                compact: compact,
                subtitle: subtitle,
                onSelect: (i) => _select(tabs, i),
              ),
              Container(width: .5, color: context.colors.hairline),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }

  void _select(TabsRouter tabs, int i) {
    if (tabs.activeIndex == i) {
      // Re-tapping the active tab pops it to its first page.
      tabs.stackRouterOfIndex(i)?.popUntilRoot();
    } else {
      tabs.setActiveIndex(i);
    }
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.items, required this.active, required this.onSelect});
  final List<ShellDestination> items;
  final int active;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: c.surface.withValues(alpha: .82),
            border: Border(top: BorderSide(color: c.hairline, width: .5)),
          ),
          padding: EdgeInsets.fromLTRB(8, 8, 8, MediaQuery.paddingOf(context).bottom + (context.isIOS ? 0 : 8)),
          child: Row(
            children: [
              for (final it in items)
                Expanded(
                  child: _TabItem(item: it, active: it.index == active, onTap: () => onSelect(it.index)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.item, required this.active, required this.onTap});
  final ShellDestination item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final col = active ? c.primary : c.ink3;
    return Semantics(
      button: true,
      selected: active,
      label: item.badge > 0 ? '${item.label}, ${item.badge} new' : item.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Adaptive.tap(context);
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Badge(
                isLabelVisible: item.badge > 0,
                label: Text('${item.badge}'),
                backgroundColor: c.clay,
                child: AnimatedSlide(
                  offset: Offset(0, active ? -.04 : 0),
                  duration: const Duration(milliseconds: 300),
                  curve: MnMotion.easeSpring,
                  child: AnimatedScale(
                    scale: active ? 1.06 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: MnMotion.easeSpring,
                    child: MnIcon(item.icon, size: 25, color: col, stroke: active ? 2.3 : 2),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: MnMotion.base,
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: -.1, color: col),
                child: Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(height: 4),
              AnimatedScale(
                scale: active ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                curve: MnMotion.easeSpring,
                child: Container(width: 5, height: 5, decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.items,
    required this.active,
    required this.compact,
    required this.subtitle,
    required this.onSelect,
  });

  final List<ShellDestination> items;
  final int active;
  final bool compact;
  final String subtitle;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final user = context.select((AuthBloc b) => b.state.user);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final top = MediaQuery.paddingOf(context).top;

    Widget navItem({required MnIconData icon, required String label, required bool selected, required VoidCallback onTap, int badge = 0}) {
      final col = selected ? c.primary : c.ink2;
      return Semantics(
        button: true,
        selected: selected,
        label: badge > 0 ? '$label, $badge new' : label,
        excludeSemantics: true,
        child: Tooltip(
          message: compact ? label : '',
          child: Pressable(
            onTap: onTap,
            scale: .98,
            child: AnimatedContainer(
              duration: MnMotion.base,
              margin: EdgeInsets.symmetric(horizontal: compact ? 10 : 12, vertical: 2),
              padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 14, vertical: compact ? 10 : 0),
              height: compact ? null : 46,
              decoration: BoxDecoration(color: selected ? c.primaryTint : Colors.transparent, borderRadius: BorderRadius.circular(13)),
              child: compact
                  ? Column(
                      children: [
                        Badge(
                          isLabelVisible: badge > 0,
                          label: Text('$badge'),
                          backgroundColor: c.primary,
                          textColor: c.onPrimary,
                          child: MnIcon(icon, size: 22, color: col, stroke: selected ? 2.3 : 2),
                        ),
                        const SizedBox(height: 4),
                        Text(label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 11, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: col)),
                      ],
                    )
                  : Row(
                      children: [
                        MnIcon(icon, size: 21, color: col, stroke: selected ? 2.3 : 2),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(fontSize: 15.5, fontWeight: selected ? FontWeight.w600 : FontWeight.w500, color: selected ? c.primary : c.ink2),
                          ),
                        ),
                        if (badge > 0)
                          Container(
                            constraints: const BoxConstraints(minWidth: 20),
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: c.primary, borderRadius: BorderRadius.circular(999)),
                            child: Text('$badge', style: TextStyle(color: c.onPrimary, fontSize: 11.5, fontWeight: FontWeight.w700)),
                          ),
                      ],
                    ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: compact ? 92 : 248,
      color: c.surface,
      padding: EdgeInsets.only(top: top + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(compact ? 0 : 18, 0, compact ? 0 : 18, 22),
            child: Row(
              mainAxisAlignment: compact ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: MnColors.brandGradient,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [BoxShadow(color: const Color(0x525C7C45), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  alignment: Alignment.center,
                  child: const LeafMark(size: 20),
                ),
                if (!compact) ...[
                  const SizedBox(width: 11),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MindNest', style: context.text.headline.copyWith(fontWeight: FontWeight.w700)),
                      Text(subtitle, style: context.text.cap.copyWith(color: c.ink3)),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (final it in items)
                  navItem(
                    icon: it.icon,
                    label: it.label,
                    badge: it.badge,
                    selected: it.index == active,
                    onTap: () {
                      Adaptive.tap(context);
                      onSelect(it.index);
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Container(height: .5, color: c.hairline),
                ),
                navItem(
                  icon: MnIcons.eye,
                  label: 'Accessibility',
                  selected: false,
                  onTap: () => context.router.push(const AccessibilityRoute()),
                ),
                navItem(
                  icon: MnIcons.sliders,
                  label: 'Settings',
                  selected: false,
                  onTap: () => context.router.push(const SettingsRoute()),
                ),
                navItem(
                  icon: isDark ? MnIcons.sun : MnIcons.moon,
                  label: isDark ? 'Light mode' : 'Dark mode',
                  selected: false,
                  onTap: () => context.read<SettingsCubit>().toggleTheme(platformIsDark: MediaQuery.platformBrightnessOf(context) == Brightness.dark),
                ),
              ],
            ),
          ),
          if (user != null)
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, MediaQuery.paddingOf(context).bottom + 12),
              child: compact
                  ? Center(child: MnAvatar(name: user.name, size: 40, photo: true))
                  : Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: c.fill, borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          MnAvatar(name: user.name, size: 40, photo: true),
                          const SizedBox(width: 11),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.text.headline.copyWith(fontSize: 15)),
                                Text(user.title ?? 'Member', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.text.cap.copyWith(color: c.ink3)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
