// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent()';
}


}

/// @nodoc
class $FeedEventCopyWith<$Res>  {
$FeedEventCopyWith(FeedEvent _, $Res Function(FeedEvent) __);
}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedLoad value)?  load,TResult Function( FeedTopicChanged value)?  topicChanged,TResult Function( FeedLikeToggled value)?  likeToggled,TResult Function( FeedSaveToggled value)?  saveToggled,TResult Function( FeedPostUpdated value)?  postUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedLoad() when load != null:
return load(_that);case FeedTopicChanged() when topicChanged != null:
return topicChanged(_that);case FeedLikeToggled() when likeToggled != null:
return likeToggled(_that);case FeedSaveToggled() when saveToggled != null:
return saveToggled(_that);case FeedPostUpdated() when postUpdated != null:
return postUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedLoad value)  load,required TResult Function( FeedTopicChanged value)  topicChanged,required TResult Function( FeedLikeToggled value)  likeToggled,required TResult Function( FeedSaveToggled value)  saveToggled,required TResult Function( FeedPostUpdated value)  postUpdated,}){
final _that = this;
switch (_that) {
case FeedLoad():
return load(_that);case FeedTopicChanged():
return topicChanged(_that);case FeedLikeToggled():
return likeToggled(_that);case FeedSaveToggled():
return saveToggled(_that);case FeedPostUpdated():
return postUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedLoad value)?  load,TResult? Function( FeedTopicChanged value)?  topicChanged,TResult? Function( FeedLikeToggled value)?  likeToggled,TResult? Function( FeedSaveToggled value)?  saveToggled,TResult? Function( FeedPostUpdated value)?  postUpdated,}){
final _that = this;
switch (_that) {
case FeedLoad() when load != null:
return load(_that);case FeedTopicChanged() when topicChanged != null:
return topicChanged(_that);case FeedLikeToggled() when likeToggled != null:
return likeToggled(_that);case FeedSaveToggled() when saveToggled != null:
return saveToggled(_that);case FeedPostUpdated() when postUpdated != null:
return postUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool savedOnly)?  load,TResult Function( String topic)?  topicChanged,TResult Function( Post post)?  likeToggled,TResult Function( Post post)?  saveToggled,TResult Function( Post post)?  postUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedLoad() when load != null:
return load(_that.savedOnly);case FeedTopicChanged() when topicChanged != null:
return topicChanged(_that.topic);case FeedLikeToggled() when likeToggled != null:
return likeToggled(_that.post);case FeedSaveToggled() when saveToggled != null:
return saveToggled(_that.post);case FeedPostUpdated() when postUpdated != null:
return postUpdated(_that.post);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool savedOnly)  load,required TResult Function( String topic)  topicChanged,required TResult Function( Post post)  likeToggled,required TResult Function( Post post)  saveToggled,required TResult Function( Post post)  postUpdated,}) {final _that = this;
switch (_that) {
case FeedLoad():
return load(_that.savedOnly);case FeedTopicChanged():
return topicChanged(_that.topic);case FeedLikeToggled():
return likeToggled(_that.post);case FeedSaveToggled():
return saveToggled(_that.post);case FeedPostUpdated():
return postUpdated(_that.post);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool savedOnly)?  load,TResult? Function( String topic)?  topicChanged,TResult? Function( Post post)?  likeToggled,TResult? Function( Post post)?  saveToggled,TResult? Function( Post post)?  postUpdated,}) {final _that = this;
switch (_that) {
case FeedLoad() when load != null:
return load(_that.savedOnly);case FeedTopicChanged() when topicChanged != null:
return topicChanged(_that.topic);case FeedLikeToggled() when likeToggled != null:
return likeToggled(_that.post);case FeedSaveToggled() when saveToggled != null:
return saveToggled(_that.post);case FeedPostUpdated() when postUpdated != null:
return postUpdated(_that.post);case _:
  return null;

}
}

}

/// @nodoc


class FeedLoad implements FeedEvent {
  const FeedLoad({this.savedOnly = false});
  

@JsonKey() final  bool savedOnly;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedLoadCopyWith<FeedLoad> get copyWith => _$FeedLoadCopyWithImpl<FeedLoad>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoad&&(identical(other.savedOnly, savedOnly) || other.savedOnly == savedOnly));
}


@override
int get hashCode {
    return Object.hash(runtimeType,savedOnly);
}

@override
String toString() {
    return 'FeedEvent.load(savedOnly: $savedOnly)';
}


}

/// @nodoc
abstract mixin class $FeedLoadCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $FeedLoadCopyWith(FeedLoad value, $Res Function(FeedLoad) _then) = _$FeedLoadCopyWithImpl;
@useResult
$Res call({
 bool savedOnly
});




}
/// @nodoc
class _$FeedLoadCopyWithImpl<$Res>
    implements $FeedLoadCopyWith<$Res> {
  _$FeedLoadCopyWithImpl(this._self, this._then);

  final FeedLoad _self;
  final $Res Function(FeedLoad) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? savedOnly = null,}) {
  return _then(FeedLoad(
savedOnly: null == savedOnly ? _self.savedOnly : savedOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FeedTopicChanged implements FeedEvent {
  const FeedTopicChanged(this.topic);
  

 final  String topic;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedTopicChangedCopyWith<FeedTopicChanged> get copyWith => _$FeedTopicChangedCopyWithImpl<FeedTopicChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedTopicChanged&&(identical(other.topic, topic) || other.topic == topic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,topic);
}

@override
String toString() {
    return 'FeedEvent.topicChanged(topic: $topic)';
}


}

/// @nodoc
abstract mixin class $FeedTopicChangedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $FeedTopicChangedCopyWith(FeedTopicChanged value, $Res Function(FeedTopicChanged) _then) = _$FeedTopicChangedCopyWithImpl;
@useResult
$Res call({
 String topic
});




}
/// @nodoc
class _$FeedTopicChangedCopyWithImpl<$Res>
    implements $FeedTopicChangedCopyWith<$Res> {
  _$FeedTopicChangedCopyWithImpl(this._self, this._then);

  final FeedTopicChanged _self;
  final $Res Function(FeedTopicChanged) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topic = null,}) {
  return _then(FeedTopicChanged(
null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FeedLikeToggled implements FeedEvent {
  const FeedLikeToggled(this.post);
  

 final  Post post;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedLikeToggledCopyWith<FeedLikeToggled> get copyWith => _$FeedLikeToggledCopyWithImpl<FeedLikeToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLikeToggled&&(identical(other.post, post) || other.post == post));
}


@override
int get hashCode {
    return Object.hash(runtimeType,post);
}

@override
String toString() {
    return 'FeedEvent.likeToggled(post: $post)';
}


}

/// @nodoc
abstract mixin class $FeedLikeToggledCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $FeedLikeToggledCopyWith(FeedLikeToggled value, $Res Function(FeedLikeToggled) _then) = _$FeedLikeToggledCopyWithImpl;
@useResult
$Res call({
 Post post
});


$PostCopyWith<$Res> get post;

}
/// @nodoc
class _$FeedLikeToggledCopyWithImpl<$Res>
    implements $FeedLikeToggledCopyWith<$Res> {
  _$FeedLikeToggledCopyWithImpl(this._self, this._then);

  final FeedLikeToggled _self;
  final $Res Function(FeedLikeToggled) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,}) {
  return _then(FeedLikeToggled(
null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post,
  ));
}

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res> get post {
  
  return $PostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

/// @nodoc


class FeedSaveToggled implements FeedEvent {
  const FeedSaveToggled(this.post);
  

 final  Post post;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedSaveToggledCopyWith<FeedSaveToggled> get copyWith => _$FeedSaveToggledCopyWithImpl<FeedSaveToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedSaveToggled&&(identical(other.post, post) || other.post == post));
}


@override
int get hashCode {
    return Object.hash(runtimeType,post);
}

@override
String toString() {
    return 'FeedEvent.saveToggled(post: $post)';
}


}

/// @nodoc
abstract mixin class $FeedSaveToggledCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $FeedSaveToggledCopyWith(FeedSaveToggled value, $Res Function(FeedSaveToggled) _then) = _$FeedSaveToggledCopyWithImpl;
@useResult
$Res call({
 Post post
});


$PostCopyWith<$Res> get post;

}
/// @nodoc
class _$FeedSaveToggledCopyWithImpl<$Res>
    implements $FeedSaveToggledCopyWith<$Res> {
  _$FeedSaveToggledCopyWithImpl(this._self, this._then);

  final FeedSaveToggled _self;
  final $Res Function(FeedSaveToggled) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,}) {
  return _then(FeedSaveToggled(
null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post,
  ));
}

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res> get post {
  
  return $PostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

/// @nodoc


class FeedPostUpdated implements FeedEvent {
  const FeedPostUpdated(this.post);
  

 final  Post post;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPostUpdatedCopyWith<FeedPostUpdated> get copyWith => _$FeedPostUpdatedCopyWithImpl<FeedPostUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPostUpdated&&(identical(other.post, post) || other.post == post));
}


@override
int get hashCode {
    return Object.hash(runtimeType,post);
}

@override
String toString() {
    return 'FeedEvent.postUpdated(post: $post)';
}


}

/// @nodoc
abstract mixin class $FeedPostUpdatedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $FeedPostUpdatedCopyWith(FeedPostUpdated value, $Res Function(FeedPostUpdated) _then) = _$FeedPostUpdatedCopyWithImpl;
@useResult
$Res call({
 Post post
});


$PostCopyWith<$Res> get post;

}
/// @nodoc
class _$FeedPostUpdatedCopyWithImpl<$Res>
    implements $FeedPostUpdatedCopyWith<$Res> {
  _$FeedPostUpdatedCopyWithImpl(this._self, this._then);

  final FeedPostUpdated _self;
  final $Res Function(FeedPostUpdated) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? post = null,}) {
  return _then(FeedPostUpdated(
null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post,
  ));
}

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res> get post {
  
  return $PostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

/// @nodoc
mixin _$FeedState {

 LoadStatus get status; String get topic; List<Post> get posts; bool get savedOnly; String? get error;
/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedStateCopyWith<FeedState> get copyWith => _$FeedStateCopyWithImpl<FeedState>(this as FeedState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&const DeepCollectionEquality().equals(other.posts, _this.posts)&&(identical(other.savedOnly, _this.savedOnly) || other.savedOnly == _this.savedOnly)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as FeedState;
  return Object.hash(runtimeType,_this.status,_this.topic,const DeepCollectionEquality().hash(_this.posts),_this.savedOnly,_this.error);
}

@override
String toString() {
  final _this = this as FeedState;
  return 'FeedState(status: ${_this.status}, topic: ${_this.topic}, posts: ${_this.posts}, savedOnly: ${_this.savedOnly}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $FeedStateCopyWith<$Res>  {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) _then) = _$FeedStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String topic, List<Post> posts, bool savedOnly, String? error
});




}
/// @nodoc
class _$FeedStateCopyWithImpl<$Res>
    implements $FeedStateCopyWith<$Res> {
  _$FeedStateCopyWithImpl(this._self, this._then);

  final FeedState _self;
  final $Res Function(FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? topic = null,Object? posts = null,Object? savedOnly = null,Object? error = freezed,}) {
  return _then(FeedState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,savedOnly: null == savedOnly ? _self.savedOnly : savedOnly // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedState value)  $default,){
final _that = this;
switch (_that) {
case _FeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String topic,  List<Post> posts,  bool savedOnly,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.status,_that.topic,_that.posts,_that.savedOnly,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String topic,  List<Post> posts,  bool savedOnly,  String? error)  $default,) {final _that = this;
switch (_that) {
case _FeedState():
return $default(_that.status,_that.topic,_that.posts,_that.savedOnly,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String topic,  List<Post> posts,  bool savedOnly,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.status,_that.topic,_that.posts,_that.savedOnly,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _FeedState implements FeedState {
  const _FeedState({this.status = LoadStatus.initial, this.topic = 'For you',  List<Post> posts = const <Post>[], this.savedOnly = false, this.error}): _posts = posts;
  

@override@JsonKey() final  LoadStatus status;
@override@JsonKey() final  String topic;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool savedOnly;
@override final  String? error;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedStateCopyWith<_FeedState> get copyWith => __$FeedStateCopyWithImpl<_FeedState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedState&&(identical(other.status, status) || other.status == status)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other.posts, _posts)&&(identical(other.savedOnly, savedOnly) || other.savedOnly == savedOnly)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,topic,const DeepCollectionEquality().hash(_posts),savedOnly,error);
}

@override
String toString() {
    return 'FeedState(status: $status, topic: $topic, posts: $posts, savedOnly: $savedOnly, error: $error)';
}


}

/// @nodoc
abstract mixin class _$FeedStateCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FeedStateCopyWith(_FeedState value, $Res Function(_FeedState) _then) = __$FeedStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String topic, List<Post> posts, bool savedOnly, String? error
});




}
/// @nodoc
class __$FeedStateCopyWithImpl<$Res>
    implements _$FeedStateCopyWith<$Res> {
  __$FeedStateCopyWithImpl(this._self, this._then);

  final _FeedState _self;
  final $Res Function(_FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? topic = null,Object? posts = null,Object? savedOnly = null,Object? error = freezed,}) {
  return _then(_FeedState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,savedOnly: null == savedOnly ? _self.savedOnly : savedOnly // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
