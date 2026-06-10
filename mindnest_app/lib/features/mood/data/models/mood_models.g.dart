// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoodEntryModel _$MoodEntryModelFromJson(Map<String, dynamic> json) =>
    _MoodEntryModel(
      day: json['day'] as String,
      time: json['time'] as String,
      level: (json['level'] as num).toInt(),
      note: json['note'] as String? ?? '',
      factors:
          (json['factors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$MoodEntryModelToJson(_MoodEntryModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
      'level': instance.level,
      'note': instance.note,
      'factors': instance.factors,
    };
