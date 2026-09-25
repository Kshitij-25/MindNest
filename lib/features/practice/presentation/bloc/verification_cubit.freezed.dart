// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerificationState {

 List<VerificationDocument> get documents; DocumentKind? get uploading; bool get submitting; bool get submitted; String? get error;
/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationStateCopyWith<VerificationState> get copyWith => _$VerificationStateCopyWithImpl<VerificationState>(this as VerificationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VerificationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationState&&const DeepCollectionEquality().equals(other.documents, _this.documents)&&(identical(other.uploading, _this.uploading) || other.uploading == _this.uploading)&&(identical(other.submitting, _this.submitting) || other.submitting == _this.submitting)&&(identical(other.submitted, _this.submitted) || other.submitted == _this.submitted)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as VerificationState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.documents),_this.uploading,_this.submitting,_this.submitted,_this.error);
}

@override
String toString() {
  final _this = this as VerificationState;
  return 'VerificationState(documents: ${_this.documents}, uploading: ${_this.uploading}, submitting: ${_this.submitting}, submitted: ${_this.submitted}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $VerificationStateCopyWith<$Res>  {
  factory $VerificationStateCopyWith(VerificationState value, $Res Function(VerificationState) _then) = _$VerificationStateCopyWithImpl;
@useResult
$Res call({
 List<VerificationDocument> documents, DocumentKind? uploading, bool submitting, bool submitted, String? error
});




}
/// @nodoc
class _$VerificationStateCopyWithImpl<$Res>
    implements $VerificationStateCopyWith<$Res> {
  _$VerificationStateCopyWithImpl(this._self, this._then);

  final VerificationState _self;
  final $Res Function(VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documents = null,Object? uploading = freezed,Object? submitting = null,Object? submitted = null,Object? error = freezed,}) {
  return _then(VerificationState(
documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<VerificationDocument>,uploading: freezed == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as DocumentKind?,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationState].
extension VerificationStatePatterns on VerificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationState value)  $default,){
final _that = this;
switch (_that) {
case _VerificationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationState value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VerificationDocument> documents,  DocumentKind? uploading,  bool submitting,  bool submitted,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.documents,_that.uploading,_that.submitting,_that.submitted,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VerificationDocument> documents,  DocumentKind? uploading,  bool submitting,  bool submitted,  String? error)  $default,) {final _that = this;
switch (_that) {
case _VerificationState():
return $default(_that.documents,_that.uploading,_that.submitting,_that.submitted,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VerificationDocument> documents,  DocumentKind? uploading,  bool submitting,  bool submitted,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _VerificationState() when $default != null:
return $default(_that.documents,_that.uploading,_that.submitting,_that.submitted,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationState extends VerificationState {
  const _VerificationState({ List<VerificationDocument> documents = const <VerificationDocument>[], this.uploading, this.submitting = false, this.submitted = false, this.error}): _documents = documents,super._();
  

 final  List<VerificationDocument> _documents;
@override@JsonKey() List<VerificationDocument> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override final  DocumentKind? uploading;
@override@JsonKey() final  bool submitting;
@override@JsonKey() final  bool submitted;
@override final  String? error;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationStateCopyWith<_VerificationState> get copyWith => __$VerificationStateCopyWithImpl<_VerificationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationState&&const DeepCollectionEquality().equals(other.documents, _documents)&&(identical(other.uploading, uploading) || other.uploading == uploading)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.submitted, submitted) || other.submitted == submitted)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_documents),uploading,submitting,submitted,error);
}

@override
String toString() {
    return 'VerificationState(documents: $documents, uploading: $uploading, submitting: $submitting, submitted: $submitted, error: $error)';
}


}

/// @nodoc
abstract mixin class _$VerificationStateCopyWith<$Res> implements $VerificationStateCopyWith<$Res> {
  factory _$VerificationStateCopyWith(_VerificationState value, $Res Function(_VerificationState) _then) = __$VerificationStateCopyWithImpl;
@override @useResult
$Res call({
 List<VerificationDocument> documents, DocumentKind? uploading, bool submitting, bool submitted, String? error
});




}
/// @nodoc
class __$VerificationStateCopyWithImpl<$Res>
    implements _$VerificationStateCopyWith<$Res> {
  __$VerificationStateCopyWithImpl(this._self, this._then);

  final _VerificationState _self;
  final $Res Function(_VerificationState) _then;

/// Create a copy of VerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documents = null,Object? uploading = freezed,Object? submitting = null,Object? submitted = null,Object? error = freezed,}) {
  return _then(_VerificationState(
documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<VerificationDocument>,uploading: freezed == uploading ? _self.uploading : uploading // ignore: cast_nullable_to_non_nullable
as DocumentKind?,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
