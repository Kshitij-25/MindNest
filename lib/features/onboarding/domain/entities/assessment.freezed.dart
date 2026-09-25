// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Assessment {

 int get mood; int get stress; int? get anxiety; int get sleep; List<String> get goals;
/// Create a copy of Assessment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentCopyWith<Assessment> get copyWith => _$AssessmentCopyWithImpl<Assessment>(this as Assessment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Assessment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assessment&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.stress, _this.stress) || other.stress == _this.stress)&&(identical(other.anxiety, _this.anxiety) || other.anxiety == _this.anxiety)&&(identical(other.sleep, _this.sleep) || other.sleep == _this.sleep)&&const DeepCollectionEquality().equals(other.goals, _this.goals));
}


@override
int get hashCode {
  final _this = this as Assessment;
  return Object.hash(runtimeType,_this.mood,_this.stress,_this.anxiety,_this.sleep,const DeepCollectionEquality().hash(_this.goals));
}

@override
String toString() {
  final _this = this as Assessment;
  return 'Assessment(mood: ${_this.mood}, stress: ${_this.stress}, anxiety: ${_this.anxiety}, sleep: ${_this.sleep}, goals: ${_this.goals})';
}


}

/// @nodoc
abstract mixin class $AssessmentCopyWith<$Res>  {
  factory $AssessmentCopyWith(Assessment value, $Res Function(Assessment) _then) = _$AssessmentCopyWithImpl;
@useResult
$Res call({
 int mood, int stress, int? anxiety, int sleep, List<String> goals
});




}
/// @nodoc
class _$AssessmentCopyWithImpl<$Res>
    implements $AssessmentCopyWith<$Res> {
  _$AssessmentCopyWithImpl(this._self, this._then);

  final Assessment _self;
  final $Res Function(Assessment) _then;

/// Create a copy of Assessment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mood = null,Object? stress = null,Object? anxiety = freezed,Object? sleep = null,Object? goals = null,}) {
  return _then(Assessment(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,anxiety: freezed == anxiety ? _self.anxiety : anxiety // ignore: cast_nullable_to_non_nullable
as int?,sleep: null == sleep ? _self.sleep : sleep // ignore: cast_nullable_to_non_nullable
as int,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Assessment].
extension AssessmentPatterns on Assessment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Assessment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Assessment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Assessment value)  $default,){
final _that = this;
switch (_that) {
case _Assessment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Assessment value)?  $default,){
final _that = this;
switch (_that) {
case _Assessment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mood,  int stress,  int? anxiety,  int sleep,  List<String> goals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Assessment() when $default != null:
return $default(_that.mood,_that.stress,_that.anxiety,_that.sleep,_that.goals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mood,  int stress,  int? anxiety,  int sleep,  List<String> goals)  $default,) {final _that = this;
switch (_that) {
case _Assessment():
return $default(_that.mood,_that.stress,_that.anxiety,_that.sleep,_that.goals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mood,  int stress,  int? anxiety,  int sleep,  List<String> goals)?  $default,) {final _that = this;
switch (_that) {
case _Assessment() when $default != null:
return $default(_that.mood,_that.stress,_that.anxiety,_that.sleep,_that.goals);case _:
  return null;

}
}

}

/// @nodoc


class _Assessment implements Assessment {
  const _Assessment({this.mood = 4, this.stress = 5, this.anxiety, this.sleep = 3,  List<String> goals = const <String>[]}): _goals = goals;
  

@override@JsonKey() final  int mood;
@override@JsonKey() final  int stress;
@override final  int? anxiety;
@override@JsonKey() final  int sleep;
 final  List<String> _goals;
@override@JsonKey() List<String> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}


/// Create a copy of Assessment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentCopyWith<_Assessment> get copyWith => __$AssessmentCopyWithImpl<_Assessment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Assessment&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.stress, stress) || other.stress == stress)&&(identical(other.anxiety, anxiety) || other.anxiety == anxiety)&&(identical(other.sleep, sleep) || other.sleep == sleep)&&const DeepCollectionEquality().equals(other.goals, _goals));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mood,stress,anxiety,sleep,const DeepCollectionEquality().hash(_goals));
}

@override
String toString() {
    return 'Assessment(mood: $mood, stress: $stress, anxiety: $anxiety, sleep: $sleep, goals: $goals)';
}


}

/// @nodoc
abstract mixin class _$AssessmentCopyWith<$Res> implements $AssessmentCopyWith<$Res> {
  factory _$AssessmentCopyWith(_Assessment value, $Res Function(_Assessment) _then) = __$AssessmentCopyWithImpl;
@override @useResult
$Res call({
 int mood, int stress, int? anxiety, int sleep, List<String> goals
});




}
/// @nodoc
class __$AssessmentCopyWithImpl<$Res>
    implements _$AssessmentCopyWith<$Res> {
  __$AssessmentCopyWithImpl(this._self, this._then);

  final _Assessment _self;
  final $Res Function(_Assessment) _then;

/// Create a copy of Assessment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mood = null,Object? stress = null,Object? anxiety = freezed,Object? sleep = null,Object? goals = null,}) {
  return _then(_Assessment(
mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,stress: null == stress ? _self.stress : stress // ignore: cast_nullable_to_non_nullable
as int,anxiety: freezed == anxiety ? _self.anxiety : anxiety // ignore: cast_nullable_to_non_nullable
as int?,sleep: null == sleep ? _self.sleep : sleep // ignore: cast_nullable_to_non_nullable
as int,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
