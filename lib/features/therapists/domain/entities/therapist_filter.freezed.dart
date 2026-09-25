// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapist_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TherapistFilter {

 String get query; String get specialty; List<String> get specializations; int get maxPrice; String get minRating; String get sessionType;
/// Create a copy of TherapistFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TherapistFilterCopyWith<TherapistFilter> get copyWith => _$TherapistFilterCopyWithImpl<TherapistFilter>(this as TherapistFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TherapistFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TherapistFilter&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.specialty, _this.specialty) || other.specialty == _this.specialty)&&const DeepCollectionEquality().equals(other.specializations, _this.specializations)&&(identical(other.maxPrice, _this.maxPrice) || other.maxPrice == _this.maxPrice)&&(identical(other.minRating, _this.minRating) || other.minRating == _this.minRating)&&(identical(other.sessionType, _this.sessionType) || other.sessionType == _this.sessionType));
}


@override
int get hashCode {
  final _this = this as TherapistFilter;
  return Object.hash(runtimeType,_this.query,_this.specialty,const DeepCollectionEquality().hash(_this.specializations),_this.maxPrice,_this.minRating,_this.sessionType);
}

@override
String toString() {
  final _this = this as TherapistFilter;
  return 'TherapistFilter(query: ${_this.query}, specialty: ${_this.specialty}, specializations: ${_this.specializations}, maxPrice: ${_this.maxPrice}, minRating: ${_this.minRating}, sessionType: ${_this.sessionType})';
}


}

/// @nodoc
abstract mixin class $TherapistFilterCopyWith<$Res>  {
  factory $TherapistFilterCopyWith(TherapistFilter value, $Res Function(TherapistFilter) _then) = _$TherapistFilterCopyWithImpl;
@useResult
$Res call({
 String query, String specialty, List<String> specializations, int maxPrice, String minRating, String sessionType
});




}
/// @nodoc
class _$TherapistFilterCopyWithImpl<$Res>
    implements $TherapistFilterCopyWith<$Res> {
  _$TherapistFilterCopyWithImpl(this._self, this._then);

  final TherapistFilter _self;
  final $Res Function(TherapistFilter) _then;

/// Create a copy of TherapistFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? specialty = null,Object? specializations = null,Object? maxPrice = null,Object? minRating = null,Object? sessionType = null,}) {
  return _then(TherapistFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,specializations: null == specializations ? _self.specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<String>,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as int,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TherapistFilter].
extension TherapistFilterPatterns on TherapistFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TherapistFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TherapistFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TherapistFilter value)  $default,){
final _that = this;
switch (_that) {
case _TherapistFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TherapistFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TherapistFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  String specialty,  List<String> specializations,  int maxPrice,  String minRating,  String sessionType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TherapistFilter() when $default != null:
return $default(_that.query,_that.specialty,_that.specializations,_that.maxPrice,_that.minRating,_that.sessionType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  String specialty,  List<String> specializations,  int maxPrice,  String minRating,  String sessionType)  $default,) {final _that = this;
switch (_that) {
case _TherapistFilter():
return $default(_that.query,_that.specialty,_that.specializations,_that.maxPrice,_that.minRating,_that.sessionType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  String specialty,  List<String> specializations,  int maxPrice,  String minRating,  String sessionType)?  $default,) {final _that = this;
switch (_that) {
case _TherapistFilter() when $default != null:
return $default(_that.query,_that.specialty,_that.specializations,_that.maxPrice,_that.minRating,_that.sessionType);case _:
  return null;

}
}

}

/// @nodoc


class _TherapistFilter extends TherapistFilter {
  const _TherapistFilter({this.query = '', this.specialty = 'All',  List<String> specializations = const <String>[], this.maxPrice = 150, this.minRating = 'Any', this.sessionType = 'Any'}): _specializations = specializations,super._();
  

@override@JsonKey() final  String query;
@override@JsonKey() final  String specialty;
 final  List<String> _specializations;
@override@JsonKey() List<String> get specializations {
  if (_specializations is EqualUnmodifiableListView) return _specializations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specializations);
}

@override@JsonKey() final  int maxPrice;
@override@JsonKey() final  String minRating;
@override@JsonKey() final  String sessionType;

/// Create a copy of TherapistFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TherapistFilterCopyWith<_TherapistFilter> get copyWith => __$TherapistFilterCopyWithImpl<_TherapistFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TherapistFilter&&(identical(other.query, query) || other.query == query)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&const DeepCollectionEquality().equals(other.specializations, _specializations)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,specialty,const DeepCollectionEquality().hash(_specializations),maxPrice,minRating,sessionType);
}

@override
String toString() {
    return 'TherapistFilter(query: $query, specialty: $specialty, specializations: $specializations, maxPrice: $maxPrice, minRating: $minRating, sessionType: $sessionType)';
}


}

/// @nodoc
abstract mixin class _$TherapistFilterCopyWith<$Res> implements $TherapistFilterCopyWith<$Res> {
  factory _$TherapistFilterCopyWith(_TherapistFilter value, $Res Function(_TherapistFilter) _then) = __$TherapistFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, String specialty, List<String> specializations, int maxPrice, String minRating, String sessionType
});




}
/// @nodoc
class __$TherapistFilterCopyWithImpl<$Res>
    implements _$TherapistFilterCopyWith<$Res> {
  __$TherapistFilterCopyWithImpl(this._self, this._then);

  final _TherapistFilter _self;
  final $Res Function(_TherapistFilter) _then;

/// Create a copy of TherapistFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? specialty = null,Object? specializations = null,Object? maxPrice = null,Object? minRating = null,Object? sessionType = null,}) {
  return _then(_TherapistFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,specializations: null == specializations ? _self._specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<String>,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as int,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
