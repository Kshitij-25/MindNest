import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/load_status.dart';
import '../../domain/entities/therapist.dart';
import '../../domain/usecases/therapist_usecases.dart';

part 'therapist_profile_cubit.freezed.dart';

@freezed
abstract class TherapistProfileState with _$TherapistProfileState {
  const factory TherapistProfileState({
    @Default(LoadStatus.initial) LoadStatus status,
    Therapist? therapist,
    @Default(<Review>[]) List<Review> reviews,
    @Default(<DayAvailability>[]) List<DayAvailability> availability,
    String? error,
  }) = _TherapistProfileState;
}

@injectable
class TherapistProfileCubit extends Cubit<TherapistProfileState> {
  TherapistProfileCubit(this._get, this._reviews, this._availability, this._toggle)
      : super(const TherapistProfileState());

  final GetTherapist _get;
  final GetTherapistReviews _reviews;
  final GetWeeklyAvailability _availability;
  final ToggleSavedTherapist _toggle;

  Future<void> load(String id) async {
    emit(state.copyWith(status: LoadStatus.loading));
    final res = await _get(id);
    await res.fold(
      (f) async => emit(state.copyWith(status: LoadStatus.failure, error: f.message)),
      (t) async {
        final reviews = (await _reviews(id)).getOrElse((_) => const []);
        final avail = (await _availability(id)).getOrElse((_) => const []);
        emit(state.copyWith(status: LoadStatus.success, therapist: t, reviews: reviews, availability: avail));
      },
    );
  }

  Future<void> toggleSaved() async {
    final t = state.therapist;
    if (t == null) return;
    emit(state.copyWith(therapist: t.copyWith(saved: !t.saved)));
    await _toggle(t.id);
  }
}
