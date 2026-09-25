// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostAuthor {

 String get id; String get name; String get title; String get specialty; bool get verified;
/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<PostAuthor> get copyWith => _$PostAuthorCopyWithImpl<PostAuthor>(this as PostAuthor, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PostAuthor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostAuthor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.specialty, _this.specialty) || other.specialty == _this.specialty)&&(identical(other.verified, _this.verified) || other.verified == _this.verified));
}


@override
int get hashCode {
  final _this = this as PostAuthor;
  return Object.hash(runtimeType,_this.id,_this.name,_this.title,_this.specialty,_this.verified);
}

@override
String toString() {
  final _this = this as PostAuthor;
  return 'PostAuthor(id: ${_this.id}, name: ${_this.name}, title: ${_this.title}, specialty: ${_this.specialty}, verified: ${_this.verified})';
}


}

/// @nodoc
abstract mixin class $PostAuthorCopyWith<$Res>  {
  factory $PostAuthorCopyWith(PostAuthor value, $Res Function(PostAuthor) _then) = _$PostAuthorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String title, String specialty, bool verified
});




}
/// @nodoc
class _$PostAuthorCopyWithImpl<$Res>
    implements $PostAuthorCopyWith<$Res> {
  _$PostAuthorCopyWithImpl(this._self, this._then);

  final PostAuthor _self;
  final $Res Function(PostAuthor) _then;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? specialty = null,Object? verified = null,}) {
  return _then(PostAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostAuthor].
extension PostAuthorPatterns on PostAuthor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostAuthor value)  $default,){
final _that = this;
switch (_that) {
case _PostAuthor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String specialty,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.verified);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String specialty,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _PostAuthor():
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.verified);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String title,  String specialty,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _PostAuthor() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.verified);case _:
  return null;

}
}

}

/// @nodoc


class _PostAuthor implements PostAuthor {
  const _PostAuthor({required this.id, required this.name, required this.title, required this.specialty, this.verified = true});
  

@override final  String id;
@override final  String name;
@override final  String title;
@override final  String specialty;
@override@JsonKey() final  bool verified;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostAuthorCopyWith<_PostAuthor> get copyWith => __$PostAuthorCopyWithImpl<_PostAuthor>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.verified, verified) || other.verified == verified));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,title,specialty,verified);
}

@override
String toString() {
    return 'PostAuthor(id: $id, name: $name, title: $title, specialty: $specialty, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$PostAuthorCopyWith<$Res> implements $PostAuthorCopyWith<$Res> {
  factory _$PostAuthorCopyWith(_PostAuthor value, $Res Function(_PostAuthor) _then) = __$PostAuthorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String title, String specialty, bool verified
});




}
/// @nodoc
class __$PostAuthorCopyWithImpl<$Res>
    implements _$PostAuthorCopyWith<$Res> {
  __$PostAuthorCopyWithImpl(this._self, this._then);

  final _PostAuthor _self;
  final $Res Function(_PostAuthor) _then;

/// Create a copy of PostAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? specialty = null,Object? verified = null,}) {
  return _then(_PostAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Post {

 String get id; PostAuthor get author; String get topic; String get title; String get body; DateTime get publishedAt; bool get hasImage; int get readMinutes; int get likes; int get comments; int get views; bool get liked; bool get saved; PostStatus get status;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Post;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.hasImage, _this.hasImage) || other.hasImage == _this.hasImage)&&(identical(other.readMinutes, _this.readMinutes) || other.readMinutes == _this.readMinutes)&&(identical(other.likes, _this.likes) || other.likes == _this.likes)&&(identical(other.comments, _this.comments) || other.comments == _this.comments)&&(identical(other.views, _this.views) || other.views == _this.views)&&(identical(other.liked, _this.liked) || other.liked == _this.liked)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as Post;
  return Object.hash(runtimeType,_this.id,_this.author,_this.topic,_this.title,_this.body,_this.publishedAt,_this.hasImage,_this.readMinutes,_this.likes,_this.comments,_this.views,_this.liked,_this.saved,_this.status);
}

@override
String toString() {
  final _this = this as Post;
  return 'Post(id: ${_this.id}, author: ${_this.author}, topic: ${_this.topic}, title: ${_this.title}, body: ${_this.body}, publishedAt: ${_this.publishedAt}, hasImage: ${_this.hasImage}, readMinutes: ${_this.readMinutes}, likes: ${_this.likes}, comments: ${_this.comments}, views: ${_this.views}, liked: ${_this.liked}, saved: ${_this.saved}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String id, PostAuthor author, String topic, String title, String body, DateTime publishedAt, bool hasImage, int readMinutes, int likes, int comments, int views, bool liked, bool saved, PostStatus status
});


$PostAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? topic = null,Object? title = null,Object? body = null,Object? publishedAt = null,Object? hasImage = null,Object? readMinutes = null,Object? likes = null,Object? comments = null,Object? views = null,Object? liked = null,Object? saved = null,Object? status = null,}) {
  return _then(Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,readMinutes: null == readMinutes ? _self.readMinutes : readMinutes // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PostStatus,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  String topic,  String title,  String body,  DateTime publishedAt,  bool hasImage,  int readMinutes,  int likes,  int comments,  int views,  bool liked,  bool saved,  PostStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.author,_that.topic,_that.title,_that.body,_that.publishedAt,_that.hasImage,_that.readMinutes,_that.likes,_that.comments,_that.views,_that.liked,_that.saved,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PostAuthor author,  String topic,  String title,  String body,  DateTime publishedAt,  bool hasImage,  int readMinutes,  int likes,  int comments,  int views,  bool liked,  bool saved,  PostStatus status)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.author,_that.topic,_that.title,_that.body,_that.publishedAt,_that.hasImage,_that.readMinutes,_that.likes,_that.comments,_that.views,_that.liked,_that.saved,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PostAuthor author,  String topic,  String title,  String body,  DateTime publishedAt,  bool hasImage,  int readMinutes,  int likes,  int comments,  int views,  bool liked,  bool saved,  PostStatus status)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.author,_that.topic,_that.title,_that.body,_that.publishedAt,_that.hasImage,_that.readMinutes,_that.likes,_that.comments,_that.views,_that.liked,_that.saved,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Post extends Post {
  const _Post({required this.id, required this.author, required this.topic, required this.title, required this.body, required this.publishedAt, this.hasImage = false, this.readMinutes = 3, this.likes = 0, this.comments = 0, this.views = 0, this.liked = false, this.saved = false, this.status = PostStatus.published}): super._();
  

@override final  String id;
@override final  PostAuthor author;
@override final  String topic;
@override final  String title;
@override final  String body;
@override final  DateTime publishedAt;
@override@JsonKey() final  bool hasImage;
@override@JsonKey() final  int readMinutes;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int comments;
@override@JsonKey() final  int views;
@override@JsonKey() final  bool liked;
@override@JsonKey() final  bool saved;
@override@JsonKey() final  PostStatus status;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.hasImage, hasImage) || other.hasImage == hasImage)&&(identical(other.readMinutes, readMinutes) || other.readMinutes == readMinutes)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.views, views) || other.views == views)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,author,topic,title,body,publishedAt,hasImage,readMinutes,likes,comments,views,liked,saved,status);
}

@override
String toString() {
    return 'Post(id: $id, author: $author, topic: $topic, title: $title, body: $body, publishedAt: $publishedAt, hasImage: $hasImage, readMinutes: $readMinutes, likes: $likes, comments: $comments, views: $views, liked: $liked, saved: $saved, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String id, PostAuthor author, String topic, String title, String body, DateTime publishedAt, bool hasImage, int readMinutes, int likes, int comments, int views, bool liked, bool saved, PostStatus status
});


@override $PostAuthorCopyWith<$Res> get author;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? topic = null,Object? title = null,Object? body = null,Object? publishedAt = null,Object? hasImage = null,Object? readMinutes = null,Object? likes = null,Object? comments = null,Object? views = null,Object? liked = null,Object? saved = null,Object? status = null,}) {
  return _then(_Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthor,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,readMinutes: null == readMinutes ? _self.readMinutes : readMinutes // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PostStatus,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorCopyWith<$Res> get author {
  
  return $PostAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

/// @nodoc
mixin _$PostComment {

 String get id; String get author; DateTime get createdAt; String get text; int get likes; bool get liked;
/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCommentCopyWith<PostComment> get copyWith => _$PostCommentCopyWithImpl<PostComment>(this as PostComment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PostComment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostComment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.likes, _this.likes) || other.likes == _this.likes)&&(identical(other.liked, _this.liked) || other.liked == _this.liked));
}


@override
int get hashCode {
  final _this = this as PostComment;
  return Object.hash(runtimeType,_this.id,_this.author,_this.createdAt,_this.text,_this.likes,_this.liked);
}

@override
String toString() {
  final _this = this as PostComment;
  return 'PostComment(id: ${_this.id}, author: ${_this.author}, createdAt: ${_this.createdAt}, text: ${_this.text}, likes: ${_this.likes}, liked: ${_this.liked})';
}


}

/// @nodoc
abstract mixin class $PostCommentCopyWith<$Res>  {
  factory $PostCommentCopyWith(PostComment value, $Res Function(PostComment) _then) = _$PostCommentCopyWithImpl;
@useResult
$Res call({
 String id, String author, DateTime createdAt, String text, int likes, bool liked
});




}
/// @nodoc
class _$PostCommentCopyWithImpl<$Res>
    implements $PostCommentCopyWith<$Res> {
  _$PostCommentCopyWithImpl(this._self, this._then);

  final PostComment _self;
  final $Res Function(PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? text = null,Object? likes = null,Object? liked = null,}) {
  return _then(PostComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostComment].
extension PostCommentPatterns on PostComment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostComment value)  $default,){
final _that = this;
switch (_that) {
case _PostComment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostComment value)?  $default,){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String author,  DateTime createdAt,  String text,  int likes,  bool liked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.text,_that.likes,_that.liked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String author,  DateTime createdAt,  String text,  int likes,  bool liked)  $default,) {final _that = this;
switch (_that) {
case _PostComment():
return $default(_that.id,_that.author,_that.createdAt,_that.text,_that.likes,_that.liked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String author,  DateTime createdAt,  String text,  int likes,  bool liked)?  $default,) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.author,_that.createdAt,_that.text,_that.likes,_that.liked);case _:
  return null;

}
}

}

/// @nodoc


class _PostComment implements PostComment {
  const _PostComment({required this.id, required this.author, required this.createdAt, required this.text, this.likes = 0, this.liked = false});
  

@override final  String id;
@override final  String author;
@override final  DateTime createdAt;
@override final  String text;
@override@JsonKey() final  int likes;
@override@JsonKey() final  bool liked;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCommentCopyWith<_PostComment> get copyWith => __$PostCommentCopyWithImpl<_PostComment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostComment&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.text, text) || other.text == text)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.liked, liked) || other.liked == liked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,author,createdAt,text,likes,liked);
}

@override
String toString() {
    return 'PostComment(id: $id, author: $author, createdAt: $createdAt, text: $text, likes: $likes, liked: $liked)';
}


}

/// @nodoc
abstract mixin class _$PostCommentCopyWith<$Res> implements $PostCommentCopyWith<$Res> {
  factory _$PostCommentCopyWith(_PostComment value, $Res Function(_PostComment) _then) = __$PostCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, DateTime createdAt, String text, int likes, bool liked
});




}
/// @nodoc
class __$PostCommentCopyWithImpl<$Res>
    implements _$PostCommentCopyWith<$Res> {
  __$PostCommentCopyWithImpl(this._self, this._then);

  final _PostComment _self;
  final $Res Function(_PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? createdAt = null,Object? text = null,Object? likes = null,Object? liked = null,}) {
  return _then(_PostComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$NewPost {

 String get title; String get body; String get topic; bool get hasImage; bool get allowComments;
/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPostCopyWith<NewPost> get copyWith => _$NewPostCopyWithImpl<NewPost>(this as NewPost, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewPost;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPost&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.hasImage, _this.hasImage) || other.hasImage == _this.hasImage)&&(identical(other.allowComments, _this.allowComments) || other.allowComments == _this.allowComments));
}


@override
int get hashCode {
  final _this = this as NewPost;
  return Object.hash(runtimeType,_this.title,_this.body,_this.topic,_this.hasImage,_this.allowComments);
}

@override
String toString() {
  final _this = this as NewPost;
  return 'NewPost(title: ${_this.title}, body: ${_this.body}, topic: ${_this.topic}, hasImage: ${_this.hasImage}, allowComments: ${_this.allowComments})';
}


}

/// @nodoc
abstract mixin class $NewPostCopyWith<$Res>  {
  factory $NewPostCopyWith(NewPost value, $Res Function(NewPost) _then) = _$NewPostCopyWithImpl;
@useResult
$Res call({
 String title, String body, String topic, bool hasImage, bool allowComments
});




}
/// @nodoc
class _$NewPostCopyWithImpl<$Res>
    implements $NewPostCopyWith<$Res> {
  _$NewPostCopyWithImpl(this._self, this._then);

  final NewPost _self;
  final $Res Function(NewPost) _then;

/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? body = null,Object? topic = null,Object? hasImage = null,Object? allowComments = null,}) {
  return _then(NewPost(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,allowComments: null == allowComments ? _self.allowComments : allowComments // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NewPost].
extension NewPostPatterns on NewPost {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPost value)  $default,){
final _that = this;
switch (_that) {
case _NewPost():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPost value)?  $default,){
final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String body,  String topic,  bool hasImage,  bool allowComments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that.title,_that.body,_that.topic,_that.hasImage,_that.allowComments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String body,  String topic,  bool hasImage,  bool allowComments)  $default,) {final _that = this;
switch (_that) {
case _NewPost():
return $default(_that.title,_that.body,_that.topic,_that.hasImage,_that.allowComments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String body,  String topic,  bool hasImage,  bool allowComments)?  $default,) {final _that = this;
switch (_that) {
case _NewPost() when $default != null:
return $default(_that.title,_that.body,_that.topic,_that.hasImage,_that.allowComments);case _:
  return null;

}
}

}

/// @nodoc


class _NewPost implements NewPost {
  const _NewPost({this.title = '', this.body = '', this.topic = 'Anxiety', this.hasImage = false, this.allowComments = true});
  

@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
@override@JsonKey() final  String topic;
@override@JsonKey() final  bool hasImage;
@override@JsonKey() final  bool allowComments;

/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPostCopyWith<_NewPost> get copyWith => __$NewPostCopyWithImpl<_NewPost>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPost&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.hasImage, hasImage) || other.hasImage == hasImage)&&(identical(other.allowComments, allowComments) || other.allowComments == allowComments));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,body,topic,hasImage,allowComments);
}

@override
String toString() {
    return 'NewPost(title: $title, body: $body, topic: $topic, hasImage: $hasImage, allowComments: $allowComments)';
}


}

/// @nodoc
abstract mixin class _$NewPostCopyWith<$Res> implements $NewPostCopyWith<$Res> {
  factory _$NewPostCopyWith(_NewPost value, $Res Function(_NewPost) _then) = __$NewPostCopyWithImpl;
@override @useResult
$Res call({
 String title, String body, String topic, bool hasImage, bool allowComments
});




}
/// @nodoc
class __$NewPostCopyWithImpl<$Res>
    implements _$NewPostCopyWith<$Res> {
  __$NewPostCopyWithImpl(this._self, this._then);

  final _NewPost _self;
  final $Res Function(_NewPost) _then;

/// Create a copy of NewPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? body = null,Object? topic = null,Object? hasImage = null,Object? allowComments = null,}) {
  return _then(_NewPost(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,hasImage: null == hasImage ? _self.hasImage : hasImage // ignore: cast_nullable_to_non_nullable
as bool,allowComments: null == allowComments ? _self.allowComments : allowComments // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
