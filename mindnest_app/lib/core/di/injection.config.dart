// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mindnest_app/core/network/dio_client.dart' as _i672;
import 'package:mindnest_app/core/network/network_info.dart' as _i423;
import 'package:mindnest_app/core/services/key_value_storage.dart' as _i167;
import 'package:mindnest_app/core/services/session_service.dart' as _i644;
import 'package:mindnest_app/features/auth/data/datasource/auth_remote_data_source.dart'
    as _i634;
import 'package:mindnest_app/features/auth/data/repositories/auth_repository_impl.dart'
    as _i640;
import 'package:mindnest_app/features/auth/domain/repositories/auth_repository.dart'
    as _i864;
import 'package:mindnest_app/features/auth/domain/usecases/auth_usecases.dart'
    as _i143;
import 'package:mindnest_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i855;
import 'package:mindnest_app/features/discovery/data/datasource/discovery_local_data_source.dart'
    as _i514;
import 'package:mindnest_app/features/discovery/data/repositories/discovery_repository_impl.dart'
    as _i146;
import 'package:mindnest_app/features/discovery/domain/repositories/discovery_repository.dart'
    as _i1071;
import 'package:mindnest_app/features/discovery/domain/usecases/discovery_usecases.dart'
    as _i130;
import 'package:mindnest_app/features/discovery/presentation/cubit/booking_cubit.dart'
    as _i230;
import 'package:mindnest_app/features/discovery/presentation/cubit/discover_cubit.dart'
    as _i656;
import 'package:mindnest_app/features/discovery/presentation/cubit/therapist_profile_cubit.dart'
    as _i598;
import 'package:mindnest_app/features/feed/data/datasource/feed_local_data_source.dart'
    as _i680;
import 'package:mindnest_app/features/feed/data/repositories/feed_repository_impl.dart'
    as _i601;
import 'package:mindnest_app/features/feed/domain/repositories/feed_repository.dart'
    as _i222;
import 'package:mindnest_app/features/feed/domain/usecases/feed_usecases.dart'
    as _i725;
import 'package:mindnest_app/features/feed/presentation/cubit/comments_cubit.dart'
    as _i36;
import 'package:mindnest_app/features/feed/presentation/cubit/feed_cubit.dart'
    as _i738;
import 'package:mindnest_app/features/feed/presentation/cubit/post_detail_cubit.dart'
    as _i340;
import 'package:mindnest_app/features/home/presentation/cubit/home_cubit.dart'
    as _i120;
import 'package:mindnest_app/features/journal/data/datasource/journal_local_data_source.dart'
    as _i289;
import 'package:mindnest_app/features/journal/data/repositories/journal_repository_impl.dart'
    as _i467;
import 'package:mindnest_app/features/journal/domain/repositories/journal_repository.dart'
    as _i601;
import 'package:mindnest_app/features/journal/domain/usecases/journal_usecases.dart'
    as _i602;
import 'package:mindnest_app/features/journal/presentation/cubit/journal_entry_cubit.dart'
    as _i155;
import 'package:mindnest_app/features/journal/presentation/cubit/journal_list_cubit.dart'
    as _i1068;
import 'package:mindnest_app/features/journal/presentation/cubit/journal_write_cubit.dart'
    as _i974;
import 'package:mindnest_app/features/messaging/data/datasource/messaging_local_data_source.dart'
    as _i256;
import 'package:mindnest_app/features/messaging/data/repositories/messaging_repository_impl.dart'
    as _i502;
import 'package:mindnest_app/features/messaging/domain/repositories/messaging_repository.dart'
    as _i696;
import 'package:mindnest_app/features/messaging/domain/usecases/messaging_usecases.dart'
    as _i839;
import 'package:mindnest_app/features/messaging/presentation/cubit/chat_cubit.dart'
    as _i232;
import 'package:mindnest_app/features/messaging/presentation/cubit/conversations_cubit.dart'
    as _i3;
import 'package:mindnest_app/features/mood/data/datasource/mood_local_data_source.dart'
    as _i541;
import 'package:mindnest_app/features/mood/data/repositories/mood_repository_impl.dart'
    as _i573;
import 'package:mindnest_app/features/mood/domain/repositories/mood_repository.dart'
    as _i196;
import 'package:mindnest_app/features/mood/domain/usecases/mood_usecases.dart'
    as _i368;
import 'package:mindnest_app/features/mood/presentation/cubit/mood_history_cubit.dart'
    as _i274;
import 'package:mindnest_app/features/mood/presentation/cubit/mood_insights_cubit.dart'
    as _i595;
import 'package:mindnest_app/features/mood/presentation/cubit/mood_track_cubit.dart'
    as _i935;
import 'package:mindnest_app/features/notifications/data/datasource/notifications_local_data_source.dart'
    as _i371;
import 'package:mindnest_app/features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i221;
import 'package:mindnest_app/features/notifications/domain/repositories/notifications_repository.dart'
    as _i6;
import 'package:mindnest_app/features/notifications/domain/usecases/get_notifications.dart'
    as _i865;
import 'package:mindnest_app/features/notifications/presentation/cubit/notifications_cubit.dart'
    as _i221;
import 'package:mindnest_app/features/onboarding/data/datasource/onboarding_local_data_source.dart'
    as _i498;
import 'package:mindnest_app/features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i344;
import 'package:mindnest_app/features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i463;
import 'package:mindnest_app/features/onboarding/domain/usecases/onboarding_usecases.dart'
    as _i623;
import 'package:mindnest_app/features/onboarding/presentation/cubit/questionnaire_cubit.dart'
    as _i162;
import 'package:mindnest_app/features/professional/data/datasource/professional_local_data_source.dart'
    as _i906;
import 'package:mindnest_app/features/professional/data/repositories/professional_repository_impl.dart'
    as _i32;
import 'package:mindnest_app/features/professional/domain/repositories/professional_repository.dart'
    as _i1058;
import 'package:mindnest_app/features/professional/domain/usecases/professional_usecases.dart'
    as _i818;
import 'package:mindnest_app/features/professional/presentation/cubit/create_post_cubit.dart'
    as _i804;
import 'package:mindnest_app/features/professional/presentation/cubit/pro_clients_cubit.dart'
    as _i520;
import 'package:mindnest_app/features/professional/presentation/cubit/pro_content_cubit.dart'
    as _i194;
import 'package:mindnest_app/features/professional/presentation/cubit/pro_dashboard_cubit.dart'
    as _i618;
import 'package:mindnest_app/features/professional/presentation/cubit/pro_requests_cubit.dart'
    as _i932;
import 'package:mindnest_app/features/profile/data/datasource/profile_local_data_source.dart'
    as _i740;
import 'package:mindnest_app/features/profile/data/repositories/profile_repository_impl.dart'
    as _i344;
import 'package:mindnest_app/features/profile/domain/repositories/profile_repository.dart'
    as _i657;
import 'package:mindnest_app/features/profile/domain/usecases/profile_usecases.dart'
    as _i432;
import 'package:mindnest_app/features/profile/presentation/cubit/profile_cubit.dart'
    as _i201;
import 'package:mindnest_app/features/settings/presentation/cubit/settings_cubit.dart'
    as _i238;
import 'package:mindnest_app/features/settings/presentation/cubit/theme_cubit.dart'
    as _i577;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i935.MoodTrackCubit>(() => _i935.MoodTrackCubit());
    gh.factory<_i238.SettingsCubit>(() => _i238.SettingsCubit());
    gh.lazySingleton<_i644.SessionService>(() => _i644.SessionService());
    gh.lazySingleton<_i634.AuthRemoteDataSource>(
      () => _i634.AuthRemoteDataSource(),
    );
    gh.lazySingleton<_i514.DiscoveryLocalDataSource>(
      () => _i514.DiscoveryLocalDataSource(),
    );
    gh.lazySingleton<_i680.FeedLocalDataSource>(
      () => _i680.FeedLocalDataSource(),
    );
    gh.lazySingleton<_i289.JournalLocalDataSource>(
      () => _i289.JournalLocalDataSource(),
    );
    gh.lazySingleton<_i256.MessagingLocalDataSource>(
      () => _i256.MessagingLocalDataSource(),
    );
    gh.lazySingleton<_i541.MoodLocalDataSource>(
      () => _i541.MoodLocalDataSource(),
    );
    gh.lazySingleton<_i371.NotificationsLocalDataSource>(
      () => _i371.NotificationsLocalDataSource(),
    );
    gh.lazySingleton<_i498.OnboardingLocalDataSource>(
      () => _i498.OnboardingLocalDataSource(),
    );
    gh.lazySingleton<_i906.ProfessionalLocalDataSource>(
      () => _i906.ProfessionalLocalDataSource(),
    );
    gh.lazySingleton<_i740.ProfileLocalDataSource>(
      () => _i740.ProfileLocalDataSource(),
    );
    gh.lazySingleton<_i423.NetworkInfo>(() => _i423.NetworkInfoImpl());
    gh.lazySingleton<_i167.KeyValueStorage>(
      () => _i167.InMemoryKeyValueStorage(),
    );
    gh.lazySingleton<_i657.ProfileRepository>(
      () => _i344.ProfileRepositoryImpl(),
    );
    gh.lazySingleton<_i463.OnboardingRepository>(
      () =>
          _i344.OnboardingRepositoryImpl(gh<_i498.OnboardingLocalDataSource>()),
    );
    gh.lazySingleton<_i672.DioClient>(
      () => _i672.DioClient(gh<_i644.SessionService>()),
    );
    gh.lazySingleton<_i222.FeedRepository>(() => _i601.FeedRepositoryImpl());
    gh.lazySingleton<_i432.GetUserProfile>(
      () => _i432.GetUserProfile(gh<_i657.ProfileRepository>()),
    );
    gh.lazySingleton<_i196.MoodRepository>(() => _i573.MoodRepositoryImpl());
    gh.lazySingleton<_i6.NotificationsRepository>(
      () => _i221.NotificationsRepositoryImpl(),
    );
    gh.lazySingleton<_i601.JournalRepository>(
      () => _i467.JournalRepositoryImpl(),
    );
    gh.lazySingleton<_i577.ThemeCubit>(
      () => _i577.ThemeCubit(gh<_i167.KeyValueStorage>()),
    );
    gh.lazySingleton<_i368.GetMoodHistory>(
      () => _i368.GetMoodHistory(gh<_i196.MoodRepository>()),
    );
    gh.lazySingleton<_i368.GetMoodInsights>(
      () => _i368.GetMoodInsights(gh<_i196.MoodRepository>()),
    );
    gh.lazySingleton<_i368.GetWeekMood>(
      () => _i368.GetWeekMood(gh<_i196.MoodRepository>()),
    );
    gh.lazySingleton<_i368.LogMood>(
      () => _i368.LogMood(gh<_i196.MoodRepository>()),
    );
    gh.lazySingleton<_i1071.DiscoveryRepository>(
      () => _i146.DiscoveryRepositoryImpl(gh<_i514.DiscoveryLocalDataSource>()),
    );
    gh.factory<_i595.MoodInsightsCubit>(
      () => _i595.MoodInsightsCubit(gh<_i368.GetMoodInsights>()),
    );
    gh.lazySingleton<_i1058.ProfessionalRepository>(
      () => _i32.ProfessionalRepositoryImpl(
        gh<_i906.ProfessionalLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i864.AuthRepository>(
      () => _i640.AuthRepositoryImpl(gh<_i634.AuthRemoteDataSource>()),
    );
    gh.factory<_i201.ProfileCubit>(
      () => _i201.ProfileCubit(gh<_i432.GetUserProfile>()),
    );
    gh.lazySingleton<_i623.SaveOnboarding>(
      () => _i623.SaveOnboarding(gh<_i463.OnboardingRepository>()),
    );
    gh.lazySingleton<_i130.GetTherapists>(
      () => _i130.GetTherapists(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i130.GetTherapist>(
      () => _i130.GetTherapist(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i130.GetRecommendedTherapists>(
      () => _i130.GetRecommendedTherapists(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i130.GetTherapistReviews>(
      () => _i130.GetTherapistReviews(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i130.GetUpcomingAppointment>(
      () => _i130.GetUpcomingAppointment(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i130.SubmitBooking>(
      () => _i130.SubmitBooking(gh<_i1071.DiscoveryRepository>()),
    );
    gh.lazySingleton<_i696.MessagingRepository>(
      () => _i502.MessagingRepositoryImpl(gh<_i256.MessagingLocalDataSource>()),
    );
    gh.factory<_i598.TherapistProfileCubit>(
      () => _i598.TherapistProfileCubit(
        gh<_i130.GetTherapist>(),
        gh<_i130.GetTherapistReviews>(),
      ),
    );
    gh.factory<_i162.QuestionnaireCubit>(
      () => _i162.QuestionnaireCubit(gh<_i623.SaveOnboarding>()),
    );
    gh.lazySingleton<_i865.GetNotifications>(
      () => _i865.GetNotifications(gh<_i6.NotificationsRepository>()),
    );
    gh.lazySingleton<_i839.GetConversations>(
      () => _i839.GetConversations(gh<_i696.MessagingRepository>()),
    );
    gh.lazySingleton<_i839.GetMessages>(
      () => _i839.GetMessages(gh<_i696.MessagingRepository>()),
    );
    gh.lazySingleton<_i602.GetJournalEntries>(
      () => _i602.GetJournalEntries(gh<_i601.JournalRepository>()),
    );
    gh.lazySingleton<_i602.GetJournalEntry>(
      () => _i602.GetJournalEntry(gh<_i601.JournalRepository>()),
    );
    gh.lazySingleton<_i602.SaveJournalEntry>(
      () => _i602.SaveJournalEntry(gh<_i601.JournalRepository>()),
    );
    gh.lazySingleton<_i725.GetPosts>(
      () => _i725.GetPosts(gh<_i222.FeedRepository>()),
    );
    gh.lazySingleton<_i725.GetPost>(
      () => _i725.GetPost(gh<_i222.FeedRepository>()),
    );
    gh.lazySingleton<_i725.GetComments>(
      () => _i725.GetComments(gh<_i222.FeedRepository>()),
    );
    gh.lazySingleton<_i725.AddComment>(
      () => _i725.AddComment(gh<_i222.FeedRepository>()),
    );
    gh.factory<_i230.BookingCubit>(
      () => _i230.BookingCubit(gh<_i130.SubmitBooking>()),
    );
    gh.factory<_i3.ConversationsCubit>(
      () => _i3.ConversationsCubit(gh<_i839.GetConversations>()),
    );
    gh.lazySingleton<_i818.GetDashboardStats>(
      () => _i818.GetDashboardStats(gh<_i1058.ProfessionalRepository>()),
    );
    gh.lazySingleton<_i818.GetBookingRequests>(
      () => _i818.GetBookingRequests(gh<_i1058.ProfessionalRepository>()),
    );
    gh.lazySingleton<_i818.GetTodaySessions>(
      () => _i818.GetTodaySessions(gh<_i1058.ProfessionalRepository>()),
    );
    gh.lazySingleton<_i818.GetProClients>(
      () => _i818.GetProClients(gh<_i1058.ProfessionalRepository>()),
    );
    gh.lazySingleton<_i818.GetProPosts>(
      () => _i818.GetProPosts(gh<_i1058.ProfessionalRepository>()),
    );
    gh.lazySingleton<_i818.GetProPost>(
      () => _i818.GetProPost(gh<_i1058.ProfessionalRepository>()),
    );
    gh.factory<_i155.JournalEntryCubit>(
      () => _i155.JournalEntryCubit(gh<_i602.GetJournalEntry>()),
    );
    gh.factory<_i618.ProDashboardCubit>(
      () => _i618.ProDashboardCubit(
        gh<_i818.GetDashboardStats>(),
        gh<_i818.GetTodaySessions>(),
      ),
    );
    gh.factory<_i274.MoodHistoryCubit>(
      () => _i274.MoodHistoryCubit(gh<_i368.GetMoodHistory>()),
    );
    gh.factory<_i36.CommentsCubit>(
      () => _i36.CommentsCubit(gh<_i725.GetComments>(), gh<_i725.AddComment>()),
    );
    gh.factory<_i194.ProContentCubit>(
      () => _i194.ProContentCubit(gh<_i818.GetProPosts>()),
    );
    gh.factory<_i738.FeedCubit>(() => _i738.FeedCubit(gh<_i725.GetPosts>()));
    gh.factory<_i974.JournalWriteCubit>(
      () => _i974.JournalWriteCubit(gh<_i602.SaveJournalEntry>()),
    );
    gh.factory<_i232.ChatCubit>(() => _i232.ChatCubit(gh<_i839.GetMessages>()));
    gh.factory<_i804.CreatePostCubit>(
      () => _i804.CreatePostCubit(gh<_i818.GetProPost>()),
    );
    gh.lazySingleton<_i143.SignIn>(
      () => _i143.SignIn(gh<_i864.AuthRepository>()),
    );
    gh.lazySingleton<_i143.SignUp>(
      () => _i143.SignUp(gh<_i864.AuthRepository>()),
    );
    gh.lazySingleton<_i143.VerifyOtp>(
      () => _i143.VerifyOtp(gh<_i864.AuthRepository>()),
    );
    gh.lazySingleton<_i143.RequestPasswordReset>(
      () => _i143.RequestPasswordReset(gh<_i864.AuthRepository>()),
    );
    gh.factory<_i855.AuthCubit>(
      () => _i855.AuthCubit(
        gh<_i143.SignIn>(),
        gh<_i143.SignUp>(),
        gh<_i143.VerifyOtp>(),
        gh<_i143.RequestPasswordReset>(),
        gh<_i644.SessionService>(),
      ),
    );
    gh.factory<_i656.DiscoverCubit>(
      () => _i656.DiscoverCubit(gh<_i130.GetTherapists>()),
    );
    gh.factory<_i340.PostDetailCubit>(
      () => _i340.PostDetailCubit(gh<_i725.GetPost>()),
    );
    gh.factory<_i120.HomeCubit>(
      () => _i120.HomeCubit(
        gh<_i130.GetUpcomingAppointment>(),
        gh<_i130.GetRecommendedTherapists>(),
        gh<_i130.GetTherapist>(),
        gh<_i368.GetWeekMood>(),
      ),
    );
    gh.factory<_i221.NotificationsCubit>(
      () => _i221.NotificationsCubit(gh<_i865.GetNotifications>()),
    );
    gh.factory<_i932.ProRequestsCubit>(
      () => _i932.ProRequestsCubit(gh<_i818.GetBookingRequests>()),
    );
    gh.factory<_i520.ProClientsCubit>(
      () => _i520.ProClientsCubit(gh<_i818.GetProClients>()),
    );
    gh.factory<_i1068.JournalListCubit>(
      () => _i1068.JournalListCubit(gh<_i602.GetJournalEntries>()),
    );
    return this;
  }
}
