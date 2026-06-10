import '../../domain/entities/mood.dart';
import '../models/mood_models.dart';

extension MoodEntryModelX on MoodEntryModel {
  MoodEntry toEntity() => MoodEntry(
    day: day,
    time: time,
    level: level,
    note: note,
    factors: factors,
  );
}
