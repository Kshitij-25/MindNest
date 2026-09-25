import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/journal_entry.dart';

part 'journal_entry_model.g.dart';

@JsonSerializable()
class JournalEntryModel {
  const JournalEntryModel({
    required this.id,
    this.title = '',
    this.body = '',
    this.mood = 4,
    this.tags = const [],
    required this.createdAt,
    this.draft = false,
    this.favourite = false,
  });

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) => _$JournalEntryModelFromJson(json);

  factory JournalEntryModel.fromEntity(JournalEntry e) => JournalEntryModel(
        id: e.id,
        title: e.title,
        body: e.body,
        mood: e.mood,
        tags: e.tags,
        createdAt: e.createdAt,
        draft: e.draft,
        favourite: e.favourite,
      );

  final String id;
  final String title;
  final String body;
  final int mood;
  final List<String> tags;
  final DateTime createdAt;
  final bool draft;
  final bool favourite;

  Map<String, dynamic> toJson() => _$JournalEntryModelToJson(this);

  JournalEntry toEntity() => JournalEntry(
        id: id,
        title: title,
        body: body,
        mood: mood,
        tags: tags,
        createdAt: createdAt,
        draft: draft,
        favourite: favourite,
      );
}
