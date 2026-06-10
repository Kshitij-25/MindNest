import 'package:injectable/injectable.dart';
import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/appointment.dart';
import '../entities/therapist.dart';
import '../repositories/discovery_repository.dart';

@lazySingleton
class GetTherapists implements UseCase<List<Therapist>, NoParams> {
  GetTherapists(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<List<Therapist>>> call(NoParams params) =>
      _repo.getTherapists();
}

@lazySingleton
class GetTherapist implements UseCase<Therapist, String> {
  GetTherapist(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<Therapist>> call(String id) => _repo.getTherapist(id);
}

@lazySingleton
class GetRecommendedTherapists implements UseCase<List<Therapist>, NoParams> {
  GetRecommendedTherapists(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<List<Therapist>>> call(NoParams params) =>
      _repo.getRecommended();
}

@lazySingleton
class GetTherapistReviews implements UseCase<List<Review>, String> {
  GetTherapistReviews(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<List<Review>>> call(String therapistId) =>
      _repo.getReviews(therapistId);
}

@lazySingleton
class GetUpcomingAppointment implements UseCase<Appointment?, NoParams> {
  GetUpcomingAppointment(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<Appointment?>> call(NoParams params) =>
      _repo.getUpcomingAppointment();
}

@lazySingleton
class SubmitBooking implements UseCase<Unit, BookingDraft> {
  SubmitBooking(this._repo);
  final DiscoveryRepository _repo;
  @override
  Future<Result<Unit>> call(BookingDraft draft) => _repo.submitBooking(draft);
}
