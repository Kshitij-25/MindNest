import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../therapists/domain/entities/therapist.dart';

part 'appointment.freezed.dart';

enum SessionType {
  video('Video'),
  voice('Voice'),
  chat('Chat');

  const SessionType(this.label);
  final String label;
}

enum AppointmentStatus {
  pending('Pending'),
  accepted('Accepted'),
  completed('Completed'),
  cancelled('Cancelled');

  const AppointmentStatus(this.label);
  final String label;
}

enum Recurrence {
  oneTime('One-time'),
  weekly('Weekly'),
  fortnightly('Fortnightly'),
  monthly('Monthly');

  const Recurrence(this.label);
  final String label;
}

enum Reminder {
  day('24h', '24 hours before'),
  hour('1h', '1 hour before'),
  tenMinutes('10m', '10 minutes before');

  const Reminder(this.key, this.label);
  final String key;
  final String label;
}

@freezed
abstract class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required Therapist therapist,
    required DateTime startsAt,
    @Default(SessionType.video) SessionType type,
    @Default(50) int minutes,
    @Default(AppointmentStatus.pending) AppointmentStatus status,
    @Default(Recurrence.oneTime) Recurrence recurrence,
    @Default(<Reminder>{Reminder.day, Reminder.hour}) Set<Reminder> reminders,
  }) = _Appointment;

  const Appointment._();

  /// Free cancellation if more than 24h ahead.
  bool get freeCancellation => startsAt.difference(DateTime.now()).inHours >= 24;
}

@freezed
abstract class TimeSlot with _$TimeSlot {
  const factory TimeSlot({required DateTime time, @Default(false) bool taken}) = _TimeSlot;
}

@freezed
abstract class BookingDay with _$BookingDay {
  const factory BookingDay({required DateTime date, required bool available, required List<TimeSlot> slots}) = _BookingDay;
}

@freezed
abstract class BookingRequest with _$BookingRequest {
  const factory BookingRequest({
    required String therapistId,
    required DateTime startsAt,
    required SessionType type,
    @Default(Recurrence.oneTime) Recurrence recurrence,
    @Default(<Reminder>{Reminder.day, Reminder.hour}) Set<Reminder> reminders,
    String? rescheduleOf,
  }) = _BookingRequest;
}
