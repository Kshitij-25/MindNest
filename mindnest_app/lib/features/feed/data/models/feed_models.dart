import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_models.freezed.dart';
part 'feed_models.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String authorId,
    required String authorName,
    required String authorTitle,
    required String topic,
    required String time,
    @Default(false) bool image,
    required int read,
    required int likes,
    required int comments,
    @Default(false) bool saved,
    @Default(false) bool liked,
    required String title,
    required String body,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

@freezed
abstract class PostCommentModel with _$PostCommentModel {
  const factory PostCommentModel({
    required String id,
    required String name,
    required String time,
    required String text,
    @Default(0) int likes,
  }) = _PostCommentModel;

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentModelFromJson(json);
}
