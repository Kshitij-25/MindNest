// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthStarted value)?  started,TResult Function( AuthRoleSelected value)?  roleSelected,TResult Function( AuthUserChanged value)?  userChanged,TResult Function( AuthOnboardingCompleted value)?  onboardingCompleted,TResult Function( AuthCredentialsSubmitted value)?  credentialsSubmitted,TResult Function( AuthSignedOut value)?  signedOut,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthStarted() when started != null:
return started(_that);case AuthRoleSelected() when roleSelected != null:
return roleSelected(_that);case AuthUserChanged() when userChanged != null:
return userChanged(_that);case AuthOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that);case AuthSignedOut() when signedOut != null:
return signedOut(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthStarted value)  started,required TResult Function( AuthRoleSelected value)  roleSelected,required TResult Function( AuthUserChanged value)  userChanged,required TResult Function( AuthOnboardingCompleted value)  onboardingCompleted,required TResult Function( AuthCredentialsSubmitted value)  credentialsSubmitted,required TResult Function( AuthSignedOut value)  signedOut,}){
final _that = this;
switch (_that) {
case AuthStarted():
return started(_that);case AuthRoleSelected():
return roleSelected(_that);case AuthUserChanged():
return userChanged(_that);case AuthOnboardingCompleted():
return onboardingCompleted(_that);case AuthCredentialsSubmitted():
return credentialsSubmitted(_that);case AuthSignedOut():
return signedOut(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthStarted value)?  started,TResult? Function( AuthRoleSelected value)?  roleSelected,TResult? Function( AuthUserChanged value)?  userChanged,TResult? Function( AuthOnboardingCompleted value)?  onboardingCompleted,TResult? Function( AuthCredentialsSubmitted value)?  credentialsSubmitted,TResult? Function( AuthSignedOut value)?  signedOut,}){
final _that = this;
switch (_that) {
case AuthStarted() when started != null:
return started(_that);case AuthRoleSelected() when roleSelected != null:
return roleSelected(_that);case AuthUserChanged() when userChanged != null:
return userChanged(_that);case AuthOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that);case AuthSignedOut() when signedOut != null:
return signedOut(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( UserRole role)?  roleSelected,TResult Function( AppUser user)?  userChanged,TResult Function()?  onboardingCompleted,TResult Function()?  credentialsSubmitted,TResult Function()?  signedOut,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthStarted() when started != null:
return started();case AuthRoleSelected() when roleSelected != null:
return roleSelected(_that.role);case AuthUserChanged() when userChanged != null:
return userChanged(_that.user);case AuthOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted();case AuthSignedOut() when signedOut != null:
return signedOut();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( UserRole role)  roleSelected,required TResult Function( AppUser user)  userChanged,required TResult Function()  onboardingCompleted,required TResult Function()  credentialsSubmitted,required TResult Function()  signedOut,}) {final _that = this;
switch (_that) {
case AuthStarted():
return started();case AuthRoleSelected():
return roleSelected(_that.role);case AuthUserChanged():
return userChanged(_that.user);case AuthOnboardingCompleted():
return onboardingCompleted();case AuthCredentialsSubmitted():
return credentialsSubmitted();case AuthSignedOut():
return signedOut();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( UserRole role)?  roleSelected,TResult? Function( AppUser user)?  userChanged,TResult? Function()?  onboardingCompleted,TResult? Function()?  credentialsSubmitted,TResult? Function()?  signedOut,}) {final _that = this;
switch (_that) {
case AuthStarted() when started != null:
return started();case AuthRoleSelected() when roleSelected != null:
return roleSelected(_that.role);case AuthUserChanged() when userChanged != null:
return userChanged(_that.user);case AuthOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted();case AuthSignedOut() when signedOut != null:
return signedOut();case _:
  return null;

}
}

}

/// @nodoc


class AuthStarted implements AuthEvent {
  const AuthStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthEvent.started()';
}


}




/// @nodoc


class AuthRoleSelected implements AuthEvent {
  const AuthRoleSelected(this.role);
  

 final  UserRole role;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRoleSelectedCopyWith<AuthRoleSelected> get copyWith => _$AuthRoleSelectedCopyWithImpl<AuthRoleSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthRoleSelected&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode {
    return Object.hash(runtimeType,role);
}

@override
String toString() {
    return 'AuthEvent.roleSelected(role: $role)';
}


}

/// @nodoc
abstract mixin class $AuthRoleSelectedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthRoleSelectedCopyWith(AuthRoleSelected value, $Res Function(AuthRoleSelected) _then) = _$AuthRoleSelectedCopyWithImpl;
@useResult
$Res call({
 UserRole role
});




}
/// @nodoc
class _$AuthRoleSelectedCopyWithImpl<$Res>
    implements $AuthRoleSelectedCopyWith<$Res> {
  _$AuthRoleSelectedCopyWithImpl(this._self, this._then);

  final AuthRoleSelected _self;
  final $Res Function(AuthRoleSelected) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? role = null,}) {
  return _then(AuthRoleSelected(
null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

/// @nodoc


class AuthUserChanged implements AuthEvent {
  const AuthUserChanged(this.user);
  

 final  AppUser user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserChangedCopyWith<AuthUserChanged> get copyWith => _$AuthUserChangedCopyWithImpl<AuthUserChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUserChanged&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,user);
}

@override
String toString() {
    return 'AuthEvent.userChanged(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthUserChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthUserChangedCopyWith(AuthUserChanged value, $Res Function(AuthUserChanged) _then) = _$AuthUserChangedCopyWithImpl;
@useResult
$Res call({
 AppUser user
});


$AppUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthUserChangedCopyWithImpl<$Res>
    implements $AuthUserChangedCopyWith<$Res> {
  _$AuthUserChangedCopyWithImpl(this._self, this._then);

  final AuthUserChanged _self;
  final $Res Function(AuthUserChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthUserChanged(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser,
  ));
}

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res> get user {
  
  return $AppUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class AuthOnboardingCompleted implements AuthEvent {
  const AuthOnboardingCompleted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthEvent.onboardingCompleted()';
}


}




/// @nodoc


class AuthCredentialsSubmitted implements AuthEvent {
  const AuthCredentialsSubmitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCredentialsSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthEvent.credentialsSubmitted()';
}


}




/// @nodoc


class AuthSignedOut implements AuthEvent {
  const AuthSignedOut();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSignedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AuthEvent.signedOut()';
}


}




/// @nodoc
mixin _$AuthState {

 AuthStatus get status; AppUser? get user; UserRole get role;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.role, _this.role) || other.role == _this.role));
}


@override
int get hashCode {
  final _this = this as AuthState;
  return Object.hash(runtimeType,_this.status,_this.user,_this.role);
}

@override
String toString() {
  final _this = this as AuthState;
  return 'AuthState(status: ${_this.status}, user: ${_this.user}, role: ${_this.role})';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, AppUser? user, UserRole role
});


$AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? role = null,}) {
  return _then(AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}
/// Create a copy of AuthState
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


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthStatus status,  AppUser? user,  UserRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthStatus status,  AppUser? user,  UserRole role)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.status,_that.user,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthStatus status,  AppUser? user,  UserRole role)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState extends AuthState {
  const _AuthState({this.status = AuthStatus.unknown, this.user, this.role = UserRole.client}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  AppUser? user;
@override@JsonKey() final  UserRole role;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,user,role);
}

@override
String toString() {
    return 'AuthState(status: $status, user: $user, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, AppUser? user, UserRole role
});


@override $AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? role = null,}) {
  return _then(_AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

/// Create a copy of AuthState
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
