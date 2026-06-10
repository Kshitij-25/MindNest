import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_models.freezed.dart';
part 'mood_models.g.dart';

@freezed
abstract class MoodEntryModel with _$MoodEntryModel {
  const factory MoodEntryModel({
    required String day,
    required String time,
    required int level,
    @Default('') String note,
    @Default(<String>[]) List<String> factors,
  }) = _MoodEntryModel;

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) =>
      _$MoodEntryModelFromJson(json);
}
