import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

class TabDef {
  const TabDef(this.id, this.label, this.icon, this.builder);
  final String id;
  final String label;
  final String icon;
  final WidgetBuilder builder;
}

/// Blurred, translucent bottom tab bar (matches the design's `.tabbar`).
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    required this.active,
    required this.onSelect,
  });
  final List<TabDef> tabs;
  final int active;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: c.surface.withValues(alpha: 0.82),
            border: Border(top: BorderSide(color: c.hairline, width: 0.5)),
          ),
          padding: EdgeInsets.fromLTRB(8, 8, 8, safeBottom(context) - 18),
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelect(i),
                    child: _TabItem(tab: tabs[i], active: i == active),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.tab, required this.active});
  final TabDef tab;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final color = active ? c.primary : c.ink3;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: active ? 1.06 : 1,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutBack,
            child: MnIcon(
              tab.icon,
              size: 25,
              color: color,
              stroke: active ? 2.3 : 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tab.label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: color,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedScale(
            scale: active ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: c.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
