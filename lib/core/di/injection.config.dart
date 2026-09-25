// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mindnest/core/di/register_module.dart' as _i433;
import 'package:mindnest/core/firebase/session.dart' as _i871;
import 'package:mindnest/core/push/push_service.dart' as _i1072;
import 'package:mindnest/core/router/app_router.dart' as _i687;
import 'package:mindnest/features/auth/data/datasources/auth_local_data_source.dart'
    as _i572;
import 'package:mindnest/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i530;
import 'package:mindnest/features/auth/data/repositories/auth_repository_impl.dart'
    as _i1046;
import 'package:mindnest/features/auth/domain/repositories/auth_repository.dart'
    as _i418;
import 'package:mindnest/features/auth/domain/usecases/auth_usecases.dart'
    as _i340;
import 'package:mindnest/features/auth/presentation/bloc/auth_bloc.dart'
    as _i548;
import 'package:mindnest/features/auth/presentation/cubit/forgot_password_cubit.dart'
    as _i346;
import 'package:mindnest/features/auth/presentation/cubit/otp_cubit.dart'
    as _i958;
import 'package:mindnest/features/auth/presentation/cubit/sign_in_cubit.dart'
    as _i462;
import 'package:mindnest/features/auth/presentation/cubit/sign_up_cubit.dart'
    as _i945;
import 'package:mindnest/features/chat/data/datasources/chat_data_source.dart'
    as _i90;
import 'package:mindnest/features/chat/data/repositories/chat_repository_impl.dart'
    as _i1041;
import 'package:mindnest/features/chat/domain/repositories/chat_repository.dart'
    as _i1059;
import 'package:mindnest/features/chat/domain/usecases/chat_usecases.dart'
    as _i961;
import 'package:mindnest/features/chat/presentation/bloc/chat_thread_bloc.dart'
    as _i878;
import 'package:mindnest/features/chat/presentation/bloc/conversations_bloc.dart'
    as _i358;
import 'package:mindnest/features/feed/data/datasources/feed_data_source.dart'
    as _i692;
import 'package:mindnest/features/feed/data/repositories/feed_repository_impl.dart'
    as _i757;
import 'package:mindnest/features/feed/domain/repositories/feed_repository.dart'
    as _i1061;
import 'package:mindnest/features/feed/domain/usecases/feed_usecases.dart'
    as _i92;
import 'package:mindnest/features/feed/presentation/bloc/feed_bloc.dart'
    as _i697;
import 'package:mindnest/features/feed/presentation/bloc/post_detail_cubit.dart'
    as _i859;
import 'package:mindnest/features/home/presentation/cubit/home_cubit.dart'
    as _i23;
import 'package:mindnest/features/journal/data/datasources/journal_data_source.dart'
    as _i1024;
import 'package:mindnest/features/journal/data/repositories/journal_repository_impl.dart'
    as _i496;
import 'package:mindnest/features/journal/domain/repositories/journal_repository.dart'
    as _i768;
import 'package:mindnest/features/journal/domain/usecases/journal_usecases.dart'
    as _i314;
import 'package:mindnest/features/journal/presentation/bloc/journal_bloc.dart'
    as _i840;
import 'package:mindnest/features/journal/presentation/bloc/journal_editor_cubit.dart'
    as _i901;
import 'package:mindnest/features/mood/data/datasources/mood_data_source.dart'
    as _i252;
import 'package:mindnest/features/mood/data/repositories/mood_repository_impl.dart'
    as _i322;
import 'package:mindnest/features/mood/domain/repositories/mood_repository.dart'
    as _i98;
import 'package:mindnest/features/mood/domain/usecases/mood_usecases.dart'
    as _i389;
import 'package:mindnest/features/mood/presentation/bloc/mood_bloc.dart'
    as _i326;
import 'package:mindnest/features/mood/presentation/bloc/mood_track_cubit.dart'
    as _i338;
import 'package:mindnest/features/notifications/data/datasources/notifications_data_source.dart'
    as _i270;
import 'package:mindnest/features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i126;
import 'package:mindnest/features/notifications/domain/repositories/notifications_repository.dart'
    as _i233;
import 'package:mindnest/features/notifications/domain/usecases/notifications_usecases.dart'
    as _i359;
import 'package:mindnest/features/notifications/presentation/bloc/notifications_bloc.dart'
    as _i789;
import 'package:mindnest/features/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i637;
import 'package:mindnest/features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i149;
import 'package:mindnest/features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i987;
import 'package:mindnest/features/onboarding/domain/usecases/onboarding_usecases.dart'
    as _i998;
import 'package:mindnest/features/onboarding/presentation/cubit/questionnaire_cubit.dart'
    as _i446;
import 'package:mindnest/features/practice/data/datasources/practice_data_source.dart'
    as _i471;
import 'package:mindnest/features/practice/data/repositories/practice_repository_impl.dart'
    as _i137;
import 'package:mindnest/features/practice/domain/repositories/practice_repository.dart'
    as _i989;
import 'package:mindnest/features/practice/domain/usecases/practice_usecases.dart'
    as _i889;
import 'package:mindnest/features/practice/presentation/bloc/calendar_cubit.dart'
    as _i1037;
import 'package:mindnest/features/practice/presentation/bloc/clients_cubit.dart'
    as _i956;
import 'package:mindnest/features/practice/presentation/bloc/content_cubit.dart'
    as _i378;
import 'package:mindnest/features/practice/presentation/bloc/dashboard_cubit.dart'
    as _i242;
import 'package:mindnest/features/practice/presentation/bloc/earnings_cubit.dart'
    as _i295;
import 'package:mindnest/features/practice/presentation/bloc/requests_bloc.dart'
    as _i168;
import 'package:mindnest/features/practice/presentation/bloc/verification_cubit.dart'
    as _i847;
import 'package:mindnest/features/profile/data/datasources/profile_data_source.dart'
    as _i84;
import 'package:mindnest/features/profile/data/repositories/profile_repository_impl.dart'
    as _i125;
import 'package:mindnest/features/profile/domain/repositories/profile_repository.dart'
    as _i522;
import 'package:mindnest/features/profile/domain/usecases/profile_usecases.dart'
    as _i237;
import 'package:mindnest/features/profile/presentation/cubit/edit_profile_cubit.dart'
    as _i465;
import 'package:mindnest/features/sessions/data/datasources/sessions_data_source.dart'
    as _i587;
import 'package:mindnest/features/sessions/data/repositories/sessions_repository_impl.dart'
    as _i147;
import 'package:mindnest/features/sessions/domain/repositories/sessions_repository.dart'
    as _i225;
import 'package:mindnest/features/sessions/domain/usecases/sessions_usecases.dart'
    as _i968;
import 'package:mindnest/features/sessions/presentation/bloc/booking_cubit.dart'
    as _i571;
import 'package:mindnest/features/sessions/presentation/bloc/sessions_bloc.dart'
    as _i592;
import 'package:mindnest/features/settings/data/datasources/settings_local_data_source.dart'
    as _i839;
import 'package:mindnest/features/settings/data/repositories/settings_repository_impl.dart'
    as _i91;
import 'package:mindnest/features/settings/domain/repositories/settings_repository.dart'
    as _i954;
import 'package:mindnest/features/settings/domain/usecases/settings_usecases.dart'
    as _i215;
import 'package:mindnest/features/settings/presentation/cubit/settings_cubit.dart'
    as _i567;
import 'package:mindnest/features/therapists/data/datasources/therapist_data_source.dart'
    as _i4;
import 'package:mindnest/features/therapists/data/repositories/therapist_repository_impl.dart'
    as _i316;
import 'package:mindnest/features/therapists/domain/repositories/therapist_repository.dart'
    as _i824;
import 'package:mindnest/features/therapists/domain/usecases/therapist_usecases.dart'
    as _i906;
import 'package:mindnest/features/therapists/presentation/bloc/discover_bloc.dart'
    as _i52;
import 'package:mindnest/features/therapists/presentation/bloc/therapist_profile_cubit.dart'
    as _i343;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i892.FirebaseMessaging>(() => registerModule.messaging);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i530.AuthRemoteDataSource>(
      () => _i530.FirebaseAuthRemoteDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i839.SettingsLocalDataSource>(
      () => _i839.SettingsLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i572.AuthLocalDataSource>(
      () => _i572.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i637.OnboardingLocalDataSource>(
      () => _i637.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i871.FirebaseSession>(
      () => _i871.FirebaseSession(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i954.SettingsRepository>(
      () => _i91.SettingsRepositoryImpl(
        gh<_i839.SettingsLocalDataSource>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i252.MoodDataSource>(
      () => _i252.FirestoreMoodDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i4.TherapistDataSource>(
      () => _i4.FirestoreTherapistDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i471.PracticeDataSource>(
      () => _i471.FirestorePracticeDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i989.PracticeRepository>(
      () => _i137.PracticeRepositoryImpl(gh<_i471.PracticeDataSource>()),
    );
    gh.lazySingleton<_i637.OnboardingRemoteDataSource>(
      () => _i637.FirestoreOnboardingDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i1024.JournalDataSource>(
      () => _i1024.FirestoreJournalDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i768.JournalRepository>(
      () => _i496.JournalRepositoryImpl(gh<_i1024.JournalDataSource>()),
    );
    gh.lazySingleton<_i587.SessionsDataSource>(
      () => _i587.FirestoreSessionsDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i90.ChatDataSource>(
      () => _i90.FirestoreChatDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i418.AuthRepository>(
      () => _i1046.AuthRepositoryImpl(
        gh<_i530.AuthRemoteDataSource>(),
        gh<_i572.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i889.GetVerificationDocuments>(
      () => _i889.GetVerificationDocuments(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.SetDocumentUploaded>(
      () => _i889.SetDocumentUploaded(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.SubmitVerification>(
      () => _i889.SubmitVerification(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetPracticeDashboard>(
      () => _i889.GetPracticeDashboard(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.SetAcceptingClients>(
      () => _i889.SetAcceptingClients(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetSessionRequests>(
      () => _i889.GetSessionRequests(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.RespondToRequest>(
      () => _i889.RespondToRequest(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetWeekSchedule>(
      () => _i889.GetWeekSchedule(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetClients>(
      () => _i889.GetClients(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetClientDetail>(
      () => _i889.GetClientDetail(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.AddClientNote>(
      () => _i889.AddClientNote(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.ToggleClientGoal>(
      () => _i889.ToggleClientGoal(gh<_i989.PracticeRepository>()),
    );
    gh.factory<_i889.GetEarnings>(
      () => _i889.GetEarnings(gh<_i989.PracticeRepository>()),
    );
    gh.lazySingleton<_i824.TherapistRepository>(
      () => _i316.TherapistRepositoryImpl(gh<_i4.TherapistDataSource>()),
    );
    gh.lazySingleton<_i987.OnboardingRepository>(
      () => _i149.OnboardingRepositoryImpl(
        gh<_i637.OnboardingLocalDataSource>(),
        gh<_i637.OnboardingRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i270.NotificationsDataSource>(
      () => _i270.FirestoreNotificationsDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.lazySingleton<_i84.ProfileDataSource>(
      () => _i84.FirestoreProfileDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.factory<_i295.EarningsCubit>(
      () => _i295.EarningsCubit(gh<_i889.GetEarnings>()),
    );
    gh.lazySingleton<_i692.FeedDataSource>(
      () => _i692.FirestoreFeedDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i871.FirebaseSession>(),
      ),
    );
    gh.factory<_i215.LoadPreferences>(
      () => _i215.LoadPreferences(gh<_i954.SettingsRepository>()),
    );
    gh.factory<_i215.SavePreferences>(
      () => _i215.SavePreferences(gh<_i954.SettingsRepository>()),
    );
    gh.factory<_i314.GetJournalEntries>(
      () => _i314.GetJournalEntries(gh<_i768.JournalRepository>()),
    );
    gh.factory<_i314.SaveJournalEntry>(
      () => _i314.SaveJournalEntry(gh<_i768.JournalRepository>()),
    );
    gh.factory<_i314.DeleteJournalEntry>(
      () => _i314.DeleteJournalEntry(gh<_i768.JournalRepository>()),
    );
    gh.lazySingleton<_i840.JournalBloc>(
      () => _i840.JournalBloc(
        gh<_i314.GetJournalEntries>(),
        gh<_i314.SaveJournalEntry>(),
        gh<_i314.DeleteJournalEntry>(),
      ),
    );
    gh.factory<_i901.JournalEditorCubit>(
      () => _i901.JournalEditorCubit(
        gh<_i314.SaveJournalEntry>(),
        gh<_i840.JournalBloc>(),
      ),
    );
    gh.factory<_i956.ClientsCubit>(
      () => _i956.ClientsCubit(gh<_i889.GetClients>()),
    );
    gh.singleton<_i687.AppRouter>(
      () => _i687.AppRouter(gh<_i418.AuthRepository>()),
    );
    gh.lazySingleton<_i1059.ChatRepository>(
      () => _i1041.ChatRepositoryImpl(gh<_i90.ChatDataSource>()),
    );
    gh.factory<_i340.SignIn>(() => _i340.SignIn(gh<_i418.AuthRepository>()));
    gh.factory<_i340.SignUp>(() => _i340.SignUp(gh<_i418.AuthRepository>()));
    gh.factory<_i340.SocialSignIn>(
      () => _i340.SocialSignIn(gh<_i418.AuthRepository>()),
    );
    gh.factory<_i340.SendPasswordReset>(
      () => _i340.SendPasswordReset(gh<_i418.AuthRepository>()),
    );
    gh.factory<_i340.CheckEmailVerified>(
      () => _i340.CheckEmailVerified(gh<_i418.AuthRepository>()),
    );
    gh.factory<_i340.ResendVerificationEmail>(
      () => _i340.ResendVerificationEmail(gh<_i418.AuthRepository>()),
    );
    gh.factory<_i340.UpdateUser>(
      () => _i340.UpdateUser(gh<_i418.AuthRepository>()),
    );
    gh.factory<_i340.SignOut>(() => _i340.SignOut(gh<_i418.AuthRepository>()));
    gh.lazySingleton<_i168.RequestsBloc>(
      () => _i168.RequestsBloc(
        gh<_i889.GetSessionRequests>(),
        gh<_i889.RespondToRequest>(),
      ),
    );
    gh.factory<_i998.SaveAssessment>(
      () => _i998.SaveAssessment(gh<_i987.OnboardingRepository>()),
    );
    gh.factory<_i998.GetAssessment>(
      () => _i998.GetAssessment(gh<_i987.OnboardingRepository>()),
    );
    gh.factory<_i956.ClientDetailCubit>(
      () => _i956.ClientDetailCubit(
        gh<_i889.GetClientDetail>(),
        gh<_i889.AddClientNote>(),
        gh<_i889.ToggleClientGoal>(),
      ),
    );
    gh.lazySingleton<_i1061.FeedRepository>(
      () => _i757.FeedRepositoryImpl(
        gh<_i692.FeedDataSource>(),
        gh<_i418.AuthRepository>(),
      ),
    );
    gh.factory<_i462.SignInCubit>(
      () => _i462.SignInCubit(gh<_i340.SignIn>(), gh<_i340.SocialSignIn>()),
    );
    gh.lazySingleton<_i567.SettingsCubit>(
      () => _i567.SettingsCubit(
        gh<_i215.LoadPreferences>(),
        gh<_i215.SavePreferences>(),
      ),
    );
    gh.lazySingleton<_i522.ProfileRepository>(
      () => _i125.ProfileRepositoryImpl(gh<_i84.ProfileDataSource>()),
    );
    gh.factory<_i906.GetTherapists>(
      () => _i906.GetTherapists(gh<_i824.TherapistRepository>()),
    );
    gh.factory<_i906.GetTherapist>(
      () => _i906.GetTherapist(gh<_i824.TherapistRepository>()),
    );
    gh.factory<_i906.GetTherapistReviews>(
      () => _i906.GetTherapistReviews(gh<_i824.TherapistRepository>()),
    );
    gh.factory<_i906.GetWeeklyAvailability>(
      () => _i906.GetWeeklyAvailability(gh<_i824.TherapistRepository>()),
    );
    gh.factory<_i906.ToggleSavedTherapist>(
      () => _i906.ToggleSavedTherapist(gh<_i824.TherapistRepository>()),
    );
    gh.factory<_i446.QuestionnaireCubit>(
      () => _i446.QuestionnaireCubit(gh<_i998.SaveAssessment>()),
    );
    gh.lazySingleton<_i98.MoodRepository>(
      () => _i322.MoodRepositoryImpl(
        gh<_i252.MoodDataSource>(),
        gh<_i1024.JournalDataSource>(),
        gh<_i587.SessionsDataSource>(),
      ),
    );
    gh.factory<_i92.GetPosts>(() => _i92.GetPosts(gh<_i1061.FeedRepository>()));
    gh.factory<_i92.GetPost>(() => _i92.GetPost(gh<_i1061.FeedRepository>()));
    gh.factory<_i92.TogglePostLike>(
      () => _i92.TogglePostLike(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.TogglePostSave>(
      () => _i92.TogglePostSave(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.GetComments>(
      () => _i92.GetComments(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.AddComment>(
      () => _i92.AddComment(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.ToggleCommentLike>(
      () => _i92.ToggleCommentLike(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.GetMyPosts>(
      () => _i92.GetMyPosts(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i92.PublishPost>(
      () => _i92.PublishPost(gh<_i1061.FeedRepository>()),
    );
    gh.factory<_i958.OtpCubit>(
      () => _i958.OtpCubit(
        gh<_i340.CheckEmailVerified>(),
        gh<_i340.ResendVerificationEmail>(),
      ),
    );
    gh.factory<_i1037.CalendarCubit>(
      () => _i1037.CalendarCubit(gh<_i889.GetWeekSchedule>()),
    );
    gh.lazySingleton<_i233.NotificationsRepository>(
      () => _i126.NotificationsRepositoryImpl(
        gh<_i270.NotificationsDataSource>(),
      ),
    );
    gh.lazySingleton<_i1072.PushService>(
      () => _i1072.PushService(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i892.FirebaseMessaging>(),
        gh<_i567.SettingsCubit>(),
        gh<_i687.AppRouter>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i225.SessionsRepository>(
      () => _i147.SessionsRepositoryImpl(
        gh<_i587.SessionsDataSource>(),
        gh<_i824.TherapistRepository>(),
      ),
    );
    gh.factory<_i847.VerificationCubit>(
      () => _i847.VerificationCubit(
        gh<_i889.GetVerificationDocuments>(),
        gh<_i889.SetDocumentUploaded>(),
        gh<_i889.SubmitVerification>(),
      ),
    );
    gh.factory<_i961.GetConversations>(
      () => _i961.GetConversations(gh<_i1059.ChatRepository>()),
    );
    gh.factory<_i961.OpenConversation>(
      () => _i961.OpenConversation(gh<_i1059.ChatRepository>()),
    );
    gh.factory<_i961.SendMessage>(
      () => _i961.SendMessage(gh<_i1059.ChatRepository>()),
    );
    gh.factory<_i961.WatchConversation>(
      () => _i961.WatchConversation(gh<_i1059.ChatRepository>()),
    );
    gh.factory<_i968.GetUpcomingSessions>(
      () => _i968.GetUpcomingSessions(gh<_i225.SessionsRepository>()),
    );
    gh.factory<_i968.GetPastSessions>(
      () => _i968.GetPastSessions(gh<_i225.SessionsRepository>()),
    );
    gh.factory<_i968.GetBookingDays>(
      () => _i968.GetBookingDays(gh<_i225.SessionsRepository>()),
    );
    gh.factory<_i968.BookSession>(
      () => _i968.BookSession(gh<_i225.SessionsRepository>()),
    );
    gh.factory<_i968.CancelSession>(
      () => _i968.CancelSession(gh<_i225.SessionsRepository>()),
    );
    gh.factory<_i945.SignUpCubit>(() => _i945.SignUpCubit(gh<_i340.SignUp>()));
    gh.factory<_i346.ForgotPasswordCubit>(
      () => _i346.ForgotPasswordCubit(gh<_i340.SendPasswordReset>()),
    );
    gh.factory<_i859.PostDetailCubit>(
      () => _i859.PostDetailCubit(
        gh<_i92.GetPost>(),
        gh<_i92.TogglePostLike>(),
        gh<_i92.TogglePostSave>(),
        gh<_i92.GetComments>(),
        gh<_i92.AddComment>(),
        gh<_i92.ToggleCommentLike>(),
      ),
    );
    gh.factory<_i52.DiscoverBloc>(
      () => _i52.DiscoverBloc(
        gh<_i906.GetTherapists>(),
        gh<_i906.ToggleSavedTherapist>(),
      ),
    );
    gh.factory<_i343.TherapistProfileCubit>(
      () => _i343.TherapistProfileCubit(
        gh<_i906.GetTherapist>(),
        gh<_i906.GetTherapistReviews>(),
        gh<_i906.GetWeeklyAvailability>(),
        gh<_i906.ToggleSavedTherapist>(),
      ),
    );
    gh.lazySingleton<_i242.DashboardCubit>(
      () => _i242.DashboardCubit(
        gh<_i889.GetPracticeDashboard>(),
        gh<_i889.SetAcceptingClients>(),
        gh<_i168.RequestsBloc>(),
      ),
    );
    gh.lazySingleton<_i548.AuthBloc>(
      () => _i548.AuthBloc(
        gh<_i418.AuthRepository>(),
        gh<_i340.UpdateUser>(),
        gh<_i340.SignOut>(),
        gh<_i1072.PushService>(),
      ),
    );
    gh.factory<_i237.GetProfileDetails>(
      () => _i237.GetProfileDetails(gh<_i522.ProfileRepository>()),
    );
    gh.factory<_i237.SaveProfileDetails>(
      () => _i237.SaveProfileDetails(gh<_i522.ProfileRepository>()),
    );
    gh.factory<_i358.ConversationsBloc>(
      () => _i358.ConversationsBloc(gh<_i961.GetConversations>()),
    );
    gh.factory<_i697.FeedBloc>(
      () => _i697.FeedBloc(
        gh<_i92.GetPosts>(),
        gh<_i92.TogglePostLike>(),
        gh<_i92.TogglePostSave>(),
      ),
    );
    gh.factory<_i359.GetNotifications>(
      () => _i359.GetNotifications(gh<_i233.NotificationsRepository>()),
    );
    gh.factory<_i359.WatchNotifications>(
      () => _i359.WatchNotifications(gh<_i233.NotificationsRepository>()),
    );
    gh.factory<_i359.MarkNotificationRead>(
      () => _i359.MarkNotificationRead(gh<_i233.NotificationsRepository>()),
    );
    gh.factory<_i359.MarkAllNotificationsRead>(
      () => _i359.MarkAllNotificationsRead(gh<_i233.NotificationsRepository>()),
    );
    gh.lazySingleton<_i378.ContentCubit>(
      () => _i378.ContentCubit(gh<_i92.GetMyPosts>()),
    );
    gh.factory<_i389.GetMoodSummary>(
      () => _i389.GetMoodSummary(gh<_i98.MoodRepository>()),
    );
    gh.factory<_i389.LogMood>(() => _i389.LogMood(gh<_i98.MoodRepository>()));
    gh.factory<_i878.ChatThreadBloc>(
      () => _i878.ChatThreadBloc(
        gh<_i961.OpenConversation>(),
        gh<_i961.SendMessage>(),
        gh<_i961.WatchConversation>(),
      ),
    );
    gh.lazySingleton<_i592.SessionsBloc>(
      () => _i592.SessionsBloc(
        gh<_i968.GetUpcomingSessions>(),
        gh<_i968.GetPastSessions>(),
        gh<_i968.CancelSession>(),
      ),
    );
    gh.factory<_i465.EditProfileCubit>(
      () => _i465.EditProfileCubit(
        gh<_i548.AuthBloc>(),
        gh<_i237.GetProfileDetails>(),
        gh<_i237.SaveProfileDetails>(),
        gh<_i340.UpdateUser>(),
      ),
    );
    gh.factory<_i571.BookingCubit>(
      () => _i571.BookingCubit(
        gh<_i906.GetTherapist>(),
        gh<_i968.GetBookingDays>(),
        gh<_i968.BookSession>(),
        gh<_i592.SessionsBloc>(),
      ),
    );
    gh.factory<_i378.CreatePostCubit>(
      () => _i378.CreatePostCubit(
        gh<_i92.PublishPost>(),
        gh<_i378.ContentCubit>(),
      ),
    );
    gh.lazySingleton<_i789.NotificationsBloc>(
      () => _i789.NotificationsBloc(
        gh<_i359.GetNotifications>(),
        gh<_i359.WatchNotifications>(),
        gh<_i359.MarkNotificationRead>(),
        gh<_i359.MarkAllNotificationsRead>(),
      ),
    );
    gh.lazySingleton<_i326.MoodBloc>(
      () => _i326.MoodBloc(gh<_i389.GetMoodSummary>(), gh<_i389.LogMood>()),
    );
    gh.factory<_i338.MoodTrackCubit>(
      () => _i338.MoodTrackCubit(gh<_i389.LogMood>(), gh<_i326.MoodBloc>()),
    );
    gh.factory<_i23.HomeCubit>(
      () => _i23.HomeCubit(
        gh<_i906.GetTherapists>(),
        gh<_i92.GetPosts>(),
        gh<_i326.MoodBloc>(),
        gh<_i592.SessionsBloc>(),
        gh<_i789.NotificationsBloc>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i433.RegisterModule {}
