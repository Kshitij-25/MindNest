// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAuthorModel _$PostAuthorModelFromJson(Map<String, dynamic> json) =>
    PostAuthorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      spec: json['spec'] as String,
      verified: json['verified'] as bool? ?? true,
    );

Map<String, dynamic> _$PostAuthorModelToJson(PostAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'spec': instance.spec,
      'verified': instance.verified,
    };

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  author: PostAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
  topic: json['topic'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  publishedAt: DateTime.parse(json['publishedAt'] as String),
  image: json['image'] as bool? ?? false,
  read: (json['read'] as num?)?.toInt() ?? 3,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  comments: (json['comments'] as num?)?.toInt() ?? 0,
  views: (json['views'] as num?)?.toInt() ?? 0,
  liked: json['liked'] as bool? ?? false,
  saved: json['saved'] as bool? ?? false,
  status:
      $enumDecodeNullable(_$PostStatusEnumMap, json['status']) ??
      PostStatus.published,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author.toJson(),
  'topic': instance.topic,
  'title': instance.title,
  'body': instance.body,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'image': instance.image,
  'read': instance.read,
  'likes': instance.likes,
  'comments': instance.comments,
  'views': instance.views,
  'liked': instance.liked,
  'saved': instance.saved,
  'status': _$PostStatusEnumMap[instance.status]!,
};

const _$PostStatusEnumMap = {
  PostStatus.published: 'published',
  PostStatus.draft: 'draft',
};

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  text: json['text'] as String,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  liked: json['liked'] as bool? ?? false,
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'text': instance.text,
      'likes': instance.likes,
      'liked': instance.liked,
    };
