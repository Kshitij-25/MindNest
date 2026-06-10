import '../../domain/entities/appointment.dart';
import '../../domain/entities/therapist.dart';
import '../models/discovery_models.dart';

/// DTO → entity mappers, keeping the domain free of serialization concerns.
extension TherapistModelX on TherapistModel {
  Therapist toEntity() => Therapist(
    id: id,
    name: name,
    title: title,
    spec: spec,
    tags: tags,
    rating: rating,
    reviews: reviews,
    years: years,
    verified: verified,
    price: price,
    location: location,
    next: next,
    langs: langs,
    about: about,
    quals: quals,
  );
}

extension ReviewModelX on ReviewModel {
  Review toEntity() =>
      Review(id: id, name: name, rating: rating, time: time, text: text);
}

extension AppointmentModelX on AppointmentModel {
  Appointment toEntity() => Appointment(
    id: id,
    therapistId: tid,
    date: date,
    time: time,
    type: type,
    status: status,
    mins: mins,
  );
}
