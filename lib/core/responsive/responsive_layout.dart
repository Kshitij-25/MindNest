import 'package:flutter/widgets.dart';

import 'breakpoints.dart';

/// Picks a builder for the current width class.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.phone,
    this.tablet,
    this.wide,
  });

  final WidgetBuilder phone;
  final WidgetBuilder? tablet;
  final WidgetBuilder? wide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        switch (Breakpoints.fromWidth(c.maxWidth)) {
          case ScreenType.tabletLandscape:
            return (wide ?? tablet ?? phone)(context);
          case ScreenType.tablet:
            return (tablet ?? phone)(context);
          case ScreenType.phone:
            return phone(context);
        }
      },
    );
  }
}

/// Picks a value for the current width class.
T responsive<T>(BuildContext context, {required T phone, T? tablet, T? wide}) {
  switch (Breakpoints.of(context)) {
    case ScreenType.tabletLandscape:
      return wide ?? tablet ?? phone;
    case ScreenType.tablet:
      return tablet ?? phone;
    case ScreenType.phone:
      return phone;
  }
}

/// Centers content and caps its width, for forms/reading screens on tablets.
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.maxWidth = 560});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Simple responsive grid: lays children out in [columns] equal columns.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.columns,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  final List<Widget> children;
  final int columns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: runSpacing),
            children[i],
          ],
        ],
      );
    }
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += columns) {
      final slice = children.sublist(
        i,
        (i + columns).clamp(0, children.length),
      );
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < columns; j++) ...[
                if (j > 0) SizedBox(width: spacing),
                Expanded(child: j < slice.length ? slice[j] : const SizedBox()),
              ],
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) SizedBox(height: runSpacing),
          rows[i],
        ],
      ],
    );
  }
}
