// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {

 String get id; String get authorId; String get authorName; String get authorTitle; String get topic; String get time; bool get image; int get read; int get likes; int get comments; bool get saved; bool get liked; String get title; String get body;
/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostModelCopyWith<PostModel> get copyWith => _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorTitle, authorTitle) || other.authorTitle == authorTitle)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.time, time) || other.time == time)&&(identical(other.image, image) || other.image == image)&&(identical(other.read, read) || other.read == read)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,authorName,authorTitle,topic,time,image,read,likes,comments,saved,liked,title,body);

@override
String toString() {
  return 'PostModel(id: $id, authorId: $authorId, authorName: $authorName, authorTitle: $authorTitle, topic: $topic, time: $time, image: $image, read: $read, likes: $likes, comments: $comments, saved: $saved, liked: $liked, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res>  {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) = _$PostModelCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String authorName, String authorTitle, String topic, String time, bool image, int read, int likes, int comments, bool saved, bool liked, String title, String body
});




}
/// @nodoc
class _$PostModelCopyWithImpl<$Res>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? authorName = null,Object? authorTitle = null,Object? topic = null,Object? time = null,Object? image = null,Object? read = null,Object? likes = null,Object? comments = null,Object? saved = null,Object? liked = null,Object? title = null,Object? body = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorTitle: null == authorTitle ? _self.authorTitle : authorTitle // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as bool,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostModel].
extension PostModelPatterns on PostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostModel value)  $default,){
final _that = this;
switch (_that) {
case _PostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorId,  String authorName,  String authorTitle,  String topic,  String time,  bool image,  int read,  int likes,  int comments,  bool saved,  bool liked,  String title,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.authorId,_that.authorName,_that.authorTitle,_that.topic,_that.time,_that.image,_that.read,_that.likes,_that.comments,_that.saved,_that.liked,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorId,  String authorName,  String authorTitle,  String topic,  String time,  bool image,  int read,  int likes,  int comments,  bool saved,  bool liked,  String title,  String body)  $default,) {final _that = this;
switch (_that) {
case _PostModel():
return $default(_that.id,_that.authorId,_that.authorName,_that.authorTitle,_that.topic,_that.time,_that.image,_that.read,_that.likes,_that.comments,_that.saved,_that.liked,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorId,  String authorName,  String authorTitle,  String topic,  String time,  bool image,  int read,  int likes,  int comments,  bool saved,  bool liked,  String title,  String body)?  $default,) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.authorId,_that.authorName,_that.authorTitle,_that.topic,_that.time,_that.image,_that.read,_that.likes,_that.comments,_that.saved,_that.liked,_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostModel implements PostModel {
  const _PostModel({required this.id, required this.authorId, required this.authorName, required this.authorTitle, required this.topic, required this.time, this.image = false, required this.read, required this.likes, required this.comments, this.saved = false, this.liked = false, required this.title, required this.body});
  factory _PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String authorName;
@override final  String authorTitle;
@override final  String topic;
@override final  String time;
@override@JsonKey() final  bool image;
@override final  int read;
@override final  int likes;
@override final  int comments;
@override@JsonKey() final  bool saved;
@override@JsonKey() final  bool liked;
@override final  String title;
@override final  String body;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostModelCopyWith<_PostModel> get copyWith => __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorTitle, authorTitle) || other.authorTitle == authorTitle)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.time, time) || other.time == time)&&(identical(other.image, image) || other.image == image)&&(identical(other.read, read) || other.read == read)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorId,authorName,authorTitle,topic,time,image,read,likes,comments,saved,liked,title,body);

@override
String toString() {
  return 'PostModel(id: $id, authorId: $authorId, authorName: $authorName, authorTitle: $authorTitle, topic: $topic, time: $time, image: $image, read: $read, likes: $likes, comments: $comments, saved: $saved, liked: $liked, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(_PostModel value, $Res Function(_PostModel) _then) = __$PostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String authorName, String authorTitle, String topic, String time, bool image, int read, int likes, int comments, bool saved, bool liked, String title, String body
});




}
/// @nodoc
class __$PostModelCopyWithImpl<$Res>
    implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? authorName = null,Object? authorTitle = null,Object? topic = null,Object? time = null,Object? image = null,Object? read = null,Object? likes = null,Object? comments = null,Object? saved = null,Object? liked = null,Object? title = null,Object? body = null,}) {
  return _then(_PostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorTitle: null == authorTitle ? _self.authorTitle : authorTitle // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as bool,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PostCommentModel {

 String get id; String get name; String get time; String get text; int get likes;
/// Create a copy of PostCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCommentModelCopyWith<PostCommentModel> get copyWith => _$PostCommentModelCopyWithImpl<PostCommentModel>(this as PostCommentModel, _$identity);

  /// Serializes this PostCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.time, time) || other.time == time)&&(identical(other.text, text) || other.text == text)&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,time,text,likes);

@override
String toString() {
  return 'PostCommentModel(id: $id, name: $name, time: $time, text: $text, likes: $likes)';
}


}

/// @nodoc
abstract mixin class $PostCommentModelCopyWith<$Res>  {
  factory $PostCommentModelCopyWith(PostCommentModel value, $Res Function(PostCommentModel) _then) = _$PostCommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String time, String text, int likes
});




}
/// @nodoc
class _$PostCommentModelCopyWithImpl<$Res>
    implements $PostCommentModelCopyWith<$Res> {
  _$PostCommentModelCopyWithImpl(this._self, this._then);

  final PostCommentModel _self;
  final $Res Function(PostCommentModel) _then;

/// Create a copy of PostCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? time = null,Object? text = null,Object? likes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PostCommentModel].
extension PostCommentModelPatterns on PostCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _PostCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String time,  String text,  int likes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostCommentModel() when $default != null:
return $default(_that.id,_that.name,_that.time,_that.text,_that.likes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String time,  String text,  int likes)  $default,) {final _that = this;
switch (_that) {
case _PostCommentModel():
return $default(_that.id,_that.name,_that.time,_that.text,_that.likes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String time,  String text,  int likes)?  $default,) {final _that = this;
switch (_that) {
case _PostCommentModel() when $default != null:
return $default(_that.id,_that.name,_that.time,_that.text,_that.likes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostCommentModel implements PostCommentModel {
  const _PostCommentModel({required this.id, required this.name, required this.time, required this.text, this.likes = 0});
  factory _PostCommentModel.fromJson(Map<String, dynamic> json) => _$PostCommentModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String time;
@override final  String text;
@override@JsonKey() final  int likes;

/// Create a copy of PostCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCommentModelCopyWith<_PostCommentModel> get copyWith => __$PostCommentModelCopyWithImpl<_PostCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.time, time) || other.time == time)&&(identical(other.text, text) || other.text == text)&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,time,text,likes);

@override
String toString() {
  return 'PostCommentModel(id: $id, name: $name, time: $time, text: $text, likes: $likes)';
}


}

/// @nodoc
abstract mixin class _$PostCommentModelCopyWith<$Res> implements $PostCommentModelCopyWith<$Res> {
  factory _$PostCommentModelCopyWith(_PostCommentModel value, $Res Function(_PostCommentModel) _then) = __$PostCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String time, String text, int likes
});




}
/// @nodoc
class __$PostCommentModelCopyWithImpl<$Res>
    implements _$PostCommentModelCopyWith<$Res> {
  __$PostCommentModelCopyWithImpl(this._self, this._then);

  final _PostCommentModel _self;
  final $Res Function(_PostCommentModel) _then;

/// Create a copy of PostCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? time = null,Object? text = null,Object? likes = null,}) {
  return _then(_PostCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
