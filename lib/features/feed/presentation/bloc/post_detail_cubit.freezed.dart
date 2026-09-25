// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostDetailState {

 LoadStatus get status; Post? get post; List<PostComment> get comments; bool get commentsLoading; bool get sending; String? get error;
/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailStateCopyWith<PostDetailState> get copyWith => _$PostDetailStateCopyWithImpl<PostDetailState>(this as PostDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PostDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.post, _this.post) || other.post == _this.post)&&const DeepCollectionEquality().equals(other.comments, _this.comments)&&(identical(other.commentsLoading, _this.commentsLoading) || other.commentsLoading == _this.commentsLoading)&&(identical(other.sending, _this.sending) || other.sending == _this.sending)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as PostDetailState;
  return Object.hash(runtimeType,_this.status,_this.post,const DeepCollectionEquality().hash(_this.comments),_this.commentsLoading,_this.sending,_this.error);
}

@override
String toString() {
  final _this = this as PostDetailState;
  return 'PostDetailState(status: ${_this.status}, post: ${_this.post}, comments: ${_this.comments}, commentsLoading: ${_this.commentsLoading}, sending: ${_this.sending}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $PostDetailStateCopyWith<$Res>  {
  factory $PostDetailStateCopyWith(PostDetailState value, $Res Function(PostDetailState) _then) = _$PostDetailStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, Post? post, List<PostComment> comments, bool commentsLoading, bool sending, String? error
});


$PostCopyWith<$Res>? get post;

}
/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._self, this._then);

  final PostDetailState _self;
  final $Res Function(PostDetailState) _then;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? post = freezed,Object? comments = null,Object? commentsLoading = null,Object? sending = null,Object? error = freezed,}) {
  return _then(PostDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<PostComment>,commentsLoading: null == commentsLoading ? _self.commentsLoading : commentsLoading // ignore: cast_nullable_to_non_nullable
as bool,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDetailState].
extension PostDetailStatePatterns on PostDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDetailState value)  $default,){
final _that = this;
switch (_that) {
case _PostDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  Post? post,  List<PostComment> comments,  bool commentsLoading,  bool sending,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that.status,_that.post,_that.comments,_that.commentsLoading,_that.sending,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  Post? post,  List<PostComment> comments,  bool commentsLoading,  bool sending,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PostDetailState():
return $default(_that.status,_that.post,_that.comments,_that.commentsLoading,_that.sending,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  Post? post,  List<PostComment> comments,  bool commentsLoading,  bool sending,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PostDetailState() when $default != null:
return $default(_that.status,_that.post,_that.comments,_that.commentsLoading,_that.sending,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PostDetailState implements PostDetailState {
  const _PostDetailState({this.status = LoadStatus.initial, this.post,  List<PostComment> comments = const <PostComment>[], this.commentsLoading = false, this.sending = false, this.error}): _comments = comments;
  

@override@JsonKey() final  LoadStatus status;
@override final  Post? post;
 final  List<PostComment> _comments;
@override@JsonKey() List<PostComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  bool commentsLoading;
@override@JsonKey() final  bool sending;
@override final  String? error;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDetailStateCopyWith<_PostDetailState> get copyWith => __$PostDetailStateCopyWithImpl<_PostDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.post, post) || other.post == post)&&const DeepCollectionEquality().equals(other.comments, _comments)&&(identical(other.commentsLoading, commentsLoading) || other.commentsLoading == commentsLoading)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,post,const DeepCollectionEquality().hash(_comments),commentsLoading,sending,error);
}

@override
String toString() {
    return 'PostDetailState(status: $status, post: $post, comments: $comments, commentsLoading: $commentsLoading, sending: $sending, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PostDetailStateCopyWith<$Res> implements $PostDetailStateCopyWith<$Res> {
  factory _$PostDetailStateCopyWith(_PostDetailState value, $Res Function(_PostDetailState) _then) = __$PostDetailStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, Post? post, List<PostComment> comments, bool commentsLoading, bool sending, String? error
});


@override $PostCopyWith<$Res>? get post;

}
/// @nodoc
class __$PostDetailStateCopyWithImpl<$Res>
    implements _$PostDetailStateCopyWith<$Res> {
  __$PostDetailStateCopyWithImpl(this._self, this._then);

  final _PostDetailState _self;
  final $Res Function(_PostDetailState) _then;

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? post = freezed,Object? comments = null,Object? commentsLoading = null,Object? sending = null,Object? error = freezed,}) {
  return _then(_PostDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as Post?,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<PostComment>,commentsLoading: null == commentsLoading ? _self.commentsLoading : commentsLoading // ignore: cast_nullable_to_non_nullable
as bool,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

// dart format on
