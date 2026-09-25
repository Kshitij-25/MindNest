import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/therapist.dart';
import '../entities/therapist_filter.dart';
import '../repositories/therapist_repository.dart';

@injectable
class GetTherapists implements UseCase<List<Therapist>, TherapistFilter> {
  const GetTherapists(this._repo);
  final TherapistRepository _repo;

  @override
  ResultFuture<List<Therapist>> call(TherapistFilter f) => _repo.getTherapists(f);
}

@injectable
class GetTherapist implements UseCase<Therapist, String> {
  const GetTherapist(this._repo);
  final TherapistRepository _repo;

  @override
  ResultFuture<Therapist> call(String id) => _repo.getTherapist(id);
}

@injectable
class GetTherapistReviews implements UseCase<List<Review>, String> {
  const GetTherapistReviews(this._repo);
  final TherapistRepository _repo;

  @override
  ResultFuture<List<Review>> call(String id) => _repo.getReviews(id);
}

@injectable
class GetWeeklyAvailability implements UseCase<List<DayAvailability>, String> {
  const GetWeeklyAvailability(this._repo);
  final TherapistRepository _repo;

  @override
  ResultFuture<List<DayAvailability>> call(String id) => _repo.getWeeklyAvailability(id);
}

@injectable
class ToggleSavedTherapist implements UseCase<bool, String> {
  const ToggleSavedTherapist(this._repo);
  final TherapistRepository _repo;

  @override
  ResultFuture<bool> call(String id) => _repo.toggleSaved(id);
}
