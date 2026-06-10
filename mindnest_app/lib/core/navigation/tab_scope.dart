import 'package:flutter/widgets.dart';

/// Lets descendant pages switch the active tab of the enclosing shell
/// (e.g. a Home quick-action jumping to the Journal tab).
class TabScope extends InheritedWidget {
  const TabScope({super.key, required this.go, required super.child});

  /// Switch to a tab by its id (e.g. 'journal', 'feed', 'requests').
  final void Function(String id) go;

  static TabScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabScope>();

  @override
  bool updateShouldNotify(TabScope oldWidget) => false;
}
