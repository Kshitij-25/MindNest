// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalEntryModel _$JournalEntryModelFromJson(Map<String, dynamic> json) =>
    JournalEntryModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      mood: (json['mood'] as num?)?.toInt() ?? 4,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      draft: json['draft'] as bool? ?? false,
      favourite: json['favourite'] as bool? ?? false,
    );

Map<String, dynamic> _$JournalEntryModelToJson(JournalEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'mood': instance.mood,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'draft': instance.draft,
      'favourite': instance.favourite,
    };
