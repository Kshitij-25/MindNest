import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';
import 'package:mindnest_app/features/discovery/domain/entities/appointment.dart';
import 'package:mindnest_app/features/discovery/domain/entities/therapist.dart';
import 'package:mindnest_app/features/discovery/domain/usecases/discovery_usecases.dart';
import 'package:mindnest_app/features/mood/domain/usecases/mood_usecases.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = ViewStatus.initial,
    this.appointment,
    this.apptTherapist,
    this.recommended = const [],
    this.week = const [],
    this.failure,
  });

  final ViewStatus status;
  final Appointment? appointment;
  final Therapist? apptTherapist;
  final List<Therapist> recommended;
  final List<int> week;
  final Failure? failure;

  HomeState copyWith({
    ViewStatus? status,
    Appointment? appointment,
    Therapist? apptTherapist,
    List<Therapist>? recommended,
    List<int>? week,
    Failure? failure,
  }) => HomeState(
    status: status ?? this.status,
    appointment: appointment ?? this.appointment,
    apptTherapist: apptTherapist ?? this.apptTherapist,
    recommended: recommended ?? this.recommended,
    week: week ?? this.week,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [
    status,
    appointment,
    apptTherapist,
    recommended,
    week,
    failure,
  ];
}

/// Aggregates the discovery + mood features to compose the user dashboard.
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getUpcomingAppointment,
    this._getRecommended,
    this._getTherapist,
    this._getWeekMood,
  ) : super(const HomeState());

  final GetUpcomingAppointment _getUpcomingAppointment;
  final GetRecommendedTherapists _getRecommended;
  final GetTherapist _getTherapist;
  final GetWeekMood _getWeekMood;

  Future<void> load() async {
    emit(state.copyWith(status: ViewStatus.loading));

    final apptResult = await _getUpcomingAppointment(const NoParams());
    final recommendedResult = await _getRecommended(const NoParams());
    final weekResult = await _getWeekMood(const NoParams());

    Appointment? appointment;
    Therapist? apptTherapist;
    var recommended = <Therapist>[];
    var week = <int>[];
    Failure? failure;

    apptResult.fold((f) => failure ??= f, (a) => appointment = a);
    recommendedResult.fold((f) => failure ??= f, (r) => recommended = r);
    weekResult.fold((f) => failure ??= f, (w) => week = w);

    if (failure != null) {
      emit(state.copyWith(status: ViewStatus.error, failure: failure));
      return;
    }

    if (appointment != null) {
      final therapistResult = await _getTherapist(appointment!.therapistId);
      therapistResult.fold((f) => failure ??= f, (t) => apptTherapist = t);
      if (failure != null) {
        emit(state.copyWith(status: ViewStatus.error, failure: failure));
        return;
      }
    }

    emit(
      HomeState(
        status: ViewStatus.loaded,
        appointment: appointment,
        apptTherapist: apptTherapist,
        recommended: recommended,
        week: week,
      ),
    );
  }
}
