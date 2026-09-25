// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requests_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RequestsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RequestsEvent()';
}


}

/// @nodoc
class $RequestsEventCopyWith<$Res>  {
$RequestsEventCopyWith(RequestsEvent _, $Res Function(RequestsEvent) __);
}


/// Adds pattern-matching-related methods to [RequestsEvent].
extension RequestsEventPatterns on RequestsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RequestsLoad value)?  load,TResult Function( RequestsResponded value)?  responded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RequestsLoad() when load != null:
return load(_that);case RequestsResponded() when responded != null:
return responded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RequestsLoad value)  load,required TResult Function( RequestsResponded value)  responded,}){
final _that = this;
switch (_that) {
case RequestsLoad():
return load(_that);case RequestsResponded():
return responded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RequestsLoad value)?  load,TResult? Function( RequestsResponded value)?  responded,}){
final _that = this;
switch (_that) {
case RequestsLoad() when load != null:
return load(_that);case RequestsResponded() when responded != null:
return responded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( String id,  RequestStatus status)?  responded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RequestsLoad() when load != null:
return load();case RequestsResponded() when responded != null:
return responded(_that.id,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( String id,  RequestStatus status)  responded,}) {final _that = this;
switch (_that) {
case RequestsLoad():
return load();case RequestsResponded():
return responded(_that.id,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( String id,  RequestStatus status)?  responded,}) {final _that = this;
switch (_that) {
case RequestsLoad() when load != null:
return load();case RequestsResponded() when responded != null:
return responded(_that.id,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class RequestsLoad implements RequestsEvent {
  const RequestsLoad();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RequestsEvent.load()';
}


}




/// @nodoc


class RequestsResponded implements RequestsEvent {
  const RequestsResponded(this.id, this.status);
  

 final  String id;
 final  RequestStatus status;

/// Create a copy of RequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestsRespondedCopyWith<RequestsResponded> get copyWith => _$RequestsRespondedCopyWithImpl<RequestsResponded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsResponded&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status);
}

@override
String toString() {
    return 'RequestsEvent.responded(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class $RequestsRespondedCopyWith<$Res> implements $RequestsEventCopyWith<$Res> {
  factory $RequestsRespondedCopyWith(RequestsResponded value, $Res Function(RequestsResponded) _then) = _$RequestsRespondedCopyWithImpl;
@useResult
$Res call({
 String id, RequestStatus status
});




}
/// @nodoc
class _$RequestsRespondedCopyWithImpl<$Res>
    implements $RequestsRespondedCopyWith<$Res> {
  _$RequestsRespondedCopyWithImpl(this._self, this._then);

  final RequestsResponded _self;
  final $Res Function(RequestsResponded) _then;

/// Create a copy of RequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,}) {
  return _then(RequestsResponded(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,
  ));
}


}

/// @nodoc
mixin _$RequestsState {

 LoadStatus get status; List<SessionRequest> get requests; String? get error;
/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestsStateCopyWith<RequestsState> get copyWith => _$RequestsStateCopyWithImpl<RequestsState>(this as RequestsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RequestsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.requests, _this.requests)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as RequestsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.requests),_this.error);
}

@override
String toString() {
  final _this = this as RequestsState;
  return 'RequestsState(status: ${_this.status}, requests: ${_this.requests}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $RequestsStateCopyWith<$Res>  {
  factory $RequestsStateCopyWith(RequestsState value, $Res Function(RequestsState) _then) = _$RequestsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<SessionRequest> requests, String? error
});




}
/// @nodoc
class _$RequestsStateCopyWithImpl<$Res>
    implements $RequestsStateCopyWith<$Res> {
  _$RequestsStateCopyWithImpl(this._self, this._then);

  final RequestsState _self;
  final $Res Function(RequestsState) _then;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? requests = null,Object? error = freezed,}) {
  return _then(RequestsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<SessionRequest>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestsState].
extension RequestsStatePatterns on RequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestsState value)  $default,){
final _that = this;
switch (_that) {
case _RequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _RequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<SessionRequest> requests,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestsState() when $default != null:
return $default(_that.status,_that.requests,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<SessionRequest> requests,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RequestsState():
return $default(_that.status,_that.requests,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<SessionRequest> requests,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RequestsState() when $default != null:
return $default(_that.status,_that.requests,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RequestsState extends RequestsState {
  const _RequestsState({this.status = LoadStatus.initial,  List<SessionRequest> requests = const <SessionRequest>[], this.error}): _requests = requests,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<SessionRequest> _requests;
@override@JsonKey() List<SessionRequest> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@override final  String? error;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestsStateCopyWith<_RequestsState> get copyWith => __$RequestsStateCopyWithImpl<_RequestsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.requests, _requests)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_requests),error);
}

@override
String toString() {
    return 'RequestsState(status: $status, requests: $requests, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RequestsStateCopyWith<$Res> implements $RequestsStateCopyWith<$Res> {
  factory _$RequestsStateCopyWith(_RequestsState value, $Res Function(_RequestsState) _then) = __$RequestsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<SessionRequest> requests, String? error
});




}
/// @nodoc
class __$RequestsStateCopyWithImpl<$Res>
    implements _$RequestsStateCopyWith<$Res> {
  __$RequestsStateCopyWithImpl(this._self, this._then);

  final _RequestsState _self;
  final $Res Function(_RequestsState) _then;

/// Create a copy of RequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? requests = null,Object? error = freezed,}) {
  return _then(_RequestsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<SessionRequest>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
