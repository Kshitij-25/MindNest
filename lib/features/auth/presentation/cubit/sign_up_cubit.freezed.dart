// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {

 String get name; String get email; String get password; bool get agreed; FormStatus get status; String? get error; AppUser? get user;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignUpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.agreed, _this.agreed) || other.agreed == _this.agreed)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.user, _this.user) || other.user == _this.user));
}


@override
int get hashCode {
  final _this = this as SignUpState;
  return Object.hash(runtimeType,_this.name,_this.email,_this.password,_this.agreed,_this.status,_this.error,_this.user);
}

@override
String toString() {
  final _this = this as SignUpState;
  return 'SignUpState(name: ${_this.name}, email: ${_this.email}, password: ${_this.password}, agreed: ${_this.agreed}, status: ${_this.status}, error: ${_this.error}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password, bool agreed, FormStatus status, String? error, AppUser? user
});


$AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? password = null,Object? agreed = null,Object? status = null,Object? error = freezed,Object? user = freezed,}) {
  return _then(SignUpState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,agreed: null == agreed ? _self.agreed : agreed // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String password,  bool agreed,  FormStatus status,  String? error,  AppUser? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.name,_that.email,_that.password,_that.agreed,_that.status,_that.error,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String password,  bool agreed,  FormStatus status,  String? error,  AppUser? user)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.name,_that.email,_that.password,_that.agreed,_that.status,_that.error,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String password,  bool agreed,  FormStatus status,  String? error,  AppUser? user)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.name,_that.email,_that.password,_that.agreed,_that.status,_that.error,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState extends SignUpState {
  const _SignUpState({this.name = '', this.email = '', this.password = '', this.agreed = true, this.status = FormStatus.idle, this.error, this.user}): super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool agreed;
@override@JsonKey() final  FormStatus status;
@override final  String? error;
@override final  AppUser? user;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.agreed, agreed) || other.agreed == agreed)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,email,password,agreed,status,error,user);
}

@override
String toString() {
    return 'SignUpState(name: $name, email: $email, password: $password, agreed: $agreed, status: $status, error: $error, user: $user)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String password, bool agreed, FormStatus status, String? error, AppUser? user
});


@override $AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? agreed = null,Object? status = null,Object? error = freezed,Object? user = freezed,}) {
  return _then(_SignUpState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,agreed: null == agreed ? _self.agreed : agreed // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
