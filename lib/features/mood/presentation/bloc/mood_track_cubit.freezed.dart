// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_track_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoodTrackState {

 int get level; List<String> get factors; String get note; bool get saving; bool get saved;
/// Create a copy of MoodTrackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodTrackStateCopyWith<MoodTrackState> get copyWith => _$MoodTrackStateCopyWithImpl<MoodTrackState>(this as MoodTrackState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoodTrackState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodTrackState&&(identical(other.level, _this.level) || other.level == _this.level)&&const DeepCollectionEquality().equals(other.factors, _this.factors)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as MoodTrackState;
  return Object.hash(runtimeType,_this.level,const DeepCollectionEquality().hash(_this.factors),_this.note,_this.saving,_this.saved);
}

@override
String toString() {
  final _this = this as MoodTrackState;
  return 'MoodTrackState(level: ${_this.level}, factors: ${_this.factors}, note: ${_this.note}, saving: ${_this.saving}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $MoodTrackStateCopyWith<$Res>  {
  factory $MoodTrackStateCopyWith(MoodTrackState value, $Res Function(MoodTrackState) _then) = _$MoodTrackStateCopyWithImpl;
@useResult
$Res call({
 int level, List<String> factors, String note, bool saving, bool saved
});




}
/// @nodoc
class _$MoodTrackStateCopyWithImpl<$Res>
    implements $MoodTrackStateCopyWith<$Res> {
  _$MoodTrackStateCopyWithImpl(this._self, this._then);

  final MoodTrackState _self;
  final $Res Function(MoodTrackState) _then;

/// Create a copy of MoodTrackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? factors = null,Object? note = null,Object? saving = null,Object? saved = null,}) {
  return _then(MoodTrackState(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodTrackState].
extension MoodTrackStatePatterns on MoodTrackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodTrackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodTrackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodTrackState value)  $default,){
final _that = this;
switch (_that) {
case _MoodTrackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodTrackState value)?  $default,){
final _that = this;
switch (_that) {
case _MoodTrackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  List<String> factors,  String note,  bool saving,  bool saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodTrackState() when $default != null:
return $default(_that.level,_that.factors,_that.note,_that.saving,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  List<String> factors,  String note,  bool saving,  bool saved)  $default,) {final _that = this;
switch (_that) {
case _MoodTrackState():
return $default(_that.level,_that.factors,_that.note,_that.saving,_that.saved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  List<String> factors,  String note,  bool saving,  bool saved)?  $default,) {final _that = this;
switch (_that) {
case _MoodTrackState() when $default != null:
return $default(_that.level,_that.factors,_that.note,_that.saving,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _MoodTrackState implements MoodTrackState {
  const _MoodTrackState({this.level = 4,  List<String> factors = const <String>[], this.note = '', this.saving = false, this.saved = false}): _factors = factors;
  

@override@JsonKey() final  int level;
 final  List<String> _factors;
@override@JsonKey() List<String> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}

@override@JsonKey() final  String note;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;

/// Create a copy of MoodTrackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodTrackStateCopyWith<_MoodTrackState> get copyWith => __$MoodTrackStateCopyWithImpl<_MoodTrackState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodTrackState&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.factors, _factors)&&(identical(other.note, note) || other.note == note)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,level,const DeepCollectionEquality().hash(_factors),note,saving,saved);
}

@override
String toString() {
    return 'MoodTrackState(level: $level, factors: $factors, note: $note, saving: $saving, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$MoodTrackStateCopyWith<$Res> implements $MoodTrackStateCopyWith<$Res> {
  factory _$MoodTrackStateCopyWith(_MoodTrackState value, $Res Function(_MoodTrackState) _then) = __$MoodTrackStateCopyWithImpl;
@override @useResult
$Res call({
 int level, List<String> factors, String note, bool saving, bool saved
});




}
/// @nodoc
class __$MoodTrackStateCopyWithImpl<$Res>
    implements _$MoodTrackStateCopyWith<$Res> {
  __$MoodTrackStateCopyWithImpl(this._self, this._then);

  final _MoodTrackState _self;
  final $Res Function(_MoodTrackState) _then;

/// Create a copy of MoodTrackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? factors = null,Object? note = null,Object? saving = null,Object? saved = null,}) {
  return _then(_MoodTrackState(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
