import 'package:flutter/material.dart';
import 'package:mindnest_app/core/theme/theme.dart';

/// Calm, centered loading indicator used by cubit-driven pages.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size = 30});
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: c.primary,
          backgroundColor: c.primaryRing,
        ),
      ),
    );
  }
}
