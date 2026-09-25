// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversations_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ConversationsEvent()';
}


}

/// @nodoc
class $ConversationsEventCopyWith<$Res>  {
$ConversationsEventCopyWith(ConversationsEvent _, $Res Function(ConversationsEvent) __);
}


/// Adds pattern-matching-related methods to [ConversationsEvent].
extension ConversationsEventPatterns on ConversationsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConversationsLoad value)?  load,TResult Function( ConversationsSelected value)?  selected,TResult Function( ConversationsQueryChanged value)?  queryChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConversationsLoad() when load != null:
return load(_that);case ConversationsSelected() when selected != null:
return selected(_that);case ConversationsQueryChanged() when queryChanged != null:
return queryChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConversationsLoad value)  load,required TResult Function( ConversationsSelected value)  selected,required TResult Function( ConversationsQueryChanged value)  queryChanged,}){
final _that = this;
switch (_that) {
case ConversationsLoad():
return load(_that);case ConversationsSelected():
return selected(_that);case ConversationsQueryChanged():
return queryChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConversationsLoad value)?  load,TResult? Function( ConversationsSelected value)?  selected,TResult? Function( ConversationsQueryChanged value)?  queryChanged,}){
final _that = this;
switch (_that) {
case ConversationsLoad() when load != null:
return load(_that);case ConversationsSelected() when selected != null:
return selected(_that);case ConversationsQueryChanged() when queryChanged != null:
return queryChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool asProfessional)?  load,TResult Function( String id)?  selected,TResult Function( String query)?  queryChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConversationsLoad() when load != null:
return load(_that.asProfessional);case ConversationsSelected() when selected != null:
return selected(_that.id);case ConversationsQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool asProfessional)  load,required TResult Function( String id)  selected,required TResult Function( String query)  queryChanged,}) {final _that = this;
switch (_that) {
case ConversationsLoad():
return load(_that.asProfessional);case ConversationsSelected():
return selected(_that.id);case ConversationsQueryChanged():
return queryChanged(_that.query);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool asProfessional)?  load,TResult? Function( String id)?  selected,TResult? Function( String query)?  queryChanged,}) {final _that = this;
switch (_that) {
case ConversationsLoad() when load != null:
return load(_that.asProfessional);case ConversationsSelected() when selected != null:
return selected(_that.id);case ConversationsQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class ConversationsLoad implements ConversationsEvent {
  const ConversationsLoad({required this.asProfessional});
  

 final  bool asProfessional;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsLoadCopyWith<ConversationsLoad> get copyWith => _$ConversationsLoadCopyWithImpl<ConversationsLoad>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsLoad&&(identical(other.asProfessional, asProfessional) || other.asProfessional == asProfessional));
}


@override
int get hashCode {
    return Object.hash(runtimeType,asProfessional);
}

@override
String toString() {
    return 'ConversationsEvent.load(asProfessional: $asProfessional)';
}


}

/// @nodoc
abstract mixin class $ConversationsLoadCopyWith<$Res> implements $ConversationsEventCopyWith<$Res> {
  factory $ConversationsLoadCopyWith(ConversationsLoad value, $Res Function(ConversationsLoad) _then) = _$ConversationsLoadCopyWithImpl;
@useResult
$Res call({
 bool asProfessional
});




}
/// @nodoc
class _$ConversationsLoadCopyWithImpl<$Res>
    implements $ConversationsLoadCopyWith<$Res> {
  _$ConversationsLoadCopyWithImpl(this._self, this._then);

  final ConversationsLoad _self;
  final $Res Function(ConversationsLoad) _then;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? asProfessional = null,}) {
  return _then(ConversationsLoad(
asProfessional: null == asProfessional ? _self.asProfessional : asProfessional // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ConversationsSelected implements ConversationsEvent {
  const ConversationsSelected(this.id);
  

 final  String id;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsSelectedCopyWith<ConversationsSelected> get copyWith => _$ConversationsSelectedCopyWithImpl<ConversationsSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsSelected&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'ConversationsEvent.selected(id: $id)';
}


}

/// @nodoc
abstract mixin class $ConversationsSelectedCopyWith<$Res> implements $ConversationsEventCopyWith<$Res> {
  factory $ConversationsSelectedCopyWith(ConversationsSelected value, $Res Function(ConversationsSelected) _then) = _$ConversationsSelectedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ConversationsSelectedCopyWithImpl<$Res>
    implements $ConversationsSelectedCopyWith<$Res> {
  _$ConversationsSelectedCopyWithImpl(this._self, this._then);

  final ConversationsSelected _self;
  final $Res Function(ConversationsSelected) _then;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ConversationsSelected(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ConversationsQueryChanged implements ConversationsEvent {
  const ConversationsQueryChanged(this.query);
  

 final  String query;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsQueryChangedCopyWith<ConversationsQueryChanged> get copyWith => _$ConversationsQueryChangedCopyWithImpl<ConversationsQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'ConversationsEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $ConversationsQueryChangedCopyWith<$Res> implements $ConversationsEventCopyWith<$Res> {
  factory $ConversationsQueryChangedCopyWith(ConversationsQueryChanged value, $Res Function(ConversationsQueryChanged) _then) = _$ConversationsQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$ConversationsQueryChangedCopyWithImpl<$Res>
    implements $ConversationsQueryChangedCopyWith<$Res> {
  _$ConversationsQueryChangedCopyWithImpl(this._self, this._then);

  final ConversationsQueryChanged _self;
  final $Res Function(ConversationsQueryChanged) _then;

/// Create a copy of ConversationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(ConversationsQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ConversationsState {

 LoadStatus get status; List<Conversation> get conversations; String? get selectedId; String get query; String? get error;
/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationsStateCopyWith<ConversationsState> get copyWith => _$ConversationsStateCopyWithImpl<ConversationsState>(this as ConversationsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ConversationsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.conversations, _this.conversations)&&(identical(other.selectedId, _this.selectedId) || other.selectedId == _this.selectedId)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ConversationsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.conversations),_this.selectedId,_this.query,_this.error);
}

@override
String toString() {
  final _this = this as ConversationsState;
  return 'ConversationsState(status: ${_this.status}, conversations: ${_this.conversations}, selectedId: ${_this.selectedId}, query: ${_this.query}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ConversationsStateCopyWith<$Res>  {
  factory $ConversationsStateCopyWith(ConversationsState value, $Res Function(ConversationsState) _then) = _$ConversationsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Conversation> conversations, String? selectedId, String query, String? error
});




}
/// @nodoc
class _$ConversationsStateCopyWithImpl<$Res>
    implements $ConversationsStateCopyWith<$Res> {
  _$ConversationsStateCopyWithImpl(this._self, this._then);

  final ConversationsState _self;
  final $Res Function(ConversationsState) _then;

/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? conversations = null,Object? selectedId = freezed,Object? query = null,Object? error = freezed,}) {
  return _then(ConversationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,conversations: null == conversations ? _self.conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationsState].
extension ConversationsStatePatterns on ConversationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationsState value)  $default,){
final _that = this;
switch (_that) {
case _ConversationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationsState value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Conversation> conversations,  String? selectedId,  String query,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationsState() when $default != null:
return $default(_that.status,_that.conversations,_that.selectedId,_that.query,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Conversation> conversations,  String? selectedId,  String query,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ConversationsState():
return $default(_that.status,_that.conversations,_that.selectedId,_that.query,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Conversation> conversations,  String? selectedId,  String query,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ConversationsState() when $default != null:
return $default(_that.status,_that.conversations,_that.selectedId,_that.query,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationsState extends ConversationsState {
  const _ConversationsState({this.status = LoadStatus.initial,  List<Conversation> conversations = const <Conversation>[], this.selectedId, this.query = '', this.error}): _conversations = conversations,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<Conversation> _conversations;
@override@JsonKey() List<Conversation> get conversations {
  if (_conversations is EqualUnmodifiableListView) return _conversations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversations);
}

@override final  String? selectedId;
@override@JsonKey() final  String query;
@override final  String? error;

/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationsStateCopyWith<_ConversationsState> get copyWith => __$ConversationsStateCopyWithImpl<_ConversationsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.conversations, _conversations)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.query, query) || other.query == query)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_conversations),selectedId,query,error);
}

@override
String toString() {
    return 'ConversationsState(status: $status, conversations: $conversations, selectedId: $selectedId, query: $query, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ConversationsStateCopyWith<$Res> implements $ConversationsStateCopyWith<$Res> {
  factory _$ConversationsStateCopyWith(_ConversationsState value, $Res Function(_ConversationsState) _then) = __$ConversationsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Conversation> conversations, String? selectedId, String query, String? error
});




}
/// @nodoc
class __$ConversationsStateCopyWithImpl<$Res>
    implements _$ConversationsStateCopyWith<$Res> {
  __$ConversationsStateCopyWithImpl(this._self, this._then);

  final _ConversationsState _self;
  final $Res Function(_ConversationsState) _then;

/// Create a copy of ConversationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? conversations = null,Object? selectedId = freezed,Object? query = null,Object? error = freezed,}) {
  return _then(_ConversationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,conversations: null == conversations ? _self._conversations : conversations // ignore: cast_nullable_to_non_nullable
as List<Conversation>,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
