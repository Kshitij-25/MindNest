import 'package:injectable/injectable.dart';

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
