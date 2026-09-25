// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoodEntry {

 String get id; int get level; DateTime get createdAt; List<String> get factors; String get note;
/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodEntryCopyWith<MoodEntry> get copyWith => _$MoodEntryCopyWithImpl<MoodEntry>(this as MoodEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoodEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.factors, _this.factors)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as MoodEntry;
  return Object.hash(runtimeType,_this.id,_this.level,_this.createdAt,const DeepCollectionEquality().hash(_this.factors),_this.note);
}

@override
String toString() {
  final _this = this as MoodEntry;
  return 'MoodEntry(id: ${_this.id}, level: ${_this.level}, createdAt: ${_this.createdAt}, factors: ${_this.factors}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $MoodEntryCopyWith<$Res>  {
  factory $MoodEntryCopyWith(MoodEntry value, $Res Function(MoodEntry) _then) = _$MoodEntryCopyWithImpl;
@useResult
$Res call({
 String id, int level, DateTime createdAt, List<String> factors, String note
});




}
/// @nodoc
class _$MoodEntryCopyWithImpl<$Res>
    implements $MoodEntryCopyWith<$Res> {
  _$MoodEntryCopyWithImpl(this._self, this._then);

  final MoodEntry _self;
  final $Res Function(MoodEntry) _then;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? level = null,Object? createdAt = null,Object? factors = null,Object? note = null,}) {
  return _then(MoodEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,factors: null == factors ? _self.factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodEntry].
extension MoodEntryPatterns on MoodEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodEntry value)  $default,){
final _that = this;
switch (_that) {
case _MoodEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodEntry value)?  $default,){
final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int level,  DateTime createdAt,  List<String> factors,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
return $default(_that.id,_that.level,_that.createdAt,_that.factors,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int level,  DateTime createdAt,  List<String> factors,  String note)  $default,) {final _that = this;
switch (_that) {
case _MoodEntry():
return $default(_that.id,_that.level,_that.createdAt,_that.factors,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int level,  DateTime createdAt,  List<String> factors,  String note)?  $default,) {final _that = this;
switch (_that) {
case _MoodEntry() when $default != null:
return $default(_that.id,_that.level,_that.createdAt,_that.factors,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _MoodEntry implements MoodEntry {
  const _MoodEntry({required this.id, required this.level, required this.createdAt,  List<String> factors = const <String>[], this.note = ''}): _factors = factors;
  

@override final  String id;
@override final  int level;
@override final  DateTime createdAt;
 final  List<String> _factors;
@override@JsonKey() List<String> get factors {
  if (_factors is EqualUnmodifiableListView) return _factors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_factors);
}

@override@JsonKey() final  String note;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodEntryCopyWith<_MoodEntry> get copyWith => __$MoodEntryCopyWithImpl<_MoodEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.factors, _factors)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,level,createdAt,const DeepCollectionEquality().hash(_factors),note);
}

@override
String toString() {
    return 'MoodEntry(id: $id, level: $level, createdAt: $createdAt, factors: $factors, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MoodEntryCopyWith<$Res> implements $MoodEntryCopyWith<$Res> {
  factory _$MoodEntryCopyWith(_MoodEntry value, $Res Function(_MoodEntry) _then) = __$MoodEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, int level, DateTime createdAt, List<String> factors, String note
});




}
/// @nodoc
class __$MoodEntryCopyWithImpl<$Res>
    implements _$MoodEntryCopyWith<$Res> {
  __$MoodEntryCopyWithImpl(this._self, this._then);

  final _MoodEntry _self;
  final $Res Function(_MoodEntry) _then;

/// Create a copy of MoodEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? level = null,Object? createdAt = null,Object? factors = null,Object? note = null,}) {
  return _then(_MoodEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,factors: null == factors ? _self._factors : factors // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
