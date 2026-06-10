import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/failures.dart';
import 'package:mindnest_app/shared/models/view_status.dart';

import '../../domain/entities/therapist.dart';
import '../../domain/usecases/discovery_usecases.dart';

class TherapistProfileState extends Equatable {
  const TherapistProfileState({
    this.status = ViewStatus.initial,
    this.therapist,
    this.reviews = const [],
    this.failure,
  });

  final ViewStatus status;
  final Therapist? therapist;
  final List<Review> reviews;
  final Failure? failure;

  @override
  List<Object?> get props => [status, therapist, reviews, failure];
}

@injectable
class TherapistProfileCubit extends Cubit<TherapistProfileState> {
  TherapistProfileCubit(this._getTherapist, this._getReviews)
    : super(const TherapistProfileState());
  final GetTherapist _getTherapist;
  final GetTherapistReviews _getReviews;

  Future<void> load(String id) async {
    emit(const TherapistProfileState(status: ViewStatus.loading));
    final therapistResult = await _getTherapist(id);
    final reviewsResult = await _getReviews(id);
    therapistResult.fold(
      (failure) => emit(
        TherapistProfileState(status: ViewStatus.error, failure: failure),
      ),
      (therapist) => emit(
        TherapistProfileState(
          status: ViewStatus.loaded,
          therapist: therapist,
          reviews: reviewsResult.valueOrNull ?? const [],
        ),
      ),
    );
  }
}
