import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/mood_entry.dart';

part 'mood_entry_model.g.dart';

@JsonSerializable()
class MoodEntryModel {
  const MoodEntryModel({required this.id, required this.level, required this.createdAt, this.factors = const [], this.note = ''});

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) => _$MoodEntryModelFromJson(json);

  final String id;
  final int level;
  final DateTime createdAt;
  final List<String> factors;
  final String note;

  Map<String, dynamic> toJson() => _$MoodEntryModelToJson(this);

  MoodEntry toEntity() => MoodEntry(id: id, level: level, createdAt: createdAt, factors: factors, note: note);
}
