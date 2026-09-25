import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../therapists/domain/entities/therapist.dart';
import '../../../therapists/domain/repositories/therapist_repository.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/sessions_repository.dart';
import '../datasources/sessions_data_source.dart';
import '../models/appointment_model.dart';

@LazySingleton(as: SessionsRepository)
class SessionsRepositoryImpl implements SessionsRepository {
  const SessionsRepositoryImpl(this._ds, this._therapists);

  final SessionsDataSource _ds;
  final TherapistRepository _therapists;

  Future<Therapist> _therapist(String id) async =>
      (await _therapists.getTherapist(id)).getOrElse((_) => throw const NotFoundException());

  Future<List<Appointment>> _resolve(Iterable<AppointmentModel> models) async =>
      [for (final m in models) m.toEntity(await _therapist(m.therapistId))];

  @override
  ResultFuture<List<Appointment>> getUpcoming() => guard(() async {
        final now = DateTime.now();
        final list = (await _ds.appointments())
            .where((a) => a.startsAt.isAfter(now) && a.status != AppointmentStatus.cancelled)
            .toList()
          ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
        return _resolve(list);
      });

  @override
  ResultFuture<List<Appointment>> getPast() => guard(() async {
        final now = DateTime.now();
        final list = (await _ds.appointments()).where((a) => a.startsAt.isBefore(now)).toList()
          ..sort((a, b) => b.startsAt.compareTo(a.startsAt));
        return _resolve(list);
      });

  @override
  ResultFuture<List<BookingDay>> getBookingDays(String therapistId, {int days = 14}) => guard(() async {
        final now = DateTime.now();
        final map = await _ds.availability(therapistId, DateTime(now.year, now.month, now.day + 1), days);
        return [
          for (final e in map.entries)
            BookingDay(
              date: e.key,
              available: e.value.isNotEmpty,
              slots: [for (final (t, taken) in e.value) TimeSlot(time: t, taken: taken)],
            ),
        ];
      });

  @override
  ResultFuture<Appointment> book(BookingRequest r) => guard(() async {
        if (r.rescheduleOf != null) await _ds.cancel(r.rescheduleOf!);
        final m = await _ds.create(AppointmentModel(
          id: 'a${DateTime.now().microsecondsSinceEpoch}',
          therapistId: r.therapistId,
          startsAt: r.startsAt,
          type: r.type,
          recurrence: r.recurrence,
          reminders: [for (final x in r.reminders) x.key],
        ));
        return m.toEntity(await _therapist(r.therapistId));
      });

  @override
  ResultFuture<void> cancel(String id) => guard(() => _ds.cancel(id));
}
