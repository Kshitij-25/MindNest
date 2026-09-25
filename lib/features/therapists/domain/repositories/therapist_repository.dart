import '../../../../core/usecase/usecase.dart';
import '../entities/therapist.dart';
import '../entities/therapist_filter.dart';

abstract interface class TherapistRepository {
  ResultFuture<List<Therapist>> getTherapists([TherapistFilter filter = const TherapistFilter()]);
  ResultFuture<Therapist> getTherapist(String id);
  ResultFuture<List<Review>> getReviews(String therapistId);
  ResultFuture<List<DayAvailability>> getWeeklyAvailability(String therapistId);
  ResultFuture<bool> toggleSaved(String id);
}
