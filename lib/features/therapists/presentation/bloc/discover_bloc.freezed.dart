// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discover_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiscoverEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiscoverEvent()';
}


}

/// @nodoc
class $DiscoverEventCopyWith<$Res>  {
$DiscoverEventCopyWith(DiscoverEvent _, $Res Function(DiscoverEvent) __);
}


/// Adds pattern-matching-related methods to [DiscoverEvent].
extension DiscoverEventPatterns on DiscoverEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DiscoverStarted value)?  started,TResult Function( DiscoverQueryChanged value)?  queryChanged,TResult Function( DiscoverSpecialtySelected value)?  specialtySelected,TResult Function( DiscoverFilterApplied value)?  filterApplied,TResult Function( DiscoverCleared value)?  cleared,TResult Function( DiscoverSavedToggled value)?  savedToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DiscoverStarted() when started != null:
return started(_that);case DiscoverQueryChanged() when queryChanged != null:
return queryChanged(_that);case DiscoverSpecialtySelected() when specialtySelected != null:
return specialtySelected(_that);case DiscoverFilterApplied() when filterApplied != null:
return filterApplied(_that);case DiscoverCleared() when cleared != null:
return cleared(_that);case DiscoverSavedToggled() when savedToggled != null:
return savedToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DiscoverStarted value)  started,required TResult Function( DiscoverQueryChanged value)  queryChanged,required TResult Function( DiscoverSpecialtySelected value)  specialtySelected,required TResult Function( DiscoverFilterApplied value)  filterApplied,required TResult Function( DiscoverCleared value)  cleared,required TResult Function( DiscoverSavedToggled value)  savedToggled,}){
final _that = this;
switch (_that) {
case DiscoverStarted():
return started(_that);case DiscoverQueryChanged():
return queryChanged(_that);case DiscoverSpecialtySelected():
return specialtySelected(_that);case DiscoverFilterApplied():
return filterApplied(_that);case DiscoverCleared():
return cleared(_that);case DiscoverSavedToggled():
return savedToggled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DiscoverStarted value)?  started,TResult? Function( DiscoverQueryChanged value)?  queryChanged,TResult? Function( DiscoverSpecialtySelected value)?  specialtySelected,TResult? Function( DiscoverFilterApplied value)?  filterApplied,TResult? Function( DiscoverCleared value)?  cleared,TResult? Function( DiscoverSavedToggled value)?  savedToggled,}){
final _that = this;
switch (_that) {
case DiscoverStarted() when started != null:
return started(_that);case DiscoverQueryChanged() when queryChanged != null:
return queryChanged(_that);case DiscoverSpecialtySelected() when specialtySelected != null:
return specialtySelected(_that);case DiscoverFilterApplied() when filterApplied != null:
return filterApplied(_that);case DiscoverCleared() when cleared != null:
return cleared(_that);case DiscoverSavedToggled() when savedToggled != null:
return savedToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  queryChanged,TResult Function( String specialty)?  specialtySelected,TResult Function( TherapistFilter filter)?  filterApplied,TResult Function()?  cleared,TResult Function( String id)?  savedToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DiscoverStarted() when started != null:
return started();case DiscoverQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case DiscoverSpecialtySelected() when specialtySelected != null:
return specialtySelected(_that.specialty);case DiscoverFilterApplied() when filterApplied != null:
return filterApplied(_that.filter);case DiscoverCleared() when cleared != null:
return cleared();case DiscoverSavedToggled() when savedToggled != null:
return savedToggled(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  queryChanged,required TResult Function( String specialty)  specialtySelected,required TResult Function( TherapistFilter filter)  filterApplied,required TResult Function()  cleared,required TResult Function( String id)  savedToggled,}) {final _that = this;
switch (_that) {
case DiscoverStarted():
return started();case DiscoverQueryChanged():
return queryChanged(_that.query);case DiscoverSpecialtySelected():
return specialtySelected(_that.specialty);case DiscoverFilterApplied():
return filterApplied(_that.filter);case DiscoverCleared():
return cleared();case DiscoverSavedToggled():
return savedToggled(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  queryChanged,TResult? Function( String specialty)?  specialtySelected,TResult? Function( TherapistFilter filter)?  filterApplied,TResult? Function()?  cleared,TResult? Function( String id)?  savedToggled,}) {final _that = this;
switch (_that) {
case DiscoverStarted() when started != null:
return started();case DiscoverQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case DiscoverSpecialtySelected() when specialtySelected != null:
return specialtySelected(_that.specialty);case DiscoverFilterApplied() when filterApplied != null:
return filterApplied(_that.filter);case DiscoverCleared() when cleared != null:
return cleared();case DiscoverSavedToggled() when savedToggled != null:
return savedToggled(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class DiscoverStarted implements DiscoverEvent {
  const DiscoverStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiscoverEvent.started()';
}


}




/// @nodoc


class DiscoverQueryChanged implements DiscoverEvent {
  const DiscoverQueryChanged(this.query);
  

 final  String query;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverQueryChangedCopyWith<DiscoverQueryChanged> get copyWith => _$DiscoverQueryChangedCopyWithImpl<DiscoverQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'DiscoverEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $DiscoverQueryChangedCopyWith<$Res> implements $DiscoverEventCopyWith<$Res> {
  factory $DiscoverQueryChangedCopyWith(DiscoverQueryChanged value, $Res Function(DiscoverQueryChanged) _then) = _$DiscoverQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$DiscoverQueryChangedCopyWithImpl<$Res>
    implements $DiscoverQueryChangedCopyWith<$Res> {
  _$DiscoverQueryChangedCopyWithImpl(this._self, this._then);

  final DiscoverQueryChanged _self;
  final $Res Function(DiscoverQueryChanged) _then;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(DiscoverQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DiscoverSpecialtySelected implements DiscoverEvent {
  const DiscoverSpecialtySelected(this.specialty);
  

 final  String specialty;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverSpecialtySelectedCopyWith<DiscoverSpecialtySelected> get copyWith => _$DiscoverSpecialtySelectedCopyWithImpl<DiscoverSpecialtySelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverSpecialtySelected&&(identical(other.specialty, specialty) || other.specialty == specialty));
}


@override
int get hashCode {
    return Object.hash(runtimeType,specialty);
}

@override
String toString() {
    return 'DiscoverEvent.specialtySelected(specialty: $specialty)';
}


}

/// @nodoc
abstract mixin class $DiscoverSpecialtySelectedCopyWith<$Res> implements $DiscoverEventCopyWith<$Res> {
  factory $DiscoverSpecialtySelectedCopyWith(DiscoverSpecialtySelected value, $Res Function(DiscoverSpecialtySelected) _then) = _$DiscoverSpecialtySelectedCopyWithImpl;
@useResult
$Res call({
 String specialty
});




}
/// @nodoc
class _$DiscoverSpecialtySelectedCopyWithImpl<$Res>
    implements $DiscoverSpecialtySelectedCopyWith<$Res> {
  _$DiscoverSpecialtySelectedCopyWithImpl(this._self, this._then);

  final DiscoverSpecialtySelected _self;
  final $Res Function(DiscoverSpecialtySelected) _then;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? specialty = null,}) {
  return _then(DiscoverSpecialtySelected(
null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DiscoverFilterApplied implements DiscoverEvent {
  const DiscoverFilterApplied(this.filter);
  

 final  TherapistFilter filter;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverFilterAppliedCopyWith<DiscoverFilterApplied> get copyWith => _$DiscoverFilterAppliedCopyWithImpl<DiscoverFilterApplied>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverFilterApplied&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filter);
}

@override
String toString() {
    return 'DiscoverEvent.filterApplied(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $DiscoverFilterAppliedCopyWith<$Res> implements $DiscoverEventCopyWith<$Res> {
  factory $DiscoverFilterAppliedCopyWith(DiscoverFilterApplied value, $Res Function(DiscoverFilterApplied) _then) = _$DiscoverFilterAppliedCopyWithImpl;
@useResult
$Res call({
 TherapistFilter filter
});


$TherapistFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$DiscoverFilterAppliedCopyWithImpl<$Res>
    implements $DiscoverFilterAppliedCopyWith<$Res> {
  _$DiscoverFilterAppliedCopyWithImpl(this._self, this._then);

  final DiscoverFilterApplied _self;
  final $Res Function(DiscoverFilterApplied) _then;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(DiscoverFilterApplied(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TherapistFilter,
  ));
}

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistFilterCopyWith<$Res> get filter {
  
  return $TherapistFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

/// @nodoc


class DiscoverCleared implements DiscoverEvent {
  const DiscoverCleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'DiscoverEvent.cleared()';
}


}




/// @nodoc


class DiscoverSavedToggled implements DiscoverEvent {
  const DiscoverSavedToggled(this.id);
  

 final  String id;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverSavedToggledCopyWith<DiscoverSavedToggled> get copyWith => _$DiscoverSavedToggledCopyWithImpl<DiscoverSavedToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverSavedToggled&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'DiscoverEvent.savedToggled(id: $id)';
}


}

/// @nodoc
abstract mixin class $DiscoverSavedToggledCopyWith<$Res> implements $DiscoverEventCopyWith<$Res> {
  factory $DiscoverSavedToggledCopyWith(DiscoverSavedToggled value, $Res Function(DiscoverSavedToggled) _then) = _$DiscoverSavedToggledCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DiscoverSavedToggledCopyWithImpl<$Res>
    implements $DiscoverSavedToggledCopyWith<$Res> {
  _$DiscoverSavedToggledCopyWithImpl(this._self, this._then);

  final DiscoverSavedToggled _self;
  final $Res Function(DiscoverSavedToggled) _then;

/// Create a copy of DiscoverEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DiscoverSavedToggled(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DiscoverState {

 LoadStatus get status; List<Therapist> get therapists; TherapistFilter get filter; String? get error;
/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverStateCopyWith<DiscoverState> get copyWith => _$DiscoverStateCopyWithImpl<DiscoverState>(this as DiscoverState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiscoverState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.therapists, _this.therapists)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as DiscoverState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.therapists),_this.filter,_this.error);
}

@override
String toString() {
  final _this = this as DiscoverState;
  return 'DiscoverState(status: ${_this.status}, therapists: ${_this.therapists}, filter: ${_this.filter}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $DiscoverStateCopyWith<$Res>  {
  factory $DiscoverStateCopyWith(DiscoverState value, $Res Function(DiscoverState) _then) = _$DiscoverStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Therapist> therapists, TherapistFilter filter, String? error
});


$TherapistFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$DiscoverStateCopyWithImpl<$Res>
    implements $DiscoverStateCopyWith<$Res> {
  _$DiscoverStateCopyWithImpl(this._self, this._then);

  final DiscoverState _self;
  final $Res Function(DiscoverState) _then;

/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? therapists = null,Object? filter = null,Object? error = freezed,}) {
  return _then(DiscoverState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapists: null == therapists ? _self.therapists : therapists // ignore: cast_nullable_to_non_nullable
as List<Therapist>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TherapistFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistFilterCopyWith<$Res> get filter {
  
  return $TherapistFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiscoverState].
extension DiscoverStatePatterns on DiscoverState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoverState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoverState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoverState value)  $default,){
final _that = this;
switch (_that) {
case _DiscoverState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoverState value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoverState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Therapist> therapists,  TherapistFilter filter,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoverState() when $default != null:
return $default(_that.status,_that.therapists,_that.filter,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Therapist> therapists,  TherapistFilter filter,  String? error)  $default,) {final _that = this;
switch (_that) {
case _DiscoverState():
return $default(_that.status,_that.therapists,_that.filter,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Therapist> therapists,  TherapistFilter filter,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _DiscoverState() when $default != null:
return $default(_that.status,_that.therapists,_that.filter,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DiscoverState implements DiscoverState {
  const _DiscoverState({this.status = LoadStatus.initial,  List<Therapist> therapists = const <Therapist>[], this.filter = const TherapistFilter(), this.error}): _therapists = therapists;
  

@override@JsonKey() final  LoadStatus status;
 final  List<Therapist> _therapists;
@override@JsonKey() List<Therapist> get therapists {
  if (_therapists is EqualUnmodifiableListView) return _therapists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_therapists);
}

@override@JsonKey() final  TherapistFilter filter;
@override final  String? error;

/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverStateCopyWith<_DiscoverState> get copyWith => __$DiscoverStateCopyWithImpl<_DiscoverState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.therapists, _therapists)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_therapists),filter,error);
}

@override
String toString() {
    return 'DiscoverState(status: $status, therapists: $therapists, filter: $filter, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DiscoverStateCopyWith<$Res> implements $DiscoverStateCopyWith<$Res> {
  factory _$DiscoverStateCopyWith(_DiscoverState value, $Res Function(_DiscoverState) _then) = __$DiscoverStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Therapist> therapists, TherapistFilter filter, String? error
});


@override $TherapistFilterCopyWith<$Res> get filter;

}
/// @nodoc
class __$DiscoverStateCopyWithImpl<$Res>
    implements _$DiscoverStateCopyWith<$Res> {
  __$DiscoverStateCopyWithImpl(this._self, this._then);

  final _DiscoverState _self;
  final $Res Function(_DiscoverState) _then;

/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? therapists = null,Object? filter = null,Object? error = freezed,}) {
  return _then(_DiscoverState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapists: null == therapists ? _self._therapists : therapists // ignore: cast_nullable_to_non_nullable
as List<Therapist>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TherapistFilter,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DiscoverState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistFilterCopyWith<$Res> get filter {
  
  return $TherapistFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on
