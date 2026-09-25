// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodEntryModel _$MoodEntryModelFromJson(Map<String, dynamic> json) =>
    MoodEntryModel(
      id: json['id'] as String,
      level: (json['level'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      factors:
          (json['factors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$MoodEntryModelToJson(MoodEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'createdAt': instance.createdAt.toIso8601String(),
      'factors': instance.factors,
      'note': instance.note,
    };
