import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.therapistId,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    required this.mins,
  });

  final String id, therapistId, date, time, type, status;
  final int mins;

  @override
  List<Object?> get props => [id];
}

/// Value object describing a booking the user is about to submit.
class BookingDraft extends Equatable {
  const BookingDraft({
    required this.therapistId,
    required this.dayLabel,
    required this.dateLabel,
    required this.slot,
    required this.type,
  });

  final String therapistId, dayLabel, dateLabel, slot, type;

  @override
  List<Object?> get props => [therapistId, dayLabel, dateLabel, slot, type];
}
