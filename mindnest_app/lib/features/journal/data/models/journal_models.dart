import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_models.freezed.dart';
part 'journal_models.g.dart';

@freezed
abstract class JournalEntryModel with _$JournalEntryModel {
  const factory JournalEntryModel({
    required String id,
    required String day,
    required String date,
    required String time,
    required int mood,
    @Default('') String title,
    @Default('') String body,
    @Default(<String>[]) List<String> tags,
    @Default(false) bool draft,
  }) = _JournalEntryModel;

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryModelFromJson(json);
}
