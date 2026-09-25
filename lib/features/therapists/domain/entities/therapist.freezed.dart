// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Therapist {

 String get id; String get name; String get title; String get specialty; List<String> get tags; double get rating; int get reviewCount; int get years; bool get verified; int get price; String get location; String get nextAvailable; List<String> get languages; String get about; List<String> get qualifications; List<String> get sessionTypes; bool get saved;
/// Create a copy of Therapist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TherapistCopyWith<Therapist> get copyWith => _$TherapistCopyWithImpl<Therapist>(this as Therapist, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Therapist;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Therapist&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.specialty, _this.specialty) || other.specialty == _this.specialty)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.years, _this.years) || other.years == _this.years)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.nextAvailable, _this.nextAvailable) || other.nextAvailable == _this.nextAvailable)&&const DeepCollectionEquality().equals(other.languages, _this.languages)&&(identical(other.about, _this.about) || other.about == _this.about)&&const DeepCollectionEquality().equals(other.qualifications, _this.qualifications)&&const DeepCollectionEquality().equals(other.sessionTypes, _this.sessionTypes)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as Therapist;
  return Object.hash(runtimeType,_this.id,_this.name,_this.title,_this.specialty,const DeepCollectionEquality().hash(_this.tags),_this.rating,_this.reviewCount,_this.years,_this.verified,_this.price,_this.location,_this.nextAvailable,const DeepCollectionEquality().hash(_this.languages),_this.about,const DeepCollectionEquality().hash(_this.qualifications),const DeepCollectionEquality().hash(_this.sessionTypes),_this.saved);
}

@override
String toString() {
  final _this = this as Therapist;
  return 'Therapist(id: ${_this.id}, name: ${_this.name}, title: ${_this.title}, specialty: ${_this.specialty}, tags: ${_this.tags}, rating: ${_this.rating}, reviewCount: ${_this.reviewCount}, years: ${_this.years}, verified: ${_this.verified}, price: ${_this.price}, location: ${_this.location}, nextAvailable: ${_this.nextAvailable}, languages: ${_this.languages}, about: ${_this.about}, qualifications: ${_this.qualifications}, sessionTypes: ${_this.sessionTypes}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $TherapistCopyWith<$Res>  {
  factory $TherapistCopyWith(Therapist value, $Res Function(Therapist) _then) = _$TherapistCopyWithImpl;
@useResult
$Res call({
 String id, String name, String title, String specialty, List<String> tags, double rating, int reviewCount, int years, bool verified, int price, String location, String nextAvailable, List<String> languages, String about, List<String> qualifications, List<String> sessionTypes, bool saved
});




}
/// @nodoc
class _$TherapistCopyWithImpl<$Res>
    implements $TherapistCopyWith<$Res> {
  _$TherapistCopyWithImpl(this._self, this._then);

  final Therapist _self;
  final $Res Function(Therapist) _then;

/// Create a copy of Therapist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? specialty = null,Object? tags = null,Object? rating = null,Object? reviewCount = null,Object? years = null,Object? verified = null,Object? price = null,Object? location = null,Object? nextAvailable = null,Object? languages = null,Object? about = null,Object? qualifications = null,Object? sessionTypes = null,Object? saved = null,}) {
  return _then(Therapist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,nextAvailable: null == nextAvailable ? _self.nextAvailable : nextAvailable // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,qualifications: null == qualifications ? _self.qualifications : qualifications // ignore: cast_nullable_to_non_nullable
as List<String>,sessionTypes: null == sessionTypes ? _self.sessionTypes : sessionTypes // ignore: cast_nullable_to_non_nullable
as List<String>,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Therapist].
extension TherapistPatterns on Therapist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Therapist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Therapist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Therapist value)  $default,){
final _that = this;
switch (_that) {
case _Therapist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Therapist value)?  $default,){
final _that = this;
switch (_that) {
case _Therapist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String specialty,  List<String> tags,  double rating,  int reviewCount,  int years,  bool verified,  int price,  String location,  String nextAvailable,  List<String> languages,  String about,  List<String> qualifications,  List<String> sessionTypes,  bool saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Therapist() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.tags,_that.rating,_that.reviewCount,_that.years,_that.verified,_that.price,_that.location,_that.nextAvailable,_that.languages,_that.about,_that.qualifications,_that.sessionTypes,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String specialty,  List<String> tags,  double rating,  int reviewCount,  int years,  bool verified,  int price,  String location,  String nextAvailable,  List<String> languages,  String about,  List<String> qualifications,  List<String> sessionTypes,  bool saved)  $default,) {final _that = this;
switch (_that) {
case _Therapist():
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.tags,_that.rating,_that.reviewCount,_that.years,_that.verified,_that.price,_that.location,_that.nextAvailable,_that.languages,_that.about,_that.qualifications,_that.sessionTypes,_that.saved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String title,  String specialty,  List<String> tags,  double rating,  int reviewCount,  int years,  bool verified,  int price,  String location,  String nextAvailable,  List<String> languages,  String about,  List<String> qualifications,  List<String> sessionTypes,  bool saved)?  $default,) {final _that = this;
switch (_that) {
case _Therapist() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.specialty,_that.tags,_that.rating,_that.reviewCount,_that.years,_that.verified,_that.price,_that.location,_that.nextAvailable,_that.languages,_that.about,_that.qualifications,_that.sessionTypes,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _Therapist extends Therapist {
  const _Therapist({required this.id, required this.name, required this.title, required this.specialty, required  List<String> tags, required this.rating, required this.reviewCount, required this.years, required this.verified, required this.price, required this.location, required this.nextAvailable, required  List<String> languages, required this.about, required  List<String> qualifications,  List<String> sessionTypes = const <String>['Video', 'Voice', 'Chat'], this.saved = false}): _tags = tags,_languages = languages,_qualifications = qualifications,_sessionTypes = sessionTypes,super._();
  

@override final  String id;
@override final  String name;
@override final  String title;
@override final  String specialty;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  double rating;
@override final  int reviewCount;
@override final  int years;
@override final  bool verified;
@override final  int price;
@override final  String location;
@override final  String nextAvailable;
 final  List<String> _languages;
@override List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override final  String about;
 final  List<String> _qualifications;
@override List<String> get qualifications {
  if (_qualifications is EqualUnmodifiableListView) return _qualifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qualifications);
}

 final  List<String> _sessionTypes;
@override@JsonKey() List<String> get sessionTypes {
  if (_sessionTypes is EqualUnmodifiableListView) return _sessionTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessionTypes);
}

@override@JsonKey() final  bool saved;

/// Create a copy of Therapist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TherapistCopyWith<_Therapist> get copyWith => __$TherapistCopyWithImpl<_Therapist>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Therapist&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.years, years) || other.years == years)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.price, price) || other.price == price)&&(identical(other.location, location) || other.location == location)&&(identical(other.nextAvailable, nextAvailable) || other.nextAvailable == nextAvailable)&&const DeepCollectionEquality().equals(other.languages, _languages)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.qualifications, _qualifications)&&const DeepCollectionEquality().equals(other.sessionTypes, _sessionTypes)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,title,specialty,const DeepCollectionEquality().hash(_tags),rating,reviewCount,years,verified,price,location,nextAvailable,const DeepCollectionEquality().hash(_languages),about,const DeepCollectionEquality().hash(_qualifications),const DeepCollectionEquality().hash(_sessionTypes),saved);
}

@override
String toString() {
    return 'Therapist(id: $id, name: $name, title: $title, specialty: $specialty, tags: $tags, rating: $rating, reviewCount: $reviewCount, years: $years, verified: $verified, price: $price, location: $location, nextAvailable: $nextAvailable, languages: $languages, about: $about, qualifications: $qualifications, sessionTypes: $sessionTypes, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$TherapistCopyWith<$Res> implements $TherapistCopyWith<$Res> {
  factory _$TherapistCopyWith(_Therapist value, $Res Function(_Therapist) _then) = __$TherapistCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String title, String specialty, List<String> tags, double rating, int reviewCount, int years, bool verified, int price, String location, String nextAvailable, List<String> languages, String about, List<String> qualifications, List<String> sessionTypes, bool saved
});




}
/// @nodoc
class __$TherapistCopyWithImpl<$Res>
    implements _$TherapistCopyWith<$Res> {
  __$TherapistCopyWithImpl(this._self, this._then);

  final _Therapist _self;
  final $Res Function(_Therapist) _then;

/// Create a copy of Therapist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? specialty = null,Object? tags = null,Object? rating = null,Object? reviewCount = null,Object? years = null,Object? verified = null,Object? price = null,Object? location = null,Object? nextAvailable = null,Object? languages = null,Object? about = null,Object? qualifications = null,Object? sessionTypes = null,Object? saved = null,}) {
  return _then(_Therapist(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,nextAvailable: null == nextAvailable ? _self.nextAvailable : nextAvailable // ignore: cast_nullable_to_non_nullable
as String,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,qualifications: null == qualifications ? _self._qualifications : qualifications // ignore: cast_nullable_to_non_nullable
as List<String>,sessionTypes: null == sessionTypes ? _self._sessionTypes : sessionTypes // ignore: cast_nullable_to_non_nullable
as List<String>,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$Review {

 String get id; String get author; int get rating; String get timeAgo; String get text;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Review;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.timeAgo, _this.timeAgo) || other.timeAgo == _this.timeAgo)&&(identical(other.text, _this.text) || other.text == _this.text));
}


@override
int get hashCode {
  final _this = this as Review;
  return Object.hash(runtimeType,_this.id,_this.author,_this.rating,_this.timeAgo,_this.text);
}

@override
String toString() {
  final _this = this as Review;
  return 'Review(id: ${_this.id}, author: ${_this.author}, rating: ${_this.rating}, timeAgo: ${_this.timeAgo}, text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 String id, String author, int rating, String timeAgo, String text
});




}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? rating = null,Object? timeAgo = null,Object? text = null,}) {
  return _then(Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,timeAgo: null == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String author,  int rating,  String timeAgo,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.author,_that.rating,_that.timeAgo,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String author,  int rating,  String timeAgo,  String text)  $default,) {final _that = this;
switch (_that) {
case _Review():
return $default(_that.id,_that.author,_that.rating,_that.timeAgo,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String author,  int rating,  String timeAgo,  String text)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.author,_that.rating,_that.timeAgo,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _Review implements Review {
  const _Review({required this.id, required this.author, required this.rating, required this.timeAgo, required this.text});
  

@override final  String id;
@override final  String author;
@override final  int rating;
@override final  String timeAgo;
@override final  String text;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,author,rating,timeAgo,text);
}

@override
String toString() {
    return 'Review(id: $id, author: $author, rating: $rating, timeAgo: $timeAgo, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, int rating, String timeAgo, String text
});




}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? rating = null,Object? timeAgo = null,Object? text = null,}) {
  return _then(_Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,timeAgo: null == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DayAvailability {

 String get day; int get slots;
/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayAvailabilityCopyWith<DayAvailability> get copyWith => _$DayAvailabilityCopyWithImpl<DayAvailability>(this as DayAvailability, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DayAvailability;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayAvailability&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.slots, _this.slots) || other.slots == _this.slots));
}


@override
int get hashCode {
  final _this = this as DayAvailability;
  return Object.hash(runtimeType,_this.day,_this.slots);
}

@override
String toString() {
  final _this = this as DayAvailability;
  return 'DayAvailability(day: ${_this.day}, slots: ${_this.slots})';
}


}

/// @nodoc
abstract mixin class $DayAvailabilityCopyWith<$Res>  {
  factory $DayAvailabilityCopyWith(DayAvailability value, $Res Function(DayAvailability) _then) = _$DayAvailabilityCopyWithImpl;
@useResult
$Res call({
 String day, int slots
});




}
/// @nodoc
class _$DayAvailabilityCopyWithImpl<$Res>
    implements $DayAvailabilityCopyWith<$Res> {
  _$DayAvailabilityCopyWithImpl(this._self, this._then);

  final DayAvailability _self;
  final $Res Function(DayAvailability) _then;

/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? slots = null,}) {
  return _then(DayAvailability(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DayAvailability].
extension DayAvailabilityPatterns on DayAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayAvailability value)  $default,){
final _that = this;
switch (_that) {
case _DayAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  int slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
return $default(_that.day,_that.slots);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  int slots)  $default,) {final _that = this;
switch (_that) {
case _DayAvailability():
return $default(_that.day,_that.slots);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  int slots)?  $default,) {final _that = this;
switch (_that) {
case _DayAvailability() when $default != null:
return $default(_that.day,_that.slots);case _:
  return null;

}
}

}

/// @nodoc


class _DayAvailability implements DayAvailability {
  const _DayAvailability({required this.day, required this.slots});
  

@override final  String day;
@override final  int slots;

/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayAvailabilityCopyWith<_DayAvailability> get copyWith => __$DayAvailabilityCopyWithImpl<_DayAvailability>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayAvailability&&(identical(other.day, day) || other.day == day)&&(identical(other.slots, slots) || other.slots == slots));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day,slots);
}

@override
String toString() {
    return 'DayAvailability(day: $day, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$DayAvailabilityCopyWith<$Res> implements $DayAvailabilityCopyWith<$Res> {
  factory _$DayAvailabilityCopyWith(_DayAvailability value, $Res Function(_DayAvailability) _then) = __$DayAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String day, int slots
});




}
/// @nodoc
class __$DayAvailabilityCopyWithImpl<$Res>
    implements _$DayAvailabilityCopyWith<$Res> {
  __$DayAvailabilityCopyWithImpl(this._self, this._then);

  final _DayAvailability _self;
  final $Res Function(_DayAvailability) _then;

/// Create a copy of DayAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? slots = null,}) {
  return _then(_DayAvailability(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
