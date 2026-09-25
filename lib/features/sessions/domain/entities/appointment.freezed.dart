// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Appointment {

 String get id; Therapist get therapist; DateTime get startsAt; SessionType get type; int get minutes; AppointmentStatus get status; Recurrence get recurrence; Set<Reminder> get reminders;
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentCopyWith<Appointment> get copyWith => _$AppointmentCopyWithImpl<Appointment>(this as Appointment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Appointment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Appointment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.therapist, _this.therapist) || other.therapist == _this.therapist)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.minutes, _this.minutes) || other.minutes == _this.minutes)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&const DeepCollectionEquality().equals(other.reminders, _this.reminders));
}


@override
int get hashCode {
  final _this = this as Appointment;
  return Object.hash(runtimeType,_this.id,_this.therapist,_this.startsAt,_this.type,_this.minutes,_this.status,_this.recurrence,const DeepCollectionEquality().hash(_this.reminders));
}

@override
String toString() {
  final _this = this as Appointment;
  return 'Appointment(id: ${_this.id}, therapist: ${_this.therapist}, startsAt: ${_this.startsAt}, type: ${_this.type}, minutes: ${_this.minutes}, status: ${_this.status}, recurrence: ${_this.recurrence}, reminders: ${_this.reminders})';
}


}

/// @nodoc
abstract mixin class $AppointmentCopyWith<$Res>  {
  factory $AppointmentCopyWith(Appointment value, $Res Function(Appointment) _then) = _$AppointmentCopyWithImpl;
@useResult
$Res call({
 String id, Therapist therapist, DateTime startsAt, SessionType type, int minutes, AppointmentStatus status, Recurrence recurrence, Set<Reminder> reminders
});


$TherapistCopyWith<$Res> get therapist;

}
/// @nodoc
class _$AppointmentCopyWithImpl<$Res>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._self, this._then);

  final Appointment _self;
  final $Res Function(Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? therapist = null,Object? startsAt = null,Object? type = null,Object? minutes = null,Object? status = null,Object? recurrence = null,Object? reminders = null,}) {
  return _then(Appointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,therapist: null == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,
  ));
}
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistCopyWith<$Res> get therapist {
  
  return $TherapistCopyWith<$Res>(_self.therapist, (value) {
    return _then(_self.copyWith(therapist: value));
  });
}
}


/// Adds pattern-matching-related methods to [Appointment].
extension AppointmentPatterns on Appointment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Appointment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Appointment value)  $default,){
final _that = this;
switch (_that) {
case _Appointment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Appointment value)?  $default,){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Therapist therapist,  DateTime startsAt,  SessionType type,  int minutes,  AppointmentStatus status,  Recurrence recurrence,  Set<Reminder> reminders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.therapist,_that.startsAt,_that.type,_that.minutes,_that.status,_that.recurrence,_that.reminders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Therapist therapist,  DateTime startsAt,  SessionType type,  int minutes,  AppointmentStatus status,  Recurrence recurrence,  Set<Reminder> reminders)  $default,) {final _that = this;
switch (_that) {
case _Appointment():
return $default(_that.id,_that.therapist,_that.startsAt,_that.type,_that.minutes,_that.status,_that.recurrence,_that.reminders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Therapist therapist,  DateTime startsAt,  SessionType type,  int minutes,  AppointmentStatus status,  Recurrence recurrence,  Set<Reminder> reminders)?  $default,) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.therapist,_that.startsAt,_that.type,_that.minutes,_that.status,_that.recurrence,_that.reminders);case _:
  return null;

}
}

}

/// @nodoc


class _Appointment extends Appointment {
  const _Appointment({required this.id, required this.therapist, required this.startsAt, this.type = SessionType.video, this.minutes = 50, this.status = AppointmentStatus.pending, this.recurrence = Recurrence.oneTime,  Set<Reminder> reminders = const <Reminder>{Reminder.day, Reminder.hour}}): _reminders = reminders,super._();
  

@override final  String id;
@override final  Therapist therapist;
@override final  DateTime startsAt;
@override@JsonKey() final  SessionType type;
@override@JsonKey() final  int minutes;
@override@JsonKey() final  AppointmentStatus status;
@override@JsonKey() final  Recurrence recurrence;
 final  Set<Reminder> _reminders;
@override@JsonKey() Set<Reminder> get reminders {
  if (_reminders is EqualUnmodifiableSetView) return _reminders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_reminders);
}


/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentCopyWith<_Appointment> get copyWith => __$AppointmentCopyWithImpl<_Appointment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.therapist, therapist) || other.therapist == therapist)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&const DeepCollectionEquality().equals(other.reminders, _reminders));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,therapist,startsAt,type,minutes,status,recurrence,const DeepCollectionEquality().hash(_reminders));
}

@override
String toString() {
    return 'Appointment(id: $id, therapist: $therapist, startsAt: $startsAt, type: $type, minutes: $minutes, status: $status, recurrence: $recurrence, reminders: $reminders)';
}


}

/// @nodoc
abstract mixin class _$AppointmentCopyWith<$Res> implements $AppointmentCopyWith<$Res> {
  factory _$AppointmentCopyWith(_Appointment value, $Res Function(_Appointment) _then) = __$AppointmentCopyWithImpl;
@override @useResult
$Res call({
 String id, Therapist therapist, DateTime startsAt, SessionType type, int minutes, AppointmentStatus status, Recurrence recurrence, Set<Reminder> reminders
});


@override $TherapistCopyWith<$Res> get therapist;

}
/// @nodoc
class __$AppointmentCopyWithImpl<$Res>
    implements _$AppointmentCopyWith<$Res> {
  __$AppointmentCopyWithImpl(this._self, this._then);

  final _Appointment _self;
  final $Res Function(_Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? therapist = null,Object? startsAt = null,Object? type = null,Object? minutes = null,Object? status = null,Object? recurrence = null,Object? reminders = null,}) {
  return _then(_Appointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,therapist: null == therapist ? _self.therapist : therapist // ignore: cast_nullable_to_non_nullable
as Therapist,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self._reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,
  ));
}

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TherapistCopyWith<$Res> get therapist {
  
  return $TherapistCopyWith<$Res>(_self.therapist, (value) {
    return _then(_self.copyWith(therapist: value));
  });
}
}

/// @nodoc
mixin _$TimeSlot {

 DateTime get time; bool get taken;
/// Create a copy of TimeSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSlotCopyWith<TimeSlot> get copyWith => _$TimeSlotCopyWithImpl<TimeSlot>(this as TimeSlot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TimeSlot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlot&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.taken, _this.taken) || other.taken == _this.taken));
}


@override
int get hashCode {
  final _this = this as TimeSlot;
  return Object.hash(runtimeType,_this.time,_this.taken);
}

@override
String toString() {
  final _this = this as TimeSlot;
  return 'TimeSlot(time: ${_this.time}, taken: ${_this.taken})';
}


}

/// @nodoc
abstract mixin class $TimeSlotCopyWith<$Res>  {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) _then) = _$TimeSlotCopyWithImpl;
@useResult
$Res call({
 DateTime time, bool taken
});




}
/// @nodoc
class _$TimeSlotCopyWithImpl<$Res>
    implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._self, this._then);

  final TimeSlot _self;
  final $Res Function(TimeSlot) _then;

/// Create a copy of TimeSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? taken = null,}) {
  return _then(TimeSlot(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,taken: null == taken ? _self.taken : taken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeSlot].
extension TimeSlotPatterns on TimeSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeSlot value)  $default,){
final _that = this;
switch (_that) {
case _TimeSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeSlot value)?  $default,){
final _that = this;
switch (_that) {
case _TimeSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  bool taken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeSlot() when $default != null:
return $default(_that.time,_that.taken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  bool taken)  $default,) {final _that = this;
switch (_that) {
case _TimeSlot():
return $default(_that.time,_that.taken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  bool taken)?  $default,) {final _that = this;
switch (_that) {
case _TimeSlot() when $default != null:
return $default(_that.time,_that.taken);case _:
  return null;

}
}

}

/// @nodoc


class _TimeSlot implements TimeSlot {
  const _TimeSlot({required this.time, this.taken = false});
  

@override final  DateTime time;
@override@JsonKey() final  bool taken;

/// Create a copy of TimeSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeSlotCopyWith<_TimeSlot> get copyWith => __$TimeSlotCopyWithImpl<_TimeSlot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeSlot&&(identical(other.time, time) || other.time == time)&&(identical(other.taken, taken) || other.taken == taken));
}


@override
int get hashCode {
    return Object.hash(runtimeType,time,taken);
}

@override
String toString() {
    return 'TimeSlot(time: $time, taken: $taken)';
}


}

/// @nodoc
abstract mixin class _$TimeSlotCopyWith<$Res> implements $TimeSlotCopyWith<$Res> {
  factory _$TimeSlotCopyWith(_TimeSlot value, $Res Function(_TimeSlot) _then) = __$TimeSlotCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, bool taken
});




}
/// @nodoc
class __$TimeSlotCopyWithImpl<$Res>
    implements _$TimeSlotCopyWith<$Res> {
  __$TimeSlotCopyWithImpl(this._self, this._then);

  final _TimeSlot _self;
  final $Res Function(_TimeSlot) _then;

/// Create a copy of TimeSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? taken = null,}) {
  return _then(_TimeSlot(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,taken: null == taken ? _self.taken : taken // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$BookingDay {

 DateTime get date; bool get available; List<TimeSlot> get slots;
/// Create a copy of BookingDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDayCopyWith<BookingDay> get copyWith => _$BookingDayCopyWithImpl<BookingDay>(this as BookingDay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BookingDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDay&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.available, _this.available) || other.available == _this.available)&&const DeepCollectionEquality().equals(other.slots, _this.slots));
}


@override
int get hashCode {
  final _this = this as BookingDay;
  return Object.hash(runtimeType,_this.date,_this.available,const DeepCollectionEquality().hash(_this.slots));
}

@override
String toString() {
  final _this = this as BookingDay;
  return 'BookingDay(date: ${_this.date}, available: ${_this.available}, slots: ${_this.slots})';
}


}

/// @nodoc
abstract mixin class $BookingDayCopyWith<$Res>  {
  factory $BookingDayCopyWith(BookingDay value, $Res Function(BookingDay) _then) = _$BookingDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool available, List<TimeSlot> slots
});




}
/// @nodoc
class _$BookingDayCopyWithImpl<$Res>
    implements $BookingDayCopyWith<$Res> {
  _$BookingDayCopyWithImpl(this._self, this._then);

  final BookingDay _self;
  final $Res Function(BookingDay) _then;

/// Create a copy of BookingDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? available = null,Object? slots = null,}) {
  return _then(BookingDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<TimeSlot>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingDay].
extension BookingDayPatterns on BookingDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDay value)  $default,){
final _that = this;
switch (_that) {
case _BookingDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDay value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  bool available,  List<TimeSlot> slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDay() when $default != null:
return $default(_that.date,_that.available,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  bool available,  List<TimeSlot> slots)  $default,) {final _that = this;
switch (_that) {
case _BookingDay():
return $default(_that.date,_that.available,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  bool available,  List<TimeSlot> slots)?  $default,) {final _that = this;
switch (_that) {
case _BookingDay() when $default != null:
return $default(_that.date,_that.available,_that.slots);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDay implements BookingDay {
  const _BookingDay({required this.date, required this.available, required  List<TimeSlot> slots}): _slots = slots;
  

@override final  DateTime date;
@override final  bool available;
 final  List<TimeSlot> _slots;
@override List<TimeSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of BookingDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDayCopyWith<_BookingDay> get copyWith => __$BookingDayCopyWithImpl<_BookingDay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDay&&(identical(other.date, date) || other.date == date)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other.slots, _slots));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,available,const DeepCollectionEquality().hash(_slots));
}

@override
String toString() {
    return 'BookingDay(date: $date, available: $available, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$BookingDayCopyWith<$Res> implements $BookingDayCopyWith<$Res> {
  factory _$BookingDayCopyWith(_BookingDay value, $Res Function(_BookingDay) _then) = __$BookingDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool available, List<TimeSlot> slots
});




}
/// @nodoc
class __$BookingDayCopyWithImpl<$Res>
    implements _$BookingDayCopyWith<$Res> {
  __$BookingDayCopyWithImpl(this._self, this._then);

  final _BookingDay _self;
  final $Res Function(_BookingDay) _then;

/// Create a copy of BookingDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? available = null,Object? slots = null,}) {
  return _then(_BookingDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<TimeSlot>,
  ));
}


}

/// @nodoc
mixin _$BookingRequest {

 String get therapistId; DateTime get startsAt; SessionType get type; Recurrence get recurrence; Set<Reminder> get reminders; String? get rescheduleOf;
/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestCopyWith<BookingRequest> get copyWith => _$BookingRequestCopyWithImpl<BookingRequest>(this as BookingRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BookingRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequest&&(identical(other.therapistId, _this.therapistId) || other.therapistId == _this.therapistId)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.recurrence, _this.recurrence) || other.recurrence == _this.recurrence)&&const DeepCollectionEquality().equals(other.reminders, _this.reminders)&&(identical(other.rescheduleOf, _this.rescheduleOf) || other.rescheduleOf == _this.rescheduleOf));
}


@override
int get hashCode {
  final _this = this as BookingRequest;
  return Object.hash(runtimeType,_this.therapistId,_this.startsAt,_this.type,_this.recurrence,const DeepCollectionEquality().hash(_this.reminders),_this.rescheduleOf);
}

@override
String toString() {
  final _this = this as BookingRequest;
  return 'BookingRequest(therapistId: ${_this.therapistId}, startsAt: ${_this.startsAt}, type: ${_this.type}, recurrence: ${_this.recurrence}, reminders: ${_this.reminders}, rescheduleOf: ${_this.rescheduleOf})';
}


}

/// @nodoc
abstract mixin class $BookingRequestCopyWith<$Res>  {
  factory $BookingRequestCopyWith(BookingRequest value, $Res Function(BookingRequest) _then) = _$BookingRequestCopyWithImpl;
@useResult
$Res call({
 String therapistId, DateTime startsAt, SessionType type, Recurrence recurrence, Set<Reminder> reminders, String? rescheduleOf
});




}
/// @nodoc
class _$BookingRequestCopyWithImpl<$Res>
    implements $BookingRequestCopyWith<$Res> {
  _$BookingRequestCopyWithImpl(this._self, this._then);

  final BookingRequest _self;
  final $Res Function(BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? therapistId = null,Object? startsAt = null,Object? type = null,Object? recurrence = null,Object? reminders = null,Object? rescheduleOf = freezed,}) {
  return _then(BookingRequest(
therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,rescheduleOf: freezed == rescheduleOf ? _self.rescheduleOf : rescheduleOf // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingRequest].
extension BookingRequestPatterns on BookingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRequest value)  $default,){
final _that = this;
switch (_that) {
case _BookingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String therapistId,  DateTime startsAt,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  String? rescheduleOf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
return $default(_that.therapistId,_that.startsAt,_that.type,_that.recurrence,_that.reminders,_that.rescheduleOf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String therapistId,  DateTime startsAt,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  String? rescheduleOf)  $default,) {final _that = this;
switch (_that) {
case _BookingRequest():
return $default(_that.therapistId,_that.startsAt,_that.type,_that.recurrence,_that.reminders,_that.rescheduleOf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String therapistId,  DateTime startsAt,  SessionType type,  Recurrence recurrence,  Set<Reminder> reminders,  String? rescheduleOf)?  $default,) {final _that = this;
switch (_that) {
case _BookingRequest() when $default != null:
return $default(_that.therapistId,_that.startsAt,_that.type,_that.recurrence,_that.reminders,_that.rescheduleOf);case _:
  return null;

}
}

}

/// @nodoc


class _BookingRequest implements BookingRequest {
  const _BookingRequest({required this.therapistId, required this.startsAt, required this.type, this.recurrence = Recurrence.oneTime,  Set<Reminder> reminders = const <Reminder>{Reminder.day, Reminder.hour}, this.rescheduleOf}): _reminders = reminders;
  

@override final  String therapistId;
@override final  DateTime startsAt;
@override final  SessionType type;
@override@JsonKey() final  Recurrence recurrence;
 final  Set<Reminder> _reminders;
@override@JsonKey() Set<Reminder> get reminders {
  if (_reminders is EqualUnmodifiableSetView) return _reminders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_reminders);
}

@override final  String? rescheduleOf;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestCopyWith<_BookingRequest> get copyWith => __$BookingRequestCopyWithImpl<_BookingRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequest&&(identical(other.therapistId, therapistId) || other.therapistId == therapistId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&const DeepCollectionEquality().equals(other.reminders, _reminders)&&(identical(other.rescheduleOf, rescheduleOf) || other.rescheduleOf == rescheduleOf));
}


@override
int get hashCode {
    return Object.hash(runtimeType,therapistId,startsAt,type,recurrence,const DeepCollectionEquality().hash(_reminders),rescheduleOf);
}

@override
String toString() {
    return 'BookingRequest(therapistId: $therapistId, startsAt: $startsAt, type: $type, recurrence: $recurrence, reminders: $reminders, rescheduleOf: $rescheduleOf)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestCopyWith<$Res> implements $BookingRequestCopyWith<$Res> {
  factory _$BookingRequestCopyWith(_BookingRequest value, $Res Function(_BookingRequest) _then) = __$BookingRequestCopyWithImpl;
@override @useResult
$Res call({
 String therapistId, DateTime startsAt, SessionType type, Recurrence recurrence, Set<Reminder> reminders, String? rescheduleOf
});




}
/// @nodoc
class __$BookingRequestCopyWithImpl<$Res>
    implements _$BookingRequestCopyWith<$Res> {
  __$BookingRequestCopyWithImpl(this._self, this._then);

  final _BookingRequest _self;
  final $Res Function(_BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? therapistId = null,Object? startsAt = null,Object? type = null,Object? recurrence = null,Object? reminders = null,Object? rescheduleOf = freezed,}) {
  return _then(_BookingRequest(
therapistId: null == therapistId ? _self.therapistId : therapistId // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as Recurrence,reminders: null == reminders ? _self._reminders : reminders // ignore: cast_nullable_to_non_nullable
as Set<Reminder>,rescheduleOf: freezed == rescheduleOf ? _self.rescheduleOf : rescheduleOf // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
