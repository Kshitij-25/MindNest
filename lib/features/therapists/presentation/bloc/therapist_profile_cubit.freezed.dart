// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapist_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TherapistProfileState {

 LoadStatus get status; Therapist? get therapist; List<Review> get reviews; List<DayAvailability> get availability; String? get error;
/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TherapistProfileStateCopyWith<TherapistProfileState> get copyWith => _$TherapistProfileStateCopyWithImpl<TherapistProfileState>(this as TherapistProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TherapistProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TherapistProfileState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.therapist, _this.therapist) || other.therapist == _this.therapist)&&const DeepCollectionEquality().equals(other.reviews, _this.reviews)&&const DeepCollectionEquality().equals(other.availability, _this.availability)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as TherapistProfileState;
  return Object.hash(runtimeType,_this.status,_this.therapist,const DeepCollectionEquality().hash(_this.reviews),const DeepCollectionEquality().hash(_this.availability),_this.error);
}

@override
String toString() {
  final _this = this as TherapistProfileState;
  return 'TherapistProfileState(status: ${_this.status}, therapist: ${_this.therapist}, reviews: ${_this.reviews}, availability: ${_this.availability}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $TherapistProfileStateCopyWith<$Res>  {
  factory $TherapistProfileStateCopyWith(TherapistProfileState value, $Res Function(TherapistProfileState) _then) = _$TherapistProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, Therapist? therapist, List<Review> reviews, List<DayAvailability> availability, String? error
});


$TherapistCopyWith<$Res>? get therapist;

}
/// @nodoc
class _$TherapistProfileStateCopyWithImpl<$Res>
    implements $TherapistProfileStateCopyWith<$Res> {
  _$TherapistProfileStateCopyWithImpl(this._self, this._then);

  final TherapistProfileState _self;
  final $Res Function(TherapistProfileState) _then;

/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? therapist = freezed,Object? reviews = null,Object? availability = null,Object? error = freezed,}) {
  return _then(TherapistProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapist: freezed == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist?,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as List<DayAvailability>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistCopyWith<$Res>? get therapist {
    if (_self.therapist == null) {
    return null;
  }

  return $TherapistCopyWith<$Res>(_self.therapist!, (value) {
    return _then(_self.copyWith(therapist: value));
  });
}
}


/// Adds pattern-matching-related methods to [TherapistProfileState].
extension TherapistProfileStatePatterns on TherapistProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TherapistProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TherapistProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TherapistProfileState value)  $default,){
final _that = this;
switch (_that) {
case _TherapistProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TherapistProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _TherapistProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  Therapist? therapist,  List<Review> reviews,  List<DayAvailability> availability,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TherapistProfileState() when $default != null:
return $default(_that.status,_that.therapist,_that.reviews,_that.availability,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  Therapist? therapist,  List<Review> reviews,  List<DayAvailability> availability,  String? error)  $default,) {final _that = this;
switch (_that) {
case _TherapistProfileState():
return $default(_that.status,_that.therapist,_that.reviews,_that.availability,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  Therapist? therapist,  List<Review> reviews,  List<DayAvailability> availability,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _TherapistProfileState() when $default != null:
return $default(_that.status,_that.therapist,_that.reviews,_that.availability,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TherapistProfileState implements TherapistProfileState {
  const _TherapistProfileState({this.status = LoadStatus.initial, this.therapist,  List<Review> reviews = const <Review>[],  List<DayAvailability> availability = const <DayAvailability>[], this.error}): _reviews = reviews,_availability = availability;
  

@override@JsonKey() final  LoadStatus status;
@override final  Therapist? therapist;
 final  List<Review> _reviews;
@override@JsonKey() List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<DayAvailability> _availability;
@override@JsonKey() List<DayAvailability> get availability {
  if (_availability is EqualUnmodifiableListView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availability);
}

@override final  String? error;

/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TherapistProfileStateCopyWith<_TherapistProfileState> get copyWith => __$TherapistProfileStateCopyWithImpl<_TherapistProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TherapistProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.therapist, therapist) || other.therapist == therapist)&&const DeepCollectionEquality().equals(other.reviews, _reviews)&&const DeepCollectionEquality().equals(other.availability, _availability)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,therapist,const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_availability),error);
}

@override
String toString() {
    return 'TherapistProfileState(status: $status, therapist: $therapist, reviews: $reviews, availability: $availability, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TherapistProfileStateCopyWith<$Res> implements $TherapistProfileStateCopyWith<$Res> {
  factory _$TherapistProfileStateCopyWith(_TherapistProfileState value, $Res Function(_TherapistProfileState) _then) = __$TherapistProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, Therapist? therapist, List<Review> reviews, List<DayAvailability> availability, String? error
});


@override $TherapistCopyWith<$Res>? get therapist;

}
/// @nodoc
class __$TherapistProfileStateCopyWithImpl<$Res>
    implements _$TherapistProfileStateCopyWith<$Res> {
  __$TherapistProfileStateCopyWithImpl(this._self, this._then);

  final _TherapistProfileState _self;
  final $Res Function(_TherapistProfileState) _then;

/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? therapist = freezed,Object? reviews = null,Object? availability = null,Object? error = freezed,}) {
  return _then(_TherapistProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapist: freezed == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist?,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,availability: null == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as List<DayAvailability>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TherapistProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistCopyWith<$Res>? get therapist {
    if (_self.therapist == null) {
    return null;
  }

  return $TherapistCopyWith<$Res>(_self.therapist!, (value) {
    return _then(_self.copyWith(therapist: value));
  });
}
}

// dart format on
