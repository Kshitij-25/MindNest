import 'package:flutter/material.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/widgets/widgets.dart';

/// Generic, retryable error state driven by a domain [Failure].
class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, required this.failure, this.onRetry});
  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: 'info',
      title: 'Something went wrong',
      body: failure.message,
      action: onRetry != null ? 'Try again' : null,
      onAction: onRetry,
    );
  }
}
