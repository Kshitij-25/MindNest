import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/tokens.dart';
import 'package:mindnest_app/core/widgets/common.dart';
import 'package:mindnest_app/core/widgets/nav.dart';
import 'package:mindnest_app/core/navigation/screen_nav.dart';

/// Standard pushed-screen scaffold: calm background, a back NavHeader, and a
/// non-glowing scroll body. Mirrors the prototype's `mn-screen` + `NavHeader`
/// + `mn-scroll` trio so each wellness screen stays a thin body.
class MvpPage extends StatelessWidget {
  const MvpPage({
    super.key,
    required this.title,
    required this.children,
    this.right,
    this.transparent = false,
    this.background,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 30),
    this.bottomBar,
  });

  final String title;
  final List<Widget> children;
  final Widget? right;
  final bool transparent;
  final Color? background;
  final EdgeInsetsGeometry padding;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return MnScaffold(
      background: background,
      resizeToAvoidBottomInset: false,
      child: Column(
        children: [
          SizedBox(height: safeTop(context)),
          NavHeader(
            title: title,
            onBack: () => context.popScreen(),
            right: right,
            transparent: transparent,
          ),
          Expanded(
            child: NoGlow(
              child: SingleChildScrollView(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
          ),
          ?bottomBar,
        ],
      ),
    );
  }
}

/// A standard radial-gradient backdrop (primary tint at top) used by a couple
/// of the celebratory screens.
BoxDecoration mvpTopGlow(BuildContext context) {
  final c = context.c;
  return BoxDecoration(
    gradient: RadialGradient(
      center: const Alignment(0, -1),
      radius: 1.1,
      colors: [c.primaryTint, c.bg],
      stops: const [0, 0.45],
    ),
  );
}
