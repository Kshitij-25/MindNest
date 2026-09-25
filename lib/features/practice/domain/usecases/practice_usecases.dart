import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/practice_entities.dart';
import '../repositories/practice_repository.dart';

@injectable
class GetVerificationDocuments implements UseCase<List<VerificationDocument>, NoParams> {
  const GetVerificationDocuments(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<List<VerificationDocument>> call(NoParams _) => _r.getDocuments();
}

class SetDocumentParams extends Equatable {
  const SetDocumentParams(this.kind, this.uploaded);
  final DocumentKind kind;
  final bool uploaded;
  @override
  List<Object?> get props => [kind, uploaded];
}

@injectable
class SetDocumentUploaded implements UseCase<void, SetDocumentParams> {
  const SetDocumentUploaded(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<void> call(SetDocumentParams p) => _r.setDocumentUploaded(p.kind, p.uploaded);
}

@injectable
class SubmitVerification implements UseCase<void, NoParams> {
  const SubmitVerification(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<void> call(NoParams _) => _r.submitVerification();
}

@injectable
class GetPracticeDashboard implements UseCase<PracticeDashboard, NoParams> {
  const GetPracticeDashboard(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<PracticeDashboard> call(NoParams _) => _r.getDashboard();
}

@injectable
class SetAcceptingClients implements UseCase<void, bool> {
  const SetAcceptingClients(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<void> call(bool v) => _r.setAcceptingClients(v);
}

@injectable
class GetSessionRequests implements UseCase<List<SessionRequest>, NoParams> {
  const GetSessionRequests(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<List<SessionRequest>> call(NoParams _) => _r.getRequests();
}

class RespondParams extends Equatable {
  const RespondParams(this.id, this.status);
  final String id;
  final RequestStatus status;
  @override
  List<Object?> get props => [id, status];
}

@injectable
class RespondToRequest implements UseCase<SessionRequest, RespondParams> {
  const RespondToRequest(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<SessionRequest> call(RespondParams p) => _r.respondToRequest(p.id, p.status);
}

@injectable
class GetWeekSchedule implements UseCase<List<ScheduledSession>, DateTime> {
  const GetWeekSchedule(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<List<ScheduledSession>> call(DateTime weekStart) => _r.getWeek(weekStart);
}

@injectable
class GetClients implements UseCase<List<Client>, NoParams> {
  const GetClients(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<List<Client>> call(NoParams _) => _r.getClients();
}

@injectable
class GetClientDetail implements UseCase<ClientDetail, String> {
  const GetClientDetail(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<ClientDetail> call(String id) => _r.getClient(id);
}

class AddNoteParams extends Equatable {
  const AddNoteParams(this.clientId, this.text);
  final String clientId;
  final String text;
  @override
  List<Object?> get props => [clientId, text];
}

@injectable
class AddClientNote implements UseCase<ClientNote, AddNoteParams> {
  const AddClientNote(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<ClientNote> call(AddNoteParams p) async {
    if (p.text.trim().isEmpty) return const Left(ValidationFailure('Write a note first.'));
    return _r.addClientNote(p.clientId, p.text.trim());
  }
}

class ToggleGoalParams extends Equatable {
  const ToggleGoalParams(this.clientId, this.goalId);
  final String clientId;
  final String goalId;
  @override
  List<Object?> get props => [clientId, goalId];
}

@injectable
class ToggleClientGoal implements UseCase<void, ToggleGoalParams> {
  const ToggleClientGoal(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<void> call(ToggleGoalParams p) => _r.toggleClientGoal(p.clientId, p.goalId);
}

@injectable
class GetEarnings implements UseCase<Earnings, NoParams> {
  const GetEarnings(this._r);
  final PracticeRepository _r;
  @override
  ResultFuture<Earnings> call(NoParams _) => _r.getEarnings();
}
