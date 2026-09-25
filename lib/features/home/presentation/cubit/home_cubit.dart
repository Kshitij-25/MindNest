import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../feed/domain/entities/post.dart';
import '../../../feed/domain/usecases/feed_usecases.dart';
import '../../../mood/presentation/bloc/mood_bloc.dart';
import '../../../notifications/presentation/bloc/notifications_bloc.dart';
import '../../../sessions/presentation/bloc/sessions_bloc.dart';
import '../../../therapists/domain/entities/therapist.dart';
import '../../../therapists/domain/usecases/therapist_usecases.dart';
import '../../../therapists/domain/entities/therapist_filter.dart';

part 'home_cubit.freezed.dart';

/// Home-only data (recommendations). Mood, sessions and notifications come
/// from their feature blocs, which this cubit kicks off.
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(<Therapist>[]) List<Therapist> recommended,
    @Default(<Post>[]) List<Post> reading,
  }) = _HomeState;
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._therapists, this._posts, this._mood, this._sessions, this._notifications) : super(const HomeState());

  final GetTherapists _therapists;
  final GetPosts _posts;
  final MoodBloc _mood;
  final SessionsBloc _sessions;
  final NotificationsBloc _notifications;

  Future<void> load() async {
    _mood.add(const MoodEvent.load());
    _sessions.add(const SessionsEvent.load());
    _notifications.add(const NotificationsEvent.load());
    final t = await _therapists(const TherapistFilter());
    final p = await _posts(const GetPostsParams());
    emit(HomeState(
      recommended: t.getOrElse((_) => const []).take(3).toList(),
      reading: p.getOrElse((_) => const []).take(2).toList(),
    ));
  }

  Future<void> refresh() => load();
}
