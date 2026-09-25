// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState {

 LoadStatus get status; Therapist? get therapist; List<BookingDay> get days; int get dayIndex; DateTime? get slot; SessionType get type; Recurrence get recurrence; Set<Reminder> get reminders; bool get submitting; Appointment? get booked; String? get error; String? get rescheduleOf;
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateCopyWith<BookingState> get copyWith => _$BookingStateCopyWithImpl<BookingState>(this as BookingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BookingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.therapist, _this.therapist) || other.therapist == _this.therapist)&&const DeepCollectionEquality().equals(other.days, _this.days)&&(identical(other.dayIndex, _this.dayIndex) || other.dayIndex == _this.dayIndex)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&const DeepCollectionEquality().equals(other.reminders, _this.reminders)&&(identical(other.submitting, _this.submitting) || other.submitting == _this.submitting)&&(identical(other.booked, _this.booked) || other.booked == _this.booked)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.rescheduleOf, _this.rescheduleOf) || other.rescheduleOf == _this.rescheduleOf));
}


@override
int get hashCode {
  final _this = this as BookingState;
  return Object.hash(runtimeType,_this.status,_this.therapist,const DeepCollectionEquality().hash(_this.days),_this.dayIndex,_this.slot,_this.type,_this.recurrence,const DeepCollectionEquality().hash(_this.reminders),_this.submitting,_this.booked,_this.error,_this.rescheduleOf);
}

@override
String toString() {
  final _this = this as BookingState;
  return 'BookingState(status: ${_this.status}, therapist: ${_this.therapist}, days: ${_this.days}, dayIndex: ${_this.dayIndex}, slot: ${_this.slot}, type: ${_this.type}, recurrence: ${_this.recurrence}, reminders: ${_this.reminders}, submitting: ${_this.submitting}, booked: ${_this.booked}, error: ${_this.error}, rescheduleOf: ${_this.rescheduleOf})';
}


}

/// @nodoc
abstract mixin class $BookingStateCopyWith<$Res>  {
  factory $BookingStateCopyWith(BookingState value, $Res Function(BookingState) _then) = _$BookingStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, Therapist? therapist, List<BookingDay> days, int dayIndex, DateTime? slot, SessionType type, Recurrence recurrence, Set<Reminder> reminders, bool submitting, Appointment? booked, String? error, String? rescheduleOf
});


$TherapistCopyWith<$Res>? get therapist;$AppointmentCopyWith<$Res>? get booked;

}
/// @nodoc
class _$BookingStateCopyWithImpl<$Res>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._self, this._then);

  final BookingState _self;
  final $Res Function(BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? therapist = freezed,Object? days = null,Object? dayIndex = null,Object? slot = freezed,Object? type = null,Object? recurrence = null,Object? reminders = null,Object? submitting = null,Object? booked = freezed,Object? error = freezed,Object? rescheduleOf = freezed,}) {
  return _then(BookingState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapist: freezed == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<BookingDay>,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,slot: freezed == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DateTime?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,booked: freezed == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as Appointment?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,rescheduleOf: freezed == rescheduleOf ? _self.rescheduleOf : rescheduleOf // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookingState
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
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppointmentCopyWith<$Res>? get booked {
    if (_self.booked == null) {
    return null;
  }

  return $AppointmentCopyWith<$Res>(_self.booked!, (value) {
    return _then(_self.copyWith(booked: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingState value)  $default,){
final _that = this;
switch (_that) {
case _BookingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  Therapist? therapist,  List<BookingDay> days,  int dayIndex,  DateTime? slot,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  bool submitting,  Appointment? booked,  String? error,  String? rescheduleOf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.status,_that.therapist,_that.days,_that.dayIndex,_that.slot,_that.type,_that.recurrence,_that.reminders,_that.submitting,_that.booked,_that.error,_that.rescheduleOf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  Therapist? therapist,  List<BookingDay> days,  int dayIndex,  DateTime? slot,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  bool submitting,  Appointment? booked,  String? error,  String? rescheduleOf)  $default,) {final _that = this;
switch (_that) {
case _BookingState():
return $default(_that.status,_that.therapist,_that.days,_that.dayIndex,_that.slot,_that.type,_that.recurrence,_that.reminders,_that.submitting,_that.booked,_that.error,_that.rescheduleOf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  Therapist? therapist,  List<BookingDay> days,  int dayIndex,  DateTime? slot,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  bool submitting,  Appointment? booked,  String? error,  String? rescheduleOf)?  $default,) {final _that = this;
switch (_that) {
case _BookingState() when $default != null:
return $default(_that.status,_that.therapist,_that.days,_that.dayIndex,_that.slot,_that.type,_that.recurrence,_that.reminders,_that.submitting,_that.booked,_that.error,_that.rescheduleOf);case _:
  return null;

}
}

}

/// @nodoc


class _BookingState extends BookingState {
  const _BookingState({this.status = LoadStatus.initial, this.therapist,  List<BookingDay> days = const <BookingDay>[], this.dayIndex = 0, this.slot, this.type = SessionType.video, this.recurrence = Recurrence.oneTime,  Set<Reminder> reminders = const <Reminder>{Reminder.day, Reminder.hour}, this.submitting = false, this.booked, this.error, this.rescheduleOf}): _days = days,_reminders = reminders,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  Therapist? therapist;
 final  List<BookingDay> _days;
@override@JsonKey() List<BookingDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

@override@JsonKey() final  int dayIndex;
@override final  DateTime? slot;
@override@JsonKey() final  SessionType type;
@override@JsonKey() final  Recurrence recurrence;
 final  Set<Reminder> _reminders;
@override@JsonKey() Set<Reminder> get reminders {
  if (_reminders is EqualUnmodifiableSetView) return _reminders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_reminders);
}

@override@JsonKey() final  bool submitting;
@override final  Appointment? booked;
@override final  String? error;
@override final  String? rescheduleOf;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStateCopyWith<_BookingState> get copyWith => __$BookingStateCopyWithImpl<_BookingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingState&&(identical(other.status, status) || other.status == status)&&(identical(other.therapist, therapist) || other.therapist == therapist)&&const DeepCollectionEquality().equals(other.days, _days)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.type, type) || other.type == type)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&const DeepCollectionEquality().equals(other.reminders, _reminders)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.booked, booked) || other.booked == booked)&&(identical(other.error, error) || other.error == error)&&(identical(other.rescheduleOf, rescheduleOf) || other.rescheduleOf == rescheduleOf));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,therapist,const DeepCollectionEquality().hash(_days),dayIndex,slot,type,recurrence,const DeepCollectionEquality().hash(_reminders),submitting,booked,error,rescheduleOf);
}

@override
String toString() {
    return 'BookingState(status: $status, therapist: $therapist, days: $days, dayIndex: $dayIndex, slot: $slot, type: $type, recurrence: $recurrence, reminders: $reminders, submitting: $submitting, booked: $booked, error: $error, rescheduleOf: $rescheduleOf)';
}


}

/// @nodoc
abstract mixin class _$BookingStateCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory _$BookingStateCopyWith(_BookingState value, $Res Function(_BookingState) _then) = __$BookingStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, Therapist? therapist, List<BookingDay> days, int dayIndex, DateTime? slot, SessionType type, Recurrence recurrence, Set<Reminder> reminders, bool submitting, Appointment? booked, String? error, String? rescheduleOf
});


@override $TherapistCopyWith<$Res>? get therapist;@override $AppointmentCopyWith<$Res>? get booked;

}
/// @nodoc
class __$BookingStateCopyWithImpl<$Res>
    implements _$BookingStateCopyWith<$Res> {
  __$BookingStateCopyWithImpl(this._self, this._then);

  final _BookingState _self;
  final $Res Function(_BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? therapist = freezed,Object? days = null,Object? dayIndex = null,Object? slot = freezed,Object? type = null,Object? recurrence = null,Object? reminders = null,Object? submitting = null,Object? booked = freezed,Object? error = freezed,Object? rescheduleOf = freezed,}) {
  return _then(_BookingState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,therapist: freezed == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist?,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<BookingDay>,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,slot: freezed == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DateTime?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self._reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,booked: freezed == booked ? _self.booked : booked // ignore: cast_nullable_to_non_nullable
as Appointment?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,rescheduleOf: freezed == rescheduleOf ? _self.rescheduleOf : rescheduleOf // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookingState
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
}/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppointmentCopyWith<$Res>? get booked {
    if (_self.booked == null) {
    return null;
  }

  return $AppointmentCopyWith<$Res>(_self.booked!, (value) {
    return _then(_self.copyWith(booked: value));
  });
}
}

// dart format on
