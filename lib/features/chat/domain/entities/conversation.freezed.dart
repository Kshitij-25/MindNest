// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Participant {

 String get id; String get name; String get subtitle; bool get verified; bool get online;
/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantCopyWith<Participant> get copyWith => _$ParticipantCopyWithImpl<Participant>(this as Participant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Participant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Participant&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.online, _this.online) || other.online == _this.online));
}


@override
int get hashCode {
  final _this = this as Participant;
  return Object.hash(runtimeType,_this.id,_this.name,_this.subtitle,_this.verified,_this.online);
}

@override
String toString() {
  final _this = this as Participant;
  return 'Participant(id: ${_this.id}, name: ${_this.name}, subtitle: ${_this.subtitle}, verified: ${_this.verified}, online: ${_this.online})';
}


}

/// @nodoc
abstract mixin class $ParticipantCopyWith<$Res>  {
  factory $ParticipantCopyWith(Participant value, $Res Function(Participant) _then) = _$ParticipantCopyWithImpl;
@useResult
$Res call({
 String id, String name, String subtitle, bool verified, bool online
});




}
/// @nodoc
class _$ParticipantCopyWithImpl<$Res>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._self, this._then);

  final Participant _self;
  final $Res Function(Participant) _then;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? subtitle = null,Object? verified = null,Object? online = null,}) {
  return _then(Participant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Participant].
extension ParticipantPatterns on Participant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Participant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Participant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Participant value)  $default,){
final _that = this;
switch (_that) {
case _Participant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Participant value)?  $default,){
final _that = this;
switch (_that) {
case _Participant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String subtitle,  bool verified,  bool online)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Participant() when $default != null:
return $default(_that.id,_that.name,_that.subtitle,_that.verified,_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String subtitle,  bool verified,  bool online)  $default,) {final _that = this;
switch (_that) {
case _Participant():
return $default(_that.id,_that.name,_that.subtitle,_that.verified,_that.online);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String subtitle,  bool verified,  bool online)?  $default,) {final _that = this;
switch (_that) {
case _Participant() when $default != null:
return $default(_that.id,_that.name,_that.subtitle,_that.verified,_that.online);case _:
  return null;

}
}

}

/// @nodoc


class _Participant implements Participant {
  const _Participant({required this.id, required this.name, this.subtitle = '', this.verified = false, this.online = false});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  String subtitle;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool online;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantCopyWith<_Participant> get copyWith => __$ParticipantCopyWithImpl<_Participant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Participant&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.online, online) || other.online == online));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,subtitle,verified,online);
}

@override
String toString() {
    return 'Participant(id: $id, name: $name, subtitle: $subtitle, verified: $verified, online: $online)';
}


}

/// @nodoc
abstract mixin class _$ParticipantCopyWith<$Res> implements $ParticipantCopyWith<$Res> {
  factory _$ParticipantCopyWith(_Participant value, $Res Function(_Participant) _then) = __$ParticipantCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String subtitle, bool verified, bool online
});




}
/// @nodoc
class __$ParticipantCopyWithImpl<$Res>
    implements _$ParticipantCopyWith<$Res> {
  __$ParticipantCopyWithImpl(this._self, this._then);

  final _Participant _self;
  final $Res Function(_Participant) _then;

/// Create a copy of Participant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? subtitle = null,Object? verified = null,Object? online = null,}) {
  return _then(_Participant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Conversation {

 String get id; Participant get participant; String get lastMessage; DateTime get updatedAt; int get unread; bool get typing;/// Optional booking context pinned at the top of the thread.
 SessionContext? get session;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Conversation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.participant, _this.participant) || other.participant == _this.participant)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.unread, _this.unread) || other.unread == _this.unread)&&(identical(other.typing, _this.typing) || other.typing == _this.typing)&&(identical(other.session, _this.session) || other.session == _this.session));
}


@override
int get hashCode {
  final _this = this as Conversation;
  return Object.hash(runtimeType,_this.id,_this.participant,_this.lastMessage,_this.updatedAt,_this.unread,_this.typing,_this.session);
}

@override
String toString() {
  final _this = this as Conversation;
  return 'Conversation(id: ${_this.id}, participant: ${_this.participant}, lastMessage: ${_this.lastMessage}, updatedAt: ${_this.updatedAt}, unread: ${_this.unread}, typing: ${_this.typing}, session: ${_this.session})';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String id, Participant participant, String lastMessage, DateTime updatedAt, int unread, bool typing, SessionContext? session
});


$ParticipantCopyWith<$Res> get participant;$SessionContextCopyWith<$Res>? get session;

}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? participant = null,Object? lastMessage = null,Object? updatedAt = null,Object? unread = null,Object? typing = null,Object? session = freezed,}) {
  return _then(Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,participant: null == participant ? _self.participant : participant // ignore: cast_nullable_to_non_nullable
as Participant,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SessionContext?,
  ));
}
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParticipantCopyWith<$Res> get participant {
  
  return $ParticipantCopyWith<$Res>(_self.participant, (value) {
    return _then(_self.copyWith(participant: value));
  });
}/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionContextCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionContextCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Participant participant,  String lastMessage,  DateTime updatedAt,  int unread,  bool typing,  SessionContext? session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.participant,_that.lastMessage,_that.updatedAt,_that.unread,_that.typing,_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Participant participant,  String lastMessage,  DateTime updatedAt,  int unread,  bool typing,  SessionContext? session)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.participant,_that.lastMessage,_that.updatedAt,_that.unread,_that.typing,_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Participant participant,  String lastMessage,  DateTime updatedAt,  int unread,  bool typing,  SessionContext? session)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.participant,_that.lastMessage,_that.updatedAt,_that.unread,_that.typing,_that.session);case _:
  return null;

}
}

}

/// @nodoc


class _Conversation implements Conversation {
  const _Conversation({required this.id, required this.participant, required this.lastMessage, required this.updatedAt, this.unread = 0, this.typing = false, this.session});
  

@override final  String id;
@override final  Participant participant;
@override final  String lastMessage;
@override final  DateTime updatedAt;
@override@JsonKey() final  int unread;
@override@JsonKey() final  bool typing;
/// Optional booking context pinned at the top of the thread.
@override final  SessionContext? session;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&(identical(other.participant, participant) || other.participant == participant)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.typing, typing) || other.typing == typing)&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,participant,lastMessage,updatedAt,unread,typing,session);
}

@override
String toString() {
    return 'Conversation(id: $id, participant: $participant, lastMessage: $lastMessage, updatedAt: $updatedAt, unread: $unread, typing: $typing, session: $session)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String id, Participant participant, String lastMessage, DateTime updatedAt, int unread, bool typing, SessionContext? session
});


@override $ParticipantCopyWith<$Res> get participant;@override $SessionContextCopyWith<$Res>? get session;

}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? participant = null,Object? lastMessage = null,Object? updatedAt = null,Object? unread = null,Object? typing = null,Object? session = freezed,}) {
  return _then(_Conversation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,participant: null == participant ? _self.participant : participant // ignore: cast_nullable_to_non_nullable
as Participant,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SessionContext?,
  ));
}

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParticipantCopyWith<$Res> get participant {
  
  return $ParticipantCopyWith<$Res>(_self.participant, (value) {
    return _then(_self.copyWith(participant: value));
  });
}/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionContextCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $SessionContextCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc
mixin _$SessionContext {

 String get title; DateTime get startsAt; String get status;
/// Create a copy of SessionContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionContextCopyWith<SessionContext> get copyWith => _$SessionContextCopyWithImpl<SessionContext>(this as SessionContext, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionContext;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionContext&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as SessionContext;
  return Object.hash(runtimeType,_this.title,_this.startsAt,_this.status);
}

@override
String toString() {
  final _this = this as SessionContext;
  return 'SessionContext(title: ${_this.title}, startsAt: ${_this.startsAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $SessionContextCopyWith<$Res>  {
  factory $SessionContextCopyWith(SessionContext value, $Res Function(SessionContext) _then) = _$SessionContextCopyWithImpl;
@useResult
$Res call({
 String title, DateTime startsAt, String status
});




}
/// @nodoc
class _$SessionContextCopyWithImpl<$Res>
    implements $SessionContextCopyWith<$Res> {
  _$SessionContextCopyWithImpl(this._self, this._then);

  final SessionContext _self;
  final $Res Function(SessionContext) _then;

/// Create a copy of SessionContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? startsAt = null,Object? status = null,}) {
  return _then(SessionContext(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionContext].
extension SessionContextPatterns on SessionContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionContext value)  $default,){
final _that = this;
switch (_that) {
case _SessionContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionContext value)?  $default,){
final _that = this;
switch (_that) {
case _SessionContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  DateTime startsAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionContext() when $default != null:
return $default(_that.title,_that.startsAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  DateTime startsAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _SessionContext():
return $default(_that.title,_that.startsAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  DateTime startsAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _SessionContext() when $default != null:
return $default(_that.title,_that.startsAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _SessionContext implements SessionContext {
  const _SessionContext({required this.title, required this.startsAt, required this.status});
  

@override final  String title;
@override final  DateTime startsAt;
@override final  String status;

/// Create a copy of SessionContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionContextCopyWith<_SessionContext> get copyWith => __$SessionContextCopyWithImpl<_SessionContext>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionContext&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,startsAt,status);
}

@override
String toString() {
    return 'SessionContext(title: $title, startsAt: $startsAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SessionContextCopyWith<$Res> implements $SessionContextCopyWith<$Res> {
  factory _$SessionContextCopyWith(_SessionContext value, $Res Function(_SessionContext) _then) = __$SessionContextCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime startsAt, String status
});




}
/// @nodoc
class __$SessionContextCopyWithImpl<$Res>
    implements _$SessionContextCopyWith<$Res> {
  __$SessionContextCopyWithImpl(this._self, this._then);

  final _SessionContext _self;
  final $Res Function(_SessionContext) _then;

/// Create a copy of SessionContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? startsAt = null,Object? status = null,}) {
  return _then(_SessionContext(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChatMessage {

 String get id; bool get fromMe; String get text; DateTime get sentAt; bool get read;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fromMe, _this.fromMe) || other.fromMe == _this.fromMe)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt)&&(identical(other.read, _this.read) || other.read == _this.read));
}


@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.id,_this.fromMe,_this.text,_this.sentAt,_this.read);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, fromMe: ${_this.fromMe}, text: ${_this.text}, sentAt: ${_this.sentAt}, read: ${_this.read})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, bool fromMe, String text, DateTime sentAt, bool read
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromMe = null,Object? text = null,Object? sentAt = null,Object? read = null,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMe: null == fromMe ? _self.fromMe : fromMe // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  bool fromMe,  String text,  DateTime sentAt,  bool read)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.fromMe,_that.text,_that.sentAt,_that.read);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  bool fromMe,  String text,  DateTime sentAt,  bool read)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.fromMe,_that.text,_that.sentAt,_that.read);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  bool fromMe,  String text,  DateTime sentAt,  bool read)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.fromMe,_that.text,_that.sentAt,_that.read);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.fromMe, required this.text, required this.sentAt, this.read = false});
  

@override final  String id;
@override final  bool fromMe;
@override final  String text;
@override final  DateTime sentAt;
@override@JsonKey() final  bool read;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.fromMe, fromMe) || other.fromMe == fromMe)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.read, read) || other.read == read));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,fromMe,text,sentAt,read);
}

@override
String toString() {
    return 'ChatMessage(id: $id, fromMe: $fromMe, text: $text, sentAt: $sentAt, read: $read)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, bool fromMe, String text, DateTime sentAt, bool read
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromMe = null,Object? text = null,Object? sentAt = null,Object? read = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromMe: null == fromMe ? _self.fromMe : fromMe // ignore: cast_nullable_to_non_nullable
as bool,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
