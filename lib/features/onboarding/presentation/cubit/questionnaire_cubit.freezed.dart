// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questionnaire_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionnaireState {

 int get step; int get direction; Assessment get answers; bool get saving; bool get done;
/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionnaireStateCopyWith<QuestionnaireState> get copyWith => _$QuestionnaireStateCopyWithImpl<QuestionnaireState>(this as QuestionnaireState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuestionnaireState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionnaireState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.answers, _this.answers) || other.answers == _this.answers)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.done, _this.done) || other.done == _this.done));
}


@override
int get hashCode {
  final _this = this as QuestionnaireState;
  return Object.hash(runtimeType,_this.step,_this.direction,_this.answers,_this.saving,_this.done);
}

@override
String toString() {
  final _this = this as QuestionnaireState;
  return 'QuestionnaireState(step: ${_this.step}, direction: ${_this.direction}, answers: ${_this.answers}, saving: ${_this.saving}, done: ${_this.done})';
}


}

/// @nodoc
abstract mixin class $QuestionnaireStateCopyWith<$Res>  {
  factory $QuestionnaireStateCopyWith(QuestionnaireState value, $Res Function(QuestionnaireState) _then) = _$QuestionnaireStateCopyWithImpl;
@useResult
$Res call({
 int step, int direction, Assessment answers, bool saving, bool done
});


$AssessmentCopyWith<$Res> get answers;

}
/// @nodoc
class _$QuestionnaireStateCopyWithImpl<$Res>
    implements $QuestionnaireStateCopyWith<$Res> {
  _$QuestionnaireStateCopyWithImpl(this._self, this._then);

  final QuestionnaireState _self;
  final $Res Function(QuestionnaireState) _then;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? direction = null,Object? answers = null,Object? saving = null,Object? done = null,}) {
  return _then(QuestionnaireState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Assessment,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssessmentCopyWith<$Res> get answers {
  
  return $AssessmentCopyWith<$Res>(_self.answers, (value) {
    return _then(_self.copyWith(answers: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestionnaireState].
extension QuestionnaireStatePatterns on QuestionnaireState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionnaireState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionnaireState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionnaireState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionnaireState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionnaireState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionnaireState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int step,  int direction,  Assessment answers,  bool saving,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionnaireState() when $default != null:
return $default(_that.step,_that.direction,_that.answers,_that.saving,_that.done);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int step,  int direction,  Assessment answers,  bool saving,  bool done)  $default,) {final _that = this;
switch (_that) {
case _QuestionnaireState():
return $default(_that.step,_that.direction,_that.answers,_that.saving,_that.done);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int step,  int direction,  Assessment answers,  bool saving,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _QuestionnaireState() when $default != null:
return $default(_that.step,_that.direction,_that.answers,_that.saving,_that.done);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionnaireState extends QuestionnaireState {
  const _QuestionnaireState({this.step = 0, this.direction = 1, this.answers = const Assessment(), this.saving = false, this.done = false}): super._();
  

@override@JsonKey() final  int step;
@override@JsonKey() final  int direction;
@override@JsonKey() final  Assessment answers;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool done;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionnaireStateCopyWith<_QuestionnaireState> get copyWith => __$QuestionnaireStateCopyWithImpl<_QuestionnaireState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionnaireState&&(identical(other.step, step) || other.step == step)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.answers, answers) || other.answers == answers)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.done, done) || other.done == done));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,direction,answers,saving,done);
}

@override
String toString() {
    return 'QuestionnaireState(step: $step, direction: $direction, answers: $answers, saving: $saving, done: $done)';
}


}

/// @nodoc
abstract mixin class _$QuestionnaireStateCopyWith<$Res> implements $QuestionnaireStateCopyWith<$Res> {
  factory _$QuestionnaireStateCopyWith(_QuestionnaireState value, $Res Function(_QuestionnaireState) _then) = __$QuestionnaireStateCopyWithImpl;
@override @useResult
$Res call({
 int step, int direction, Assessment answers, bool saving, bool done
});


@override $AssessmentCopyWith<$Res> get answers;

}
/// @nodoc
class __$QuestionnaireStateCopyWithImpl<$Res>
    implements _$QuestionnaireStateCopyWith<$Res> {
  __$QuestionnaireStateCopyWithImpl(this._self, this._then);

  final _QuestionnaireState _self;
  final $Res Function(_QuestionnaireState) _then;

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? direction = null,Object? answers = null,Object? saving = null,Object? done = null,}) {
  return _then(_QuestionnaireState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as int,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Assessment,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QuestionnaireState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssessmentCopyWith<$Res> get answers {
  
  return $AssessmentCopyWith<$Res>(_self.answers, (value) {
    return _then(_self.copyWith(answers: value));
  });
}
}

// dart format on
