import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapist_filter.freezed.dart';

const discoverSpecialties = ['All', 'Anxiety', 'Depression', 'Sleep', 'Stress', 'Relationships'];
const filterSpecialties = ['Anxiety', 'Depression', 'Sleep', 'Stress', 'Relationships', 'Burnout', 'Grief', 'Trauma'];
const ratingOptions = ['Any', '4.0+', '4.5+', '4.8+'];
const sessionTypeOptions = ['Any', 'Video', 'Chat'];

@freezed
abstract class TherapistFilter with _$TherapistFilter {
  const factory TherapistFilter({
    @Default('') String query,
    @Default('All') String specialty,
    @Default(<String>[]) List<String> specializations,
    @Default(150) int maxPrice,
    @Default('Any') String minRating,
    @Default('Any') String sessionType,
  }) = _TherapistFilter;

  const TherapistFilter._();

  double get minRatingValue => minRating == 'Any' ? 0 : double.parse(minRating.replaceAll('+', ''));

  int get activeCount =>
      (specializations.isNotEmpty ? 1 : 0) + (maxPrice < 150 ? 1 : 0) + (minRating != 'Any' ? 1 : 0) + (sessionType != 'Any' ? 1 : 0);
}
