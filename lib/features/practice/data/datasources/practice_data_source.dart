import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/mock_latency.dart';
import '../../domain/entities/practice_entities.dart';

/// Practitioner API. In-memory mock mirroring the prototype data.
abstract interface class PracticeDataSource {
  Future<List<VerificationDocument>> documents();
  Future<void> setUploaded(DocumentKind kind, bool uploaded);
  Future<void> submitVerification();

  Future<PracticeDashboard> dashboard();
  Future<void> setAccepting(bool accepting);

  Future<List<SessionRequest>> requests();
  Future<SessionRequest> respond(String id, RequestStatus status);

  Future<List<ScheduledSession>> sessionsBetween(DateTime from, DateTime to);

  Future<List<Client>> clients();
  Future<ClientDetail> client(String id);
  Future<ClientNote> addNote(String clientId, String text);
  Future<void> toggleGoal(String clientId, String goalId);

  Future<Earnings> earnings();
}

@LazySingleton(as: PracticeDataSource)
class PracticeMockDataSource implements PracticeDataSource {
  PracticeMockDataSource() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));
    DateTime d(int dayOffset, int h, [int m = 0]) => today.add(Duration(days: dayOffset, hours: h, minutes: m));
    DateTime w(int weekday, int h) => monday.add(Duration(days: weekday, hours: h));

    _requests.addAll([
      SessionRequest(
        id: 'q1',
        clientId: 'cl1',
        clientName: 'Jordan Mills',
        requestedAt: d(3, 14),
        reason: 'Anxiety & work stress',
        note: 'I’ve been feeling really stretched at work and would love some tools to manage the pressure. Looking forward to talking.',
      ),
      SessionRequest(
        id: 'q2',
        clientId: 'cl5',
        clientName: 'Priya Shah',
        requestedAt: d(4, 11),
        reason: 'First consultation',
        minutes: 30,
        note: 'Looking for someone to talk to about a recent change at home.',
      ),
    ]);

    _sessions.addAll([
      ScheduledSession(id: 's1', clientId: 'cl2', clientName: 'Leah Karim', startsAt: d(0, 13), recurring: true),
      ScheduledSession(id: 's2', clientId: 'cl3', clientName: 'Sam Rivera', startsAt: d(0, 15, 30), type: 'Chat'),
      ScheduledSession(id: 's3', clientId: 'cl4', clientName: 'Noah Bennett', startsAt: d(1, 10), type: 'Intro', minutes: 30),
      // Week grid events.
      ScheduledSession(id: 'w1', clientId: 'cl2', clientName: 'Leah Karim', startsAt: w(0, 10), recurring: true),
      ScheduledSession(id: 'w2', clientId: 'cl3', clientName: 'Sam Rivera', startsAt: w(0, 14), type: 'Chat'),
      ScheduledSession(id: 'w3', clientId: 'cl1', clientName: 'Jordan Mills', startsAt: w(1, 11), recurring: true),
      ScheduledSession(id: 'w4', clientId: 'cl4', clientName: 'Noah Bennett', startsAt: w(2, 9), type: 'Intro'),
      ScheduledSession(id: 'w5', clientId: 'cl5', clientName: 'Priya Shah', startsAt: w(3, 16), recurring: true),
      ScheduledSession(id: 'w6', clientId: 'grp', clientName: 'Group session', startsAt: w(4, 13)),
    ]);

    _clients.addAll(const [
      Client(id: 'cl1', name: 'Jordan Mills', focus: 'Anxiety & work stress', sessions: 8, since: 'Jan 2026', next: 'Fri', status: ClientStatus.stable, online: true),
      Client(id: 'cl2', name: 'Leah Karim', focus: 'Sleep & burnout', sessions: 12, since: 'Nov 2025', next: 'Thu', status: ClientStatus.improving),
      Client(id: 'cl3', name: 'Sam Rivera', focus: 'Low mood', sessions: 5, since: 'Mar 2026', next: 'Mon', status: ClientStatus.monitor, online: true),
      Client(id: 'cl4', name: 'Noah Bennett', focus: 'Relationships', sessions: 2, since: 'May 2026', next: 'Tue', status: ClientStatus.newClient),
    ]);

    _notes['cl1'] = [
      ClientNote(
        id: 'n1',
        date: d(-7, 16),
        tag: 'Session 8',
        text: 'Reframed “I’m behind” as “I’m carrying a lot.” Homework: 3-3-3 grounding before stand-ups. Sleep improving.',
      ),
      ClientNote(
        id: 'n2',
        date: d(-14, 16),
        tag: 'Session 7',
        text: 'Work pressure peaked midweek. Practised boundary-setting script with manager — felt empowering.',
      ),
    ];
    _goals['cl1'] = const [
      ClientGoal(id: 'g1', text: 'Practise 3-3-3 grounding daily', done: true),
      ClientGoal(id: 'g2', text: 'Set one work boundary this week', done: true),
      ClientGoal(id: 'g3', text: 'Sleep before 11pm, 5 nights'),
    ];
  }

  final _docs = <DocumentKind, bool>{
    DocumentKind.licence: true,
    DocumentKind.photoId: false,
    DocumentKind.qualifications: false,
  };
  bool _accepting = true;
  final _requests = <SessionRequest>[];
  final _sessions = <ScheduledSession>[];
  final _clients = <Client>[];
  final _notes = <String, List<ClientNote>>{};
  final _goals = <String, List<ClientGoal>>{};

  @override
  Future<List<VerificationDocument>> documents() async {
    await mockLatency(200);
    return [
      VerificationDocument(kind: DocumentKind.licence, title: 'Practising licence', description: 'HCPC / BACP registration', uploaded: _docs[DocumentKind.licence]!),
      VerificationDocument(kind: DocumentKind.photoId, title: 'Photo ID', description: 'Passport or driving licence', uploaded: _docs[DocumentKind.photoId]!),
      VerificationDocument(
        kind: DocumentKind.qualifications,
        title: 'Qualifications',
        description: 'Degree & training certificates',
        uploaded: _docs[DocumentKind.qualifications]!,
      ),
    ];
  }

  @override
  Future<void> setUploaded(DocumentKind kind, bool uploaded) async {
    await mockLatency(uploaded ? 700 : 150);
    _docs[kind] = uploaded;
  }

  @override
  Future<void> submitVerification() async {
    await mockLatency(800);
    if (_docs.values.any((v) => !v)) throw const ServerException('Upload all documents first.');
  }

  @override
  Future<PracticeDashboard> dashboard() async {
    await mockLatency();
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day + 2);
    return PracticeDashboard(
      sessionsToday: _sessions.where((s) => _sameDay(s.startsAt, now) && s.id.startsWith('s')).length,
      pendingRequests: _requests.where((r) => r.status == RequestStatus.pending).length,
      rating: 4.9,
      weekEarnings: 1240,
      responseRate: 96,
      engagement: 78,
      activeClients: 42,
      newThisMonth: 11,
      completedRate: 96,
      attendanceRate: 92,
      rebookedRate: 74,
      totalClients: 128,
      years: 9,
      acceptingClients: _accepting,
      earningsWeek: const [270, 180, 360, 225, 405, 90, 0],
      schedule: _sessions.where((s) => s.id.startsWith('s') && s.startsAt.isBefore(end)).toList()
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
    );
  }

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Future<void> setAccepting(bool accepting) async => _accepting = accepting;

  @override
  Future<List<SessionRequest>> requests() async {
    await mockLatency();
    return List.of(_requests);
  }

  @override
  Future<SessionRequest> respond(String id, RequestStatus status) async {
    await mockLatency(400);
    final i = _requests.indexWhere((r) => r.id == id);
    if (i < 0) throw const NotFoundException();
    final r = _requests[i] = _requests[i].copyWith(status: status);
    if (status == RequestStatus.accepted) {
      _sessions.add(ScheduledSession(
        id: 'acc-${r.id}',
        clientId: r.clientId,
        clientName: r.clientName,
        startsAt: r.requestedAt,
        type: r.type,
        minutes: r.minutes,
      ));
    }
    return r;
  }

  @override
  Future<List<ScheduledSession>> sessionsBetween(DateTime from, DateTime to) async {
    await mockLatency(200);
    return _sessions.where((s) => !s.startsAt.isBefore(from) && s.startsAt.isBefore(to) && !s.id.startsWith('s')).toList();
  }

  @override
  Future<List<Client>> clients() async {
    await mockLatency();
    return _clients;
  }

  @override
  Future<ClientDetail> client(String id) async {
    await mockLatency(200);
    final c = _clients.firstWhere((x) => x.id == id, orElse: () => throw const NotFoundException());
    final now = DateTime.now();
    return ClientDetail(
      client: c,
      notes: _notes[id] ?? const [],
      goals: _goals[id] ?? const [ClientGoal(id: 'g0', text: 'Agree first goals in next session')],
      history: [
        for (var i = 0; i < (c.sessions > 4 ? 4 : c.sessions); i++)
          ScheduledSession(
            id: 'h$i',
            clientId: id,
            clientName: 'Session ${c.sessions - i}',
            startsAt: DateTime(now.year, now.month, now.day - 7 * (i + 1), 16),
          ),
      ],
    );
  }

  @override
  Future<ClientNote> addNote(String clientId, String text) async {
    await mockLatency(300);
    final n = ClientNote(id: 'n${DateTime.now().microsecondsSinceEpoch}', date: DateTime.now(), tag: 'New note', text: text);
    _notes.putIfAbsent(clientId, () => []).insert(0, n);
    return n;
  }

  @override
  Future<void> toggleGoal(String clientId, String goalId) async {
    final l = _goals[clientId];
    if (l == null) return;
    _goals[clientId] = [for (final g in l) g.id == goalId ? g.copyWith(done: !g.done) : g];
  }

  @override
  Future<Earnings> earnings() async {
    await mockLatency();
    final now = DateTime.now();
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final labels = [for (var i = 7; i >= 0; i--) months[(now.month - 1 - i) % 12]];
    return Earnings(
      available: 4860,
      yearTotal: 18420,
      sessions: 204,
      averageRate: 90,
      thisWeek: 1240,
      weekChangePercent: 18,
      nextPayoutDays: 3,
      week: const [270, 180, 360, 225, 405, 90, 0],
      months: const [2100, 2480, 2260, 2890, 3120, 2980, 3460, 3840],
      monthLabels: labels,
      transactions: [
        Transaction(clientName: 'Leah Karim', description: 'Video · 50 min', date: now, amount: 90),
        Transaction(clientName: 'Sam Rivera', description: 'Chat · 50 min', date: now, amount: 90),
        Transaction(clientName: 'Jordan Mills', description: 'Video · 50 min', date: now.subtract(const Duration(days: 1)), amount: 90),
        Transaction(clientName: 'Noah Bennett', description: 'Intro · 30 min', date: now.subtract(const Duration(days: 3)), amount: 45),
        Transaction(clientName: 'Priya Shah', description: 'Video · 50 min', date: now.subtract(const Duration(days: 4)), amount: 90),
      ],
      byType: const {'Video sessions': 68, 'Chat sessions': 22, 'Intro calls': 10},
    );
  }
}
