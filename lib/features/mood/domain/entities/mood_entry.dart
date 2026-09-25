import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_entry.freezed.dart';

@freezed
abstract class MoodEntry with _$MoodEntry {
  const factory MoodEntry({
    required String id,
    required int level,
    required DateTime createdAt,
    @Default(<String>[]) List<String> factors,
    @Default('') String note,
  }) = _MoodEntry;
}

const moodFactors = ['Work', 'Sleep', 'Family', 'Health', 'Money', 'Relationships', 'Exercise', 'Solitude'];
