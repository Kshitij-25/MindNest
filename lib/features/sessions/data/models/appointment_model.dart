import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/firebase/collections.dart';

import '../../../therapists/domain/entities/therapist.dart';
import '../../domain/entities/appointment.dart';

part 'appointment_model.g.dart';

@JsonSerializable()
class AppointmentModel {
  const AppointmentModel({
    required this.id,
    required this.therapistId,
    required this.startsAt,
    this.type = SessionType.video,
    this.minutes = 50,
    this.status = AppointmentStatus.pending,
    this.recurrence = Recurrence.oneTime,
    this.reminders = const ['24h', '1h'],
  });

  /// Maps a booking doc to the client's view: `declined` reads as cancelled,
  /// and an accepted session that has ended reads as completed.
  factory AppointmentModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    final startsAt = readDate(d['startsAt']);
    final minutes = readInt(d['minutes'], 50);
    var status = switch (d['status']) {
      'accepted' => AppointmentStatus.accepted,
      'completed' => AppointmentStatus.completed,
      'cancelled' || 'declined' => AppointmentStatus.cancelled,
      _ => AppointmentStatus.pending,
    };
    if (status == AppointmentStatus.accepted &&
        startsAt.add(Duration(minutes: minutes)).isBefore(DateTime.now())) {
      status = AppointmentStatus.completed;
    }
    return AppointmentModel(
      id: s.id,
      therapistId: d['therapistId'] as String,
      startsAt: startsAt,
      type: SessionType.values.asNameMap()[d['type']] ?? SessionType.video,
      minutes: minutes,
      status: status,
      recurrence: Recurrence.values.asNameMap()[d['recurrence']] ?? Recurrence.oneTime,
      reminders: readStrings(d['reminders']),
    );
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

  final String id;
  final String therapistId;
  final DateTime startsAt;
  final SessionType type;
  final int minutes;
  final AppointmentStatus status;
  final Recurrence recurrence;
  final List<String> reminders;

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);

  AppointmentModel copyWith({AppointmentStatus? status}) => AppointmentModel(
        id: id,
        therapistId: therapistId,
        startsAt: startsAt,
        type: type,
        minutes: minutes,
        status: status ?? this.status,
        recurrence: recurrence,
        reminders: reminders,
      );

  Appointment toEntity(Therapist therapist) => Appointment(
        id: id,
        therapist: therapist,
        startsAt: startsAt,
        type: type,
        minutes: minutes,
        status: status,
        recurrence: recurrence,
        reminders: {for (final r in Reminder.values) if (reminders.contains(r.key)) r},
      );
}
