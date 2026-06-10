import 'package:go_router/go_router.dart';
import 'package:mindnest_app/core/services/session_service.dart';
import 'package:mindnest_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:mindnest_app/features/auth/presentation/pages/login_page.dart';
import 'package:mindnest_app/features/auth/presentation/pages/otp_page.dart';
import 'package:mindnest_app/features/auth/presentation/pages/role_select_page.dart';
import 'package:mindnest_app/features/auth/presentation/pages/signup_page.dart';
// Auth / onboarding
import 'package:mindnest_app/features/auth/presentation/pages/splash_page.dart';
import 'package:mindnest_app/features/discovery/domain/entities/therapist.dart';
import 'package:mindnest_app/features/discovery/presentation/pages/booking_page.dart';
import 'package:mindnest_app/features/discovery/presentation/pages/booking_success_page.dart';
import 'package:mindnest_app/features/discovery/presentation/pages/discover_page.dart';
import 'package:mindnest_app/features/discovery/presentation/pages/therapist_profile_page.dart';
import 'package:mindnest_app/features/feed/presentation/pages/post_detail_page.dart';
import 'package:mindnest_app/features/journal/domain/entities/journal_entry.dart';
import 'package:mindnest_app/features/journal/presentation/pages/journal_entry_page.dart';
import 'package:mindnest_app/features/journal/presentation/pages/journal_write_page.dart';
import 'package:mindnest_app/features/messaging/presentation/pages/chat_page.dart';
import 'package:mindnest_app/features/mood/presentation/pages/mood_history_page.dart';
import 'package:mindnest_app/features/mood/presentation/pages/mood_insights_page.dart';
import 'package:mindnest_app/features/mood/presentation/pages/mood_track_page.dart';
// User pushed pages
import 'package:mindnest_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:mindnest_app/features/onboarding/presentation/pages/questionnaire_page.dart';
import 'package:mindnest_app/features/onboarding/presentation/pages/welcome_page.dart';
// import 'package:mindnest_app/features/professional/presentation/pages/create_post_page.dart';
// Professional pushed pages
import 'package:mindnest_app/features/professional/presentation/pages/pro_credentials_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_request_detail_page.dart';
import 'package:mindnest_app/features/professional/presentation/pages/pro_verify_page.dart';
import 'package:mindnest_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:mindnest_app/features/settings/presentation/pages/settings_page.dart';
// Shells
import 'package:mindnest_app/features/shell/presentation/pages/main_shell.dart';
// MVP-1 wellness insights suite
import 'package:mindnest_app/core/navigation/screen_nav.dart';
import 'package:mindnest_app/features/insights/presentation/pages/insights_pages.dart';
import 'package:mindnest_app/features/insights/presentation/pages/recommendation_pages.dart';
import 'package:mindnest_app/shared/models/user_role.dart';

import 'route_guards.dart';
import 'route_names.dart';

/// Centralized navigation. One GoRouter for the whole app, with a redirect
/// guard protecting the authenticated shells.
class AppRouter {
  AppRouter(SessionService session) : _guards = RouteGuards(session);
  final RouteGuards _guards;

  static UserRole _role(GoRouterState s) =>
      s.extra is UserRole ? s.extra as UserRole : UserRole.user;

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splashPath,
    redirect: (context, state) => _guards.redirect(state),
    routes: [
      GoRoute(
        name: RouteNames.splash,
        path: RouteNames.splashPath,
        builder: (_, _) => const SplashPage(),
      ),
      GoRoute(
        name: RouteNames.roleSelect,
        path: RouteNames.roleSelectPath,
        builder: (_, _) => const RoleSelectPage(),
      ),
      GoRoute(
        name: RouteNames.login,
        path: RouteNames.loginPath,
        builder: (_, s) => LoginPage(role: _role(s)),
      ),
      GoRoute(
        name: RouteNames.signup,
        path: RouteNames.signupPath,
        builder: (_, s) => SignupPage(role: _role(s)),
      ),
      GoRoute(
        name: RouteNames.forgot,
        path: RouteNames.forgotPath,
        builder: (_, _) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: RouteNames.otp,
        path: RouteNames.otpPath,
        builder: (_, s) => OtpPage(role: _role(s)),
      ),
      GoRoute(
        name: RouteNames.questionnaire,
        path: RouteNames.questionnairePath,
        builder: (_, _) => const QuestionnairePage(),
      ),
      GoRoute(
        name: RouteNames.welcome,
        path: RouteNames.welcomePath,
        builder: (_, _) => const WelcomePage(),
      ),

      // MVP-1 wellness insights suite
      GoRoute(
        name: RouteNames.insightsHub,
        path: RouteNames.insightsHubPath,
        builder: (_, _) => const InsightsHubScreen(),
      ),
      GoRoute(
        name: RouteNames.wellnessScore,
        path: RouteNames.wellnessScorePath,
        builder: (_, _) => const WellnessScoreScreen(),
      ),
      GoRoute(
        name: RouteNames.emotionalProfile,
        path: RouteNames.emotionalProfilePath,
        builder: (_, _) => const EmotionalProfileScreen(),
      ),
      GoRoute(
        name: RouteNames.assessments,
        path: RouteNames.assessmentsPath,
        builder: (_, _) => const AssessmentsScreen(),
      ),
      GoRoute(
        name: RouteNames.timeline,
        path: RouteNames.timelinePath,
        builder: (_, _) => const TimelineScreen(),
      ),
      GoRoute(
        name: RouteNames.patterns,
        path: RouteNames.patternsPath,
        builder: (_, _) => const PatternsScreen(),
      ),
      GoRoute(
        name: RouteNames.memory,
        path: RouteNames.memoryPath,
        builder: (_, _) => const MemoryScreen(),
      ),
      GoRoute(
        name: RouteNames.weeklyReport,
        path: RouteNames.weeklyReportPath,
        builder: (_, _) => const WeeklyReportScreen(),
      ),
      GoRoute(
        name: RouteNames.analytics,
        path: RouteNames.analyticsPath,
        builder: (_, _) => const AnalyticsScreen(),
      ),
      GoRoute(
        name: RouteNames.insightDetail,
        path: RouteNames.insightDetailPath,
        builder: (_, s) => InsightDetailScreen(
          type: (screenParams(s)['type'] as String?) ?? 'burnout',
        ),
      ),
      GoRoute(
        name: RouteNames.habits,
        path: RouteNames.habitsPath,
        builder: (_, _) => const HabitsScreen(),
      ),
      GoRoute(
        name: RouteNames.recommendations,
        path: RouteNames.recommendationsPath,
        builder: (_, _) => const RecommendationsScreen(),
      ),
      GoRoute(
        name: RouteNames.recDetail,
        path: RouteNames.recDetailPath,
        builder: (_, s) => RecDetailScreen(
          id: (screenParams(s)['id'] as String?) ?? 'rc1',
        ),
      ),

      GoRoute(
        name: RouteNames.userShell,
        path: RouteNames.userShellPath,
        builder: (_, s) =>
            UserShellPage(initialTab: s.uri.queryParameters['tab'] ?? 'home'),
      ),
      GoRoute(
        name: RouteNames.notifications,
        path: RouteNames.notificationsPath,
        builder: (_, _) => const NotificationsPage(),
      ),
      GoRoute(
        name: RouteNames.moodTrack,
        path: RouteNames.moodTrackPath,
        builder: (_, _) => const MoodTrackPage(),
      ),
      GoRoute(
        name: RouteNames.moodHistory,
        path: RouteNames.moodHistoryPath,
        builder: (_, _) => const MoodHistoryPage(),
      ),
      GoRoute(
        name: RouteNames.moodInsights,
        path: RouteNames.moodInsightsPath,
        builder: (_, _) => const MoodInsightsPage(),
      ),
      GoRoute(
        name: RouteNames.journalWrite,
        path: RouteNames.journalWritePath,
        builder: (_, s) => JournalWritePage(
          entry: s.extra is JournalEntry ? s.extra as JournalEntry : null,
        ),
      ),
      GoRoute(
        name: RouteNames.journalEntry,
        path: RouteNames.journalEntryPath,
        builder: (_, s) => JournalEntryPage(entryId: s.pathParameters['id']!),
      ),
      GoRoute(
        name: RouteNames.postDetail,
        path: RouteNames.postDetailPath,
        builder: (_, s) => PostDetailPage(
          postId: s.pathParameters['id']!,
          openComments: s.uri.queryParameters['comments'] == '1',
        ),
      ),
      GoRoute(
        name: RouteNames.discover,
        path: RouteNames.discoverPath,
        builder: (_, _) => const DiscoverPage(),
      ),
      GoRoute(
        name: RouteNames.therapistProfile,
        path: RouteNames.therapistProfilePath,
        builder: (_, s) =>
            TherapistProfilePage(therapistId: s.pathParameters['id']!),
      ),
      GoRoute(
        name: RouteNames.booking,
        path: RouteNames.bookingPath,
        builder: (_, s) => s.extra is Therapist
            ? BookingPage(therapist: s.extra as Therapist)
            : const DiscoverPage(),
      ),
      GoRoute(
        name: RouteNames.bookingSuccess,
        path: RouteNames.bookingSuccessPath,
        builder: (_, s) => s.extra is BookingSuccessArgs
            ? BookingSuccessPage(args: s.extra as BookingSuccessArgs)
            : const UserShellPage(),
      ),
      GoRoute(
        name: RouteNames.chat,
        path: RouteNames.chatPath,
        builder: (_, s) {
          final args = s.extra is ChatArgs ? s.extra as ChatArgs : null;
          return ChatPage(
            conversationId: s.pathParameters['id']!,
            asProfessional: args?.asProfessional ?? false,
            conversationName: args?.name,
          );
        },
      ),
      GoRoute(
        name: RouteNames.editProfile,
        path: RouteNames.editProfilePath,
        builder: (_, _) => const EditProfilePage(),
      ),
      GoRoute(
        name: RouteNames.settings,
        path: RouteNames.settingsPath,
        builder: (_, _) => const SettingsPage(),
      ),

      GoRoute(
        name: RouteNames.proCredentials,
        path: RouteNames.proCredentialsPath,
        builder: (_, _) => const ProCredentialsPage(),
      ),
      GoRoute(
        name: RouteNames.proVerify,
        path: RouteNames.proVerifyPath,
        builder: (_, _) => const ProVerifyPage(),
      ),
      GoRoute(
        name: RouteNames.proShell,
        path: RouteNames.proShellPath,
        builder: (_, s) =>
            ProShellPage(initialTab: s.uri.queryParameters['tab'] ?? 'home'),
      ),
      GoRoute(
        name: RouteNames.proRequestDetail,
        path: RouteNames.proRequestDetailPath,
        builder: (_, s) =>
            ProRequestDetailPage(requestId: s.pathParameters['id']!),
      ),
      // GoRoute(
      //   name: RouteNames.createPost,
      //   path: RouteNames.createPostPath,
      //   builder: (_, s) => CreatePostPage(postId: s.uri.queryParameters['id']),
      // ),
    ],
  );
}
