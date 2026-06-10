import 'package:mindnest_app/core/error/result.dart';
import 'package:mindnest_app/core/usecases/usecase.dart';

import '../entities/appointment.dart';
import '../entities/therapist.dart';

abstract interface class DiscoveryRepository {
  Future<Result<List<Therapist>>> getTherapists();
  Future<Result<Therapist>> getTherapist(String id);
  Future<Result<List<Therapist>>> getRecommended();
  Future<Result<List<Review>>> getReviews(String therapistId);
  Future<Result<Appointment?>> getUpcomingAppointment();
  Future<Result<Unit>> submitBooking(BookingDraft draft);
}
