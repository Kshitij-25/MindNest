import 'package:injectable/injectable.dart';

import '../../../../core/error/guard.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/therapist.dart';
import '../../domain/entities/therapist_filter.dart';
import '../../domain/repositories/therapist_repository.dart';
import '../datasources/therapist_data_source.dart';

@LazySingleton(as: TherapistRepository)
class TherapistRepositoryImpl implements TherapistRepository {
  const TherapistRepositoryImpl(this._ds);
  final TherapistDataSource _ds;

  @override
  ResultFuture<List<Therapist>> getTherapists([TherapistFilter f = const TherapistFilter()]) => guard(() async {
        final saved = await _ds.savedIds();
        final q = f.query.trim().toLowerCase();
        bool matchesSpec(Therapist t, String s) {
          final k = s.toLowerCase();
          return t.tags.any((tg) => tg.toLowerCase().contains(k)) || t.specialty.toLowerCase().contains(k);
        }

        return (await _ds.therapists())
            .map((m) => m.toEntity(saved: saved.contains(m.id)))
            .where((t) => f.specialty == 'All' || matchesSpec(t, f.specialty))
            .where((t) => q.isEmpty || t.name.toLowerCase().contains(q) || t.specialty.toLowerCase().contains(q))
            .where((t) => f.specializations.isEmpty || f.specializations.any((s) => matchesSpec(t, s)))
            .where((t) => t.price <= f.maxPrice)
            .where((t) => t.rating >= f.minRatingValue)
            .where((t) => f.sessionType == 'Any' || t.sessionTypes.contains(f.sessionType))
            .toList();
      });

  @override
  ResultFuture<Therapist> getTherapist(String id) => guard(() async {
        final saved = await _ds.savedIds();
        return (await _ds.therapist(id)).toEntity(saved: saved.contains(id));
      });

  @override
  ResultFuture<List<Review>> getReviews(String therapistId) =>
      guard(() async => (await _ds.reviews(therapistId)).map((r) => r.toEntity()).toList());

  @override
  ResultFuture<List<DayAvailability>> getWeeklyAvailability(String therapistId) => guard(() async => [
        for (final (i, d) in const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'].indexed)
          DayAvailability(day: d, slots: i % 3 == 0 ? 0 : 2 + i),
      ]);

  @override
  ResultFuture<bool> toggleSaved(String id) => guard(() => _ds.toggleSaved(id));
}
