import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/inbox.dart';
import '../../../../core/firebase/session.dart';
import '../../domain/entities/practice_entities.dart';

/// Practitioner API over Firestore. Requests, schedule, clients and earnings
/// are all derived from the professional's `appointments`; notes and goals
/// live privately under `therapists/{me}/clients/{clientId}`.
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

/// A booking as the practitioner sees it.
class _Appt {
  _Appt(DocumentSnapshot<Map<String, dynamic>> s)
      : id = s.id,
        clientId = s.data()!['clientId'] as String,
        clientName = s.data()!['clientName'] as String? ?? 'Client',
        startsAt = readDate(s.data()!['startsAt']),
        createdAt = readDate(s.data()!['createdAt']),
        respondedAt = s.data()!['respondedAt'] == null ? null : readDate(s.data()!['respondedAt']),
        minutes = readInt(s.data()!['minutes'], 50),
        type = s.data()!['type'] as String? ?? 'video',
        status = s.data()!['status'] as String? ?? 'pending',
        recurrence = s.data()!['recurrence'] as String? ?? 'oneTime',
        price = readInt(s.data()!['price']),
        reason = s.data()!['reason'] as String? ?? 'Session request',
        note = s.data()!['note'] as String? ?? '',
        newClient = s.data()!['newClient'] as bool? ?? true;

  final String id, clientId, clientName, type, status, recurrence, reason, note;
  final DateTime startsAt, createdAt;
  final DateTime? respondedAt;
  final int minutes, price;
  final bool newClient;

  String get typeLabel => type.isEmpty ? 'Video' : '${type[0].toUpperCase()}${type.substring(1)}';
  bool get accepted => status == 'accepted' || status == 'completed';
  bool get done => accepted && startsAt.add(Duration(minutes: minutes)).isBefore(DateTime.now());
  bool get cancelled => status == 'cancelled' || status == 'declined';

  ScheduledSession toSession({String? label}) => ScheduledSession(
        id: id,
        clientId: clientId,
        clientName: label ?? clientName,
        startsAt: startsAt,
        type: minutes <= 30 && newClient ? 'Intro' : typeLabel,
        minutes: minutes,
        recurring: recurrence != 'oneTime',
      );
}

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

@LazySingleton(as: PracticeDataSource)
class FirestorePracticeDataSource implements PracticeDataSource {
  FirestorePracticeDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  String get _me => _session.uid;
  DocumentReference<Map<String, dynamic>> get _verification => _db.private(_me, 'verification');
  CollectionReference<Map<String, dynamic>> get _clients => _db.therapist(_me).collection('clients');

  Future<List<_Appt>> _appointments() async {
    final snap = await _db.appointments.where('therapistId', isEqualTo: _me).get();
    return snap.docs.map(_Appt.new).toList();
  }

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);
  DateTime _monday(DateTime d) => _day(d).subtract(Duration(days: d.weekday - 1));
  int _pct(num part, num whole, [int fallback = 0]) => whole == 0 ? fallback : (part * 100 / whole).round();

  // ─── Verification ────────────────────────────────────────────
  // Without Cloud Storage (Spark plan) this records which documents the
  // professional has provided; files are exchanged with the review team
  // out of band. Swap `setUploaded` for a Storage upload on Blaze.

  @override
  Future<List<VerificationDocument>> documents() async {
    final d = (await _verification.get()).data() ?? const {};
    bool has(DocumentKind k) => d[k.name] as bool? ?? false;
    return [
      VerificationDocument(kind: DocumentKind.licence, title: 'Practising licence', description: 'HCPC / BACP registration', uploaded: has(DocumentKind.licence)),
      VerificationDocument(kind: DocumentKind.photoId, title: 'Photo ID', description: 'Passport or driving licence', uploaded: has(DocumentKind.photoId)),
      VerificationDocument(
        kind: DocumentKind.qualifications,
        title: 'Qualifications',
        description: 'Degree & training certificates',
        uploaded: has(DocumentKind.qualifications),
      ),
    ];
  }

  @override
  Future<void> setUploaded(DocumentKind kind, bool uploaded) =>
      _verification.set({kind.name: uploaded, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  @override
  Future<void> submitVerification() async {
    final docs = await documents();
    if (docs.any((d) => !d.uploaded)) throw const ServerException('Upload all documents first.');
    final batch = _db.batch()
      ..set(_verification, {'submittedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true))
      ..update(_db.user(_me), {'verification': 'pending'});
    await batch.commit();
  }

  // ─── Dashboard ───────────────────────────────────────────────

  @override
  Future<PracticeDashboard> dashboard() async {
    final all = await _appointments();
    final pro = (await _db.therapist(_me).get()).data() ?? const {};
    final now = DateTime.now();
    final monday = _monday(now);
    final end = _day(now).add(const Duration(days: 2));

    final accepted = all.where((a) => a.accepted).toList();
    final done = accepted.where((a) => a.done).toList();
    final responded = all.where((a) => a.status != 'pending').length;
    final requested = all.where((a) => !(a.status == 'cancelled' && a.respondedAt == null)).length;
    final cancelledAfterAccept = all.where((a) => a.status == 'cancelled' && a.respondedAt != null).length;
    final clientIds = accepted.map((a) => a.clientId).toSet();
    final activeIds = accepted.where((a) => a.startsAt.isAfter(now.subtract(const Duration(days: 60)))).map((a) => a.clientId).toSet();
    final firstSeen = <String, DateTime>{};
    for (final a in accepted) {
      final f = firstSeen[a.clientId];
      if (f == null || a.startsAt.isBefore(f)) firstSeen[a.clientId] = a.startsAt;
    }
    final rebooked = clientIds.where((c) => accepted.where((a) => a.clientId == c).length > 1).length;
    final week = [
      for (var i = 0; i < 7; i++)
        done.where((a) => _sameDay(a.startsAt, monday.add(Duration(days: i)))).fold<int>(0, (s, a) => s + a.price),
    ];

    return PracticeDashboard(
      sessionsToday: accepted.where((a) => _sameDay(a.startsAt, now)).length,
      pendingRequests: all.where((a) => a.status == 'pending' && a.startsAt.isAfter(now)).length,
      rating: (pro['rating'] as num?)?.toDouble() ?? 0,
      weekEarnings: week.fold(0, (s, v) => s + v),
      responseRate: _pct(responded, all.length, 100),
      engagement: _pct(activeIds.length, clientIds.length),
      activeClients: activeIds.length,
      newThisMonth: firstSeen.values.where((d) => d.year == now.year && d.month == now.month).length,
      completedRate: _pct(done.length, done.length + cancelledAfterAccept, 100),
      attendanceRate: _pct(done.length, requested, 100),
      rebookedRate: _pct(rebooked, clientIds.length),
      totalClients: clientIds.length,
      years: readInt(pro['years']),
      acceptingClients: pro['acceptingClients'] as bool? ?? true,
      earningsWeek: week,
      schedule: accepted.where((a) => a.startsAt.isAfter(now.subtract(const Duration(hours: 1))) && a.startsAt.isBefore(end)).map((a) => a.toSession()).toList()
        ..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
    );
  }

  @override
  Future<void> setAccepting(bool accepting) => _db.therapist(_me).update({'acceptingClients': accepting});

  // ─── Requests & schedule ─────────────────────────────────────

  SessionRequest _request(_Appt a) => SessionRequest(
        id: a.id,
        clientId: a.clientId,
        clientName: a.clientName,
        requestedAt: a.startsAt,
        reason: a.reason,
        minutes: a.minutes,
        type: a.typeLabel,
        status: switch (a.status) {
          'accepted' || 'completed' => RequestStatus.accepted,
          'declined' => RequestStatus.declined,
          _ => RequestStatus.pending,
        },
        note: a.note,
        newClient: a.newClient,
      );

  @override
  Future<List<SessionRequest>> requests() async {
    final now = DateTime.now();
    final list = (await _appointments())
        .where((a) => a.startsAt.isAfter(now) && a.status != 'cancelled')
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.map(_request).toList();
  }

  @override
  Future<SessionRequest> respond(String id, RequestStatus status) async {
    final ref = _db.appointments.doc(id);
    final snap = await ref.get();
    if (!snap.exists) throw const NotFoundException();
    final a = _Appt(snap);
    final accept = status == RequestStatus.accepted;
    final pro = (await _db.therapist(_me).get()).data() ?? const {};
    final proName = pro['name'] as String? ?? 'Your therapist';

    final batch = _db.batch()
      ..update(ref, {
        'status': accept ? 'accepted' : 'declined',
        'respondedAt': FieldValue.serverTimestamp(),
      });
    if (accept) {
      final clientRef = _clients.doc(a.clientId);
      final existing = await clientRef.get();
      batch.set(
        clientRef,
        {
          'name': a.clientName,
          'focus': a.reason,
          if (!existing.exists) ...{
            'since': FieldValue.serverTimestamp(),
            'status': ClientStatus.newClient.name,
          },
        },
        SetOptions(merge: true),
      );
      // Open (or update) the chat thread with the confirmed session pinned.
      final convRef = _db.conversations.doc('${a.clientId}_$_me');
      final session = {
        'title': 'Session confirmed',
        'at': Timestamp.fromDate(a.startsAt),
        'status': 'Accepted',
      };
      if ((await convRef.get()).exists) {
        batch.update(convRef, {'session': session});
      } else {
        batch.set(convRef, {
          'participants': [a.clientId, _me],
          'clientId': a.clientId,
          'proId': _me,
          'members': {
            a.clientId: {'name': a.clientName, 'subtitle': a.reason, 'verified': false},
            _me: {'name': proName, 'subtitle': pro['title'] ?? 'Therapist', 'verified': pro['verified'] ?? false},
          },
          'last': 'Your session is confirmed. Say hello whenever you’re ready.',
          'updatedAt': FieldValue.serverTimestamp(),
          'unread': {a.clientId: 1, _me: 0},
          'session': session,
        });
      }
    } else {
      batch.delete(_db.therapist(_me).collection('busy').doc(slotKey(a.startsAt)));
    }
    Inbox.add(
      batch,
      _db,
      to: a.clientId,
      from: _me,
      type: 'booking',
      title: accept ? 'Booking confirmed' : 'Booking declined',
      body: accept
          ? '$proName accepted your upcoming session.'
          : '$proName can’t make that time. Try another slot or therapist.',
      targetId: a.id,
    );
    await batch.commit();
    return _request(a).copyWith(status: status);
  }

  @override
  Future<List<ScheduledSession>> sessionsBetween(DateTime from, DateTime to) async => (await _appointments())
      .where((a) => a.accepted && !a.startsAt.isBefore(from) && a.startsAt.isBefore(to))
      .map((a) => a.toSession())
      .toList();

  // ─── Clients ─────────────────────────────────────────────────

  Client _client(DocumentSnapshot<Map<String, dynamic>> doc, List<_Appt> all) {
    final d = doc.data() ?? const {};
    final mine = all.where((a) => a.clientId == doc.id && a.accepted).toList();
    final now = DateTime.now();
    final upcoming = mine.where((a) => a.startsAt.isAfter(now)).toList()..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    final since = readDate(d['since']);
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Client(
      id: doc.id,
      name: d['name'] as String? ?? 'Client',
      focus: d['focus'] as String? ?? '',
      sessions: mine.where((a) => a.done).length,
      since: '${_months[since.month - 1]} ${since.year}',
      next: upcoming.isEmpty ? '—' : days[upcoming.first.startsAt.weekday - 1],
      status: ClientStatus.values.asNameMap()[d['status']] ?? ClientStatus.newClient,
    );
  }

  @override
  Future<List<Client>> clients() async {
    final all = await _appointments();
    final snap = await _clients.get();
    return snap.docs.map((d) => _client(d, all)).toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<ClientDetail> client(String id) async {
    final doc = await _clients.doc(id).get();
    if (!doc.exists) throw const NotFoundException();
    final all = await _appointments();
    final notes = await _clients.doc(id).collection('notes').orderBy('date', descending: true).get();
    final goals = await _clients.doc(id).collection('goals').orderBy('createdAt').get();
    final past = all.where((a) => a.clientId == id && a.done).toList()..sort((a, b) => b.startsAt.compareTo(a.startsAt));
    return ClientDetail(
      client: _client(doc, all),
      notes: [
        for (final n in notes.docs)
          ClientNote(id: n.id, date: readDate(n['date']), tag: n.data()['tag'] as String? ?? 'Note', text: n.data()['text'] as String? ?? ''),
      ],
      goals: goals.docs.isEmpty
          ? const [ClientGoal(id: 'g0', text: 'Agree first goals in next session')]
          : [for (final g in goals.docs) ClientGoal(id: g.id, text: g.data()['text'] as String? ?? '', done: g.data()['done'] as bool? ?? false)],
      history: [
        for (final (i, a) in past.take(4).indexed) a.toSession(label: 'Session ${past.length - i}'),
      ],
    );
  }

  @override
  Future<ClientNote> addNote(String clientId, String text) async {
    final sessions = (await _appointments()).where((a) => a.clientId == clientId && a.done).length;
    final tag = sessions == 0 ? 'Note' : 'Session $sessions';
    final now = DateTime.now();
    final ref = await _clients.doc(clientId).collection('notes').add({'date': Timestamp.fromDate(now), 'tag': tag, 'text': text});
    return ClientNote(id: ref.id, date: now, tag: tag, text: text);
  }

  @override
  Future<void> toggleGoal(String clientId, String goalId) async {
    final ref = _clients.doc(clientId).collection('goals').doc(goalId);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);
      if (!snap.exists) return; // placeholder goal
      tx.update(ref, {'done': !(snap.data()!['done'] as bool? ?? false)});
    });
  }

  // ─── Earnings ────────────────────────────────────────────────
  // Earned = accepted sessions that have taken place, at the booked price.
  // Payouts run weekly on Fridays; "available" is what has accrued since the
  // last one.

  @override
  Future<Earnings> earnings() async {
    final done = (await _appointments()).where((a) => a.done).toList()..sort((a, b) => b.startsAt.compareTo(a.startsAt));
    final now = DateTime.now();
    final monday = _monday(now);
    final lastMonday = monday.subtract(const Duration(days: 7));
    final daysToFriday = (DateTime.friday - now.weekday) % 7;
    final lastPayout = _day(now).subtract(Duration(days: (now.weekday - DateTime.friday) % 7));
    int sum(Iterable<_Appt> l) => l.fold(0, (s, a) => s + a.price);

    final thisWeek = sum(done.where((a) => !a.startsAt.isBefore(monday)));
    final prevWeek = sum(done.where((a) => !a.startsAt.isBefore(lastMonday) && a.startsAt.isBefore(monday)));
    final monthStarts = [for (var i = 7; i >= 0; i--) DateTime(now.year, now.month - i)];
    final byType = <String, int>{};
    for (final a in done) {
      final label = a.minutes <= 30 && a.newClient ? 'Intro calls' : '${a.typeLabel} sessions';
      byType[label] = (byType[label] ?? 0) + 1;
    }

    return Earnings(
      available: sum(done.where((a) => !a.startsAt.isBefore(lastPayout))),
      yearTotal: sum(done.where((a) => a.startsAt.year == now.year)),
      sessions: done.length,
      averageRate: done.isEmpty ? 0 : (sum(done) / done.length).round(),
      thisWeek: thisWeek,
      weekChangePercent: _pct(thisWeek - prevWeek, prevWeek),
      nextPayoutDays: daysToFriday == 0 ? 7 : daysToFriday,
      week: [
        for (var i = 0; i < 7; i++) sum(done.where((a) => _sameDay(a.startsAt, monday.add(Duration(days: i))))),
      ],
      months: [
        for (final m in monthStarts) sum(done.where((a) => a.startsAt.year == m.year && a.startsAt.month == m.month)),
      ],
      monthLabels: [for (final m in monthStarts) _months[m.month - 1]],
      transactions: [
        for (final a in done.take(10))
          Transaction(clientName: a.clientName, description: '${a.typeLabel} · ${a.minutes} min', date: a.startsAt, amount: a.price),
      ],
      byType: {for (final e in byType.entries) e.key: _pct(e.value, done.length)},
    );
  }
}
