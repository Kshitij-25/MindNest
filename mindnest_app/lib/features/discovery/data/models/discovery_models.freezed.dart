// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discovery_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TherapistModel {

 String get id; String get name; String get title; String get spec; List<String> get tags; double get rating; int get reviews; int get years; bool get verified; int get price; String get location; String get next; List<String> get langs; String get about; List<String> get quals;
/// Create a copy of TherapistModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TherapistModelCopyWith<TherapistModel> get copyWith => _$TherapistModelCopyWithImpl<TherapistModel>(this as TherapistModel, _$identity);

  /// Serializes this TherapistModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TherapistModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.spec, spec) || other.spec == spec)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.years, years) || other.years == years)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.price, price) || other.price == price)&&(identical(other.location, location) || other.location == location)&&(identical(other.next, next) || other.next == next)&&const DeepCollectionEquality().equals(other.langs, langs)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.quals, quals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,spec,const DeepCollectionEquality().hash(tags),rating,reviews,years,verified,price,location,next,const DeepCollectionEquality().hash(langs),about,const DeepCollectionEquality().hash(quals));

@override
String toString() {
  return 'TherapistModel(id: $id, name: $name, title: $title, spec: $spec, tags: $tags, rating: $rating, reviews: $reviews, years: $years, verified: $verified, price: $price, location: $location, next: $next, langs: $langs, about: $about, quals: $quals)';
}


}

/// @nodoc
abstract mixin class $TherapistModelCopyWith<$Res>  {
  factory $TherapistModelCopyWith(TherapistModel value, $Res Function(TherapistModel) _then) = _$TherapistModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String title, String spec, List<String> tags, double rating, int reviews, int years, bool verified, int price, String location, String next, List<String> langs, String about, List<String> quals
});




}
/// @nodoc
class _$TherapistModelCopyWithImpl<$Res>
    implements $TherapistModelCopyWith<$Res> {
  _$TherapistModelCopyWithImpl(this._self, this._then);

  final TherapistModel _self;
  final $Res Function(TherapistModel) _then;

/// Create a copy of TherapistModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? spec = null,Object? tags = null,Object? rating = null,Object? reviews = null,Object? years = null,Object? verified = null,Object? price = null,Object? location = null,Object? next = null,Object? langs = null,Object? about = null,Object? quals = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,spec: null == spec ? _self.spec : spec // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String,langs: null == langs ? _self.langs : langs // ignore: cast_nullable_to_non_nullable
as List<String>,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,quals: null == quals ? _self.quals : quals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TherapistModel].
extension TherapistModelPatterns on TherapistModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TherapistModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TherapistModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TherapistModel value)  $default,){
final _that = this;
switch (_that) {
case _TherapistModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TherapistModel value)?  $default,){
final _that = this;
switch (_that) {
case _TherapistModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String spec,  List<String> tags,  double rating,  int reviews,  int years,  bool verified,  int price,  String location,  String next,  List<String> langs,  String about,  List<String> quals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TherapistModel() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.spec,_that.tags,_that.rating,_that.reviews,_that.years,_that.verified,_that.price,_that.location,_that.next,_that.langs,_that.about,_that.quals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String spec,  List<String> tags,  double rating,  int reviews,  int years,  bool verified,  int price,  String location,  String next,  List<String> langs,  String about,  List<String> quals)  $default,) {final _that = this;
switch (_that) {
case _TherapistModel():
return $default(_that.id,_that.name,_that.title,_that.spec,_that.tags,_that.rating,_that.reviews,_that.years,_that.verified,_that.price,_that.location,_that.next,_that.langs,_that.about,_that.quals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String title,  String spec,  List<String> tags,  double rating,  int reviews,  int years,  bool verified,  int price,  String location,  String next,  List<String> langs,  String about,  List<String> quals)?  $default,) {final _that = this;
switch (_that) {
case _TherapistModel() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.spec,_that.tags,_that.rating,_that.reviews,_that.years,_that.verified,_that.price,_that.location,_that.next,_that.langs,_that.about,_that.quals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TherapistModel implements TherapistModel {
  const _TherapistModel({required this.id, required this.name, required this.title, required this.spec, final  List<String> tags = const <String>[], required this.rating, required this.reviews, required this.years, this.verified = false, required this.price, required this.location, required this.next, final  List<String> langs = const <String>[], required this.about, final  List<String> quals = const <String>[]}): _tags = tags,_langs = langs,_quals = quals;
  factory _TherapistModel.fromJson(Map<String, dynamic> json) => _$TherapistModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String title;
@override final  String spec;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  double rating;
@override final  int reviews;
@override final  int years;
@override@JsonKey() final  bool verified;
@override final  int price;
@override final  String location;
@override final  String next;
 final  List<String> _langs;
@override@JsonKey() List<String> get langs {
  if (_langs is EqualUnmodifiableListView) return _langs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_langs);
}

@override final  String about;
 final  List<String> _quals;
@override@JsonKey() List<String> get quals {
  if (_quals is EqualUnmodifiableListView) return _quals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quals);
}


/// Create a copy of TherapistModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TherapistModelCopyWith<_TherapistModel> get copyWith => __$TherapistModelCopyWithImpl<_TherapistModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TherapistModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TherapistModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.spec, spec) || other.spec == spec)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.years, years) || other.years == years)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.price, price) || other.price == price)&&(identical(other.location, location) || other.location == location)&&(identical(other.next, next) || other.next == next)&&const DeepCollectionEquality().equals(other._langs, _langs)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._quals, _quals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,spec,const DeepCollectionEquality().hash(_tags),rating,reviews,years,verified,price,location,next,const DeepCollectionEquality().hash(_langs),about,const DeepCollectionEquality().hash(_quals));

@override
String toString() {
  return 'TherapistModel(id: $id, name: $name, title: $title, spec: $spec, tags: $tags, rating: $rating, reviews: $reviews, years: $years, verified: $verified, price: $price, location: $location, next: $next, langs: $langs, about: $about, quals: $quals)';
}


}

/// @nodoc
abstract mixin class _$TherapistModelCopyWith<$Res> implements $TherapistModelCopyWith<$Res> {
  factory _$TherapistModelCopyWith(_TherapistModel value, $Res Function(_TherapistModel) _then) = __$TherapistModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String title, String spec, List<String> tags, double rating, int reviews, int years, bool verified, int price, String location, String next, List<String> langs, String about, List<String> quals
});




}
/// @nodoc
class __$TherapistModelCopyWithImpl<$Res>
    implements _$TherapistModelCopyWith<$Res> {
  __$TherapistModelCopyWithImpl(this._self, this._then);

  final _TherapistModel _self;
  final $Res Function(_TherapistModel) _then;

/// Create a copy of TherapistModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? spec = null,Object? tags = null,Object? rating = null,Object? reviews = null,Object? years = null,Object? verified = null,Object? price = null,Object? location = null,Object? next = null,Object? langs = null,Object? about = null,Object? quals = null,}) {
  return _then(_TherapistModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,spec: null == spec ? _self.spec : spec // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as int,years: null == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String,langs: null == langs ? _self._langs : langs // ignore: cast_nullable_to_non_nullable
as List<String>,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,quals: null == quals ? _self._quals : quals // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ReviewModel {

 String get id; String get name; int get rating; String get time; String get text;
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewModelCopyWith<ReviewModel> get copyWith => _$ReviewModelCopyWithImpl<ReviewModel>(this as ReviewModel, _$identity);

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.time, time) || other.time == time)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rating,time,text);

@override
String toString() {
  return 'ReviewModel(id: $id, name: $name, rating: $rating, time: $time, text: $text)';
}


}

/// @nodoc
abstract mixin class $ReviewModelCopyWith<$Res>  {
  factory $ReviewModelCopyWith(ReviewModel value, $Res Function(ReviewModel) _then) = _$ReviewModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int rating, String time, String text
});




}
/// @nodoc
class _$ReviewModelCopyWithImpl<$Res>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._self, this._then);

  final ReviewModel _self;
  final $Res Function(ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? rating = null,Object? time = null,Object? text = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewModel].
extension ReviewModelPatterns on ReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int rating,  String time,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.name,_that.rating,_that.time,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int rating,  String time,  String text)  $default,) {final _that = this;
switch (_that) {
case _ReviewModel():
return $default(_that.id,_that.name,_that.rating,_that.time,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int rating,  String time,  String text)?  $default,) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.name,_that.rating,_that.time,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewModel implements ReviewModel {
  const _ReviewModel({required this.id, required this.name, required this.rating, required this.time, required this.text});
  factory _ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  int rating;
@override final  String time;
@override final  String text;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewModelCopyWith<_ReviewModel> get copyWith => __$ReviewModelCopyWithImpl<_ReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.time, time) || other.time == time)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rating,time,text);

@override
String toString() {
  return 'ReviewModel(id: $id, name: $name, rating: $rating, time: $time, text: $text)';
}


}

/// @nodoc
abstract mixin class _$ReviewModelCopyWith<$Res> implements $ReviewModelCopyWith<$Res> {
  factory _$ReviewModelCopyWith(_ReviewModel value, $Res Function(_ReviewModel) _then) = __$ReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int rating, String time, String text
});




}
/// @nodoc
class __$ReviewModelCopyWithImpl<$Res>
    implements _$ReviewModelCopyWith<$Res> {
  __$ReviewModelCopyWithImpl(this._self, this._then);

  final _ReviewModel _self;
  final $Res Function(_ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? rating = null,Object? time = null,Object? text = null,}) {
  return _then(_ReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AppointmentModel {

 String get id; String get tid; String get date; String get time; String get type; String get status; int get mins;
/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentModelCopyWith<AppointmentModel> get copyWith => _$AppointmentModelCopyWithImpl<AppointmentModel>(this as AppointmentModel, _$identity);

  /// Serializes this AppointmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.mins, mins) || other.mins == mins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tid,date,time,type,status,mins);

@override
String toString() {
  return 'AppointmentModel(id: $id, tid: $tid, date: $date, time: $time, type: $type, status: $status, mins: $mins)';
}


}

/// @nodoc
abstract mixin class $AppointmentModelCopyWith<$Res>  {
  factory $AppointmentModelCopyWith(AppointmentModel value, $Res Function(AppointmentModel) _then) = _$AppointmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String tid, String date, String time, String type, String status, int mins
});




}
/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._self, this._then);

  final AppointmentModel _self;
  final $Res Function(AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tid = null,Object? date = null,Object? time = null,Object? type = null,Object? status = null,Object? mins = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppointmentModel].
extension AppointmentModelPatterns on AppointmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentModel value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tid,  String date,  String time,  String type,  String status,  int mins)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
return $default(_that.id,_that.tid,_that.date,_that.time,_that.type,_that.status,_that.mins);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tid,  String date,  String time,  String type,  String status,  int mins)  $default,) {final _that = this;
switch (_that) {
case _AppointmentModel():
return $default(_that.id,_that.tid,_that.date,_that.time,_that.type,_that.status,_that.mins);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tid,  String date,  String time,  String type,  String status,  int mins)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentModel() when $default != null:
return $default(_that.id,_that.tid,_that.date,_that.time,_that.type,_that.status,_that.mins);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentModel implements AppointmentModel {
  const _AppointmentModel({required this.id, required this.tid, required this.date, required this.time, required this.type, required this.status, required this.mins});
  factory _AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

@override final  String id;
@override final  String tid;
@override final  String date;
@override final  String time;
@override final  String type;
@override final  String status;
@override final  int mins;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentModelCopyWith<_AppointmentModel> get copyWith => __$AppointmentModelCopyWithImpl<_AppointmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tid, tid) || other.tid == tid)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.mins, mins) || other.mins == mins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tid,date,time,type,status,mins);

@override
String toString() {
  return 'AppointmentModel(id: $id, tid: $tid, date: $date, time: $time, type: $type, status: $status, mins: $mins)';
}


}

/// @nodoc
abstract mixin class _$AppointmentModelCopyWith<$Res> implements $AppointmentModelCopyWith<$Res> {
  factory _$AppointmentModelCopyWith(_AppointmentModel value, $Res Function(_AppointmentModel) _then) = __$AppointmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tid, String date, String time, String type, String status, int mins
});




}
/// @nodoc
class __$AppointmentModelCopyWithImpl<$Res>
    implements _$AppointmentModelCopyWith<$Res> {
  __$AppointmentModelCopyWithImpl(this._self, this._then);

  final _AppointmentModel _self;
  final $Res Function(_AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tid = null,Object? date = null,Object? time = null,Object? type = null,Object? status = null,Object? mins = null,}) {
  return _then(_AppointmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tid: null == tid ? _self.tid : tid // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
