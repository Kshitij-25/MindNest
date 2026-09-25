// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppPreferences {

 ThemeMode get themeMode;/// Dynamic type multiplier on top of the OS setting (0.85 – 1.3).
 double get textScale; bool get reduceMotion; bool get highContrast; bool get dailyReminders; bool get sessionReminders; bool get messageAlerts; bool get contentUpdates; bool get faceIdLock;
/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppPreferencesCopyWith<AppPreferences> get copyWith => _$AppPreferencesCopyWithImpl<AppPreferences>(this as AppPreferences, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppPreferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppPreferences&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.textScale, _this.textScale) || other.textScale == _this.textScale)&&(identical(other.reduceMotion, _this.reduceMotion) || other.reduceMotion == _this.reduceMotion)&&(identical(other.highContrast, _this.highContrast) || other.highContrast == _this.highContrast)&&(identical(other.dailyReminders, _this.dailyReminders) || other.dailyReminders == _this.dailyReminders)&&(identical(other.sessionReminders, _this.sessionReminders) || other.sessionReminders == _this.sessionReminders)&&(identical(other.messageAlerts, _this.messageAlerts) || other.messageAlerts == _this.messageAlerts)&&(identical(other.contentUpdates, _this.contentUpdates) || other.contentUpdates == _this.contentUpdates)&&(identical(other.faceIdLock, _this.faceIdLock) || other.faceIdLock == _this.faceIdLock));
}


@override
int get hashCode {
  final _this = this as AppPreferences;
  return Object.hash(runtimeType,_this.themeMode,_this.textScale,_this.reduceMotion,_this.highContrast,_this.dailyReminders,_this.sessionReminders,_this.messageAlerts,_this.contentUpdates,_this.faceIdLock);
}

@override
String toString() {
  final _this = this as AppPreferences;
  return 'AppPreferences(themeMode: ${_this.themeMode}, textScale: ${_this.textScale}, reduceMotion: ${_this.reduceMotion}, highContrast: ${_this.highContrast}, dailyReminders: ${_this.dailyReminders}, sessionReminders: ${_this.sessionReminders}, messageAlerts: ${_this.messageAlerts}, contentUpdates: ${_this.contentUpdates}, faceIdLock: ${_this.faceIdLock})';
}


}

/// @nodoc
abstract mixin class $AppPreferencesCopyWith<$Res>  {
  factory $AppPreferencesCopyWith(AppPreferences value, $Res Function(AppPreferences) _then) = _$AppPreferencesCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, double textScale, bool reduceMotion, bool highContrast, bool dailyReminders, bool sessionReminders, bool messageAlerts, bool contentUpdates, bool faceIdLock
});




}
/// @nodoc
class _$AppPreferencesCopyWithImpl<$Res>
    implements $AppPreferencesCopyWith<$Res> {
  _$AppPreferencesCopyWithImpl(this._self, this._then);

  final AppPreferences _self;
  final $Res Function(AppPreferences) _then;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? textScale = null,Object? reduceMotion = null,Object? highContrast = null,Object? dailyReminders = null,Object? sessionReminders = null,Object? messageAlerts = null,Object? contentUpdates = null,Object? faceIdLock = null,}) {
  return _then(AppPreferences(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,dailyReminders: null == dailyReminders ? _self.dailyReminders : dailyReminders // ignore: cast_nullable_to_non_nullable
as bool,sessionReminders: null == sessionReminders ? _self.sessionReminders : sessionReminders // ignore: cast_nullable_to_non_nullable
as bool,messageAlerts: null == messageAlerts ? _self.messageAlerts : messageAlerts // ignore: cast_nullable_to_non_nullable
as bool,contentUpdates: null == contentUpdates ? _self.contentUpdates : contentUpdates // ignore: cast_nullable_to_non_nullable
as bool,faceIdLock: null == faceIdLock ? _self.faceIdLock : faceIdLock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppPreferences].
extension AppPreferencesPatterns on AppPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppPreferences value)  $default,){
final _that = this;
switch (_that) {
case _AppPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _AppPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  double textScale,  bool reduceMotion,  bool highContrast,  bool dailyReminders,  bool sessionReminders,  bool messageAlerts,  bool contentUpdates,  bool faceIdLock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppPreferences() when $default != null:
return $default(_that.themeMode,_that.textScale,_that.reduceMotion,_that.highContrast,_that.dailyReminders,_that.sessionReminders,_that.messageAlerts,_that.contentUpdates,_that.faceIdLock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  double textScale,  bool reduceMotion,  bool highContrast,  bool dailyReminders,  bool sessionReminders,  bool messageAlerts,  bool contentUpdates,  bool faceIdLock)  $default,) {final _that = this;
switch (_that) {
case _AppPreferences():
return $default(_that.themeMode,_that.textScale,_that.reduceMotion,_that.highContrast,_that.dailyReminders,_that.sessionReminders,_that.messageAlerts,_that.contentUpdates,_that.faceIdLock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  double textScale,  bool reduceMotion,  bool highContrast,  bool dailyReminders,  bool sessionReminders,  bool messageAlerts,  bool contentUpdates,  bool faceIdLock)?  $default,) {final _that = this;
switch (_that) {
case _AppPreferences() when $default != null:
return $default(_that.themeMode,_that.textScale,_that.reduceMotion,_that.highContrast,_that.dailyReminders,_that.sessionReminders,_that.messageAlerts,_that.contentUpdates,_that.faceIdLock);case _:
  return null;

}
}

}

/// @nodoc


class _AppPreferences implements AppPreferences {
  const _AppPreferences({this.themeMode = ThemeMode.system, this.textScale = 1.0, this.reduceMotion = false, this.highContrast = false, this.dailyReminders = true, this.sessionReminders = true, this.messageAlerts = true, this.contentUpdates = false, this.faceIdLock = true});
  

@override@JsonKey() final  ThemeMode themeMode;
/// Dynamic type multiplier on top of the OS setting (0.85 – 1.3).
@override@JsonKey() final  double textScale;
@override@JsonKey() final  bool reduceMotion;
@override@JsonKey() final  bool highContrast;
@override@JsonKey() final  bool dailyReminders;
@override@JsonKey() final  bool sessionReminders;
@override@JsonKey() final  bool messageAlerts;
@override@JsonKey() final  bool contentUpdates;
@override@JsonKey() final  bool faceIdLock;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppPreferencesCopyWith<_AppPreferences> get copyWith => __$AppPreferencesCopyWithImpl<_AppPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppPreferences&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.reduceMotion, reduceMotion) || other.reduceMotion == reduceMotion)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.dailyReminders, dailyReminders) || other.dailyReminders == dailyReminders)&&(identical(other.sessionReminders, sessionReminders) || other.sessionReminders == sessionReminders)&&(identical(other.messageAlerts, messageAlerts) || other.messageAlerts == messageAlerts)&&(identical(other.contentUpdates, contentUpdates) || other.contentUpdates == contentUpdates)&&(identical(other.faceIdLock, faceIdLock) || other.faceIdLock == faceIdLock));
}


@override
int get hashCode {
    return Object.hash(runtimeType,themeMode,textScale,reduceMotion,highContrast,dailyReminders,sessionReminders,messageAlerts,contentUpdates,faceIdLock);
}

@override
String toString() {
    return 'AppPreferences(themeMode: $themeMode, textScale: $textScale, reduceMotion: $reduceMotion, highContrast: $highContrast, dailyReminders: $dailyReminders, sessionReminders: $sessionReminders, messageAlerts: $messageAlerts, contentUpdates: $contentUpdates, faceIdLock: $faceIdLock)';
}


}

/// @nodoc
abstract mixin class _$AppPreferencesCopyWith<$Res> implements $AppPreferencesCopyWith<$Res> {
  factory _$AppPreferencesCopyWith(_AppPreferences value, $Res Function(_AppPreferences) _then) = __$AppPreferencesCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, double textScale, bool reduceMotion, bool highContrast, bool dailyReminders, bool sessionReminders, bool messageAlerts, bool contentUpdates, bool faceIdLock
});




}
/// @nodoc
class __$AppPreferencesCopyWithImpl<$Res>
    implements _$AppPreferencesCopyWith<$Res> {
  __$AppPreferencesCopyWithImpl(this._self, this._then);

  final _AppPreferences _self;
  final $Res Function(_AppPreferences) _then;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? textScale = null,Object? reduceMotion = null,Object? highContrast = null,Object? dailyReminders = null,Object? sessionReminders = null,Object? messageAlerts = null,Object? contentUpdates = null,Object? faceIdLock = null,}) {
  return _then(_AppPreferences(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,dailyReminders: null == dailyReminders ? _self.dailyReminders : dailyReminders // ignore: cast_nullable_to_non_nullable
as bool,sessionReminders: null == sessionReminders ? _self.sessionReminders : sessionReminders // ignore: cast_nullable_to_non_nullable
as bool,messageAlerts: null == messageAlerts ? _self.messageAlerts : messageAlerts // ignore: cast_nullable_to_non_nullable
as bool,contentUpdates: null == contentUpdates ? _self.contentUpdates : contentUpdates // ignore: cast_nullable_to_non_nullable
as bool,faceIdLock: null == faceIdLock ? _self.faceIdLock : faceIdLock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
