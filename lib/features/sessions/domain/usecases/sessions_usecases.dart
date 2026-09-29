import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/sessions_repository.dart';

@injectable
class GetUpcomingSessions implements UseCase<List<Appointment>, NoParams> {
  const GetUpcomingSessions(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<List<Appointment>> call(NoParams _) => _repo.getUpcoming();
}

@injectable
class GetPastSessions implements UseCase<List<Appointment>, NoParams> {
  const GetPastSessions(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<List<Appointment>> call(NoParams _) => _repo.getPast();
}

@injectable
class GetBookingDays implements UseCase<List<BookingDay>, String> {
  const GetBookingDays(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<List<BookingDay>> call(String therapistId) => _repo.getBookingDays(therapistId);
}

@injectable
class BookSession implements UseCase<Appointment, BookingRequest> {
  const BookSession(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<Appointment> call(BookingRequest r) => _repo.book(r);
}

@injectable
class CancelSession implements UseCase<void, String> {
  const CancelSession(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<void> call(String id) => _repo.cancel(id);
}

class ReviewParams {
  const ReviewParams(this.appointmentId, {required this.rating, required this.text});
  final String appointmentId;
  final int rating;
  final String text;
}

@injectable
class ReviewSession implements UseCase<void, ReviewParams> {
  const ReviewSession(this._repo);
  final SessionsRepository _repo;

  @override
  ResultFuture<void> call(ReviewParams p) {
    if (p.rating < 1 || p.rating > 5) return Future.value(const Left(ValidationFailure('Choose a rating from 1 to 5.')));
    if (p.text.trim().length > 1000) return Future.value(const Left(ValidationFailure('Keep your review under 1000 characters.')));
    return _repo.review(p.appointmentId, rating: p.rating, text: p.text);
  }
}
