import '../../../../core/usecase/usecase.dart';
import '../entities/practice_entities.dart';

abstract interface class PracticeRepository {
  ResultFuture<List<VerificationDocument>> getDocuments();
  ResultFuture<void> setDocumentUploaded(DocumentKind kind, bool uploaded);
  ResultFuture<void> submitVerification();

  ResultFuture<PracticeDashboard> getDashboard();
  ResultFuture<void> setAcceptingClients(bool accepting);

  ResultFuture<List<SessionRequest>> getRequests();
  ResultFuture<SessionRequest> respondToRequest(String id, RequestStatus status);

  ResultFuture<List<ScheduledSession>> getWeek(DateTime weekStart);

  ResultFuture<List<Client>> getClients();
  ResultFuture<ClientDetail> getClient(String id);
  ResultFuture<ClientNote> addClientNote(String clientId, String text);
  ResultFuture<void> toggleClientGoal(String clientId, String goalId);

  ResultFuture<Earnings> getEarnings();
}
