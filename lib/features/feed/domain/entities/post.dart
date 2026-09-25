import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

const feedTopics = ['For you', 'Anxiety', 'Sleep', 'Mindfulness', 'Relationships'];
const postTopics = ['Anxiety', 'Stress', 'Sleep', 'Mindfulness', 'Relationships', 'Growth', 'Self-care'];

enum PostStatus { published, draft }

@freezed
abstract class PostAuthor with _$PostAuthor {
  const factory PostAuthor({
    required String id,
    required String name,
    required String title,
    required String specialty,
    @Default(true) bool verified,
  }) = _PostAuthor;
}

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    required PostAuthor author,
    required String topic,
    required String title,
    required String body,
    required DateTime publishedAt,
    @Default(false) bool hasImage,
    @Default(3) int readMinutes,
    @Default(0) int likes,
    @Default(0) int comments,
    @Default(0) int views,
    @Default(false) bool liked,
    @Default(false) bool saved,
    @Default(PostStatus.published) PostStatus status,
  }) = _Post;

  const Post._();

  String get excerpt => body.split('\n').first;
}

@freezed
abstract class PostComment with _$PostComment {
  const factory PostComment({
    required String id,
    required String author,
    required DateTime createdAt,
    required String text,
    @Default(0) int likes,
    @Default(false) bool liked,
  }) = _PostComment;
}

@freezed
abstract class NewPost with _$NewPost {
  const factory NewPost({
    @Default('') String title,
    @Default('') String body,
    @Default('Anxiety') String topic,
    @Default(false) bool hasImage,
    @Default(true) bool allowComments,
  }) = _NewPost;
}
