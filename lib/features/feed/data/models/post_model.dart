import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/post.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostAuthorModel {
  const PostAuthorModel({required this.id, required this.name, required this.title, required this.spec, this.verified = true});
  factory PostAuthorModel.fromJson(Map<String, dynamic> json) => _$PostAuthorModelFromJson(json);

  final String id;
  final String name;
  final String title;
  final String spec;
  final bool verified;

  Map<String, dynamic> toJson() => _$PostAuthorModelToJson(this);
  PostAuthor toEntity() => PostAuthor(id: id, name: name, title: title, specialty: spec, verified: verified);
}

@JsonSerializable()
class PostModel {
  PostModel({
    required this.id,
    required this.author,
    required this.topic,
    required this.title,
    required this.body,
    required this.publishedAt,
    this.image = false,
    this.read = 3,
    this.likes = 0,
    this.comments = 0,
    this.views = 0,
    this.liked = false,
    this.saved = false,
    this.status = PostStatus.published,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  final String id;
  final PostAuthorModel author;
  final String topic;
  final String title;
  final String body;
  final DateTime publishedAt;
  final bool image;
  final int read;
  int likes;
  int comments;
  final int views;
  bool liked;
  bool saved;
  final PostStatus status;

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  Post toEntity() => Post(
        id: id,
        author: author.toEntity(),
        topic: topic,
        title: title,
        body: body,
        publishedAt: publishedAt,
        hasImage: image,
        readMinutes: read,
        likes: likes,
        comments: comments,
        views: views,
        liked: liked,
        saved: saved,
        status: status,
      );
}

@JsonSerializable()
class CommentModel {
  CommentModel({required this.id, required this.name, required this.createdAt, required this.text, this.likes = 0, this.liked = false});
  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  final String id;
  final String name;
  final DateTime createdAt;
  final String text;
  int likes;
  bool liked;

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
  PostComment toEntity() => PostComment(id: id, author: name, createdAt: createdAt, text: text, likes: likes, liked: liked);
}
