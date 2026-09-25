// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {

 String get name; String get email; String get phone; String get bio; bool get loaded; bool get saving; bool get saved; String? get error;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EditProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.loaded, _this.loaded) || other.loaded == _this.loaded)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as EditProfileState;
  return Object.hash(runtimeType,_this.name,_this.email,_this.phone,_this.bio,_this.loaded,_this.saving,_this.saved,_this.error);
}

@override
String toString() {
  final _this = this as EditProfileState;
  return 'EditProfileState(name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, bio: ${_this.bio}, loaded: ${_this.loaded}, saving: ${_this.saving}, saved: ${_this.saved}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 String name, String email, String phone, String bio, bool loaded, bool saving, bool saved, String? error
});




}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? bio = null,Object? loaded = null,Object? saving = null,Object? saved = null,Object? error = freezed,}) {
  return _then(EditProfileState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditProfileState value)  $default,){
final _that = this;
switch (_that) {
case _EditProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String bio,  bool loaded,  bool saving,  bool saved,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.bio,_that.loaded,_that.saving,_that.saved,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String bio,  bool loaded,  bool saving,  bool saved,  String? error)  $default,) {final _that = this;
switch (_that) {
case _EditProfileState():
return $default(_that.name,_that.email,_that.phone,_that.bio,_that.loaded,_that.saving,_that.saved,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String phone,  String bio,  bool loaded,  bool saving,  bool saved,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.bio,_that.loaded,_that.saving,_that.saved,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _EditProfileState extends EditProfileState {
  const _EditProfileState({this.name = '', this.email = '', this.phone = '', this.bio = '', this.loaded = false, this.saving = false, this.saved = false, this.error}): super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String bio;
@override@JsonKey() final  bool loaded;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;
@override final  String? error;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.loaded, loaded) || other.loaded == loaded)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,email,phone,bio,loaded,saving,saved,error);
}

@override
String toString() {
    return 'EditProfileState(name: $name, email: $email, phone: $phone, bio: $bio, loaded: $loaded, saving: $saving, saved: $saved, error: $error)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String phone, String bio, bool loaded, bool saving, bool saved, String? error
});




}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? bio = null,Object? loaded = null,Object? saving = null,Object? saved = null,Object? error = freezed,}) {
  return _then(_EditProfileState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,loaded: null == loaded ? _self.loaded : loaded // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
