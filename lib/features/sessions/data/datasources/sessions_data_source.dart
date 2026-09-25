import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/firebase/collections.dart';
import '../../../../core/firebase/inbox.dart';
import '../../../../core/firebase/session.dart';
import '../../../therapists/data/models/working_hours.dart';
import '../models/appointment_model.dart';

abstract interface class SessionsDataSource {
  Future<List<AppointmentModel>> appointments();
  Future<AppointmentModel> create(AppointmentModel model);
  Future<void> cancel(String id);
  Future<Map<DateTime, List<(DateTime, bool)>>> availability(String therapistId, DateTime from, int days);
}

/// Client-side bookings. Each booking also writes a lock at
/// `therapists/{id}/busy/{slotKey}` so a slot can't be double-booked and
/// other clients can see it as taken without reading anyone's appointments.
@LazySingleton(as: SessionsDataSource)
class FirestoreSessionsDataSource implements SessionsDataSource {
  FirestoreSessionsDataSource(this._db, this._session);
  final FirebaseFirestore _db;
  final FirebaseSession _session;

  DocumentReference<Map<String, dynamic>> _lock(String therapistId, DateTime at) =>
      _db.therapist(therapistId).collection('busy').doc(slotKey(at));

  @override
  Future<List<AppointmentModel>> appointments() async {
    final snap = await _db.appointments.where('clientId', isEqualTo: _session.uid).get();
    return snap.docs.map(AppointmentModel.fromFirestore).toList();
  }

  @override
  Future<AppointmentModel> create(AppointmentModel m) async {
    final uid = _session.uid;
    final lock = _lock(m.therapistId, m.startsAt);
    if ((await lock.get()).exists) {
      throw const ServerException('That time was just booked — please pick another.');
    }
    final me = (await _db.user(uid).get()).data() ?? const {};
    final pro = (await _db.therapist(m.therapistId).get()).data() ?? const {};
    final assessment = (await _db.private(uid, 'assessment').get()).data();
    final goals = readStrings(assessment?['goals']);
    final previous = await _db.appointments
        .where('clientId', isEqualTo: uid)
        .where('therapistId', isEqualTo: m.therapistId)
        .limit(1)
        .get();

    final ref = _db.appointments.doc();
    final clientName = me['name'] as String? ?? 'A client';
    final batch = _db.batch()
      ..set(ref, {
        'clientId': uid,
        'clientName': clientName,
        'therapistId': m.therapistId,
        'therapistName': pro['name'] ?? '',
        'startsAt': Timestamp.fromDate(m.startsAt),
        'type': m.type.name,
        'minutes': m.minutes,
        'status': 'pending',
        'recurrence': m.recurrence.name,
        'reminders': m.reminders,
        'price': readInt(pro['price'], 80),
        'reason': goals.isEmpty ? 'First consultation' : goals.take(2).join(' & '),
        'note': '',
        'newClient': previous.docs.isEmpty,
        'createdAt': FieldValue.serverTimestamp(),
      })
      ..set(lock, {
        'appointmentId': ref.id,
        'clientId': uid,
        'startsAt': Timestamp.fromDate(m.startsAt),
      });
    Inbox.add(
      batch,
      _db,
      to: m.therapistId,
      from: uid,
      type: 'booking',
      title: 'New session request',
      body: '$clientName requested a ${m.type.label.toLowerCase()} session.',
      targetId: ref.id,
    );
    await batch.commit();
    return AppointmentModel(
      id: ref.id,
      therapistId: m.therapistId,
      startsAt: m.startsAt,
      type: m.type,
      minutes: m.minutes,
      recurrence: m.recurrence,
      reminders: m.reminders,
    );
  }

  @override
  Future<void> cancel(String id) async {
    final ref = _db.appointments.doc(id);
    final snap = await ref.get();
    if (!snap.exists) throw const NotFoundException();
    final d = snap.data()!;
    final therapistId = d['therapistId'] as String;
    final batch = _db.batch()
      ..update(ref, {'status': 'cancelled', 'cancelledAt': FieldValue.serverTimestamp()})
      ..delete(_lock(therapistId, readDate(d['startsAt'])));
    Inbox.add(
      batch,
      _db,
      to: therapistId,
      from: _session.uid,
      type: 'booking',
      title: 'Session cancelled',
      body: '${d['clientName'] ?? 'A client'} cancelled their session.',
      targetId: id,
    );
    await batch.commit();
  }

  @override
  Future<Map<DateTime, List<(DateTime, bool)>>> availability(String therapistId, DateTime from, int days) async {
    final pro = await _db.therapist(therapistId).get();
    if (!pro.exists) throw const NotFoundException();
    final hours = readWorkingHours(pro.data()!['hours']);
    final to = DateTime(from.year, from.month, from.day + days);
    final busy = await _db
        .therapist(therapistId)
        .collection('busy')
        .where('startsAt', isGreaterThanOrEqualTo: Timestamp.fromDate(from))
        .where('startsAt', isLessThan: Timestamp.fromDate(to))
        .get();
    final taken = busy.docs.map((d) => d.id).toSet();
    final now = DateTime.now();
    return {
      for (var d = 0; d < days; d++)
        DateTime(from.year, from.month, from.day + d): [
          for (final t in slotsOn(hours, DateTime(from.year, from.month, from.day + d)))
            if (t.isAfter(now)) (t, taken.contains(slotKey(t))),
        ],
    };
  }
}
