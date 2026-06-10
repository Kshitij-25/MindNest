// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileActivityModel {

 String get icon; String get value; String get label; String get colorKey;
/// Create a copy of ProfileActivityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileActivityModelCopyWith<ProfileActivityModel> get copyWith => _$ProfileActivityModelCopyWithImpl<ProfileActivityModel>(this as ProfileActivityModel, _$identity);

  /// Serializes this ProfileActivityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileActivityModel&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.colorKey, colorKey) || other.colorKey == colorKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,value,label,colorKey);

@override
String toString() {
  return 'ProfileActivityModel(icon: $icon, value: $value, label: $label, colorKey: $colorKey)';
}


}

/// @nodoc
abstract mixin class $ProfileActivityModelCopyWith<$Res>  {
  factory $ProfileActivityModelCopyWith(ProfileActivityModel value, $Res Function(ProfileActivityModel) _then) = _$ProfileActivityModelCopyWithImpl;
@useResult
$Res call({
 String icon, String value, String label, String colorKey
});




}
/// @nodoc
class _$ProfileActivityModelCopyWithImpl<$Res>
    implements $ProfileActivityModelCopyWith<$Res> {
  _$ProfileActivityModelCopyWithImpl(this._self, this._then);

  final ProfileActivityModel _self;
  final $Res Function(ProfileActivityModel) _then;

/// Create a copy of ProfileActivityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = null,Object? value = null,Object? label = null,Object? colorKey = null,}) {
  return _then(_self.copyWith(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,colorKey: null == colorKey ? _self.colorKey : colorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileActivityModel].
extension ProfileActivityModelPatterns on ProfileActivityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileActivityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileActivityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileActivityModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileActivityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileActivityModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileActivityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String icon,  String value,  String label,  String colorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileActivityModel() when $default != null:
return $default(_that.icon,_that.value,_that.label,_that.colorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String icon,  String value,  String label,  String colorKey)  $default,) {final _that = this;
switch (_that) {
case _ProfileActivityModel():
return $default(_that.icon,_that.value,_that.label,_that.colorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String icon,  String value,  String label,  String colorKey)?  $default,) {final _that = this;
switch (_that) {
case _ProfileActivityModel() when $default != null:
return $default(_that.icon,_that.value,_that.label,_that.colorKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileActivityModel implements ProfileActivityModel {
  const _ProfileActivityModel({required this.icon, required this.value, required this.label, required this.colorKey});
  factory _ProfileActivityModel.fromJson(Map<String, dynamic> json) => _$ProfileActivityModelFromJson(json);

@override final  String icon;
@override final  String value;
@override final  String label;
@override final  String colorKey;

/// Create a copy of ProfileActivityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileActivityModelCopyWith<_ProfileActivityModel> get copyWith => __$ProfileActivityModelCopyWithImpl<_ProfileActivityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileActivityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileActivityModel&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.colorKey, colorKey) || other.colorKey == colorKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,icon,value,label,colorKey);

@override
String toString() {
  return 'ProfileActivityModel(icon: $icon, value: $value, label: $label, colorKey: $colorKey)';
}


}

/// @nodoc
abstract mixin class _$ProfileActivityModelCopyWith<$Res> implements $ProfileActivityModelCopyWith<$Res> {
  factory _$ProfileActivityModelCopyWith(_ProfileActivityModel value, $Res Function(_ProfileActivityModel) _then) = __$ProfileActivityModelCopyWithImpl;
@override @useResult
$Res call({
 String icon, String value, String label, String colorKey
});




}
/// @nodoc
class __$ProfileActivityModelCopyWithImpl<$Res>
    implements _$ProfileActivityModelCopyWith<$Res> {
  __$ProfileActivityModelCopyWithImpl(this._self, this._then);

  final _ProfileActivityModel _self;
  final $Res Function(_ProfileActivityModel) _then;

/// Create a copy of ProfileActivityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? value = null,Object? label = null,Object? colorKey = null,}) {
  return _then(_ProfileActivityModel(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,colorKey: null == colorKey ? _self.colorKey : colorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileModel {

 String get name; String get email; String get checkIns; String get entries; String get streak; List<ProfileActivityModel> get weekActivity; List<int> get moodWeek;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.checkIns, checkIns) || other.checkIns == checkIns)&&(identical(other.entries, entries) || other.entries == entries)&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other.weekActivity, weekActivity)&&const DeepCollectionEquality().equals(other.moodWeek, moodWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,checkIns,entries,streak,const DeepCollectionEquality().hash(weekActivity),const DeepCollectionEquality().hash(moodWeek));

@override
String toString() {
  return 'ProfileModel(name: $name, email: $email, checkIns: $checkIns, entries: $entries, streak: $streak, weekActivity: $weekActivity, moodWeek: $moodWeek)';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
 String name, String email, String checkIns, String entries, String streak, List<ProfileActivityModel> weekActivity, List<int> moodWeek
});




}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? checkIns = null,Object? entries = null,Object? streak = null,Object? weekActivity = null,Object? moodWeek = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,checkIns: null == checkIns ? _self.checkIns : checkIns // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as String,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as String,weekActivity: null == weekActivity ? _self.weekActivity : weekActivity // ignore: cast_nullable_to_non_nullable
as List<ProfileActivityModel>,moodWeek: null == moodWeek ? _self.moodWeek : moodWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String checkIns,  String entries,  String streak,  List<ProfileActivityModel> weekActivity,  List<int> moodWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.name,_that.email,_that.checkIns,_that.entries,_that.streak,_that.weekActivity,_that.moodWeek);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String checkIns,  String entries,  String streak,  List<ProfileActivityModel> weekActivity,  List<int> moodWeek)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that.name,_that.email,_that.checkIns,_that.entries,_that.streak,_that.weekActivity,_that.moodWeek);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String checkIns,  String entries,  String streak,  List<ProfileActivityModel> weekActivity,  List<int> moodWeek)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.name,_that.email,_that.checkIns,_that.entries,_that.streak,_that.weekActivity,_that.moodWeek);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel implements ProfileModel {
  const _ProfileModel({required this.name, required this.email, required this.checkIns, required this.entries, required this.streak, final  List<ProfileActivityModel> weekActivity = const <ProfileActivityModel>[], final  List<int> moodWeek = const <int>[]}): _weekActivity = weekActivity,_moodWeek = moodWeek;
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override final  String name;
@override final  String email;
@override final  String checkIns;
@override final  String entries;
@override final  String streak;
 final  List<ProfileActivityModel> _weekActivity;
@override@JsonKey() List<ProfileActivityModel> get weekActivity {
  if (_weekActivity is EqualUnmodifiableListView) return _weekActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekActivity);
}

 final  List<int> _moodWeek;
@override@JsonKey() List<int> get moodWeek {
  if (_moodWeek is EqualUnmodifiableListView) return _moodWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moodWeek);
}


/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.checkIns, checkIns) || other.checkIns == checkIns)&&(identical(other.entries, entries) || other.entries == entries)&&(identical(other.streak, streak) || other.streak == streak)&&const DeepCollectionEquality().equals(other._weekActivity, _weekActivity)&&const DeepCollectionEquality().equals(other._moodWeek, _moodWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,checkIns,entries,streak,const DeepCollectionEquality().hash(_weekActivity),const DeepCollectionEquality().hash(_moodWeek));

@override
String toString() {
  return 'ProfileModel(name: $name, email: $email, checkIns: $checkIns, entries: $entries, streak: $streak, weekActivity: $weekActivity, moodWeek: $moodWeek)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String checkIns, String entries, String streak, List<ProfileActivityModel> weekActivity, List<int> moodWeek
});




}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? checkIns = null,Object? entries = null,Object? streak = null,Object? weekActivity = null,Object? moodWeek = null,}) {
  return _then(_ProfileModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,checkIns: null == checkIns ? _self.checkIns : checkIns // ignore: cast_nullable_to_non_nullable
as String,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as String,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as String,weekActivity: null == weekActivity ? _self._weekActivity : weekActivity // ignore: cast_nullable_to_non_nullable
as List<ProfileActivityModel>,moodWeek: null == moodWeek ? _self._moodWeek : moodWeek // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
