// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoodEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MoodEvent()';
}


}

/// @nodoc
class $MoodEventCopyWith<$Res>  {
$MoodEventCopyWith(MoodEvent _, $Res Function(MoodEvent) __);
}


/// Adds pattern-matching-related methods to [MoodEvent].
extension MoodEventPatterns on MoodEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MoodLoad value)?  load,TResult Function( MoodQuickLog value)?  quickLog,TResult Function( MoodRefresh value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MoodLoad() when load != null:
return load(_that);case MoodQuickLog() when quickLog != null:
return quickLog(_that);case MoodRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MoodLoad value)  load,required TResult Function( MoodQuickLog value)  quickLog,required TResult Function( MoodRefresh value)  refresh,}){
final _that = this;
switch (_that) {
case MoodLoad():
return load(_that);case MoodQuickLog():
return quickLog(_that);case MoodRefresh():
return refresh(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MoodLoad value)?  load,TResult? Function( MoodQuickLog value)?  quickLog,TResult? Function( MoodRefresh value)?  refresh,}){
final _that = this;
switch (_that) {
case MoodLoad() when load != null:
return load(_that);case MoodQuickLog() when quickLog != null:
return quickLog(_that);case MoodRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( int level)?  quickLog,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MoodLoad() when load != null:
return load();case MoodQuickLog() when quickLog != null:
return quickLog(_that.level);case MoodRefresh() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( int level)  quickLog,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case MoodLoad():
return load();case MoodQuickLog():
return quickLog(_that.level);case MoodRefresh():
return refresh();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( int level)?  quickLog,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case MoodLoad() when load != null:
return load();case MoodQuickLog() when quickLog != null:
return quickLog(_that.level);case MoodRefresh() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class MoodLoad implements MoodEvent {
  const MoodLoad();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MoodEvent.load()';
}


}




/// @nodoc


class MoodQuickLog implements MoodEvent {
  const MoodQuickLog(this.level);
  

 final  int level;

/// Create a copy of MoodEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodQuickLogCopyWith<MoodQuickLog> get copyWith => _$MoodQuickLogCopyWithImpl<MoodQuickLog>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodQuickLog&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode {
    return Object.hash(runtimeType,level);
}

@override
String toString() {
    return 'MoodEvent.quickLog(level: $level)';
}


}

/// @nodoc
abstract mixin class $MoodQuickLogCopyWith<$Res> implements $MoodEventCopyWith<$Res> {
  factory $MoodQuickLogCopyWith(MoodQuickLog value, $Res Function(MoodQuickLog) _then) = _$MoodQuickLogCopyWithImpl;
@useResult
$Res call({
 int level
});




}
/// @nodoc
class _$MoodQuickLogCopyWithImpl<$Res>
    implements $MoodQuickLogCopyWith<$Res> {
  _$MoodQuickLogCopyWithImpl(this._self, this._then);

  final MoodQuickLog _self;
  final $Res Function(MoodQuickLog) _then;

/// Create a copy of MoodEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? level = null,}) {
  return _then(MoodQuickLog(
null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MoodRefresh implements MoodEvent {
  const MoodRefresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'MoodEvent.refresh()';
}


}




/// @nodoc
mixin _$MoodState {

 LoadStatus get status; MoodSummary? get summary; String? get error;/// Set briefly after a quick log from the home check-in.
 int? get justLogged;
/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodStateCopyWith<MoodState> get copyWith => _$MoodStateCopyWithImpl<MoodState>(this as MoodState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoodState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.justLogged, _this.justLogged) || other.justLogged == _this.justLogged));
}


@override
int get hashCode {
  final _this = this as MoodState;
  return Object.hash(runtimeType,_this.status,_this.summary,_this.error,_this.justLogged);
}

@override
String toString() {
  final _this = this as MoodState;
  return 'MoodState(status: ${_this.status}, summary: ${_this.summary}, error: ${_this.error}, justLogged: ${_this.justLogged})';
}


}

/// @nodoc
abstract mixin class $MoodStateCopyWith<$Res>  {
  factory $MoodStateCopyWith(MoodState value, $Res Function(MoodState) _then) = _$MoodStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, MoodSummary? summary, String? error, int? justLogged
});


$MoodSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$MoodStateCopyWithImpl<$Res>
    implements $MoodStateCopyWith<$Res> {
  _$MoodStateCopyWithImpl(this._self, this._then);

  final MoodState _self;
  final $Res Function(MoodState) _then;

/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? summary = freezed,Object? error = freezed,Object? justLogged = freezed,}) {
  return _then(MoodState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MoodSummary?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,justLogged: freezed == justLogged ? _self.justLogged : justLogged // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoodSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $MoodSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [MoodState].
extension MoodStatePatterns on MoodState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodState value)  $default,){
final _that = this;
switch (_that) {
case _MoodState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodState value)?  $default,){
final _that = this;
switch (_that) {
case _MoodState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  MoodSummary? summary,  String? error,  int? justLogged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodState() when $default != null:
return $default(_that.status,_that.summary,_that.error,_that.justLogged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  MoodSummary? summary,  String? error,  int? justLogged)  $default,) {final _that = this;
switch (_that) {
case _MoodState():
return $default(_that.status,_that.summary,_that.error,_that.justLogged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  MoodSummary? summary,  String? error,  int? justLogged)?  $default,) {final _that = this;
switch (_that) {
case _MoodState() when $default != null:
return $default(_that.status,_that.summary,_that.error,_that.justLogged);case _:
  return null;

}
}

}

/// @nodoc


class _MoodState implements MoodState {
  const _MoodState({this.status = LoadStatus.initial, this.summary, this.error, this.justLogged});
  

@override@JsonKey() final  LoadStatus status;
@override final  MoodSummary? summary;
@override final  String? error;
/// Set briefly after a quick log from the home check-in.
@override final  int? justLogged;

/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodStateCopyWith<_MoodState> get copyWith => __$MoodStateCopyWithImpl<_MoodState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodState&&(identical(other.status, status) || other.status == status)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.error, error) || other.error == error)&&(identical(other.justLogged, justLogged) || other.justLogged == justLogged));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,summary,error,justLogged);
}

@override
String toString() {
    return 'MoodState(status: $status, summary: $summary, error: $error, justLogged: $justLogged)';
}


}

/// @nodoc
abstract mixin class _$MoodStateCopyWith<$Res> implements $MoodStateCopyWith<$Res> {
  factory _$MoodStateCopyWith(_MoodState value, $Res Function(_MoodState) _then) = __$MoodStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, MoodSummary? summary, String? error, int? justLogged
});


@override $MoodSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$MoodStateCopyWithImpl<$Res>
    implements _$MoodStateCopyWith<$Res> {
  __$MoodStateCopyWithImpl(this._self, this._then);

  final _MoodState _self;
  final $Res Function(_MoodState) _then;

/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? summary = freezed,Object? error = freezed,Object? justLogged = freezed,}) {
  return _then(_MoodState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MoodSummary?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,justLogged: freezed == justLogged ? _self.justLogged : justLogged // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of MoodState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoodSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $MoodSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
