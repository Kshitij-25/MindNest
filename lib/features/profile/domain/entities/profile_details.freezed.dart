// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileDetails {

 String get phone; String get bio;
/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDetailsCopyWith<ProfileDetails> get copyWith => _$ProfileDetailsCopyWithImpl<ProfileDetails>(this as ProfileDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDetails&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.bio, _this.bio) || other.bio == _this.bio));
}


@override
int get hashCode {
  final _this = this as ProfileDetails;
  return Object.hash(runtimeType,_this.phone,_this.bio);
}

@override
String toString() {
  final _this = this as ProfileDetails;
  return 'ProfileDetails(phone: ${_this.phone}, bio: ${_this.bio})';
}


}

/// @nodoc
abstract mixin class $ProfileDetailsCopyWith<$Res>  {
  factory $ProfileDetailsCopyWith(ProfileDetails value, $Res Function(ProfileDetails) _then) = _$ProfileDetailsCopyWithImpl;
@useResult
$Res call({
 String phone, String bio
});




}
/// @nodoc
class _$ProfileDetailsCopyWithImpl<$Res>
    implements $ProfileDetailsCopyWith<$Res> {
  _$ProfileDetailsCopyWithImpl(this._self, this._then);

  final ProfileDetails _self;
  final $Res Function(ProfileDetails) _then;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? bio = null,}) {
  return _then(ProfileDetails(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileDetails].
extension ProfileDetailsPatterns on ProfileDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileDetails value)  $default,){
final _that = this;
switch (_that) {
case _ProfileDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileDetails value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  String bio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that.phone,_that.bio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  String bio)  $default,) {final _that = this;
switch (_that) {
case _ProfileDetails():
return $default(_that.phone,_that.bio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  String bio)?  $default,) {final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that.phone,_that.bio);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileDetails implements ProfileDetails {
  const _ProfileDetails({this.phone = '+44 7700 900892', this.bio = 'Learning to slow down and be kinder to myself.'});
  

@override@JsonKey() final  String phone;
@override@JsonKey() final  String bio;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDetailsCopyWith<_ProfileDetails> get copyWith => __$ProfileDetailsCopyWithImpl<_ProfileDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDetails&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bio, bio) || other.bio == bio));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone,bio);
}

@override
String toString() {
    return 'ProfileDetails(phone: $phone, bio: $bio)';
}


}

/// @nodoc
abstract mixin class _$ProfileDetailsCopyWith<$Res> implements $ProfileDetailsCopyWith<$Res> {
  factory _$ProfileDetailsCopyWith(_ProfileDetails value, $Res Function(_ProfileDetails) _then) = __$ProfileDetailsCopyWithImpl;
@override @useResult
$Res call({
 String phone, String bio
});




}
/// @nodoc
class __$ProfileDetailsCopyWithImpl<$Res>
    implements _$ProfileDetailsCopyWith<$Res> {
  __$ProfileDetailsCopyWithImpl(this._self, this._then);

  final _ProfileDetails _self;
  final $Res Function(_ProfileDetails) _then;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? bio = null,}) {
  return _then(_ProfileDetails(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
