import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.authorTitle,
    required this.topic,
    required this.time,
    required this.image,
    required this.read,
    required this.likes,
    required this.comments,
    required this.title,
    required this.body,
    required this.saved,
    required this.liked,
  });

  final String id, authorId, authorName, authorTitle, topic, time, title, body;
  final bool image, saved, liked;
  final int read, likes, comments;

  @override
  List<Object?> get props => [id, saved, liked];
}

class PostComment extends Equatable {
  const PostComment({
    required this.id,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
  });
  final String id, name, time, text;
  final int likes;

  @override
  List<Object?> get props => [id];
}
