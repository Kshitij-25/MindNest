/// Centralized route names + paths. Use the `name` constants with
/// `context.goNamed` / `context.pushNamed` so paths can change freely.
abstract class RouteNames {
  // Onboarding / auth
  static const splash = 'splash';
  static const splashPath = '/';
  static const roleSelect = 'roleSelect';
  static const roleSelectPath = '/role';
  static const login = 'login';
  static const loginPath = '/login';
  static const signup = 'signup';
  static const signupPath = '/signup';
  static const forgot = 'forgot';
  static const forgotPath = '/forgot';
  static const otp = 'otp';
  static const otpPath = '/otp';
  static const questionnaire = 'questionnaire';
  static const questionnairePath = '/questionnaire';
  static const welcome = 'welcome';
  static const welcomePath = '/welcome';

  // MVP-1 wellness insights suite
  static const insightsHub = 'insightsHub';
  static const insightsHubPath = '/insights';
  static const wellnessScore = 'wellnessScore';
  static const wellnessScorePath = '/insights/score';
  static const emotionalProfile = 'emotionalProfile';
  static const emotionalProfilePath = '/insights/emotional-profile';
  static const assessments = 'assessments';
  static const assessmentsPath = '/assessments';
  static const timeline = 'timeline';
  static const timelinePath = '/insights/timeline';
  static const patterns = 'patterns';
  static const patternsPath = '/insights/patterns';
  static const memory = 'memory';
  static const memoryPath = '/insights/memory';
  static const weeklyReport = 'weeklyReport';
  static const weeklyReportPath = '/insights/weekly-report';
  static const analytics = 'analytics';
  static const analyticsPath = '/insights/analytics';
  static const insightDetail = 'insightDetail';
  static const insightDetailPath = '/insights/detail';
  static const habits = 'habits';
  static const habitsPath = '/habits';
  static const recommendations = 'recommendations';
  static const recommendationsPath = '/recommendations';
  static const recDetail = 'recDetail';
  static const recDetailPath = '/recommendations/detail';

  // User shell + pushed pages
  static const userShell = 'app';
  static const userShellPath = '/app';
  static const notifications = 'notifications';
  static const notificationsPath = '/notifications';
  static const moodTrack = 'moodTrack';
  static const moodTrackPath = '/mood/track';
  static const moodHistory = 'moodHistory';
  static const moodHistoryPath = '/mood/history';
  static const moodInsights = 'moodInsights';
  static const moodInsightsPath = '/mood/insights';
  static const journalWrite = 'journalWrite';
  static const journalWritePath = '/journal/write';
  static const journalEntry = 'journalEntry';
  static const journalEntryPath = '/journal/entry/:id';
  static const postDetail = 'postDetail';
  static const postDetailPath = '/feed/post/:id';
  static const discover = 'discover';
  static const discoverPath = '/discover';
  static const therapistProfile = 'therapistProfile';
  static const therapistProfilePath = '/therapist/:id';
  static const booking = 'booking';
  static const bookingPath = '/booking/:id';
  static const bookingSuccess = 'bookingSuccess';
  static const bookingSuccessPath = '/booking-success';
  static const chat = 'chat';
  static const chatPath = '/chat/:id';
  static const editProfile = 'editProfile';
  static const editProfilePath = '/profile/edit';
  static const settings = 'settings';
  static const settingsPath = '/settings';

  // Professional
  static const proCredentials = 'proCredentials';
  static const proCredentialsPath = '/pro/credentials';
  static const proVerify = 'proVerify';
  static const proVerifyPath = '/pro/verify';
  static const proShell = 'pro';
  static const proShellPath = '/pro';
  static const proRequestDetail = 'proRequestDetail';
  static const proRequestDetailPath = '/pro/request/:id';
  static const createPost = 'createPost';
  static const createPostPath = '/pro/create-post';
}
