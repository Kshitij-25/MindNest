// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalEntryModel _$JournalEntryModelFromJson(Map<String, dynamic> json) =>
    _JournalEntryModel(
      id: json['id'] as String,
      day: json['day'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      mood: (json['mood'] as num).toInt(),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      draft: json['draft'] as bool? ?? false,
    );

Map<String, dynamic> _$JournalEntryModelToJson(_JournalEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'date': instance.date,
      'time': instance.time,
      'mood': instance.mood,
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
      'draft': instance.draft,
    };
