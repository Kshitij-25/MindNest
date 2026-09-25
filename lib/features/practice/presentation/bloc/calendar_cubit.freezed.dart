// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {

 DateTime get weekStart; DateTime get selectedDay; CalendarMode get mode; List<ScheduledSession> get sessions; bool get loading;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.weekStart, _this.weekStart) || other.weekStart == _this.weekStart)&&(identical(other.selectedDay, _this.selectedDay) || other.selectedDay == _this.selectedDay)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&const DeepCollectionEquality().equals(other.sessions, _this.sessions)&&(identical(other.loading, _this.loading) || other.loading == _this.loading));
}


@override
int get hashCode {
  final _this = this as CalendarState;
  return Object.hash(runtimeType,_this.weekStart,_this.selectedDay,_this.mode,const DeepCollectionEquality().hash(_this.sessions),_this.loading);
}

@override
String toString() {
  final _this = this as CalendarState;
  return 'CalendarState(weekStart: ${_this.weekStart}, selectedDay: ${_this.selectedDay}, mode: ${_this.mode}, sessions: ${_this.sessions}, loading: ${_this.loading})';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 DateTime weekStart, DateTime selectedDay, CalendarMode mode, List<ScheduledSession> sessions, bool loading
});




}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? selectedDay = null,Object? mode = null,Object? sessions = null,Object? loading = null,}) {
  return _then(CalendarState(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarMode,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarState].
extension CalendarStatePatterns on CalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarState value)  $default,){
final _that = this;
switch (_that) {
case _CalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime weekStart,  DateTime selectedDay,  CalendarMode mode,  List<ScheduledSession> sessions,  bool loading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.weekStart,_that.selectedDay,_that.mode,_that.sessions,_that.loading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime weekStart,  DateTime selectedDay,  CalendarMode mode,  List<ScheduledSession> sessions,  bool loading)  $default,) {final _that = this;
switch (_that) {
case _CalendarState():
return $default(_that.weekStart,_that.selectedDay,_that.mode,_that.sessions,_that.loading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime weekStart,  DateTime selectedDay,  CalendarMode mode,  List<ScheduledSession> sessions,  bool loading)?  $default,) {final _that = this;
switch (_that) {
case _CalendarState() when $default != null:
return $default(_that.weekStart,_that.selectedDay,_that.mode,_that.sessions,_that.loading);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarState extends CalendarState {
  const _CalendarState({required this.weekStart, required this.selectedDay, this.mode = CalendarMode.week,  List<ScheduledSession> sessions = const <ScheduledSession>[], this.loading = false}): _sessions = sessions,super._();
  

@override final  DateTime weekStart;
@override final  DateTime selectedDay;
@override@JsonKey() final  CalendarMode mode;
 final  List<ScheduledSession> _sessions;
@override@JsonKey() List<ScheduledSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override@JsonKey() final  bool loading;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.sessions, _sessions)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,weekStart,selectedDay,mode,const DeepCollectionEquality().hash(_sessions),loading);
}

@override
String toString() {
    return 'CalendarState(weekStart: $weekStart, selectedDay: $selectedDay, mode: $mode, sessions: $sessions, loading: $loading)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime weekStart, DateTime selectedDay, CalendarMode mode, List<ScheduledSession> sessions, bool loading
});




}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? selectedDay = null,Object? mode = null,Object? sessions = null,Object? loading = null,}) {
  return _then(_CalendarState(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as DateTime,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as DateTime,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarMode,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
