// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sessions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SessionsEvent()';
}


}

/// @nodoc
class $SessionsEventCopyWith<$Res>  {
$SessionsEventCopyWith(SessionsEvent _, $Res Function(SessionsEvent) __);
}


/// Adds pattern-matching-related methods to [SessionsEvent].
extension SessionsEventPatterns on SessionsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionsLoad value)?  load,TResult Function( SessionsCancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionsLoad() when load != null:
return load(_that);case SessionsCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionsLoad value)  load,required TResult Function( SessionsCancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case SessionsLoad():
return load(_that);case SessionsCancelled():
return cancelled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionsLoad value)?  load,TResult? Function( SessionsCancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case SessionsLoad() when load != null:
return load(_that);case SessionsCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( String id)?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionsLoad() when load != null:
return load();case SessionsCancelled() when cancelled != null:
return cancelled(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( String id)  cancelled,}) {final _that = this;
switch (_that) {
case SessionsLoad():
return load();case SessionsCancelled():
return cancelled(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( String id)?  cancelled,}) {final _that = this;
switch (_that) {
case SessionsLoad() when load != null:
return load();case SessionsCancelled() when cancelled != null:
return cancelled(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class SessionsLoad implements SessionsEvent {
  const SessionsLoad();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SessionsEvent.load()';
}


}




/// @nodoc


class SessionsCancelled implements SessionsEvent {
  const SessionsCancelled(this.id);
  

 final  String id;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionsCancelledCopyWith<SessionsCancelled> get copyWith => _$SessionsCancelledCopyWithImpl<SessionsCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsCancelled&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'SessionsEvent.cancelled(id: $id)';
}


}

/// @nodoc
abstract mixin class $SessionsCancelledCopyWith<$Res> implements $SessionsEventCopyWith<$Res> {
  factory $SessionsCancelledCopyWith(SessionsCancelled value, $Res Function(SessionsCancelled) _then) = _$SessionsCancelledCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SessionsCancelledCopyWithImpl<$Res>
    implements $SessionsCancelledCopyWith<$Res> {
  _$SessionsCancelledCopyWithImpl(this._self, this._then);

  final SessionsCancelled _self;
  final $Res Function(SessionsCancelled) _then;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(SessionsCancelled(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SessionsState {

 LoadStatus get status; List<Appointment> get upcoming; List<Appointment> get past; String? get error;
/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionsStateCopyWith<SessionsState> get copyWith => _$SessionsStateCopyWithImpl<SessionsState>(this as SessionsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming)&&const DeepCollectionEquality().equals(other.past, _this.past)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as SessionsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.upcoming),const DeepCollectionEquality().hash(_this.past),_this.error);
}

@override
String toString() {
  final _this = this as SessionsState;
  return 'SessionsState(status: ${_this.status}, upcoming: ${_this.upcoming}, past: ${_this.past}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $SessionsStateCopyWith<$Res>  {
  factory $SessionsStateCopyWith(SessionsState value, $Res Function(SessionsState) _then) = _$SessionsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Appointment> upcoming, List<Appointment> past, String? error
});




}
/// @nodoc
class _$SessionsStateCopyWithImpl<$Res>
    implements $SessionsStateCopyWith<$Res> {
  _$SessionsStateCopyWithImpl(this._self, this._then);

  final SessionsState _self;
  final $Res Function(SessionsState) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? upcoming = null,Object? past = null,Object? error = freezed,}) {
  return _then(SessionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Appointment>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<Appointment>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionsState].
extension SessionsStatePatterns on SessionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionsState value)  $default,){
final _that = this;
switch (_that) {
case _SessionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionsState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Appointment> upcoming,  List<Appointment> past,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionsState() when $default != null:
return $default(_that.status,_that.upcoming,_that.past,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Appointment> upcoming,  List<Appointment> past,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SessionsState():
return $default(_that.status,_that.upcoming,_that.past,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Appointment> upcoming,  List<Appointment> past,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SessionsState() when $default != null:
return $default(_that.status,_that.upcoming,_that.past,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SessionsState extends SessionsState {
  const _SessionsState({this.status = LoadStatus.initial,  List<Appointment> upcoming = const <Appointment>[],  List<Appointment> past = const <Appointment>[], this.error}): _upcoming = upcoming,_past = past,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<Appointment> _upcoming;
@override@JsonKey() List<Appointment> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<Appointment> _past;
@override@JsonKey() List<Appointment> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}

@override final  String? error;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionsStateCopyWith<_SessionsState> get copyWith => __$SessionsStateCopyWithImpl<_SessionsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.upcoming, _upcoming)&&const DeepCollectionEquality().equals(other.past, _past)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_past),error);
}

@override
String toString() {
    return 'SessionsState(status: $status, upcoming: $upcoming, past: $past, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SessionsStateCopyWith<$Res> implements $SessionsStateCopyWith<$Res> {
  factory _$SessionsStateCopyWith(_SessionsState value, $Res Function(_SessionsState) _then) = __$SessionsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Appointment> upcoming, List<Appointment> past, String? error
});




}
/// @nodoc
class __$SessionsStateCopyWithImpl<$Res>
    implements _$SessionsStateCopyWith<$Res> {
  __$SessionsStateCopyWithImpl(this._self, this._then);

  final _SessionsState _self;
  final $Res Function(_SessionsState) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? upcoming = null,Object? past = null,Object? error = freezed,}) {
  return _then(_SessionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Appointment>,past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<Appointment>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
