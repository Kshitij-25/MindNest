import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/journal/presentation/bloc/journal_bloc.dart';
import '../../features/mood/presentation/bloc/mood_bloc.dart';
import '../../features/notifications/presentation/bloc/notifications_bloc.dart';
import '../../features/practice/presentation/bloc/content_cubit.dart';
import '../../features/practice/presentation/bloc/dashboard_cubit.dart';
import '../../features/practice/presentation/bloc/requests_bloc.dart';
import '../../features/sessions/presentation/bloc/sessions_bloc.dart';
import 'injection.dart';

/// Drops app-wide blocs that hold the signed-in user's data, so the next
/// account on this device starts clean. Old instances are closed after the
/// signed-in screens have been torn down.
void resetUserScope() {
  final stale = <BlocBase<Object?>>[];
  void reset<T extends BlocBase<Object?>>() {
    if (!getIt.isRegistered<T>() || !getIt.checkLazySingletonInstanceExists<T>()) return;
    stale.add(getIt<T>());
    getIt.resetLazySingleton<T>();
  }

  reset<JournalBloc>();
  reset<MoodBloc>();
  reset<NotificationsBloc>();
  reset<SessionsBloc>();
  reset<RequestsBloc>();
  reset<DashboardCubit>();
  reset<ContentCubit>();
  Future<void>.delayed(const Duration(seconds: 2), () {
    for (final b in stale) {
      b.close();
    }
  });
}
