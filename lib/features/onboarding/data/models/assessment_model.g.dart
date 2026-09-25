// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentModel _$AssessmentModelFromJson(Map<String, dynamic> json) =>
    AssessmentModel(
      mood: (json['mood'] as num).toInt(),
      stress: (json['stress'] as num).toInt(),
      anxiety: (json['anxiety'] as num?)?.toInt(),
      sleep: (json['sleep'] as num).toInt(),
      goals: (json['goals'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AssessmentModelToJson(AssessmentModel instance) =>
    <String, dynamic>{
      'mood': instance.mood,
      'stress': instance.stress,
      'anxiety': instance.anxiety,
      'sleep': instance.sleep,
      'goals': instance.goals,
    };
