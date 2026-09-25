// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clients_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientsState {

 LoadStatus get status; List<Client> get clients; String get query; String? get selectedId;
/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientsStateCopyWith<ClientsState> get copyWith => _$ClientsStateCopyWithImpl<ClientsState>(this as ClientsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.clients, _this.clients)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.selectedId, _this.selectedId) || other.selectedId == _this.selectedId));
}


@override
int get hashCode {
  final _this = this as ClientsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.clients),_this.query,_this.selectedId);
}

@override
String toString() {
  final _this = this as ClientsState;
  return 'ClientsState(status: ${_this.status}, clients: ${_this.clients}, query: ${_this.query}, selectedId: ${_this.selectedId})';
}


}

/// @nodoc
abstract mixin class $ClientsStateCopyWith<$Res>  {
  factory $ClientsStateCopyWith(ClientsState value, $Res Function(ClientsState) _then) = _$ClientsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Client> clients, String query, String? selectedId
});




}
/// @nodoc
class _$ClientsStateCopyWithImpl<$Res>
    implements $ClientsStateCopyWith<$Res> {
  _$ClientsStateCopyWithImpl(this._self, this._then);

  final ClientsState _self;
  final $Res Function(ClientsState) _then;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? clients = null,Object? query = null,Object? selectedId = freezed,}) {
  return _then(ClientsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,clients: null == clients ? _self.clients : clients // ignore: cast_nullable_to_non_nullable
as List<Client>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientsState].
extension ClientsStatePatterns on ClientsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientsState value)  $default,){
final _that = this;
switch (_that) {
case _ClientsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientsState value)?  $default,){
final _that = this;
switch (_that) {
case _ClientsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Client> clients,  String query,  String? selectedId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientsState() when $default != null:
return $default(_that.status,_that.clients,_that.query,_that.selectedId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Client> clients,  String query,  String? selectedId)  $default,) {final _that = this;
switch (_that) {
case _ClientsState():
return $default(_that.status,_that.clients,_that.query,_that.selectedId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Client> clients,  String query,  String? selectedId)?  $default,) {final _that = this;
switch (_that) {
case _ClientsState() when $default != null:
return $default(_that.status,_that.clients,_that.query,_that.selectedId);case _:
  return null;

}
}

}

/// @nodoc


class _ClientsState extends ClientsState {
  const _ClientsState({this.status = LoadStatus.initial,  List<Client> clients = const <Client>[], this.query = '', this.selectedId}): _clients = clients,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<Client> _clients;
@override@JsonKey() List<Client> get clients {
  if (_clients is EqualUnmodifiableListView) return _clients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clients);
}

@override@JsonKey() final  String query;
@override final  String? selectedId;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientsStateCopyWith<_ClientsState> get copyWith => __$ClientsStateCopyWithImpl<_ClientsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.clients, _clients)&&(identical(other.query, query) || other.query == query)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_clients),query,selectedId);
}

@override
String toString() {
    return 'ClientsState(status: $status, clients: $clients, query: $query, selectedId: $selectedId)';
}


}

/// @nodoc
abstract mixin class _$ClientsStateCopyWith<$Res> implements $ClientsStateCopyWith<$Res> {
  factory _$ClientsStateCopyWith(_ClientsState value, $Res Function(_ClientsState) _then) = __$ClientsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Client> clients, String query, String? selectedId
});




}
/// @nodoc
class __$ClientsStateCopyWithImpl<$Res>
    implements _$ClientsStateCopyWith<$Res> {
  __$ClientsStateCopyWithImpl(this._self, this._then);

  final _ClientsState _self;
  final $Res Function(_ClientsState) _then;

/// Create a copy of ClientsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? clients = null,Object? query = null,Object? selectedId = freezed,}) {
  return _then(_ClientsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,clients: null == clients ? _self._clients : clients // ignore: cast_nullable_to_non_nullable
as List<Client>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ClientDetailState {

 LoadStatus get status; ClientDetail? get detail; ClientDetailTab get tab; bool get savingNote;
/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientDetailStateCopyWith<ClientDetailState> get copyWith => _$ClientDetailStateCopyWithImpl<ClientDetailState>(this as ClientDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ClientDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.detail, _this.detail) || other.detail == _this.detail)&&(identical(other.tab, _this.tab) || other.tab == _this.tab)&&(identical(other.savingNote, _this.savingNote) || other.savingNote == _this.savingNote));
}


@override
int get hashCode {
  final _this = this as ClientDetailState;
  return Object.hash(runtimeType,_this.status,_this.detail,_this.tab,_this.savingNote);
}

@override
String toString() {
  final _this = this as ClientDetailState;
  return 'ClientDetailState(status: ${_this.status}, detail: ${_this.detail}, tab: ${_this.tab}, savingNote: ${_this.savingNote})';
}


}

/// @nodoc
abstract mixin class $ClientDetailStateCopyWith<$Res>  {
  factory $ClientDetailStateCopyWith(ClientDetailState value, $Res Function(ClientDetailState) _then) = _$ClientDetailStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, ClientDetail? detail, ClientDetailTab tab, bool savingNote
});


$ClientDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$ClientDetailStateCopyWithImpl<$Res>
    implements $ClientDetailStateCopyWith<$Res> {
  _$ClientDetailStateCopyWithImpl(this._self, this._then);

  final ClientDetailState _self;
  final $Res Function(ClientDetailState) _then;

/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? detail = freezed,Object? tab = null,Object? savingNote = null,}) {
  return _then(ClientDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ClientDetail?,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ClientDetailTab,savingNote: null == savingNote ? _self.savingNote : savingNote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ClientDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientDetailState].
extension ClientDetailStatePatterns on ClientDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientDetailState value)  $default,){
final _that = this;
switch (_that) {
case _ClientDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _ClientDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  ClientDetail? detail,  ClientDetailTab tab,  bool savingNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.tab,_that.savingNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  ClientDetail? detail,  ClientDetailTab tab,  bool savingNote)  $default,) {final _that = this;
switch (_that) {
case _ClientDetailState():
return $default(_that.status,_that.detail,_that.tab,_that.savingNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  ClientDetail? detail,  ClientDetailTab tab,  bool savingNote)?  $default,) {final _that = this;
switch (_that) {
case _ClientDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.tab,_that.savingNote);case _:
  return null;

}
}

}

/// @nodoc


class _ClientDetailState implements ClientDetailState {
  const _ClientDetailState({this.status = LoadStatus.initial, this.detail, this.tab = ClientDetailTab.notes, this.savingNote = false});
  

@override@JsonKey() final  LoadStatus status;
@override final  ClientDetail? detail;
@override@JsonKey() final  ClientDetailTab tab;
@override@JsonKey() final  bool savingNote;

/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientDetailStateCopyWith<_ClientDetailState> get copyWith => __$ClientDetailStateCopyWithImpl<_ClientDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.savingNote, savingNote) || other.savingNote == savingNote));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,detail,tab,savingNote);
}

@override
String toString() {
    return 'ClientDetailState(status: $status, detail: $detail, tab: $tab, savingNote: $savingNote)';
}


}

/// @nodoc
abstract mixin class _$ClientDetailStateCopyWith<$Res> implements $ClientDetailStateCopyWith<$Res> {
  factory _$ClientDetailStateCopyWith(_ClientDetailState value, $Res Function(_ClientDetailState) _then) = __$ClientDetailStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, ClientDetail? detail, ClientDetailTab tab, bool savingNote
});


@override $ClientDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$ClientDetailStateCopyWithImpl<$Res>
    implements _$ClientDetailStateCopyWith<$Res> {
  __$ClientDetailStateCopyWithImpl(this._self, this._then);

  final _ClientDetailState _self;
  final $Res Function(_ClientDetailState) _then;

/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? detail = freezed,Object? tab = null,Object? savingNote = null,}) {
  return _then(_ClientDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ClientDetail?,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as ClientDetailTab,savingNote: null == savingNote ? _self.savingNote : savingNote // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ClientDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $ClientDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

// dart format on
