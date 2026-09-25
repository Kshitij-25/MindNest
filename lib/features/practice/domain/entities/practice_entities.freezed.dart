// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerificationDocument {

 DocumentKind get kind; String get title; String get description; bool get uploaded;
/// Create a copy of VerificationDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationDocumentCopyWith<VerificationDocument> get copyWith => _$VerificationDocumentCopyWithImpl<VerificationDocument>(this as VerificationDocument, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VerificationDocument;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationDocument&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.uploaded, _this.uploaded) || other.uploaded == _this.uploaded));
}


@override
int get hashCode {
  final _this = this as VerificationDocument;
  return Object.hash(runtimeType,_this.kind,_this.title,_this.description,_this.uploaded);
}

@override
String toString() {
  final _this = this as VerificationDocument;
  return 'VerificationDocument(kind: ${_this.kind}, title: ${_this.title}, description: ${_this.description}, uploaded: ${_this.uploaded})';
}


}

/// @nodoc
abstract mixin class $VerificationDocumentCopyWith<$Res>  {
  factory $VerificationDocumentCopyWith(VerificationDocument value, $Res Function(VerificationDocument) _then) = _$VerificationDocumentCopyWithImpl;
@useResult
$Res call({
 DocumentKind kind, String title, String description, bool uploaded
});




}
/// @nodoc
class _$VerificationDocumentCopyWithImpl<$Res>
    implements $VerificationDocumentCopyWith<$Res> {
  _$VerificationDocumentCopyWithImpl(this._self, this._then);

  final VerificationDocument _self;
  final $Res Function(VerificationDocument) _then;

/// Create a copy of VerificationDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? description = null,Object? uploaded = null,}) {
  return _then(VerificationDocument(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DocumentKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,uploaded: null == uploaded ? _self.uploaded : uploaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationDocument].
extension VerificationDocumentPatterns on VerificationDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationDocument value)  $default,){
final _that = this;
switch (_that) {
case _VerificationDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationDocument value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DocumentKind kind,  String title,  String description,  bool uploaded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationDocument() when $default != null:
return $default(_that.kind,_that.title,_that.description,_that.uploaded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DocumentKind kind,  String title,  String description,  bool uploaded)  $default,) {final _that = this;
switch (_that) {
case _VerificationDocument():
return $default(_that.kind,_that.title,_that.description,_that.uploaded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DocumentKind kind,  String title,  String description,  bool uploaded)?  $default,) {final _that = this;
switch (_that) {
case _VerificationDocument() when $default != null:
return $default(_that.kind,_that.title,_that.description,_that.uploaded);case _:
  return null;

}
}

}

/// @nodoc


class _VerificationDocument implements VerificationDocument {
  const _VerificationDocument({required this.kind, required this.title, required this.description, this.uploaded = false});
  

@override final  DocumentKind kind;
@override final  String title;
@override final  String description;
@override@JsonKey() final  bool uploaded;

/// Create a copy of VerificationDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationDocumentCopyWith<_VerificationDocument> get copyWith => __$VerificationDocumentCopyWithImpl<_VerificationDocument>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationDocument&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.uploaded, uploaded) || other.uploaded == uploaded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,title,description,uploaded);
}

@override
String toString() {
    return 'VerificationDocument(kind: $kind, title: $title, description: $description, uploaded: $uploaded)';
}


}

/// @nodoc
abstract mixin class _$VerificationDocumentCopyWith<$Res> implements $VerificationDocumentCopyWith<$Res> {
  factory _$VerificationDocumentCopyWith(_VerificationDocument value, $Res Function(_VerificationDocument) _then) = __$VerificationDocumentCopyWithImpl;
@override @useResult
$Res call({
 DocumentKind kind, String title, String description, bool uploaded
});




}
/// @nodoc
class __$VerificationDocumentCopyWithImpl<$Res>
    implements _$VerificationDocumentCopyWith<$Res> {
  __$VerificationDocumentCopyWithImpl(this._self, this._then);

  final _VerificationDocument _self;
  final $Res Function(_VerificationDocument) _then;

/// Create a copy of VerificationDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? description = null,Object? uploaded = null,}) {
  return _then(_VerificationDocument(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DocumentKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,uploaded: null == uploaded ? _self.uploaded : uploaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SessionRequest {

 String get id; String get clientId; String get clientName; DateTime get requestedAt; String get reason; int get minutes; String get type; RequestStatus get status; String get note; bool get newClient;
/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestCopyWith<SessionRequest> get copyWith => _$SessionRequestCopyWithImpl<SessionRequest>(this as SessionRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.clientName, _this.clientName) || other.clientName == _this.clientName)&&(identical(other.requestedAt, _this.requestedAt) || other.requestedAt == _this.requestedAt)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.newClient, _this.newClient) || other.newClient == _this.newClient));
}


@override
int get hashCode {
  final _this = this as SessionRequest;
  return Object.hash(runtimeType,_this.id,_this.clientId,_this.clientName,_this.requestedAt,_this.reason,_this.minutes,_this.type,_this.status,_this.note,_this.newClient);
}

@override
String toString() {
  final _this = this as SessionRequest;
  return 'SessionRequest(id: ${_this.id}, clientId: ${_this.clientId}, clientName: ${_this.clientName}, requestedAt: ${_this.requestedAt}, reason: ${_this.reason}, minutes: ${_this.minutes}, type: ${_this.type}, status: ${_this.status}, note: ${_this.note}, newClient: ${_this.newClient})';
}


}

/// @nodoc
abstract mixin class $SessionRequestCopyWith<$Res>  {
  factory $SessionRequestCopyWith(SessionRequest value, $Res Function(SessionRequest) _then) = _$SessionRequestCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String clientName, DateTime requestedAt, String reason, int minutes, String type, RequestStatus status, String note, bool newClient
});




}
/// @nodoc
class _$SessionRequestCopyWithImpl<$Res>
    implements $SessionRequestCopyWith<$Res> {
  _$SessionRequestCopyWithImpl(this._self, this._then);

  final SessionRequest _self;
  final $Res Function(SessionRequest) _then;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? requestedAt = null,Object? reason = null,Object? minutes = null,Object? type = null,Object? status = null,Object? note = null,Object? newClient = null,}) {
  return _then(SessionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,newClient: null == newClient ? _self.newClient : newClient // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionRequest].
extension SessionRequestPatterns on SessionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  DateTime requestedAt,  String reason,  int minutes,  String type,  RequestStatus status,  String note,  bool newClient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.requestedAt,_that.reason,_that.minutes,_that.type,_that.status,_that.note,_that.newClient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  DateTime requestedAt,  String reason,  int minutes,  String type,  RequestStatus status,  String note,  bool newClient)  $default,) {final _that = this;
switch (_that) {
case _SessionRequest():
return $default(_that.id,_that.clientId,_that.clientName,_that.requestedAt,_that.reason,_that.minutes,_that.type,_that.status,_that.note,_that.newClient);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String clientName,  DateTime requestedAt,  String reason,  int minutes,  String type,  RequestStatus status,  String note,  bool newClient)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.requestedAt,_that.reason,_that.minutes,_that.type,_that.status,_that.note,_that.newClient);case _:
  return null;

}
}

}

/// @nodoc


class _SessionRequest implements SessionRequest {
  const _SessionRequest({required this.id, required this.clientId, required this.clientName, required this.requestedAt, required this.reason, this.minutes = 50, this.type = 'Video', this.status = RequestStatus.pending, this.note = '', this.newClient = true});
  

@override final  String id;
@override final  String clientId;
@override final  String clientName;
@override final  DateTime requestedAt;
@override final  String reason;
@override@JsonKey() final  int minutes;
@override@JsonKey() final  String type;
@override@JsonKey() final  RequestStatus status;
@override@JsonKey() final  String note;
@override@JsonKey() final  bool newClient;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestCopyWith<_SessionRequest> get copyWith => __$SessionRequestCopyWithImpl<_SessionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.newClient, newClient) || other.newClient == newClient));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,clientId,clientName,requestedAt,reason,minutes,type,status,note,newClient);
}

@override
String toString() {
    return 'SessionRequest(id: $id, clientId: $clientId, clientName: $clientName, requestedAt: $requestedAt, reason: $reason, minutes: $minutes, type: $type, status: $status, note: $note, newClient: $newClient)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestCopyWith<$Res> implements $SessionRequestCopyWith<$Res> {
  factory _$SessionRequestCopyWith(_SessionRequest value, $Res Function(_SessionRequest) _then) = __$SessionRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String clientName, DateTime requestedAt, String reason, int minutes, String type, RequestStatus status, String note, bool newClient
});




}
/// @nodoc
class __$SessionRequestCopyWithImpl<$Res>
    implements _$SessionRequestCopyWith<$Res> {
  __$SessionRequestCopyWithImpl(this._self, this._then);

  final _SessionRequest _self;
  final $Res Function(_SessionRequest) _then;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? requestedAt = null,Object? reason = null,Object? minutes = null,Object? type = null,Object? status = null,Object? note = null,Object? newClient = null,}) {
  return _then(_SessionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,newClient: null == newClient ? _self.newClient : newClient // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ScheduledSession {

 String get id; String get clientId; String get clientName; DateTime get startsAt; String get type; int get minutes; bool get recurring;
/// Create a copy of ScheduledSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledSessionCopyWith<ScheduledSession> get copyWith => _$ScheduledSessionCopyWithImpl<ScheduledSession>(this as ScheduledSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScheduledSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.clientName, _this.clientName) || other.clientName == _this.clientName)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.recurring, _this.recurring) || other.recurring == _this.recurring));
}


@override
int get hashCode {
  final _this = this as ScheduledSession;
  return Object.hash(runtimeType,_this.id,_this.clientId,_this.clientName,_this.startsAt,_this.type,_this.minutes,_this.recurring);
}

@override
String toString() {
  final _this = this as ScheduledSession;
  return 'ScheduledSession(id: ${_this.id}, clientId: ${_this.clientId}, clientName: ${_this.clientName}, startsAt: ${_this.startsAt}, type: ${_this.type}, minutes: ${_this.minutes}, recurring: ${_this.recurring})';
}


}

/// @nodoc
abstract mixin class $ScheduledSessionCopyWith<$Res>  {
  factory $ScheduledSessionCopyWith(ScheduledSession value, $Res Function(ScheduledSession) _then) = _$ScheduledSessionCopyWithImpl;
@useResult
$Res call({
 String id, String clientId, String clientName, DateTime startsAt, String type, int minutes, bool recurring
});




}
/// @nodoc
class _$ScheduledSessionCopyWithImpl<$Res>
    implements $ScheduledSessionCopyWith<$Res> {
  _$ScheduledSessionCopyWithImpl(this._self, this._then);

  final ScheduledSession _self;
  final $Res Function(ScheduledSession) _then;

/// Create a copy of ScheduledSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? startsAt = null,Object? type = null,Object? minutes = null,Object? recurring = null,}) {
  return _then(ScheduledSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledSession].
extension ScheduledSessionPatterns on ScheduledSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledSession value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledSession value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  DateTime startsAt,  String type,  int minutes,  bool recurring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledSession() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.startsAt,_that.type,_that.minutes,_that.recurring);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String clientId,  String clientName,  DateTime startsAt,  String type,  int minutes,  bool recurring)  $default,) {final _that = this;
switch (_that) {
case _ScheduledSession():
return $default(_that.id,_that.clientId,_that.clientName,_that.startsAt,_that.type,_that.minutes,_that.recurring);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String clientId,  String clientName,  DateTime startsAt,  String type,  int minutes,  bool recurring)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledSession() when $default != null:
return $default(_that.id,_that.clientId,_that.clientName,_that.startsAt,_that.type,_that.minutes,_that.recurring);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduledSession implements ScheduledSession {
  const _ScheduledSession({required this.id, required this.clientId, required this.clientName, required this.startsAt, this.type = 'Video', this.minutes = 50, this.recurring = false});
  

@override final  String id;
@override final  String clientId;
@override final  String clientName;
@override final  DateTime startsAt;
@override@JsonKey() final  String type;
@override@JsonKey() final  int minutes;
@override@JsonKey() final  bool recurring;

/// Create a copy of ScheduledSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledSessionCopyWith<_ScheduledSession> get copyWith => __$ScheduledSessionCopyWithImpl<_ScheduledSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledSession&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.recurring, recurring) || other.recurring == recurring));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,clientId,clientName,startsAt,type,minutes,recurring);
}

@override
String toString() {
    return 'ScheduledSession(id: $id, clientId: $clientId, clientName: $clientName, startsAt: $startsAt, type: $type, minutes: $minutes, recurring: $recurring)';
}


}

/// @nodoc
abstract mixin class _$ScheduledSessionCopyWith<$Res> implements $ScheduledSessionCopyWith<$Res> {
  factory _$ScheduledSessionCopyWith(_ScheduledSession value, $Res Function(_ScheduledSession) _then) = __$ScheduledSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String clientId, String clientName, DateTime startsAt, String type, int minutes, bool recurring
});




}
/// @nodoc
class __$ScheduledSessionCopyWithImpl<$Res>
    implements _$ScheduledSessionCopyWith<$Res> {
  __$ScheduledSessionCopyWithImpl(this._self, this._then);

  final _ScheduledSession _self;
  final $Res Function(_ScheduledSession) _then;

/// Create a copy of ScheduledSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = null,Object? clientName = null,Object? startsAt = null,Object? type = null,Object? minutes = null,Object? recurring = null,}) {
  return _then(_ScheduledSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Client {

 String get id; String get name; String get focus; int get sessions; String get since; String get next; ClientStatus get status; bool get online;
/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientCopyWith<Client> get copyWith => _$ClientCopyWithImpl<Client>(this as Client, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Client;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Client&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.focus, _this.focus) || other.focus == _this.focus)&&(identical(other.sessions, _this.sessions) || other.sessions == _this.sessions)&&(identical(other.since, _this.since) || other.since == _this.since)&&(identical(other.next, _this.next) || other.next == _this.next)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.online, _this.online) || other.online == _this.online));
}


@override
int get hashCode {
  final _this = this as Client;
  return Object.hash(runtimeType,_this.id,_this.name,_this.focus,_this.sessions,_this.since,_this.next,_this.status,_this.online);
}

@override
String toString() {
  final _this = this as Client;
  return 'Client(id: ${_this.id}, name: ${_this.name}, focus: ${_this.focus}, sessions: ${_this.sessions}, since: ${_this.since}, next: ${_this.next}, status: ${_this.status}, online: ${_this.online})';
}


}

/// @nodoc
abstract mixin class $ClientCopyWith<$Res>  {
  factory $ClientCopyWith(Client value, $Res Function(Client) _then) = _$ClientCopyWithImpl;
@useResult
$Res call({
 String id, String name, String focus, int sessions, String since, String next, ClientStatus status, bool online
});




}
/// @nodoc
class _$ClientCopyWithImpl<$Res>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._self, this._then);

  final Client _self;
  final $Res Function(Client) _then;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? focus = null,Object? sessions = null,Object? since = null,Object? next = null,Object? status = null,Object? online = null,}) {
  return _then(Client(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,focus: null == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,since: null == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientStatus,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Client].
extension ClientPatterns on Client {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Client value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Client() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Client value)  $default,){
final _that = this;
switch (_that) {
case _Client():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Client value)?  $default,){
final _that = this;
switch (_that) {
case _Client() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String focus,  int sessions,  String since,  String next,  ClientStatus status,  bool online)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Client() when $default != null:
return $default(_that.id,_that.name,_that.focus,_that.sessions,_that.since,_that.next,_that.status,_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String focus,  int sessions,  String since,  String next,  ClientStatus status,  bool online)  $default,) {final _that = this;
switch (_that) {
case _Client():
return $default(_that.id,_that.name,_that.focus,_that.sessions,_that.since,_that.next,_that.status,_that.online);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String focus,  int sessions,  String since,  String next,  ClientStatus status,  bool online)?  $default,) {final _that = this;
switch (_that) {
case _Client() when $default != null:
return $default(_that.id,_that.name,_that.focus,_that.sessions,_that.since,_that.next,_that.status,_that.online);case _:
  return null;

}
}

}

/// @nodoc


class _Client implements Client {
  const _Client({required this.id, required this.name, required this.focus, required this.sessions, required this.since, required this.next, required this.status, this.online = false});
  

@override final  String id;
@override final  String name;
@override final  String focus;
@override final  int sessions;
@override final  String since;
@override final  String next;
@override final  ClientStatus status;
@override@JsonKey() final  bool online;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientCopyWith<_Client> get copyWith => __$ClientCopyWithImpl<_Client>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Client&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.sessions, sessions) || other.sessions == sessions)&&(identical(other.since, since) || other.since == since)&&(identical(other.next, next) || other.next == next)&&(identical(other.status, status) || other.status == status)&&(identical(other.online, online) || other.online == online));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,focus,sessions,since,next,status,online);
}

@override
String toString() {
    return 'Client(id: $id, name: $name, focus: $focus, sessions: $sessions, since: $since, next: $next, status: $status, online: $online)';
}


}

/// @nodoc
abstract mixin class _$ClientCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$ClientCopyWith(_Client value, $Res Function(_Client) _then) = __$ClientCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String focus, int sessions, String since, String next, ClientStatus status, bool online
});




}
/// @nodoc
class __$ClientCopyWithImpl<$Res>
    implements _$ClientCopyWith<$Res> {
  __$ClientCopyWithImpl(this._self, this._then);

  final _Client _self;
  final $Res Function(_Client) _then;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? focus = null,Object? sessions = null,Object? since = null,Object? next = null,Object? status = null,Object? online = null,}) {
  return _then(_Client(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,focus: null == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,since: null == since ? _self.since : since // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientStatus,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ClientNote {

 String get id; DateTime get date; String get tag; String get text;
/// Create a copy of ClientNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientNoteCopyWith<ClientNote> get copyWith => _$ClientNoteCopyWithImpl<ClientNote>(this as ClientNote, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientNote;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientNote&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.text, _this.text) || other.text == _this.text));
}


@override
int get hashCode {
  final _this = this as ClientNote;
  return Object.hash(runtimeType,_this.id,_this.date,_this.tag,_this.text);
}

@override
String toString() {
  final _this = this as ClientNote;
  return 'ClientNote(id: ${_this.id}, date: ${_this.date}, tag: ${_this.tag}, text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $ClientNoteCopyWith<$Res>  {
  factory $ClientNoteCopyWith(ClientNote value, $Res Function(ClientNote) _then) = _$ClientNoteCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String tag, String text
});




}
/// @nodoc
class _$ClientNoteCopyWithImpl<$Res>
    implements $ClientNoteCopyWith<$Res> {
  _$ClientNoteCopyWithImpl(this._self, this._then);

  final ClientNote _self;
  final $Res Function(ClientNote) _then;

/// Create a copy of ClientNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? tag = null,Object? text = null,}) {
  return _then(ClientNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientNote].
extension ClientNotePatterns on ClientNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientNote value)  $default,){
final _that = this;
switch (_that) {
case _ClientNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientNote value)?  $default,){
final _that = this;
switch (_that) {
case _ClientNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String tag,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientNote() when $default != null:
return $default(_that.id,_that.date,_that.tag,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String tag,  String text)  $default,) {final _that = this;
switch (_that) {
case _ClientNote():
return $default(_that.id,_that.date,_that.tag,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String tag,  String text)?  $default,) {final _that = this;
switch (_that) {
case _ClientNote() when $default != null:
return $default(_that.id,_that.date,_that.tag,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _ClientNote implements ClientNote {
  const _ClientNote({required this.id, required this.date, required this.tag, required this.text});
  

@override final  String id;
@override final  DateTime date;
@override final  String tag;
@override final  String text;

/// Create a copy of ClientNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientNoteCopyWith<_ClientNote> get copyWith => __$ClientNoteCopyWithImpl<_ClientNote>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientNote&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,date,tag,text);
}

@override
String toString() {
    return 'ClientNote(id: $id, date: $date, tag: $tag, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ClientNoteCopyWith<$Res> implements $ClientNoteCopyWith<$Res> {
  factory _$ClientNoteCopyWith(_ClientNote value, $Res Function(_ClientNote) _then) = __$ClientNoteCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String tag, String text
});




}
/// @nodoc
class __$ClientNoteCopyWithImpl<$Res>
    implements _$ClientNoteCopyWith<$Res> {
  __$ClientNoteCopyWithImpl(this._self, this._then);

  final _ClientNote _self;
  final $Res Function(_ClientNote) _then;

/// Create a copy of ClientNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? tag = null,Object? text = null,}) {
  return _then(_ClientNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ClientGoal {

 String get id; String get text; bool get done;
/// Create a copy of ClientGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientGoalCopyWith<ClientGoal> get copyWith => _$ClientGoalCopyWithImpl<ClientGoal>(this as ClientGoal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientGoal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientGoal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.done, _this.done) || other.done == _this.done));
}


@override
int get hashCode {
  final _this = this as ClientGoal;
  return Object.hash(runtimeType,_this.id,_this.text,_this.done);
}

@override
String toString() {
  final _this = this as ClientGoal;
  return 'ClientGoal(id: ${_this.id}, text: ${_this.text}, done: ${_this.done})';
}


}

/// @nodoc
abstract mixin class $ClientGoalCopyWith<$Res>  {
  factory $ClientGoalCopyWith(ClientGoal value, $Res Function(ClientGoal) _then) = _$ClientGoalCopyWithImpl;
@useResult
$Res call({
 String id, String text, bool done
});




}
/// @nodoc
class _$ClientGoalCopyWithImpl<$Res>
    implements $ClientGoalCopyWith<$Res> {
  _$ClientGoalCopyWithImpl(this._self, this._then);

  final ClientGoal _self;
  final $Res Function(ClientGoal) _then;

/// Create a copy of ClientGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? done = null,}) {
  return _then(ClientGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientGoal].
extension ClientGoalPatterns on ClientGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientGoal value)  $default,){
final _that = this;
switch (_that) {
case _ClientGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientGoal value)?  $default,){
final _that = this;
switch (_that) {
case _ClientGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientGoal() when $default != null:
return $default(_that.id,_that.text,_that.done);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  bool done)  $default,) {final _that = this;
switch (_that) {
case _ClientGoal():
return $default(_that.id,_that.text,_that.done);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _ClientGoal() when $default != null:
return $default(_that.id,_that.text,_that.done);case _:
  return null;

}
}

}

/// @nodoc


class _ClientGoal implements ClientGoal {
  const _ClientGoal({required this.id, required this.text, this.done = false});
  

@override final  String id;
@override final  String text;
@override@JsonKey() final  bool done;

/// Create a copy of ClientGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientGoalCopyWith<_ClientGoal> get copyWith => __$ClientGoalCopyWithImpl<_ClientGoal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.done, done) || other.done == done));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,text,done);
}

@override
String toString() {
    return 'ClientGoal(id: $id, text: $text, done: $done)';
}


}

/// @nodoc
abstract mixin class _$ClientGoalCopyWith<$Res> implements $ClientGoalCopyWith<$Res> {
  factory _$ClientGoalCopyWith(_ClientGoal value, $Res Function(_ClientGoal) _then) = __$ClientGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, bool done
});




}
/// @nodoc
class __$ClientGoalCopyWithImpl<$Res>
    implements _$ClientGoalCopyWith<$Res> {
  __$ClientGoalCopyWithImpl(this._self, this._then);

  final _ClientGoal _self;
  final $Res Function(_ClientGoal) _then;

/// Create a copy of ClientGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? done = null,}) {
  return _then(_ClientGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ClientDetail {

 Client get client; List<ClientNote> get notes; List<ScheduledSession> get history; List<ClientGoal> get goals;
/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientDetailCopyWith<ClientDetail> get copyWith => _$ClientDetailCopyWithImpl<ClientDetail>(this as ClientDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientDetail&&(identical(other.client, _this.client) || other.client == _this.client)&&const DeepCollectionEquality().equals(other.notes, _this.notes)&&const DeepCollectionEquality().equals(other.history, _this.history)&&const DeepCollectionEquality().equals(other.goals, _this.goals));
}


@override
int get hashCode {
  final _this = this as ClientDetail;
  return Object.hash(runtimeType,_this.client,const DeepCollectionEquality().hash(_this.notes),const DeepCollectionEquality().hash(_this.history),const DeepCollectionEquality().hash(_this.goals));
}

@override
String toString() {
  final _this = this as ClientDetail;
  return 'ClientDetail(client: ${_this.client}, notes: ${_this.notes}, history: ${_this.history}, goals: ${_this.goals})';
}


}

/// @nodoc
abstract mixin class $ClientDetailCopyWith<$Res>  {
  factory $ClientDetailCopyWith(ClientDetail value, $Res Function(ClientDetail) _then) = _$ClientDetailCopyWithImpl;
@useResult
$Res call({
 Client client, List<ClientNote> notes, List<ScheduledSession> history, List<ClientGoal> goals
});


$ClientCopyWith<$Res> get client;

}
/// @nodoc
class _$ClientDetailCopyWithImpl<$Res>
    implements $ClientDetailCopyWith<$Res> {
  _$ClientDetailCopyWithImpl(this._self, this._then);

  final ClientDetail _self;
  final $Res Function(ClientDetail) _then;

/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? client = null,Object? notes = null,Object? history = null,Object? goals = null,}) {
  return _then(ClientDetail(
client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as Client,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<ClientNote>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<ClientGoal>,
  ));
}
/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientCopyWith<$Res> get client {
  
  return $ClientCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientDetail].
extension ClientDetailPatterns on ClientDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientDetail value)  $default,){
final _that = this;
switch (_that) {
case _ClientDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ClientDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Client client,  List<ClientNote> notes,  List<ScheduledSession> history,  List<ClientGoal> goals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientDetail() when $default != null:
return $default(_that.client,_that.notes,_that.history,_that.goals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Client client,  List<ClientNote> notes,  List<ScheduledSession> history,  List<ClientGoal> goals)  $default,) {final _that = this;
switch (_that) {
case _ClientDetail():
return $default(_that.client,_that.notes,_that.history,_that.goals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Client client,  List<ClientNote> notes,  List<ScheduledSession> history,  List<ClientGoal> goals)?  $default,) {final _that = this;
switch (_that) {
case _ClientDetail() when $default != null:
return $default(_that.client,_that.notes,_that.history,_that.goals);case _:
  return null;

}
}

}

/// @nodoc


class _ClientDetail implements ClientDetail {
  const _ClientDetail({required this.client, required  List<ClientNote> notes, required  List<ScheduledSession> history, required  List<ClientGoal> goals}): _notes = notes,_history = history,_goals = goals;
  

@override final  Client client;
 final  List<ClientNote> _notes;
@override List<ClientNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

 final  List<ScheduledSession> _history;
@override List<ScheduledSession> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<ClientGoal> _goals;
@override List<ClientGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}


/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientDetailCopyWith<_ClientDetail> get copyWith => __$ClientDetailCopyWithImpl<_ClientDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientDetail&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.notes, _notes)&&const DeepCollectionEquality().equals(other.history, _history)&&const DeepCollectionEquality().equals(other.goals, _goals));
}


@override
int get hashCode {
    return Object.hash(runtimeType,client,const DeepCollectionEquality().hash(_notes),const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_goals));
}

@override
String toString() {
    return 'ClientDetail(client: $client, notes: $notes, history: $history, goals: $goals)';
}


}

/// @nodoc
abstract mixin class _$ClientDetailCopyWith<$Res> implements $ClientDetailCopyWith<$Res> {
  factory _$ClientDetailCopyWith(_ClientDetail value, $Res Function(_ClientDetail) _then) = __$ClientDetailCopyWithImpl;
@override @useResult
$Res call({
 Client client, List<ClientNote> notes, List<ScheduledSession> history, List<ClientGoal> goals
});


@override $ClientCopyWith<$Res> get client;

}
/// @nodoc
class __$ClientDetailCopyWithImpl<$Res>
    implements _$ClientDetailCopyWith<$Res> {
  __$ClientDetailCopyWithImpl(this._self, this._then);

  final _ClientDetail _self;
  final $Res Function(_ClientDetail) _then;

/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? client = null,Object? notes = null,Object? history = null,Object? goals = null,}) {
  return _then(_ClientDetail(
client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as Client,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<ClientNote>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<ClientGoal>,
  ));
}

/// Create a copy of ClientDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientCopyWith<$Res> get client {
  
  return $ClientCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}

/// @nodoc
mixin _$Transaction {

 String get clientName; String get description; DateTime get date; int get amount;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Transaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.clientName, _this.clientName) || other.clientName == _this.clientName)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.amount, _this.amount) || other.amount == _this.amount));
}


@override
int get hashCode {
  final _this = this as Transaction;
  return Object.hash(runtimeType,_this.clientName,_this.description,_this.date,_this.amount);
}

@override
String toString() {
  final _this = this as Transaction;
  return 'Transaction(clientName: ${_this.clientName}, description: ${_this.description}, date: ${_this.date}, amount: ${_this.amount})';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String clientName, String description, DateTime date, int amount
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientName = null,Object? description = null,Object? date = null,Object? amount = null,}) {
  return _then(Transaction(
clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientName,  String description,  DateTime date,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.clientName,_that.description,_that.date,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientName,  String description,  DateTime date,  int amount)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.clientName,_that.description,_that.date,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientName,  String description,  DateTime date,  int amount)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.clientName,_that.description,_that.date,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _Transaction implements Transaction {
  const _Transaction({required this.clientName, required this.description, required this.date, required this.amount});
  

@override final  String clientName;
@override final  String description;
@override final  DateTime date;
@override final  int amount;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,clientName,description,date,amount);
}

@override
String toString() {
    return 'Transaction(clientName: $clientName, description: $description, date: $date, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String clientName, String description, DateTime date, int amount
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientName = null,Object? description = null,Object? date = null,Object? amount = null,}) {
  return _then(_Transaction(
clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Earnings {

 int get available; int get yearTotal; int get sessions; int get averageRate; int get thisWeek; int get weekChangePercent; int get nextPayoutDays;/// Mon..Sun amounts for the current week.
 List<int> get week;/// Last 8 months, oldest first.
 List<int> get months; List<String> get monthLabels; List<Transaction> get transactions;/// Share by session type (label → percent).
 Map<String, int> get byType;
/// Create a copy of Earnings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsCopyWith<Earnings> get copyWith => _$EarningsCopyWithImpl<Earnings>(this as Earnings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Earnings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earnings&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.yearTotal, _this.yearTotal) || other.yearTotal == _this.yearTotal)&&(identical(other.sessions, _this.sessions) || other.sessions == _this.sessions)&&(identical(other.averageRate, _this.averageRate) || other.averageRate == _this.averageRate)&&(identical(other.thisWeek, _this.thisWeek) || other.thisWeek == _this.thisWeek)&&(identical(other.weekChangePercent, _this.weekChangePercent) || other.weekChangePercent == _this.weekChangePercent)&&(identical(other.nextPayoutDays, _this.nextPayoutDays) || other.nextPayoutDays == _this.nextPayoutDays)&&const DeepCollectionEquality().equals(other.week, _this.week)&&const DeepCollectionEquality().equals(other.months, _this.months)&&const DeepCollectionEquality().equals(other.monthLabels, _this.monthLabels)&&const DeepCollectionEquality().equals(other.transactions, _this.transactions)&&const DeepCollectionEquality().equals(other.byType, _this.byType));
}


@override
int get hashCode {
  final _this = this as Earnings;
  return Object.hash(runtimeType,_this.available,_this.yearTotal,_this.sessions,_this.averageRate,_this.thisWeek,_this.weekChangePercent,_this.nextPayoutDays,const DeepCollectionEquality().hash(_this.week),const DeepCollectionEquality().hash(_this.months),const DeepCollectionEquality().hash(_this.monthLabels),const DeepCollectionEquality().hash(_this.transactions),const DeepCollectionEquality().hash(_this.byType));
}

@override
String toString() {
  final _this = this as Earnings;
  return 'Earnings(available: ${_this.available}, yearTotal: ${_this.yearTotal}, sessions: ${_this.sessions}, averageRate: ${_this.averageRate}, thisWeek: ${_this.thisWeek}, weekChangePercent: ${_this.weekChangePercent}, nextPayoutDays: ${_this.nextPayoutDays}, week: ${_this.week}, months: ${_this.months}, monthLabels: ${_this.monthLabels}, transactions: ${_this.transactions}, byType: ${_this.byType})';
}


}

/// @nodoc
abstract mixin class $EarningsCopyWith<$Res>  {
  factory $EarningsCopyWith(Earnings value, $Res Function(Earnings) _then) = _$EarningsCopyWithImpl;
@useResult
$Res call({
 int available, int yearTotal, int sessions, int averageRate, int thisWeek, int weekChangePercent, int nextPayoutDays, List<int> week, List<int> months, List<String> monthLabels, List<Transaction> transactions, Map<String, int> byType
});




}
/// @nodoc
class _$EarningsCopyWithImpl<$Res>
    implements $EarningsCopyWith<$Res> {
  _$EarningsCopyWithImpl(this._self, this._then);

  final Earnings _self;
  final $Res Function(Earnings) _then;

/// Create a copy of Earnings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? available = null,Object? yearTotal = null,Object? sessions = null,Object? averageRate = null,Object? thisWeek = null,Object? weekChangePercent = null,Object? nextPayoutDays = null,Object? week = null,Object? months = null,Object? monthLabels = null,Object? transactions = null,Object? byType = null,}) {
  return _then(Earnings(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,yearTotal: null == yearTotal ? _self.yearTotal : yearTotal // ignore: cast_nullable_to_non_nullable
as int,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,averageRate: null == averageRate ? _self.averageRate : averageRate // ignore: cast_nullable_to_non_nullable
as int,thisWeek: null == thisWeek ? _self.thisWeek : thisWeek // ignore: cast_nullable_to_non_nullable
as int,weekChangePercent: null == weekChangePercent ? _self.weekChangePercent : weekChangePercent // ignore: cast_nullable_to_non_nullable
as int,nextPayoutDays: null == nextPayoutDays ? _self.nextPayoutDays : nextPayoutDays // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as List<int>,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as List<int>,monthLabels: null == monthLabels ? _self.monthLabels : monthLabels // ignore: cast_nullable_to_non_nullable
as List<String>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,byType: null == byType ? _self.byType : byType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [Earnings].
extension EarningsPatterns on Earnings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Earnings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Earnings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Earnings value)  $default,){
final _that = this;
switch (_that) {
case _Earnings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Earnings value)?  $default,){
final _that = this;
switch (_that) {
case _Earnings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int available,  int yearTotal,  int sessions,  int averageRate,  int thisWeek,  int weekChangePercent,  int nextPayoutDays,  List<int> week,  List<int> months,  List<String> monthLabels,  List<Transaction> transactions,  Map<String, int> byType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Earnings() when $default != null:
return $default(_that.available,_that.yearTotal,_that.sessions,_that.averageRate,_that.thisWeek,_that.weekChangePercent,_that.nextPayoutDays,_that.week,_that.months,_that.monthLabels,_that.transactions,_that.byType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int available,  int yearTotal,  int sessions,  int averageRate,  int thisWeek,  int weekChangePercent,  int nextPayoutDays,  List<int> week,  List<int> months,  List<String> monthLabels,  List<Transaction> transactions,  Map<String, int> byType)  $default,) {final _that = this;
switch (_that) {
case _Earnings():
return $default(_that.available,_that.yearTotal,_that.sessions,_that.averageRate,_that.thisWeek,_that.weekChangePercent,_that.nextPayoutDays,_that.week,_that.months,_that.monthLabels,_that.transactions,_that.byType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int available,  int yearTotal,  int sessions,  int averageRate,  int thisWeek,  int weekChangePercent,  int nextPayoutDays,  List<int> week,  List<int> months,  List<String> monthLabels,  List<Transaction> transactions,  Map<String, int> byType)?  $default,) {final _that = this;
switch (_that) {
case _Earnings() when $default != null:
return $default(_that.available,_that.yearTotal,_that.sessions,_that.averageRate,_that.thisWeek,_that.weekChangePercent,_that.nextPayoutDays,_that.week,_that.months,_that.monthLabels,_that.transactions,_that.byType);case _:
  return null;

}
}

}

/// @nodoc


class _Earnings implements Earnings {
  const _Earnings({required this.available, required this.yearTotal, required this.sessions, required this.averageRate, required this.thisWeek, required this.weekChangePercent, required this.nextPayoutDays, required  List<int> week, required  List<int> months, required  List<String> monthLabels, required  List<Transaction> transactions, required  Map<String, int> byType}): _week = week,_months = months,_monthLabels = monthLabels,_transactions = transactions,_byType = byType;
  

@override final  int available;
@override final  int yearTotal;
@override final  int sessions;
@override final  int averageRate;
@override final  int thisWeek;
@override final  int weekChangePercent;
@override final  int nextPayoutDays;
/// Mon..Sun amounts for the current week.
 final  List<int> _week;
/// Mon..Sun amounts for the current week.
@override List<int> get week {
  if (_week is EqualUnmodifiableListView) return _week;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_week);
}

/// Last 8 months, oldest first.
 final  List<int> _months;
/// Last 8 months, oldest first.
@override List<int> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}

 final  List<String> _monthLabels;
@override List<String> get monthLabels {
  if (_monthLabels is EqualUnmodifiableListView) return _monthLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthLabels);
}

 final  List<Transaction> _transactions;
@override List<Transaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

/// Share by session type (label → percent).
 final  Map<String, int> _byType;
/// Share by session type (label → percent).
@override Map<String, int> get byType {
  if (_byType is EqualUnmodifiableMapView) return _byType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byType);
}


/// Create a copy of Earnings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsCopyWith<_Earnings> get copyWith => __$EarningsCopyWithImpl<_Earnings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earnings&&(identical(other.available, available) || other.available == available)&&(identical(other.yearTotal, yearTotal) || other.yearTotal == yearTotal)&&(identical(other.sessions, sessions) || other.sessions == sessions)&&(identical(other.averageRate, averageRate) || other.averageRate == averageRate)&&(identical(other.thisWeek, thisWeek) || other.thisWeek == thisWeek)&&(identical(other.weekChangePercent, weekChangePercent) || other.weekChangePercent == weekChangePercent)&&(identical(other.nextPayoutDays, nextPayoutDays) || other.nextPayoutDays == nextPayoutDays)&&const DeepCollectionEquality().equals(other.week, _week)&&const DeepCollectionEquality().equals(other.months, _months)&&const DeepCollectionEquality().equals(other.monthLabels, _monthLabels)&&const DeepCollectionEquality().equals(other.transactions, _transactions)&&const DeepCollectionEquality().equals(other.byType, _byType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,available,yearTotal,sessions,averageRate,thisWeek,weekChangePercent,nextPayoutDays,const DeepCollectionEquality().hash(_week),const DeepCollectionEquality().hash(_months),const DeepCollectionEquality().hash(_monthLabels),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_byType));
}

@override
String toString() {
    return 'Earnings(available: $available, yearTotal: $yearTotal, sessions: $sessions, averageRate: $averageRate, thisWeek: $thisWeek, weekChangePercent: $weekChangePercent, nextPayoutDays: $nextPayoutDays, week: $week, months: $months, monthLabels: $monthLabels, transactions: $transactions, byType: $byType)';
}


}

/// @nodoc
abstract mixin class _$EarningsCopyWith<$Res> implements $EarningsCopyWith<$Res> {
  factory _$EarningsCopyWith(_Earnings value, $Res Function(_Earnings) _then) = __$EarningsCopyWithImpl;
@override @useResult
$Res call({
 int available, int yearTotal, int sessions, int averageRate, int thisWeek, int weekChangePercent, int nextPayoutDays, List<int> week, List<int> months, List<String> monthLabels, List<Transaction> transactions, Map<String, int> byType
});




}
/// @nodoc
class __$EarningsCopyWithImpl<$Res>
    implements _$EarningsCopyWith<$Res> {
  __$EarningsCopyWithImpl(this._self, this._then);

  final _Earnings _self;
  final $Res Function(_Earnings) _then;

/// Create a copy of Earnings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? available = null,Object? yearTotal = null,Object? sessions = null,Object? averageRate = null,Object? thisWeek = null,Object? weekChangePercent = null,Object? nextPayoutDays = null,Object? week = null,Object? months = null,Object? monthLabels = null,Object? transactions = null,Object? byType = null,}) {
  return _then(_Earnings(
available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,yearTotal: null == yearTotal ? _self.yearTotal : yearTotal // ignore: cast_nullable_to_non_nullable
as int,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as int,averageRate: null == averageRate ? _self.averageRate : averageRate // ignore: cast_nullable_to_non_nullable
as int,thisWeek: null == thisWeek ? _self.thisWeek : thisWeek // ignore: cast_nullable_to_non_nullable
as int,weekChangePercent: null == weekChangePercent ? _self.weekChangePercent : weekChangePercent // ignore: cast_nullable_to_non_nullable
as int,nextPayoutDays: null == nextPayoutDays ? _self.nextPayoutDays : nextPayoutDays // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self._week : week // ignore: cast_nullable_to_non_nullable
as List<int>,months: null == months ? _self._months : months // ignore: cast_nullable_to_non_nullable
as List<int>,monthLabels: null == monthLabels ? _self._monthLabels : monthLabels // ignore: cast_nullable_to_non_nullable
as List<String>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<Transaction>,byType: null == byType ? _self._byType : byType // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

/// @nodoc
mixin _$PracticeDashboard {

 int get sessionsToday; int get pendingRequests; double get rating; int get weekEarnings; int get responseRate; int get engagement; int get activeClients; int get newThisMonth; int get completedRate; int get attendanceRate; int get rebookedRate; int get totalClients; int get years; bool get acceptingClients; List<int> get earningsWeek; List<ScheduledSession> get schedule;
/// Create a copy of PracticeDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeDashboardCopyWith<PracticeDashboard> get copyWith => _$PracticeDashboardCopyWithImpl<PracticeDashboard>(this as PracticeDashboard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PracticeDashboard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeDashboard&&(identical(other.sessionsToday, _this.sessionsToday) || other.sessionsToday == _this.sessionsToday)&&(identical(other.pendingRequests, _this.pendingRequests) || other.pendingRequests == _this.pendingRequests)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.weekEarnings, _this.weekEarnings) || other.weekEarnings == _this.weekEarnings)&&(identical(other.responseRate, _this.responseRate) || other.responseRate == _this.responseRate)&&(identical(other.engagement, _this.engagement) || other.engagement == _this.engagement)&&(identical(other.activeClients, _this.activeClients) || other.activeClients == _this.activeClients)&&(identical(other.newThisMonth, _this.newThisMonth) || other.newThisMonth == _this.newThisMonth)&&(identical(other.completedRate, _this.completedRate) || other.completedRate == _this.completedRate)&&(identical(other.attendanceRate, _this.attendanceRate) || other.attendanceRate == _this.attendanceRate)&&(identical(other.rebookedRate, _this.rebookedRate) || other.rebookedRate == _this.rebookedRate)&&(identical(other.totalClients, _this.totalClients) || other.totalClients == _this.totalClients)&&(identical(other.years, _this.years) || other.years == _this.years)&&(identical(other.acceptingClients, _this.acceptingClients) || other.acceptingClients == _this.acceptingClients)&&const DeepCollectionEquality().equals(other.earningsWeek, _this.earningsWeek)&&const DeepCollectionEquality().equals(other.schedule, _this.schedule));
}


@override
int get hashCode {
  final _this = this as PracticeDashboard;
  return Object.hash(runtimeType,_this.sessionsToday,_this.pendingRequests,_this.rating,_this.weekEarnings,_this.responseRate,_this.engagement,_this.activeClients,_this.newThisMonth,_this.completedRate,_this.attendanceRate,_this.rebookedRate,_this.totalClients,_this.years,_this.acceptingClients,const DeepCollectionEquality().hash(_this.earningsWeek),const DeepCollectionEquality().hash(_this.schedule));
}

@override
String toString() {
  final _this = this as PracticeDashboard;
  return 'PracticeDashboard(sessionsToday: ${_this.sessionsToday}, pendingRequests: ${_this.pendingRequests}, rating: ${_this.rating}, weekEarnings: ${_this.weekEarnings}, responseRate: ${_this.responseRate}, engagement: ${_this.engagement}, activeClients: ${_this.activeClients}, newThisMonth: ${_this.newThisMonth}, completedRate: ${_this.completedRate}, attendanceRate: ${_this.attendanceRate}, rebookedRate: ${_this.rebookedRate}, totalClients: ${_this.totalClients}, years: ${_this.years}, acceptingClients: ${_this.acceptingClients}, earningsWeek: ${_this.earningsWeek}, schedule: ${_this.schedule})';
}


}

/// @nodoc
abstract mixin class $PracticeDashboardCopyWith<$Res>  {
  factory $PracticeDashboardCopyWith(PracticeDashboard value, $Res Function(PracticeDashboard) _then) = _$PracticeDashboardCopyWithImpl;
@useResult
$Res call({
 int sessionsToday, int pendingRequests, double rating, int weekEarnings, int responseRate, int engagement, int activeClients, int newThisMonth, int completedRate, int attendanceRate, int rebookedRate, int totalClients, int years, bool acceptingClients, List<int> earningsWeek, List<ScheduledSession> schedule
});




}
/// @nodoc
class _$PracticeDashboardCopyWithImpl<$Res>
    implements $PracticeDashboardCopyWith<$Res> {
  _$PracticeDashboardCopyWithImpl(this._self, this._then);

  final PracticeDashboard _self;
  final $Res Function(PracticeDashboard) _then;

/// Create a copy of PracticeDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionsToday = null,Object? pendingRequests = null,Object? rating = null,Object? weekEarnings = null,Object? responseRate = null,Object? engagement = null,Object? activeClients = null,Object? newThisMonth = null,Object? completedRate = null,Object? attendanceRate = null,Object? rebookedRate = null,Object? totalClients = null,Object? years = null,Object? acceptingClients = null,Object? earningsWeek = null,Object? schedule = null,}) {
  return _then(PracticeDashboard(
sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,weekEarnings: null == weekEarnings ? _self.weekEarnings : weekEarnings // ignore: cast_nullable_to_non_nullable
as int,responseRate: null == responseRate ? _self.responseRate : responseRate // ignore: cast_nullable_to_non_nullable
as int,engagement: null == engagement ? _self.engagement : engagement // ignore: cast_nullable_to_non_nullable
as int,activeClients: null == activeClients ? _self.activeClients : activeClients // ignore: cast_nullable_to_non_nullable
as int,newThisMonth: null == newThisMonth ? _self.newThisMonth : newThisMonth // ignore: cast_nullable_to_non_nullable
as int,completedRate: null == completedRate ? _self.completedRate : completedRate // ignore: cast_nullable_to_non_nullable
as int,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as int,rebookedRate: null == rebookedRate ? _self.rebookedRate : rebookedRate // ignore: cast_nullable_to_non_nullable
as int,totalClients: null == totalClients ? _self.totalClients : totalClients // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,acceptingClients: null == acceptingClients ? _self.acceptingClients : acceptingClients // ignore: cast_nullable_to_non_nullable
as bool,earningsWeek: null == earningsWeek ? _self.earningsWeek : earningsWeek // ignore: cast_nullable_to_non_nullable
as List<int>,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeDashboard].
extension PracticeDashboardPatterns on PracticeDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeDashboard value)  $default,){
final _that = this;
switch (_that) {
case _PracticeDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionsToday,  int pendingRequests,  double rating,  int weekEarnings,  int responseRate,  int engagement,  int activeClients,  int newThisMonth,  int completedRate,  int attendanceRate,  int rebookedRate,  int totalClients,  int years,  bool acceptingClients,  List<int> earningsWeek,  List<ScheduledSession> schedule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeDashboard() when $default != null:
return $default(_that.sessionsToday,_that.pendingRequests,_that.rating,_that.weekEarnings,_that.responseRate,_that.engagement,_that.activeClients,_that.newThisMonth,_that.completedRate,_that.attendanceRate,_that.rebookedRate,_that.totalClients,_that.years,_that.acceptingClients,_that.earningsWeek,_that.schedule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionsToday,  int pendingRequests,  double rating,  int weekEarnings,  int responseRate,  int engagement,  int activeClients,  int newThisMonth,  int completedRate,  int attendanceRate,  int rebookedRate,  int totalClients,  int years,  bool acceptingClients,  List<int> earningsWeek,  List<ScheduledSession> schedule)  $default,) {final _that = this;
switch (_that) {
case _PracticeDashboard():
return $default(_that.sessionsToday,_that.pendingRequests,_that.rating,_that.weekEarnings,_that.responseRate,_that.engagement,_that.activeClients,_that.newThisMonth,_that.completedRate,_that.attendanceRate,_that.rebookedRate,_that.totalClients,_that.years,_that.acceptingClients,_that.earningsWeek,_that.schedule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionsToday,  int pendingRequests,  double rating,  int weekEarnings,  int responseRate,  int engagement,  int activeClients,  int newThisMonth,  int completedRate,  int attendanceRate,  int rebookedRate,  int totalClients,  int years,  bool acceptingClients,  List<int> earningsWeek,  List<ScheduledSession> schedule)?  $default,) {final _that = this;
switch (_that) {
case _PracticeDashboard() when $default != null:
return $default(_that.sessionsToday,_that.pendingRequests,_that.rating,_that.weekEarnings,_that.responseRate,_that.engagement,_that.activeClients,_that.newThisMonth,_that.completedRate,_that.attendanceRate,_that.rebookedRate,_that.totalClients,_that.years,_that.acceptingClients,_that.earningsWeek,_that.schedule);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeDashboard implements PracticeDashboard {
  const _PracticeDashboard({required this.sessionsToday, required this.pendingRequests, required this.rating, required this.weekEarnings, required this.responseRate, required this.engagement, required this.activeClients, required this.newThisMonth, required this.completedRate, required this.attendanceRate, required this.rebookedRate, required this.totalClients, required this.years, required this.acceptingClients, required  List<int> earningsWeek, required  List<ScheduledSession> schedule}): _earningsWeek = earningsWeek,_schedule = schedule;
  

@override final  int sessionsToday;
@override final  int pendingRequests;
@override final  double rating;
@override final  int weekEarnings;
@override final  int responseRate;
@override final  int engagement;
@override final  int activeClients;
@override final  int newThisMonth;
@override final  int completedRate;
@override final  int attendanceRate;
@override final  int rebookedRate;
@override final  int totalClients;
@override final  int years;
@override final  bool acceptingClients;
 final  List<int> _earningsWeek;
@override List<int> get earningsWeek {
  if (_earningsWeek is EqualUnmodifiableListView) return _earningsWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earningsWeek);
}

 final  List<ScheduledSession> _schedule;
@override List<ScheduledSession> get schedule {
  if (_schedule is EqualUnmodifiableListView) return _schedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedule);
}


/// Create a copy of PracticeDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeDashboardCopyWith<_PracticeDashboard> get copyWith => __$PracticeDashboardCopyWithImpl<_PracticeDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeDashboard&&(identical(other.sessionsToday, sessionsToday) || other.sessionsToday == sessionsToday)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.weekEarnings, weekEarnings) || other.weekEarnings == weekEarnings)&&(identical(other.responseRate, responseRate) || other.responseRate == responseRate)&&(identical(other.engagement, engagement) || other.engagement == engagement)&&(identical(other.activeClients, activeClients) || other.activeClients == activeClients)&&(identical(other.newThisMonth, newThisMonth) || other.newThisMonth == newThisMonth)&&(identical(other.completedRate, completedRate) || other.completedRate == completedRate)&&(identical(other.attendanceRate, attendanceRate) || other.attendanceRate == attendanceRate)&&(identical(other.rebookedRate, rebookedRate) || other.rebookedRate == rebookedRate)&&(identical(other.totalClients, totalClients) || other.totalClients == totalClients)&&(identical(other.years, years) || other.years == years)&&(identical(other.acceptingClients, acceptingClients) || other.acceptingClients == acceptingClients)&&const DeepCollectionEquality().equals(other.earningsWeek, _earningsWeek)&&const DeepCollectionEquality().equals(other.schedule, _schedule));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sessionsToday,pendingRequests,rating,weekEarnings,responseRate,engagement,activeClients,newThisMonth,completedRate,attendanceRate,rebookedRate,totalClients,years,acceptingClients,const DeepCollectionEquality().hash(_earningsWeek),const DeepCollectionEquality().hash(_schedule));
}

@override
String toString() {
    return 'PracticeDashboard(sessionsToday: $sessionsToday, pendingRequests: $pendingRequests, rating: $rating, weekEarnings: $weekEarnings, responseRate: $responseRate, engagement: $engagement, activeClients: $activeClients, newThisMonth: $newThisMonth, completedRate: $completedRate, attendanceRate: $attendanceRate, rebookedRate: $rebookedRate, totalClients: $totalClients, years: $years, acceptingClients: $acceptingClients, earningsWeek: $earningsWeek, schedule: $schedule)';
}


}

/// @nodoc
abstract mixin class _$PracticeDashboardCopyWith<$Res> implements $PracticeDashboardCopyWith<$Res> {
  factory _$PracticeDashboardCopyWith(_PracticeDashboard value, $Res Function(_PracticeDashboard) _then) = __$PracticeDashboardCopyWithImpl;
@override @useResult
$Res call({
 int sessionsToday, int pendingRequests, double rating, int weekEarnings, int responseRate, int engagement, int activeClients, int newThisMonth, int completedRate, int attendanceRate, int rebookedRate, int totalClients, int years, bool acceptingClients, List<int> earningsWeek, List<ScheduledSession> schedule
});




}
/// @nodoc
class __$PracticeDashboardCopyWithImpl<$Res>
    implements _$PracticeDashboardCopyWith<$Res> {
  __$PracticeDashboardCopyWithImpl(this._self, this._then);

  final _PracticeDashboard _self;
  final $Res Function(_PracticeDashboard) _then;

/// Create a copy of PracticeDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionsToday = null,Object? pendingRequests = null,Object? rating = null,Object? weekEarnings = null,Object? responseRate = null,Object? engagement = null,Object? activeClients = null,Object? newThisMonth = null,Object? completedRate = null,Object? attendanceRate = null,Object? rebookedRate = null,Object? totalClients = null,Object? years = null,Object? acceptingClients = null,Object? earningsWeek = null,Object? schedule = null,}) {
  return _then(_PracticeDashboard(
sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,weekEarnings: null == weekEarnings ? _self.weekEarnings : weekEarnings // ignore: cast_nullable_to_non_nullable
as int,responseRate: null == responseRate ? _self.responseRate : responseRate // ignore: cast_nullable_to_non_nullable
as int,engagement: null == engagement ? _self.engagement : engagement // ignore: cast_nullable_to_non_nullable
as int,activeClients: null == activeClients ? _self.activeClients : activeClients // ignore: cast_nullable_to_non_nullable
as int,newThisMonth: null == newThisMonth ? _self.newThisMonth : newThisMonth // ignore: cast_nullable_to_non_nullable
as int,completedRate: null == completedRate ? _self.completedRate : completedRate // ignore: cast_nullable_to_non_nullable
as int,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as int,rebookedRate: null == rebookedRate ? _self.rebookedRate : rebookedRate // ignore: cast_nullable_to_non_nullable
as int,totalClients: null == totalClients ? _self.totalClients : totalClients // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,acceptingClients: null == acceptingClients ? _self.acceptingClients : acceptingClients // ignore: cast_nullable_to_non_nullable
as bool,earningsWeek: null == earningsWeek ? _self._earningsWeek : earningsWeek // ignore: cast_nullable_to_non_nullable
as List<int>,schedule: null == schedule ? _self._schedule : schedule // ignore: cast_nullable_to_non_nullable
as List<ScheduledSession>,
  ));
}


}

// dart format on
