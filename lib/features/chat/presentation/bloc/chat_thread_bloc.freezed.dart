// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_thread_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatThreadEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ChatThreadEvent()';
}


}

/// @nodoc
class $ChatThreadEventCopyWith<$Res>  {
$ChatThreadEventCopyWith(ChatThreadEvent _, $Res Function(ChatThreadEvent) __);
}


/// Adds pattern-matching-related methods to [ChatThreadEvent].
extension ChatThreadEventPatterns on ChatThreadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatThreadOpened value)?  opened,TResult Function( ChatThreadSent value)?  sent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatThreadOpened() when opened != null:
return opened(_that);case ChatThreadSent() when sent != null:
return sent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatThreadOpened value)  opened,required TResult Function( ChatThreadSent value)  sent,}){
final _that = this;
switch (_that) {
case ChatThreadOpened():
return opened(_that);case ChatThreadSent():
return sent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatThreadOpened value)?  opened,TResult? Function( ChatThreadSent value)?  sent,}){
final _that = this;
switch (_that) {
case ChatThreadOpened() when opened != null:
return opened(_that);case ChatThreadSent() when sent != null:
return sent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? conversationId,  String? participantId)?  opened,TResult Function( String text)?  sent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatThreadOpened() when opened != null:
return opened(_that.conversationId,_that.participantId);case ChatThreadSent() when sent != null:
return sent(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? conversationId,  String? participantId)  opened,required TResult Function( String text)  sent,}) {final _that = this;
switch (_that) {
case ChatThreadOpened():
return opened(_that.conversationId,_that.participantId);case ChatThreadSent():
return sent(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? conversationId,  String? participantId)?  opened,TResult? Function( String text)?  sent,}) {final _that = this;
switch (_that) {
case ChatThreadOpened() when opened != null:
return opened(_that.conversationId,_that.participantId);case ChatThreadSent() when sent != null:
return sent(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class ChatThreadOpened implements ChatThreadEvent {
  const ChatThreadOpened({this.conversationId, this.participantId});
  

 final  String? conversationId;
 final  String? participantId;

/// Create a copy of ChatThreadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadOpenedCopyWith<ChatThreadOpened> get copyWith => _$ChatThreadOpenedCopyWithImpl<ChatThreadOpened>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadOpened&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.participantId, participantId) || other.participantId == participantId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,conversationId,participantId);
}

@override
String toString() {
    return 'ChatThreadEvent.opened(conversationId: $conversationId, participantId: $participantId)';
}


}

/// @nodoc
abstract mixin class $ChatThreadOpenedCopyWith<$Res> implements $ChatThreadEventCopyWith<$Res> {
  factory $ChatThreadOpenedCopyWith(ChatThreadOpened value, $Res Function(ChatThreadOpened) _then) = _$ChatThreadOpenedCopyWithImpl;
@useResult
$Res call({
 String? conversationId, String? participantId
});




}
/// @nodoc
class _$ChatThreadOpenedCopyWithImpl<$Res>
    implements $ChatThreadOpenedCopyWith<$Res> {
  _$ChatThreadOpenedCopyWithImpl(this._self, this._then);

  final ChatThreadOpened _self;
  final $Res Function(ChatThreadOpened) _then;

/// Create a copy of ChatThreadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conversationId = freezed,Object? participantId = freezed,}) {
  return _then(ChatThreadOpened(
conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,participantId: freezed == participantId ? _self.participantId : participantId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChatThreadSent implements ChatThreadEvent {
  const ChatThreadSent(this.text);
  

 final  String text;

/// Create a copy of ChatThreadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadSentCopyWith<ChatThreadSent> get copyWith => _$ChatThreadSentCopyWithImpl<ChatThreadSent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadSent&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'ChatThreadEvent.sent(text: $text)';
}


}

/// @nodoc
abstract mixin class $ChatThreadSentCopyWith<$Res> implements $ChatThreadEventCopyWith<$Res> {
  factory $ChatThreadSentCopyWith(ChatThreadSent value, $Res Function(ChatThreadSent) _then) = _$ChatThreadSentCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ChatThreadSentCopyWithImpl<$Res>
    implements $ChatThreadSentCopyWith<$Res> {
  _$ChatThreadSentCopyWithImpl(this._self, this._then);

  final ChatThreadSent _self;
  final $Res Function(ChatThreadSent) _then;

/// Create a copy of ChatThreadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ChatThreadSent(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChatThreadState {

 LoadStatus get status; Conversation? get conversation; List<ChatMessage> get messages; bool get otherTyping; String? get error;
/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatThreadStateCopyWith<ChatThreadState> get copyWith => _$ChatThreadStateCopyWithImpl<ChatThreadState>(this as ChatThreadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatThreadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatThreadState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.conversation, _this.conversation) || other.conversation == _this.conversation)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.otherTyping, _this.otherTyping) || other.otherTyping == _this.otherTyping)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ChatThreadState;
  return Object.hash(runtimeType,_this.status,_this.conversation,const DeepCollectionEquality().hash(_this.messages),_this.otherTyping,_this.error);
}

@override
String toString() {
  final _this = this as ChatThreadState;
  return 'ChatThreadState(status: ${_this.status}, conversation: ${_this.conversation}, messages: ${_this.messages}, otherTyping: ${_this.otherTyping}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ChatThreadStateCopyWith<$Res>  {
  factory $ChatThreadStateCopyWith(ChatThreadState value, $Res Function(ChatThreadState) _then) = _$ChatThreadStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, Conversation? conversation, List<ChatMessage> messages, bool otherTyping, String? error
});


$ConversationCopyWith<$Res>? get conversation;

}
/// @nodoc
class _$ChatThreadStateCopyWithImpl<$Res>
    implements $ChatThreadStateCopyWith<$Res> {
  _$ChatThreadStateCopyWithImpl(this._self, this._then);

  final ChatThreadState _self;
  final $Res Function(ChatThreadState) _then;

/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? conversation = freezed,Object? messages = null,Object? otherTyping = null,Object? error = freezed,}) {
  return _then(ChatThreadState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as Conversation?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,otherTyping: null == otherTyping ? _self.otherTyping : otherTyping // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationCopyWith<$Res>? get conversation {
    if (_self.conversation == null) {
    return null;
  }

  return $ConversationCopyWith<$Res>(_self.conversation!, (value) {
    return _then(_self.copyWith(conversation: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatThreadState].
extension ChatThreadStatePatterns on ChatThreadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatThreadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatThreadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatThreadState value)  $default,){
final _that = this;
switch (_that) {
case _ChatThreadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatThreadState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatThreadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  Conversation? conversation,  List<ChatMessage> messages,  bool otherTyping,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatThreadState() when $default != null:
return $default(_that.status,_that.conversation,_that.messages,_that.otherTyping,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  Conversation? conversation,  List<ChatMessage> messages,  bool otherTyping,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ChatThreadState():
return $default(_that.status,_that.conversation,_that.messages,_that.otherTyping,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  Conversation? conversation,  List<ChatMessage> messages,  bool otherTyping,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ChatThreadState() when $default != null:
return $default(_that.status,_that.conversation,_that.messages,_that.otherTyping,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ChatThreadState implements ChatThreadState {
  const _ChatThreadState({this.status = LoadStatus.initial, this.conversation,  List<ChatMessage> messages = const <ChatMessage>[], this.otherTyping = false, this.error}): _messages = messages;
  

@override@JsonKey() final  LoadStatus status;
@override final  Conversation? conversation;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool otherTyping;
@override final  String? error;

/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatThreadStateCopyWith<_ChatThreadState> get copyWith => __$ChatThreadStateCopyWithImpl<_ChatThreadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatThreadState&&(identical(other.status, status) || other.status == status)&&(identical(other.conversation, conversation) || other.conversation == conversation)&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.otherTyping, otherTyping) || other.otherTyping == otherTyping)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,conversation,const DeepCollectionEquality().hash(_messages),otherTyping,error);
}

@override
String toString() {
    return 'ChatThreadState(status: $status, conversation: $conversation, messages: $messages, otherTyping: $otherTyping, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ChatThreadStateCopyWith<$Res> implements $ChatThreadStateCopyWith<$Res> {
  factory _$ChatThreadStateCopyWith(_ChatThreadState value, $Res Function(_ChatThreadState) _then) = __$ChatThreadStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, Conversation? conversation, List<ChatMessage> messages, bool otherTyping, String? error
});


@override $ConversationCopyWith<$Res>? get conversation;

}
/// @nodoc
class __$ChatThreadStateCopyWithImpl<$Res>
    implements _$ChatThreadStateCopyWith<$Res> {
  __$ChatThreadStateCopyWithImpl(this._self, this._then);

  final _ChatThreadState _self;
  final $Res Function(_ChatThreadState) _then;

/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? conversation = freezed,Object? messages = null,Object? otherTyping = null,Object? error = freezed,}) {
  return _then(_ChatThreadState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,conversation: freezed == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as Conversation?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,otherTyping: null == otherTyping ? _self.otherTyping : otherTyping // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChatThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConversationCopyWith<$Res>? get conversation {
    if (_self.conversation == null) {
    return null;
  }

  return $ConversationCopyWith<$Res>(_self.conversation!, (value) {
    return _then(_self.copyWith(conversation: value));
  });
}
}

// dart format on
