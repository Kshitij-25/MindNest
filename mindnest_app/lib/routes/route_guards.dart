import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/config/app_phase.dart';
import 'package:mindnest_app/core/services/session_service.dart';

import 'route_names.dart';

/// Centralized redirect logic. The shells require an authenticated session;
/// unauthenticated access bounces back to role selection.
class RouteGuards {
  const RouteGuards(this._session);
  final SessionService _session;

  static const _protectedPrefixes = [
    RouteNames.userShellPath,
    RouteNames.proShellPath,
    RouteNames.settingsPath,
    RouteNames.notificationsPath,
    '/mood',
    '/journal',
    '/feed',
    '/discover',
    '/therapist',
    '/booking',
    '/chat',
    '/profile',
  ];

  /// Auth-entry routes an already-signed-in user should never sit on — they're
  /// forwarded into the app shell instead.
  static const _authEntryPaths = [
    RouteNames.splashPath,
    RouteNames.roleSelectPath,
    RouteNames.loginPath,
    RouteNames.signupPath,
    RouteNames.forgotPath,
    RouteNames.otpPath,
  ];

  String? redirect(GoRouterState state) {
    final loc = state.matchedLocation;

    // Already signed in but sitting on an auth screen → go to the app shell.
    if (_session.isAuthenticated && _authEntryPaths.contains(loc)) {
      return RouteNames.userShellPath;
    }

    final isProtected = _protectedPrefixes.any(
      (p) => loc == p || loc.startsWith('$p/'),
    );
    if (isProtected && !_session.isAuthenticated) {
      // MVP 1 skips role selection — bounce to sign-in instead.
      return AppPhase.mvp1
          ? RouteNames.loginPath
          : RouteNames.roleSelectPath;
    }
    return null;
  }
}
