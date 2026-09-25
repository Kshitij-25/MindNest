import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/domain/entities/app_user.dart';
import '../../features/auth/domain/entities/user_role.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/role_select_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/messages_page.dart';
import '../../features/feed/presentation/pages/feed_page.dart';
import '../../features/feed/presentation/pages/post_detail_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/journal/presentation/pages/journal_entry_page.dart';
import '../../features/journal/presentation/pages/journal_page.dart';
import '../../features/journal/presentation/pages/journal_write_page.dart';
import '../../features/mood/presentation/pages/mood_history_page.dart';
import '../../features/mood/presentation/pages/mood_insights_page.dart';
import '../../features/mood/presentation/pages/mood_track_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/questionnaire_page.dart';
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/practice/presentation/pages/create_post_page.dart';
import '../../features/practice/presentation/pages/pro_calendar_page.dart';
import '../../features/practice/presentation/pages/pro_clients_page.dart';
import '../../features/practice/presentation/pages/pro_content_page.dart';
import '../../features/practice/presentation/pages/pro_credentials_page.dart';
import '../../features/practice/presentation/pages/pro_dashboard_page.dart';
import '../../features/practice/presentation/pages/pro_earnings_page.dart';
import '../../features/practice/presentation/pages/pro_request_detail_page.dart';
import '../../features/practice/presentation/pages/pro_requests_page.dart';
import '../../features/practice/presentation/pages/pro_verify_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/sessions/domain/entities/appointment.dart';
import '../../features/sessions/presentation/pages/booking_page.dart';
import '../../features/sessions/presentation/pages/booking_success_page.dart';
import '../../features/sessions/presentation/pages/sessions_page.dart';
import '../../features/settings/presentation/pages/accessibility_page.dart';
import '../../features/settings/presentation/pages/design_system_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/shell/presentation/pages/client_shell_page.dart';
import '../../features/shell/presentation/pages/pro_shell_page.dart';
import '../../features/therapists/presentation/pages/discover_page.dart';
import '../../features/therapists/presentation/pages/therapist_profile_page.dart';

part 'app_router.gr.dart';

/// Where a signed-in user lands, based on role and onboarding state.
PageRouteInfo homeRouteFor(AppUser user) {
  if (user.isProfessional) {
    return switch (user.verification) {
      VerificationStatus.none => const ProCredentialsRoute(),
      VerificationStatus.pending => const ProVerifyRoute(),
      VerificationStatus.verified => const ProShellRoute(),
    };
  }
  return user.onboarded ? const ClientShellRoute() : const QuestionnaireRoute();
}

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._auth);

  /// The persisted session is the source of truth for guarding (it is
  /// written before navigation, whereas bloc state updates asynchronously).
  final AuthRepository _auth;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRouteGuard> get guards => [
    AutoRouteGuard.simple((resolver, router) {
      final open = const {
        SplashRoute.name,
        RoleSelectRoute.name,
        LoginRoute.name,
        SignupRoute.name,
        ForgotPasswordRoute.name,
      }.contains(resolver.route.name);
      if (open || _auth.cachedUser != null) {
        resolver.next();
      } else {
        resolver.redirectUntil(const SplashRoute());
      }
    }),
  ];

  @override
  List<AutoRoute> get routes => [
    // Auth & onboarding
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: RoleSelectRoute.page, path: '/welcome'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignupRoute.page, path: '/signup'),
    AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
    AutoRoute(page: OtpRoute.page, path: '/verify-otp'),
    AutoRoute(page: QuestionnaireRoute.page, path: '/onboarding'),
    AutoRoute(page: WelcomeRoute.page, path: '/onboarding/done'),

    // Client shell
    AutoRoute(
      page: ClientShellRoute.page,
      path: '/app',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home'),
        AutoRoute(page: FeedRoute.page, path: 'feed'),
        AutoRoute(page: JournalRoute.page, path: 'journal'),
        AutoRoute(page: MessagesRoute.page, path: 'messages'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: SessionsRoute.page, path: 'sessions'),
      ],
    ),

    // Professional shell
    AutoRoute(
      page: ProShellRoute.page,
      path: '/practice',
      children: [
        AutoRoute(page: ProDashboardRoute.page, path: 'dashboard'),
        AutoRoute(page: ProRequestsRoute.page, path: 'requests'),
        AutoRoute(page: ProContentRoute.page, path: 'content'),
        AutoRoute(page: MessagesRoute.page, path: 'messages'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: ProCalendarRoute.page, path: 'calendar'),
        AutoRoute(page: ProClientsRoute.page, path: 'clients'),
        AutoRoute(page: ProEarningsRoute.page, path: 'earnings'),
      ],
    ),

    // Stack pages (pushed above the shells)
    AutoRoute(page: NotificationsRoute.page, path: '/notifications'),
    AutoRoute(
      page: MoodTrackRoute.page,
      path: '/mood/track',
      fullscreenDialog: true,
    ),
    AutoRoute(page: MoodHistoryRoute.page, path: '/mood/history'),
    AutoRoute(page: MoodInsightsRoute.page, path: '/mood/insights'),
    AutoRoute(
      page: JournalWriteRoute.page,
      path: '/journal/write',
      fullscreenDialog: true,
    ),
    AutoRoute(page: JournalEntryRoute.page, path: '/journal/:id'),
    AutoRoute(page: DiscoverRoute.page, path: '/therapists'),
    AutoRoute(page: TherapistProfileRoute.page, path: '/therapists/:id'),
    AutoRoute(page: BookingRoute.page, path: '/book'),
    AutoRoute(page: BookingSuccessRoute.page, path: '/book/success'),
    AutoRoute(page: SessionsRoute.page, path: '/sessions'),
    AutoRoute(page: ChatRoute.page, path: '/chat'),
    AutoRoute(page: PostDetailRoute.page, path: '/posts/:id'),
    AutoRoute(page: FeedRoute.page, path: '/saved'),
    AutoRoute(page: EditProfileRoute.page, path: '/profile/edit'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    AutoRoute(page: AccessibilityRoute.page, path: '/settings/accessibility'),
    AutoRoute(page: DesignSystemRoute.page, path: '/design-system'),

    // Professional stack pages
    AutoRoute(page: ProCredentialsRoute.page, path: '/practice/credentials'),
    AutoRoute(page: ProVerifyRoute.page, path: '/practice/verification'),
    AutoRoute(page: ProRequestDetailRoute.page, path: '/practice/requests/:id'),
    AutoRoute(page: ProClientDetailRoute.page, path: '/practice/clients/:id'),
    AutoRoute(
      page: CreatePostRoute.page,
      path: '/practice/content/new',
      fullscreenDialog: true,
    ),
    AutoRoute(page: ProCalendarRoute.page, path: '/practice/calendar'),
    AutoRoute(page: ProClientsRoute.page, path: '/practice/clients'),
    AutoRoute(page: ProEarningsRoute.page, path: '/practice/earnings'),
  ];
}
