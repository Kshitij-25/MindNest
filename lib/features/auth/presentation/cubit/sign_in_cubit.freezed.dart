// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {

 String get email; String get password; bool get obscure; FormStatus get status; String? get error; AppUser? get user;
/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInStateCopyWith<SignInState> get copyWith => _$SignInStateCopyWithImpl<SignInState>(this as SignInState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignInState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.obscure, _this.obscure) || other.obscure == _this.obscure)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.user, _this.user) || other.user == _this.user));
}


@override
int get hashCode {
  final _this = this as SignInState;
  return Object.hash(runtimeType,_this.email,_this.password,_this.obscure,_this.status,_this.error,_this.user);
}

@override
String toString() {
  final _this = this as SignInState;
  return 'SignInState(email: ${_this.email}, password: ${_this.password}, obscure: ${_this.obscure}, status: ${_this.status}, error: ${_this.error}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $SignInStateCopyWith<$Res>  {
  factory $SignInStateCopyWith(SignInState value, $Res Function(SignInState) _then) = _$SignInStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool obscure, FormStatus status, String? error, AppUser? user
});


$AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$SignInStateCopyWithImpl<$Res>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._self, this._then);

  final SignInState _self;
  final $Res Function(SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? obscure = null,Object? status = null,Object? error = freezed,Object? user = freezed,}) {
  return _then(SignInState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscure: null == obscure ? _self.obscure : obscure // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}
/// Create a copy of SignInState
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


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInState value)  $default,){
final _that = this;
switch (_that) {
case _SignInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInState value)?  $default,){
final _that = this;
switch (_that) {
case _SignInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  bool obscure,  FormStatus status,  String? error,  AppUser? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.email,_that.password,_that.obscure,_that.status,_that.error,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  bool obscure,  FormStatus status,  String? error,  AppUser? user)  $default,) {final _that = this;
switch (_that) {
case _SignInState():
return $default(_that.email,_that.password,_that.obscure,_that.status,_that.error,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  bool obscure,  FormStatus status,  String? error,  AppUser? user)?  $default,) {final _that = this;
switch (_that) {
case _SignInState() when $default != null:
return $default(_that.email,_that.password,_that.obscure,_that.status,_that.error,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _SignInState implements SignInState {
  const _SignInState({this.email = '', this.password = '', this.obscure = true, this.status = FormStatus.idle, this.error, this.user});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool obscure;
@override@JsonKey() final  FormStatus status;
@override final  String? error;
@override final  AppUser? user;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInStateCopyWith<_SignInState> get copyWith => __$SignInStateCopyWithImpl<_SignInState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscure, obscure) || other.obscure == obscure)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,password,obscure,status,error,user);
}

@override
String toString() {
    return 'SignInState(email: $email, password: $password, obscure: $obscure, status: $status, error: $error, user: $user)';
}


}

/// @nodoc
abstract mixin class _$SignInStateCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory _$SignInStateCopyWith(_SignInState value, $Res Function(_SignInState) _then) = __$SignInStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, bool obscure, FormStatus status, String? error, AppUser? user
});


@override $AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$SignInStateCopyWithImpl<$Res>
    implements _$SignInStateCopyWith<$Res> {
  __$SignInStateCopyWithImpl(this._self, this._then);

  final _SignInState _self;
  final $Res Function(_SignInState) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? obscure = null,Object? status = null,Object? error = freezed,Object? user = freezed,}) {
  return _then(_SignInState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscure: null == obscure ? _self.obscure : obscure // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,
  ));
}

/// Create a copy of SignInState
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
