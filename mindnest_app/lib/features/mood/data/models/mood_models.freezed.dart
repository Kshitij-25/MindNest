// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoodEntryModel {

 String get day; String get time; int get level; String get note; List<String> get factors;
/// Create a copy of MoodEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodEntryModelCopyWith<MoodEntryModel> get copyWith => _$MoodEntryModelCopyWithImpl<MoodEntryModel>(this as MoodEntryModel, _$identity);

  /// Serializes this MoodEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodEntryModel&&(identical(other.day, day) || other.day == day)&&(identical(other.time, time) || other.time == time)&&(identical(other.level, level) || other.level == level)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.factors, factors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,time,level,note,const DeepCollectionEquality().hash(factors));

@override
String toString() {
  return 'MoodEntryModel(day: $day, time: $time, level: $level, note: $note, factors: $factors)';
}


}

/// @nodoc
abstract mixin class $MoodEntryModelCopyWith<$Res>  {
  factory $MoodEntryModelCopyWith(MoodEntryModel value, $Res Function(MoodEntryModel) _then) = _$MoodEntryModelCopyWithImpl;
@useResult
$Res call({
 String day, String time, int level, String note, List<String> factors
});




}
/// @nodoc
class _$MoodEntryModelCopyWithImpl<$Res>
    implements $MoodEntryModelCopyWith<$Res> {
  _$MoodEntryModelCopyWithImpl(this._self, this._then);

  final MoodEntryModel _self;
  final $Res Function(MoodEntryModel) _then;

/// Create a copy of MoodEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? time = null,Object? level = null,Object? note = null,Object? factors = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodEntryModel].
extension MoodEntryModelPatterns on MoodEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _MoodEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _MoodEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  String time,  int level,  String note,  List<String> factors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodEntryModel() when $default != null:
return $default(_that.day,_that.time,_that.level,_that.note,_that.factors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  String time,  int level,  String note,  List<String> factors)  $default,) {final _that = this;
switch (_that) {
case _MoodEntryModel():
return $default(_that.day,_that.time,_that.level,_that.note,_that.factors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  String time,  int level,  String note,  List<String> factors)?  $default,) {final _that = this;
switch (_that) {
case _MoodEntryModel() when $default != null:
return $default(_that.day,_that.time,_that.level,_that.note,_that.factors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoodEntryModel implements MoodEntryModel {
  const _MoodEntryModel({required this.day, required this.time, required this.level, this.note = '', final  List<String> factors = const <String>[]}): _factors = factors;
  factory _MoodEntryModel.fromJson(Map<String, dynamic> json) => _$MoodEntryModelFromJson(json);

@override final  String day;
@override final  String time;
@override final  int level;
@override@JsonKey() final  String note;
 final  List<String> _factors;
@override@JsonKey() List<String> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}


/// Create a copy of MoodEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodEntryModelCopyWith<_MoodEntryModel> get copyWith => __$MoodEntryModelCopyWithImpl<_MoodEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoodEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodEntryModel&&(identical(other.day, day) || other.day == day)&&(identical(other.time, time) || other.time == time)&&(identical(other.level, level) || other.level == level)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._factors, _factors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,time,level,note,const DeepCollectionEquality().hash(_factors));

@override
String toString() {
  return 'MoodEntryModel(day: $day, time: $time, level: $level, note: $note, factors: $factors)';
}


}

/// @nodoc
abstract mixin class _$MoodEntryModelCopyWith<$Res> implements $MoodEntryModelCopyWith<$Res> {
  factory _$MoodEntryModelCopyWith(_MoodEntryModel value, $Res Function(_MoodEntryModel) _then) = __$MoodEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String day, String time, int level, String note, List<String> factors
});




}
/// @nodoc
class __$MoodEntryModelCopyWithImpl<$Res>
    implements _$MoodEntryModelCopyWith<$Res> {
  __$MoodEntryModelCopyWithImpl(this._self, this._then);

  final _MoodEntryModel _self;
  final $Res Function(_MoodEntryModel) _then;

/// Create a copy of MoodEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? time = null,Object? level = null,Object? note = null,Object? factors = null,}) {
  return _then(_MoodEntryModel(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
