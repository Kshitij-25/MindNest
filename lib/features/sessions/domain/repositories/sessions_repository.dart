import '../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';

abstract interface class SessionsRepository {
  ResultFuture<List<Appointment>> getUpcoming();
  ResultFuture<List<Appointment>> getPast();
  ResultFuture<List<BookingDay>> getBookingDays(String therapistId, {int days = 14});
  ResultFuture<Appointment> book(BookingRequest request);
  ResultFuture<void> cancel(String appointmentId);
}
