// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarningsState {

 Earnings? get data; EarningsPeriod get period;
/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsStateCopyWith<EarningsState> get copyWith => _$EarningsStateCopyWithImpl<EarningsState>(this as EarningsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EarningsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsState&&(identical(other.data, _this.data) || other.data == _this.data)&&(identical(other.period, _this.period) || other.period == _this.period));
}


@override
int get hashCode {
  final _this = this as EarningsState;
  return Object.hash(runtimeType,_this.data,_this.period);
}

@override
String toString() {
  final _this = this as EarningsState;
  return 'EarningsState(data: ${_this.data}, period: ${_this.period})';
}


}

/// @nodoc
abstract mixin class $EarningsStateCopyWith<$Res>  {
  factory $EarningsStateCopyWith(EarningsState value, $Res Function(EarningsState) _then) = _$EarningsStateCopyWithImpl;
@useResult
$Res call({
 Earnings? data, EarningsPeriod period
});


$EarningsCopyWith<$Res>? get data;

}
/// @nodoc
class _$EarningsStateCopyWithImpl<$Res>
    implements $EarningsStateCopyWith<$Res> {
  _$EarningsStateCopyWithImpl(this._self, this._then);

  final EarningsState _self;
  final $Res Function(EarningsState) _then;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? period = null,}) {
  return _then(EarningsState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Earnings?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as EarningsPeriod,
  ));
}
/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarningsCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EarningsCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarningsState].
extension EarningsStatePatterns on EarningsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningsState value)  $default,){
final _that = this;
switch (_that) {
case _EarningsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningsState value)?  $default,){
final _that = this;
switch (_that) {
case _EarningsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Earnings? data,  EarningsPeriod period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningsState() when $default != null:
return $default(_that.data,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Earnings? data,  EarningsPeriod period)  $default,) {final _that = this;
switch (_that) {
case _EarningsState():
return $default(_that.data,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Earnings? data,  EarningsPeriod period)?  $default,) {final _that = this;
switch (_that) {
case _EarningsState() when $default != null:
return $default(_that.data,_that.period);case _:
  return null;

}
}

}

/// @nodoc


class _EarningsState implements EarningsState {
  const _EarningsState({this.data, this.period = EarningsPeriod.month});
  

@override final  Earnings? data;
@override@JsonKey() final  EarningsPeriod period;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsStateCopyWith<_EarningsState> get copyWith => __$EarningsStateCopyWithImpl<_EarningsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsState&&(identical(other.data, data) || other.data == data)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode {
    return Object.hash(runtimeType,data,period);
}

@override
String toString() {
    return 'EarningsState(data: $data, period: $period)';
}


}

/// @nodoc
abstract mixin class _$EarningsStateCopyWith<$Res> implements $EarningsStateCopyWith<$Res> {
  factory _$EarningsStateCopyWith(_EarningsState value, $Res Function(_EarningsState) _then) = __$EarningsStateCopyWithImpl;
@override @useResult
$Res call({
 Earnings? data, EarningsPeriod period
});


@override $EarningsCopyWith<$Res>? get data;

}
/// @nodoc
class __$EarningsStateCopyWithImpl<$Res>
    implements _$EarningsStateCopyWith<$Res> {
  __$EarningsStateCopyWithImpl(this._self, this._then);

  final _EarningsState _self;
  final $Res Function(_EarningsState) _then;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? period = null,}) {
  return _then(_EarningsState(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Earnings?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as EarningsPeriod,
  ));
}

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarningsCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EarningsCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
