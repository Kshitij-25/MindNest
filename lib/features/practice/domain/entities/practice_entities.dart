import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice_entities.freezed.dart';

// ─── Verification ──────────────────────────────────────────────

enum DocumentKind { licence, photoId, qualifications }

@freezed
abstract class VerificationDocument with _$VerificationDocument {
  const factory VerificationDocument({
    required DocumentKind kind,
    required String title,
    required String description,
    @Default(false) bool uploaded,
  }) = _VerificationDocument;
}

enum VerificationStep { received, identity, credentials, verified }

// ─── Requests & schedule ───────────────────────────────────────

enum RequestStatus {
  pending('Pending'),
  accepted('Accepted'),
  declined('Declined');

  const RequestStatus(this.label);
  final String label;
}

@freezed
abstract class SessionRequest with _$SessionRequest {
  const factory SessionRequest({
    required String id,
    required String clientId,
    required String clientName,
    required DateTime requestedAt,
    required String reason,
    @Default(50) int minutes,
    @Default('Video') String type,
    @Default(RequestStatus.pending) RequestStatus status,
    @Default('') String note,
    @Default(true) bool newClient,
  }) = _SessionRequest;
}

@freezed
abstract class ScheduledSession with _$ScheduledSession {
  const factory ScheduledSession({
    required String id,
    required String clientId,
    required String clientName,
    required DateTime startsAt,
    @Default('Video') String type,
    @Default(50) int minutes,
    @Default(false) bool recurring,
  }) = _ScheduledSession;
}

// ─── Clients ───────────────────────────────────────────────────

enum ClientStatus {
  stable('Stable'),
  improving('Improving'),
  monitor('Monitor'),
  newClient('New');

  const ClientStatus(this.label);
  final String label;
}

@freezed
abstract class Client with _$Client {
  const factory Client({
    required String id,
    required String name,
    required String focus,
    required int sessions,
    required String since,
    required String next,
    required ClientStatus status,
    @Default(false) bool online,
  }) = _Client;
}

@freezed
abstract class ClientNote with _$ClientNote {
  const factory ClientNote({required String id, required DateTime date, required String tag, required String text}) = _ClientNote;
}

@freezed
abstract class ClientGoal with _$ClientGoal {
  const factory ClientGoal({required String id, required String text, @Default(false) bool done}) = _ClientGoal;
}

@freezed
abstract class ClientDetail with _$ClientDetail {
  const factory ClientDetail({
    required Client client,
    required List<ClientNote> notes,
    required List<ScheduledSession> history,
    required List<ClientGoal> goals,
  }) = _ClientDetail;
}

// ─── Earnings & analytics ──────────────────────────────────────

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({required String clientName, required String description, required DateTime date, required int amount}) =
      _Transaction;
}

@freezed
abstract class Earnings with _$Earnings {
  const factory Earnings({
    required int available,
    required int yearTotal,
    required int sessions,
    required int averageRate,
    required int thisWeek,
    required int weekChangePercent,
    required int nextPayoutDays,
    /// Mon..Sun amounts for the current week.
    required List<int> week,
    /// Last 8 months, oldest first.
    required List<int> months,
    required List<String> monthLabels,
    required List<Transaction> transactions,
    /// Share by session type (label → percent).
    required Map<String, int> byType,
  }) = _Earnings;
}

@freezed
abstract class PracticeDashboard with _$PracticeDashboard {
  const factory PracticeDashboard({
    required int sessionsToday,
    required int pendingRequests,
    required double rating,
    required int weekEarnings,
    required int responseRate,
    required int engagement,
    required int activeClients,
    required int newThisMonth,
    required int completedRate,
    required int attendanceRate,
    required int rebookedRate,
    required int totalClients,
    required int years,
    required bool acceptingClients,
    required List<int> earningsWeek,
    required List<ScheduledSession> schedule,
  }) = _PracticeDashboard;
}
