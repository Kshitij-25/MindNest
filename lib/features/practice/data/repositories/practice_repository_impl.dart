import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/repositories/practice_repository.dart';
import '../datasources/practice_data_source.dart';

@LazySingleton(as: PracticeRepository)
class PracticeRepositoryImpl implements PracticeRepository {
  const PracticeRepositoryImpl(this._ds);
  final PracticeDataSource _ds;

  @override
  ResultFuture<List<VerificationDocument>> getDocuments() => guard(_ds.documents);

  @override
  ResultFuture<void> setDocumentUploaded(DocumentKind kind, bool uploaded) => guard(() => _ds.setUploaded(kind, uploaded));

  @override
  ResultFuture<void> submitVerification() => guard(_ds.submitVerification);

  @override
  ResultFuture<PracticeDashboard> getDashboard() => guard(_ds.dashboard);

  @override
  ResultFuture<void> setAcceptingClients(bool accepting) => guard(() => _ds.setAccepting(accepting));

  @override
  ResultFuture<List<SessionRequest>> getRequests() => guard(_ds.requests);

  @override
  ResultFuture<SessionRequest> respondToRequest(String id, RequestStatus status) => guard(() => _ds.respond(id, status));

  @override
  ResultFuture<List<ScheduledSession>> getWeek(DateTime weekStart) =>
      guard(() => _ds.sessionsBetween(weekStart, weekStart.add(const Duration(days: 7))));

  @override
  ResultFuture<List<Client>> getClients() => guard(_ds.clients);

  @override
  ResultFuture<ClientDetail> getClient(String id) => guard(() => _ds.client(id));

  @override
  ResultFuture<ClientNote> addClientNote(String clientId, String text) => guard(() => _ds.addNote(clientId, text));

  @override
  ResultFuture<void> toggleClientGoal(String clientId, String goalId) => guard(() => _ds.toggleGoal(clientId, goalId));

  @override
  ResultFuture<Earnings> getEarnings() => guard(_ds.earnings);
}
