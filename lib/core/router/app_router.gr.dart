// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccessibilityPage]
class AccessibilityRoute extends PageRouteInfo<void> {
  const AccessibilityRoute({List<PageRouteInfo>? children})
    : super(AccessibilityRoute.name, initialChildren: children);

  static const String name = 'AccessibilityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccessibilityPage();
    },
  );
}

/// generated route for
/// [BookingPage]
class BookingRoute extends PageRouteInfo<BookingRouteArgs> {
  BookingRoute({
    Key? key,
    required String therapistId,
    String? rescheduleOf,
    List<PageRouteInfo>? children,
  }) : super(
         BookingRoute.name,
         args: BookingRouteArgs(
           key: key,
           therapistId: therapistId,
           rescheduleOf: rescheduleOf,
         ),
         initialChildren: children,
       );

  static const String name = 'BookingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingRouteArgs>();
      return BookingPage(
        key: args.key,
        therapistId: args.therapistId,
        rescheduleOf: args.rescheduleOf,
      );
    },
  );
}

class BookingRouteArgs {
  const BookingRouteArgs({
    this.key,
    required this.therapistId,
    this.rescheduleOf,
  });

  final Key? key;

  final String therapistId;

  final String? rescheduleOf;

  @override
  String toString() {
    return 'BookingRouteArgs{key: $key, therapistId: $therapistId, rescheduleOf: $rescheduleOf}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingRouteArgs) return false;
    return key == other.key &&
        therapistId == other.therapistId &&
        rescheduleOf == other.rescheduleOf;
  }

  @override
  int get hashCode =>
      key.hashCode ^ therapistId.hashCode ^ rescheduleOf.hashCode;
}

/// generated route for
/// [BookingSuccessPage]
class BookingSuccessRoute extends PageRouteInfo<BookingSuccessRouteArgs> {
  BookingSuccessRoute({
    Key? key,
    required Appointment appointment,
    List<PageRouteInfo>? children,
  }) : super(
         BookingSuccessRoute.name,
         args: BookingSuccessRouteArgs(key: key, appointment: appointment),
         initialChildren: children,
       );

  static const String name = 'BookingSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingSuccessRouteArgs>();
      return BookingSuccessPage(key: args.key, appointment: args.appointment);
    },
  );
}

class BookingSuccessRouteArgs {
  const BookingSuccessRouteArgs({this.key, required this.appointment});

  final Key? key;

  final Appointment appointment;

  @override
  String toString() {
    return 'BookingSuccessRouteArgs{key: $key, appointment: $appointment}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingSuccessRouteArgs) return false;
    return key == other.key && appointment == other.appointment;
  }

  @override
  int get hashCode => key.hashCode ^ appointment.hashCode;
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    String? conversationId,
    String? therapistId,
    List<PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(
           key: key,
           conversationId: conversationId,
           therapistId: therapistId,
         ),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>(
        orElse: () => const ChatRouteArgs(),
      );
      return ChatPage(
        key: args.key,
        conversationId: args.conversationId,
        therapistId: args.therapistId,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, this.conversationId, this.therapistId});

  final Key? key;

  final String? conversationId;

  final String? therapistId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, conversationId: $conversationId, therapistId: $therapistId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key &&
        conversationId == other.conversationId &&
        therapistId == other.therapistId;
  }

  @override
  int get hashCode =>
      key.hashCode ^ conversationId.hashCode ^ therapistId.hashCode;
}

/// generated route for
/// [ClientShellPage]
class ClientShellRoute extends PageRouteInfo<void> {
  const ClientShellRoute({List<PageRouteInfo>? children})
    : super(ClientShellRoute.name, initialChildren: children);

  static const String name = 'ClientShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ClientShellPage();
    },
  );
}

/// generated route for
/// [CreatePostPage]
class CreatePostRoute extends PageRouteInfo<CreatePostRouteArgs> {
  CreatePostRoute({Key? key, String? postId, List<PageRouteInfo>? children})
    : super(
        CreatePostRoute.name,
        args: CreatePostRouteArgs(key: key, postId: postId),
        initialChildren: children,
      );

  static const String name = 'CreatePostRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePostRouteArgs>(
        orElse: () => const CreatePostRouteArgs(),
      );
      return CreatePostPage(key: args.key, postId: args.postId);
    },
  );
}

class CreatePostRouteArgs {
  const CreatePostRouteArgs({this.key, this.postId});

  final Key? key;

  final String? postId;

  @override
  String toString() {
    return 'CreatePostRouteArgs{key: $key, postId: $postId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatePostRouteArgs) return false;
    return key == other.key && postId == other.postId;
  }

  @override
  int get hashCode => key.hashCode ^ postId.hashCode;
}

/// generated route for
/// [DesignSystemPage]
class DesignSystemRoute extends PageRouteInfo<void> {
  const DesignSystemRoute({List<PageRouteInfo>? children})
    : super(DesignSystemRoute.name, initialChildren: children);

  static const String name = 'DesignSystemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DesignSystemPage();
    },
  );
}

/// generated route for
/// [DiscoverPage]
class DiscoverRoute extends PageRouteInfo<void> {
  const DiscoverRoute({List<PageRouteInfo>? children})
    : super(DiscoverRoute.name, initialChildren: children);

  static const String name = 'DiscoverRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DiscoverPage();
    },
  );
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfilePage();
    },
  );
}

/// generated route for
/// [FeedPage]
class FeedRoute extends PageRouteInfo<FeedRouteArgs> {
  FeedRoute({Key? key, bool savedOnly = false, List<PageRouteInfo>? children})
    : super(
        FeedRoute.name,
        args: FeedRouteArgs(key: key, savedOnly: savedOnly),
        initialChildren: children,
      );

  static const String name = 'FeedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedRouteArgs>(
        orElse: () => const FeedRouteArgs(),
      );
      return FeedPage(key: args.key, savedOnly: args.savedOnly);
    },
  );
}

class FeedRouteArgs {
  const FeedRouteArgs({this.key, this.savedOnly = false});

  final Key? key;

  final bool savedOnly;

  @override
  String toString() {
    return 'FeedRouteArgs{key: $key, savedOnly: $savedOnly}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FeedRouteArgs) return false;
    return key == other.key && savedOnly == other.savedOnly;
  }

  @override
  int get hashCode => key.hashCode ^ savedOnly.hashCode;
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [JournalEntryPage]
class JournalEntryRoute extends PageRouteInfo<JournalEntryRouteArgs> {
  JournalEntryRoute({
    Key? key,
    required String entryId,
    List<PageRouteInfo>? children,
  }) : super(
         JournalEntryRoute.name,
         args: JournalEntryRouteArgs(key: key, entryId: entryId),
         rawPathParams: {'id': entryId},
         initialChildren: children,
       );

  static const String name = 'JournalEntryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<JournalEntryRouteArgs>(
        orElse: () =>
            JournalEntryRouteArgs(entryId: pathParams.getString('id')),
      );
      return JournalEntryPage(key: args.key, entryId: args.entryId);
    },
  );
}

class JournalEntryRouteArgs {
  const JournalEntryRouteArgs({this.key, required this.entryId});

  final Key? key;

  final String entryId;

  @override
  String toString() {
    return 'JournalEntryRouteArgs{key: $key, entryId: $entryId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! JournalEntryRouteArgs) return false;
    return key == other.key && entryId == other.entryId;
  }

  @override
  int get hashCode => key.hashCode ^ entryId.hashCode;
}

/// generated route for
/// [JournalPage]
class JournalRoute extends PageRouteInfo<void> {
  const JournalRoute({List<PageRouteInfo>? children})
    : super(JournalRoute.name, initialChildren: children);

  static const String name = 'JournalRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const JournalPage();
    },
  );
}

/// generated route for
/// [JournalWritePage]
class JournalWriteRoute extends PageRouteInfo<JournalWriteRouteArgs> {
  JournalWriteRoute({
    Key? key,
    String? entryId,
    String? prompt,
    List<PageRouteInfo>? children,
  }) : super(
         JournalWriteRoute.name,
         args: JournalWriteRouteArgs(
           key: key,
           entryId: entryId,
           prompt: prompt,
         ),
         initialChildren: children,
       );

  static const String name = 'JournalWriteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<JournalWriteRouteArgs>(
        orElse: () => const JournalWriteRouteArgs(),
      );
      return JournalWritePage(
        key: args.key,
        entryId: args.entryId,
        prompt: args.prompt,
      );
    },
  );
}

class JournalWriteRouteArgs {
  const JournalWriteRouteArgs({this.key, this.entryId, this.prompt});

  final Key? key;

  final String? entryId;

  final String? prompt;

  @override
  String toString() {
    return 'JournalWriteRouteArgs{key: $key, entryId: $entryId, prompt: $prompt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! JournalWriteRouteArgs) return false;
    return key == other.key &&
        entryId == other.entryId &&
        prompt == other.prompt;
  }

  @override
  int get hashCode => key.hashCode ^ entryId.hashCode ^ prompt.hashCode;
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    UserRole role = UserRole.client,
    List<PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return LoginPage(key: args.key, role: args.role);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.role = UserRole.client});

  final Key? key;

  final UserRole role;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [MessagesPage]
class MessagesRoute extends PageRouteInfo<void> {
  const MessagesRoute({List<PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MessagesPage();
    },
  );
}

/// generated route for
/// [MoodHistoryPage]
class MoodHistoryRoute extends PageRouteInfo<void> {
  const MoodHistoryRoute({List<PageRouteInfo>? children})
    : super(MoodHistoryRoute.name, initialChildren: children);

  static const String name = 'MoodHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoodHistoryPage();
    },
  );
}

/// generated route for
/// [MoodInsightsPage]
class MoodInsightsRoute extends PageRouteInfo<void> {
  const MoodInsightsRoute({List<PageRouteInfo>? children})
    : super(MoodInsightsRoute.name, initialChildren: children);

  static const String name = 'MoodInsightsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoodInsightsPage();
    },
  );
}

/// generated route for
/// [MoodTrackPage]
class MoodTrackRoute extends PageRouteInfo<void> {
  const MoodTrackRoute({List<PageRouteInfo>? children})
    : super(MoodTrackRoute.name, initialChildren: children);

  static const String name = 'MoodTrackRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoodTrackPage();
    },
  );
}

/// generated route for
/// [NotificationsPage]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationsPage();
    },
  );
}

/// generated route for
/// [OtpPage]
class OtpRoute extends PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    Key? key,
    UserRole role = UserRole.client,
    List<PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>(
        orElse: () => const OtpRouteArgs(),
      );
      return OtpPage(key: args.key, role: args.role);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key, this.role = UserRole.client});

  final Key? key;

  final UserRole role;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [PostDetailPage]
class PostDetailRoute extends PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    Key? key,
    required String postId,
    bool openComments = false,
    List<PageRouteInfo>? children,
  }) : super(
         PostDetailRoute.name,
         args: PostDetailRouteArgs(
           key: key,
           postId: postId,
           openComments: openComments,
         ),
         rawPathParams: {'id': postId},
         initialChildren: children,
       );

  static const String name = 'PostDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PostDetailRouteArgs>(
        orElse: () => PostDetailRouteArgs(postId: pathParams.getString('id')),
      );
      return PostDetailPage(
        key: args.key,
        postId: args.postId,
        openComments: args.openComments,
      );
    },
  );
}

class PostDetailRouteArgs {
  const PostDetailRouteArgs({
    this.key,
    required this.postId,
    this.openComments = false,
  });

  final Key? key;

  final String postId;

  final bool openComments;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, postId: $postId, openComments: $openComments}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostDetailRouteArgs) return false;
    return key == other.key &&
        postId == other.postId &&
        openComments == other.openComments;
  }

  @override
  int get hashCode => key.hashCode ^ postId.hashCode ^ openComments.hashCode;
}

/// generated route for
/// [ProCalendarPage]
class ProCalendarRoute extends PageRouteInfo<void> {
  const ProCalendarRoute({List<PageRouteInfo>? children})
    : super(ProCalendarRoute.name, initialChildren: children);

  static const String name = 'ProCalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProCalendarPage();
    },
  );
}

/// generated route for
/// [ProClientDetailPage]
class ProClientDetailRoute extends PageRouteInfo<ProClientDetailRouteArgs> {
  ProClientDetailRoute({
    Key? key,
    required String clientId,
    List<PageRouteInfo>? children,
  }) : super(
         ProClientDetailRoute.name,
         args: ProClientDetailRouteArgs(key: key, clientId: clientId),
         rawPathParams: {'id': clientId},
         initialChildren: children,
       );

  static const String name = 'ProClientDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProClientDetailRouteArgs>(
        orElse: () =>
            ProClientDetailRouteArgs(clientId: pathParams.getString('id')),
      );
      return ProClientDetailPage(key: args.key, clientId: args.clientId);
    },
  );
}

class ProClientDetailRouteArgs {
  const ProClientDetailRouteArgs({this.key, required this.clientId});

  final Key? key;

  final String clientId;

  @override
  String toString() {
    return 'ProClientDetailRouteArgs{key: $key, clientId: $clientId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProClientDetailRouteArgs) return false;
    return key == other.key && clientId == other.clientId;
  }

  @override
  int get hashCode => key.hashCode ^ clientId.hashCode;
}

/// generated route for
/// [ProClientsPage]
class ProClientsRoute extends PageRouteInfo<void> {
  const ProClientsRoute({List<PageRouteInfo>? children})
    : super(ProClientsRoute.name, initialChildren: children);

  static const String name = 'ProClientsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProClientsPage();
    },
  );
}

/// generated route for
/// [ProContentPage]
class ProContentRoute extends PageRouteInfo<void> {
  const ProContentRoute({List<PageRouteInfo>? children})
    : super(ProContentRoute.name, initialChildren: children);

  static const String name = 'ProContentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProContentPage();
    },
  );
}

/// generated route for
/// [ProCredentialsPage]
class ProCredentialsRoute extends PageRouteInfo<void> {
  const ProCredentialsRoute({List<PageRouteInfo>? children})
    : super(ProCredentialsRoute.name, initialChildren: children);

  static const String name = 'ProCredentialsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProCredentialsPage();
    },
  );
}

/// generated route for
/// [ProDashboardPage]
class ProDashboardRoute extends PageRouteInfo<void> {
  const ProDashboardRoute({List<PageRouteInfo>? children})
    : super(ProDashboardRoute.name, initialChildren: children);

  static const String name = 'ProDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProDashboardPage();
    },
  );
}

/// generated route for
/// [ProEarningsPage]
class ProEarningsRoute extends PageRouteInfo<void> {
  const ProEarningsRoute({List<PageRouteInfo>? children})
    : super(ProEarningsRoute.name, initialChildren: children);

  static const String name = 'ProEarningsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProEarningsPage();
    },
  );
}

/// generated route for
/// [ProRequestDetailPage]
class ProRequestDetailRoute extends PageRouteInfo<ProRequestDetailRouteArgs> {
  ProRequestDetailRoute({
    Key? key,
    required String requestId,
    List<PageRouteInfo>? children,
  }) : super(
         ProRequestDetailRoute.name,
         args: ProRequestDetailRouteArgs(key: key, requestId: requestId),
         rawPathParams: {'id': requestId},
         initialChildren: children,
       );

  static const String name = 'ProRequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProRequestDetailRouteArgs>(
        orElse: () =>
            ProRequestDetailRouteArgs(requestId: pathParams.getString('id')),
      );
      return ProRequestDetailPage(key: args.key, requestId: args.requestId);
    },
  );
}

class ProRequestDetailRouteArgs {
  const ProRequestDetailRouteArgs({this.key, required this.requestId});

  final Key? key;

  final String requestId;

  @override
  String toString() {
    return 'ProRequestDetailRouteArgs{key: $key, requestId: $requestId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProRequestDetailRouteArgs) return false;
    return key == other.key && requestId == other.requestId;
  }

  @override
  int get hashCode => key.hashCode ^ requestId.hashCode;
}

/// generated route for
/// [ProRequestsPage]
class ProRequestsRoute extends PageRouteInfo<void> {
  const ProRequestsRoute({List<PageRouteInfo>? children})
    : super(ProRequestsRoute.name, initialChildren: children);

  static const String name = 'ProRequestsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProRequestsPage();
    },
  );
}

/// generated route for
/// [ProShellPage]
class ProShellRoute extends PageRouteInfo<void> {
  const ProShellRoute({List<PageRouteInfo>? children})
    : super(ProShellRoute.name, initialChildren: children);

  static const String name = 'ProShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProShellPage();
    },
  );
}

/// generated route for
/// [ProVerifyPage]
class ProVerifyRoute extends PageRouteInfo<void> {
  const ProVerifyRoute({List<PageRouteInfo>? children})
    : super(ProVerifyRoute.name, initialChildren: children);

  static const String name = 'ProVerifyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProVerifyPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [QuestionnairePage]
class QuestionnaireRoute extends PageRouteInfo<void> {
  const QuestionnaireRoute({List<PageRouteInfo>? children})
    : super(QuestionnaireRoute.name, initialChildren: children);

  static const String name = 'QuestionnaireRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QuestionnairePage();
    },
  );
}

/// generated route for
/// [RoleSelectPage]
class RoleSelectRoute extends PageRouteInfo<void> {
  const RoleSelectRoute({List<PageRouteInfo>? children})
    : super(RoleSelectRoute.name, initialChildren: children);

  static const String name = 'RoleSelectRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RoleSelectPage();
    },
  );
}

/// generated route for
/// [SessionsPage]
class SessionsRoute extends PageRouteInfo<void> {
  const SessionsRoute({List<PageRouteInfo>? children})
    : super(SessionsRoute.name, initialChildren: children);

  static const String name = 'SessionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SessionsPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SignupPage]
class SignupRoute extends PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    Key? key,
    UserRole role = UserRole.client,
    List<PageRouteInfo>? children,
  }) : super(
         SignupRoute.name,
         args: SignupRouteArgs(key: key, role: role),
         initialChildren: children,
       );

  static const String name = 'SignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignupRouteArgs>(
        orElse: () => const SignupRouteArgs(),
      );
      return SignupPage(key: args.key, role: args.role);
    },
  );
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key, this.role = UserRole.client});

  final Key? key;

  final UserRole role;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key, role: $role}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignupRouteArgs) return false;
    return key == other.key && role == other.role;
  }

  @override
  int get hashCode => key.hashCode ^ role.hashCode;
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [TherapistProfilePage]
class TherapistProfileRoute extends PageRouteInfo<TherapistProfileRouteArgs> {
  TherapistProfileRoute({
    Key? key,
    required String therapistId,
    List<PageRouteInfo>? children,
  }) : super(
         TherapistProfileRoute.name,
         args: TherapistProfileRouteArgs(key: key, therapistId: therapistId),
         rawPathParams: {'id': therapistId},
         initialChildren: children,
       );

  static const String name = 'TherapistProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TherapistProfileRouteArgs>(
        orElse: () =>
            TherapistProfileRouteArgs(therapistId: pathParams.getString('id')),
      );
      return TherapistProfilePage(key: args.key, therapistId: args.therapistId);
    },
  );
}

class TherapistProfileRouteArgs {
  const TherapistProfileRouteArgs({this.key, required this.therapistId});

  final Key? key;

  final String therapistId;

  @override
  String toString() {
    return 'TherapistProfileRouteArgs{key: $key, therapistId: $therapistId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TherapistProfileRouteArgs) return false;
    return key == other.key && therapistId == other.therapistId;
  }

  @override
  int get hashCode => key.hashCode ^ therapistId.hashCode;
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
