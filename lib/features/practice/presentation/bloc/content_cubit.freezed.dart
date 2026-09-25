// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentState {

 LoadStatus get status; List<Post> get posts; ContentFilter get filter;
/// Create a copy of ContentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentStateCopyWith<ContentState> get copyWith => _$ContentStateCopyWithImpl<ContentState>(this as ContentState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ContentState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.posts, _this.posts)&&(identical(other.filter, _this.filter) || other.filter == _this.filter));
}


@override
int get hashCode {
  final _this = this as ContentState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.posts),_this.filter);
}

@override
String toString() {
  final _this = this as ContentState;
  return 'ContentState(status: ${_this.status}, posts: ${_this.posts}, filter: ${_this.filter})';
}


}

/// @nodoc
abstract mixin class $ContentStateCopyWith<$Res>  {
  factory $ContentStateCopyWith(ContentState value, $Res Function(ContentState) _then) = _$ContentStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Post> posts, ContentFilter filter
});




}
/// @nodoc
class _$ContentStateCopyWithImpl<$Res>
    implements $ContentStateCopyWith<$Res> {
  _$ContentStateCopyWithImpl(this._self, this._then);

  final ContentState _self;
  final $Res Function(ContentState) _then;

/// Create a copy of ContentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? posts = null,Object? filter = null,}) {
  return _then(ContentState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ContentFilter,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentState].
extension ContentStatePatterns on ContentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentState value)  $default,){
final _that = this;
switch (_that) {
case _ContentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentState value)?  $default,){
final _that = this;
switch (_that) {
case _ContentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Post> posts,  ContentFilter filter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentState() when $default != null:
return $default(_that.status,_that.posts,_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Post> posts,  ContentFilter filter)  $default,) {final _that = this;
switch (_that) {
case _ContentState():
return $default(_that.status,_that.posts,_that.filter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Post> posts,  ContentFilter filter)?  $default,) {final _that = this;
switch (_that) {
case _ContentState() when $default != null:
return $default(_that.status,_that.posts,_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class _ContentState extends ContentState {
  const _ContentState({this.status = LoadStatus.initial,  List<Post> posts = const <Post>[], this.filter = ContentFilter.published}): _posts = posts,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  ContentFilter filter;

/// Create a copy of ContentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentStateCopyWith<_ContentState> get copyWith => __$ContentStateCopyWithImpl<_ContentState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.posts, _posts)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_posts),filter);
}

@override
String toString() {
    return 'ContentState(status: $status, posts: $posts, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$ContentStateCopyWith<$Res> implements $ContentStateCopyWith<$Res> {
  factory _$ContentStateCopyWith(_ContentState value, $Res Function(_ContentState) _then) = __$ContentStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Post> posts, ContentFilter filter
});




}
/// @nodoc
class __$ContentStateCopyWithImpl<$Res>
    implements _$ContentStateCopyWith<$Res> {
  __$ContentStateCopyWithImpl(this._self, this._then);

  final _ContentState _self;
  final $Res Function(_ContentState) _then;

/// Create a copy of ContentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? posts = null,Object? filter = null,}) {
  return _then(_ContentState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ContentFilter,
  ));
}


}

/// @nodoc
mixin _$CreatePostState {

 NewPost get post; bool get submitting; Post? get published; String? get error;
/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostStateCopyWith<CreatePostState> get copyWith => _$CreatePostStateCopyWithImpl<CreatePostState>(this as CreatePostState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreatePostState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostState&&(identical(other.post, _this.post) || other.post == _this.post)&&(identical(other.submitting, _this.submitting) || other.submitting == _this.submitting)&&(identical(other.published, _this.published) || other.published == _this.published)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as CreatePostState;
  return Object.hash(runtimeType,_this.post,_this.submitting,_this.published,_this.error);
}

@override
String toString() {
  final _this = this as CreatePostState;
  return 'CreatePostState(post: ${_this.post}, submitting: ${_this.submitting}, published: ${_this.published}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $CreatePostStateCopyWith<$Res>  {
  factory $CreatePostStateCopyWith(CreatePostState value, $Res Function(CreatePostState) _then) = _$CreatePostStateCopyWithImpl;
@useResult
$Res call({
 NewPost post, bool submitting, Post? published, String? error
});


$NewPostCopyWith<$Res> get post;$PostCopyWith<$Res>? get published;

}
/// @nodoc
class _$CreatePostStateCopyWithImpl<$Res>
    implements $CreatePostStateCopyWith<$Res> {
  _$CreatePostStateCopyWithImpl(this._self, this._then);

  final CreatePostState _self;
  final $Res Function(CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? post = null,Object? submitting = null,Object? published = freezed,Object? error = freezed,}) {
  return _then(CreatePostState(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as NewPost,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,published: freezed == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as Post?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewPostCopyWith<$Res> get post {
  
  return $NewPostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get published {
    if (_self.published == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.published!, (value) {
    return _then(_self.copyWith(published: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatePostState].
extension CreatePostStatePatterns on CreatePostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePostState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePostState value)  $default,){
final _that = this;
switch (_that) {
case _CreatePostState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePostState value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NewPost post,  bool submitting,  Post? published,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.post,_that.submitting,_that.published,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NewPost post,  bool submitting,  Post? published,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CreatePostState():
return $default(_that.post,_that.submitting,_that.published,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NewPost post,  bool submitting,  Post? published,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.post,_that.submitting,_that.published,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CreatePostState extends CreatePostState {
  const _CreatePostState({this.post = const NewPost(topic: ''), this.submitting = false, this.published, this.error}): super._();
  

@override@JsonKey() final  NewPost post;
@override@JsonKey() final  bool submitting;
@override final  Post? published;
@override final  String? error;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePostStateCopyWith<_CreatePostState> get copyWith => __$CreatePostStateCopyWithImpl<_CreatePostState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePostState&&(identical(other.post, post) || other.post == post)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.published, published) || other.published == published)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,post,submitting,published,error);
}

@override
String toString() {
    return 'CreatePostState(post: $post, submitting: $submitting, published: $published, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CreatePostStateCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$CreatePostStateCopyWith(_CreatePostState value, $Res Function(_CreatePostState) _then) = __$CreatePostStateCopyWithImpl;
@override @useResult
$Res call({
 NewPost post, bool submitting, Post? published, String? error
});


@override $NewPostCopyWith<$Res> get post;@override $PostCopyWith<$Res>? get published;

}
/// @nodoc
class __$CreatePostStateCopyWithImpl<$Res>
    implements _$CreatePostStateCopyWith<$Res> {
  __$CreatePostStateCopyWithImpl(this._self, this._then);

  final _CreatePostState _self;
  final $Res Function(_CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? post = null,Object? submitting = null,Object? published = freezed,Object? error = freezed,}) {
  return _then(_CreatePostState(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as NewPost,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,published: freezed == published ? _self.published : published // ignore: cast_nullable_to_non_nullable
as Post?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewPostCopyWith<$Res> get post {
  
  return $NewPostCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get published {
    if (_self.published == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.published!, (value) {
    return _then(_self.copyWith(published: value));
  });
}
}

// dart format on
