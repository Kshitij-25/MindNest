// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorTitle: json['authorTitle'] as String,
  topic: json['topic'] as String,
  time: json['time'] as String,
  image: json['image'] as bool? ?? false,
  read: (json['read'] as num).toInt(),
  likes: (json['likes'] as num).toInt(),
  comments: (json['comments'] as num).toInt(),
  saved: json['saved'] as bool? ?? false,
  liked: json['liked'] as bool? ?? false,
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorTitle': instance.authorTitle,
      'topic': instance.topic,
      'time': instance.time,
      'image': instance.image,
      'read': instance.read,
      'likes': instance.likes,
      'comments': instance.comments,
      'saved': instance.saved,
      'liked': instance.liked,
      'title': instance.title,
      'body': instance.body,
    };

_PostCommentModel _$PostCommentModelFromJson(Map<String, dynamic> json) =>
    _PostCommentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      text: json['text'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PostCommentModelToJson(_PostCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'text': instance.text,
      'likes': instance.likes,
    };
