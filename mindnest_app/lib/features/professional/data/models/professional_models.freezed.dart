// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professional_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingRequestModel {

 String get id; String get name; String get when; String get reason; String get status; int get mins;
/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestModelCopyWith<BookingRequestModel> get copyWith => _$BookingRequestModelCopyWithImpl<BookingRequestModel>(this as BookingRequestModel, _$identity);

  /// Serializes this BookingRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.when, when) || other.when == when)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.mins, mins) || other.mins == mins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,when,reason,status,mins);

@override
String toString() {
  return 'BookingRequestModel(id: $id, name: $name, when: $when, reason: $reason, status: $status, mins: $mins)';
}


}

/// @nodoc
abstract mixin class $BookingRequestModelCopyWith<$Res>  {
  factory $BookingRequestModelCopyWith(BookingRequestModel value, $Res Function(BookingRequestModel) _then) = _$BookingRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String when, String reason, String status, int mins
});




}
/// @nodoc
class _$BookingRequestModelCopyWithImpl<$Res>
    implements $BookingRequestModelCopyWith<$Res> {
  _$BookingRequestModelCopyWithImpl(this._self, this._then);

  final BookingRequestModel _self;
  final $Res Function(BookingRequestModel) _then;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? when = null,Object? reason = null,Object? status = null,Object? mins = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingRequestModel].
extension BookingRequestModelPatterns on BookingRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String when,  String reason,  String status,  int mins)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.when,_that.reason,_that.status,_that.mins);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String when,  String reason,  String status,  int mins)  $default,) {final _that = this;
switch (_that) {
case _BookingRequestModel():
return $default(_that.id,_that.name,_that.when,_that.reason,_that.status,_that.mins);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String when,  String reason,  String status,  int mins)?  $default,) {final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.when,_that.reason,_that.status,_that.mins);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingRequestModel implements BookingRequestModel {
  const _BookingRequestModel({required this.id, required this.name, required this.when, required this.reason, this.status = 'Pending', required this.mins});
  factory _BookingRequestModel.fromJson(Map<String, dynamic> json) => _$BookingRequestModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String when;
@override final  String reason;
@override@JsonKey() final  String status;
@override final  int mins;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestModelCopyWith<_BookingRequestModel> get copyWith => __$BookingRequestModelCopyWithImpl<_BookingRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.when, when) || other.when == when)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.mins, mins) || other.mins == mins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,when,reason,status,mins);

@override
String toString() {
  return 'BookingRequestModel(id: $id, name: $name, when: $when, reason: $reason, status: $status, mins: $mins)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestModelCopyWith<$Res> implements $BookingRequestModelCopyWith<$Res> {
  factory _$BookingRequestModelCopyWith(_BookingRequestModel value, $Res Function(_BookingRequestModel) _then) = __$BookingRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String when, String reason, String status, int mins
});




}
/// @nodoc
class __$BookingRequestModelCopyWithImpl<$Res>
    implements _$BookingRequestModelCopyWith<$Res> {
  __$BookingRequestModelCopyWithImpl(this._self, this._then);

  final _BookingRequestModel _self;
  final $Res Function(_BookingRequestModel) _then;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? when = null,Object? reason = null,Object? status = null,Object? mins = null,}) {
  return _then(_BookingRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProSessionModel {

 String get id; String get name; String get when; String get type; int get mins; String get status;
/// Create a copy of ProSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProSessionModelCopyWith<ProSessionModel> get copyWith => _$ProSessionModelCopyWithImpl<ProSessionModel>(this as ProSessionModel, _$identity);

  /// Serializes this ProSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.when, when) || other.when == when)&&(identical(other.type, type) || other.type == type)&&(identical(other.mins, mins) || other.mins == mins)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,when,type,mins,status);

@override
String toString() {
  return 'ProSessionModel(id: $id, name: $name, when: $when, type: $type, mins: $mins, status: $status)';
}


}

/// @nodoc
abstract mixin class $ProSessionModelCopyWith<$Res>  {
  factory $ProSessionModelCopyWith(ProSessionModel value, $Res Function(ProSessionModel) _then) = _$ProSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String when, String type, int mins, String status
});




}
/// @nodoc
class _$ProSessionModelCopyWithImpl<$Res>
    implements $ProSessionModelCopyWith<$Res> {
  _$ProSessionModelCopyWithImpl(this._self, this._then);

  final ProSessionModel _self;
  final $Res Function(ProSessionModel) _then;

/// Create a copy of ProSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? when = null,Object? type = null,Object? mins = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProSessionModel].
extension ProSessionModelPatterns on ProSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _ProSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String when,  String type,  int mins,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProSessionModel() when $default != null:
return $default(_that.id,_that.name,_that.when,_that.type,_that.mins,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String when,  String type,  int mins,  String status)  $default,) {final _that = this;
switch (_that) {
case _ProSessionModel():
return $default(_that.id,_that.name,_that.when,_that.type,_that.mins,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String when,  String type,  int mins,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ProSessionModel() when $default != null:
return $default(_that.id,_that.name,_that.when,_that.type,_that.mins,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProSessionModel implements ProSessionModel {
  const _ProSessionModel({required this.id, required this.name, required this.when, required this.type, required this.mins, this.status = 'Accepted'});
  factory _ProSessionModel.fromJson(Map<String, dynamic> json) => _$ProSessionModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String when;
@override final  String type;
@override final  int mins;
@override@JsonKey() final  String status;

/// Create a copy of ProSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProSessionModelCopyWith<_ProSessionModel> get copyWith => __$ProSessionModelCopyWithImpl<_ProSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.when, when) || other.when == when)&&(identical(other.type, type) || other.type == type)&&(identical(other.mins, mins) || other.mins == mins)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,when,type,mins,status);

@override
String toString() {
  return 'ProSessionModel(id: $id, name: $name, when: $when, type: $type, mins: $mins, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ProSessionModelCopyWith<$Res> implements $ProSessionModelCopyWith<$Res> {
  factory _$ProSessionModelCopyWith(_ProSessionModel value, $Res Function(_ProSessionModel) _then) = __$ProSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String when, String type, int mins, String status
});




}
/// @nodoc
class __$ProSessionModelCopyWithImpl<$Res>
    implements _$ProSessionModelCopyWith<$Res> {
  __$ProSessionModelCopyWithImpl(this._self, this._then);

  final _ProSessionModel _self;
  final $Res Function(_ProSessionModel) _then;

/// Create a copy of ProSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? when = null,Object? type = null,Object? mins = null,Object? status = null,}) {
  return _then(_ProSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,when: null == when ? _self.when : when // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,mins: null == mins ? _self.mins : mins // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProPostModel {

 String get id; String get topic; String get time; String get status; bool get image; int get likes; int get comments; int get views; String get title;
/// Create a copy of ProPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProPostModelCopyWith<ProPostModel> get copyWith => _$ProPostModelCopyWithImpl<ProPostModel>(this as ProPostModel, _$identity);

  /// Serializes this ProPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.time, time) || other.time == time)&&(identical(other.status, status) || other.status == status)&&(identical(other.image, image) || other.image == image)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.views, views) || other.views == views)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,time,status,image,likes,comments,views,title);

@override
String toString() {
  return 'ProPostModel(id: $id, topic: $topic, time: $time, status: $status, image: $image, likes: $likes, comments: $comments, views: $views, title: $title)';
}


}

/// @nodoc
abstract mixin class $ProPostModelCopyWith<$Res>  {
  factory $ProPostModelCopyWith(ProPostModel value, $Res Function(ProPostModel) _then) = _$ProPostModelCopyWithImpl;
@useResult
$Res call({
 String id, String topic, String time, String status, bool image, int likes, int comments, int views, String title
});




}
/// @nodoc
class _$ProPostModelCopyWithImpl<$Res>
    implements $ProPostModelCopyWith<$Res> {
  _$ProPostModelCopyWithImpl(this._self, this._then);

  final ProPostModel _self;
  final $Res Function(ProPostModel) _then;

/// Create a copy of ProPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? time = null,Object? status = null,Object? image = null,Object? likes = null,Object? comments = null,Object? views = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as bool,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProPostModel].
extension ProPostModelPatterns on ProPostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProPostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProPostModel value)  $default,){
final _that = this;
switch (_that) {
case _ProPostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProPostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String topic,  String time,  String status,  bool image,  int likes,  int comments,  int views,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProPostModel() when $default != null:
return $default(_that.id,_that.topic,_that.time,_that.status,_that.image,_that.likes,_that.comments,_that.views,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String topic,  String time,  String status,  bool image,  int likes,  int comments,  int views,  String title)  $default,) {final _that = this;
switch (_that) {
case _ProPostModel():
return $default(_that.id,_that.topic,_that.time,_that.status,_that.image,_that.likes,_that.comments,_that.views,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String topic,  String time,  String status,  bool image,  int likes,  int comments,  int views,  String title)?  $default,) {final _that = this;
switch (_that) {
case _ProPostModel() when $default != null:
return $default(_that.id,_that.topic,_that.time,_that.status,_that.image,_that.likes,_that.comments,_that.views,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProPostModel implements ProPostModel {
  const _ProPostModel({required this.id, required this.topic, required this.time, this.status = 'Published', this.image = false, this.likes = 0, this.comments = 0, this.views = 0, required this.title});
  factory _ProPostModel.fromJson(Map<String, dynamic> json) => _$ProPostModelFromJson(json);

@override final  String id;
@override final  String topic;
@override final  String time;
@override@JsonKey() final  String status;
@override@JsonKey() final  bool image;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int comments;
@override@JsonKey() final  int views;
@override final  String title;

/// Create a copy of ProPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProPostModelCopyWith<_ProPostModel> get copyWith => __$ProPostModelCopyWithImpl<_ProPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.time, time) || other.time == time)&&(identical(other.status, status) || other.status == status)&&(identical(other.image, image) || other.image == image)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.views, views) || other.views == views)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,time,status,image,likes,comments,views,title);

@override
String toString() {
  return 'ProPostModel(id: $id, topic: $topic, time: $time, status: $status, image: $image, likes: $likes, comments: $comments, views: $views, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ProPostModelCopyWith<$Res> implements $ProPostModelCopyWith<$Res> {
  factory _$ProPostModelCopyWith(_ProPostModel value, $Res Function(_ProPostModel) _then) = __$ProPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String topic, String time, String status, bool image, int likes, int comments, int views, String title
});




}
/// @nodoc
class __$ProPostModelCopyWithImpl<$Res>
    implements _$ProPostModelCopyWith<$Res> {
  __$ProPostModelCopyWithImpl(this._self, this._then);

  final _ProPostModel _self;
  final $Res Function(_ProPostModel) _then;

/// Create a copy of ProPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? time = null,Object? status = null,Object? image = null,Object? likes = null,Object? comments = null,Object? views = null,Object? title = null,}) {
  return _then(_ProPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as bool,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProClientModel {

 String get id; String get name; String get last; String get time; int get unread; bool get online;
/// Create a copy of ProClientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProClientModelCopyWith<ProClientModel> get copyWith => _$ProClientModelCopyWithImpl<ProClientModel>(this as ProClientModel, _$identity);

  /// Serializes this ProClientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.last, last) || other.last == last)&&(identical(other.time, time) || other.time == time)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,last,time,unread,online);

@override
String toString() {
  return 'ProClientModel(id: $id, name: $name, last: $last, time: $time, unread: $unread, online: $online)';
}


}

/// @nodoc
abstract mixin class $ProClientModelCopyWith<$Res>  {
  factory $ProClientModelCopyWith(ProClientModel value, $Res Function(ProClientModel) _then) = _$ProClientModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String last, String time, int unread, bool online
});




}
/// @nodoc
class _$ProClientModelCopyWithImpl<$Res>
    implements $ProClientModelCopyWith<$Res> {
  _$ProClientModelCopyWithImpl(this._self, this._then);

  final ProClientModel _self;
  final $Res Function(ProClientModel) _then;

/// Create a copy of ProClientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? last = null,Object? time = null,Object? unread = null,Object? online = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProClientModel].
extension ProClientModelPatterns on ProClientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProClientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProClientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProClientModel value)  $default,){
final _that = this;
switch (_that) {
case _ProClientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProClientModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProClientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String last,  String time,  int unread,  bool online)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProClientModel() when $default != null:
return $default(_that.id,_that.name,_that.last,_that.time,_that.unread,_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String last,  String time,  int unread,  bool online)  $default,) {final _that = this;
switch (_that) {
case _ProClientModel():
return $default(_that.id,_that.name,_that.last,_that.time,_that.unread,_that.online);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String last,  String time,  int unread,  bool online)?  $default,) {final _that = this;
switch (_that) {
case _ProClientModel() when $default != null:
return $default(_that.id,_that.name,_that.last,_that.time,_that.unread,_that.online);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProClientModel implements ProClientModel {
  const _ProClientModel({required this.id, required this.name, required this.last, required this.time, this.unread = 0, this.online = false});
  factory _ProClientModel.fromJson(Map<String, dynamic> json) => _$ProClientModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String last;
@override final  String time;
@override@JsonKey() final  int unread;
@override@JsonKey() final  bool online;

/// Create a copy of ProClientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProClientModelCopyWith<_ProClientModel> get copyWith => __$ProClientModelCopyWithImpl<_ProClientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProClientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.last, last) || other.last == last)&&(identical(other.time, time) || other.time == time)&&(identical(other.unread, unread) || other.unread == unread)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,last,time,unread,online);

@override
String toString() {
  return 'ProClientModel(id: $id, name: $name, last: $last, time: $time, unread: $unread, online: $online)';
}


}

/// @nodoc
abstract mixin class _$ProClientModelCopyWith<$Res> implements $ProClientModelCopyWith<$Res> {
  factory _$ProClientModelCopyWith(_ProClientModel value, $Res Function(_ProClientModel) _then) = __$ProClientModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String last, String time, int unread, bool online
});




}
/// @nodoc
class __$ProClientModelCopyWithImpl<$Res>
    implements _$ProClientModelCopyWith<$Res> {
  __$ProClientModelCopyWithImpl(this._self, this._then);

  final _ProClientModel _self;
  final $Res Function(_ProClientModel) _then;

/// Create a copy of ProClientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? last = null,Object? time = null,Object? unread = null,Object? online = null,}) {
  return _then(_ProClientModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DashboardStatsModel {

 String get sessionsToday; String get newRequests; String get rating; String get weekEarnings;
/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsModelCopyWith<DashboardStatsModel> get copyWith => _$DashboardStatsModelCopyWithImpl<DashboardStatsModel>(this as DashboardStatsModel, _$identity);

  /// Serializes this DashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStatsModel&&(identical(other.sessionsToday, sessionsToday) || other.sessionsToday == sessionsToday)&&(identical(other.newRequests, newRequests) || other.newRequests == newRequests)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.weekEarnings, weekEarnings) || other.weekEarnings == weekEarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionsToday,newRequests,rating,weekEarnings);

@override
String toString() {
  return 'DashboardStatsModel(sessionsToday: $sessionsToday, newRequests: $newRequests, rating: $rating, weekEarnings: $weekEarnings)';
}


}

/// @nodoc
abstract mixin class $DashboardStatsModelCopyWith<$Res>  {
  factory $DashboardStatsModelCopyWith(DashboardStatsModel value, $Res Function(DashboardStatsModel) _then) = _$DashboardStatsModelCopyWithImpl;
@useResult
$Res call({
 String sessionsToday, String newRequests, String rating, String weekEarnings
});




}
/// @nodoc
class _$DashboardStatsModelCopyWithImpl<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  _$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final DashboardStatsModel _self;
  final $Res Function(DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionsToday = null,Object? newRequests = null,Object? rating = null,Object? weekEarnings = null,}) {
  return _then(_self.copyWith(
sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as String,newRequests: null == newRequests ? _self.newRequests : newRequests // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,weekEarnings: null == weekEarnings ? _self.weekEarnings : weekEarnings // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardStatsModel].
extension DashboardStatsModelPatterns on DashboardStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionsToday,  String newRequests,  String rating,  String weekEarnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.sessionsToday,_that.newRequests,_that.rating,_that.weekEarnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionsToday,  String newRequests,  String rating,  String weekEarnings)  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel():
return $default(_that.sessionsToday,_that.newRequests,_that.rating,_that.weekEarnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionsToday,  String newRequests,  String rating,  String weekEarnings)?  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.sessionsToday,_that.newRequests,_that.rating,_that.weekEarnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardStatsModel implements DashboardStatsModel {
  const _DashboardStatsModel({required this.sessionsToday, required this.newRequests, required this.rating, required this.weekEarnings});
  factory _DashboardStatsModel.fromJson(Map<String, dynamic> json) => _$DashboardStatsModelFromJson(json);

@override final  String sessionsToday;
@override final  String newRequests;
@override final  String rating;
@override final  String weekEarnings;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsModelCopyWith<_DashboardStatsModel> get copyWith => __$DashboardStatsModelCopyWithImpl<_DashboardStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStatsModel&&(identical(other.sessionsToday, sessionsToday) || other.sessionsToday == sessionsToday)&&(identical(other.newRequests, newRequests) || other.newRequests == newRequests)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.weekEarnings, weekEarnings) || other.weekEarnings == weekEarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionsToday,newRequests,rating,weekEarnings);

@override
String toString() {
  return 'DashboardStatsModel(sessionsToday: $sessionsToday, newRequests: $newRequests, rating: $rating, weekEarnings: $weekEarnings)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsModelCopyWith<$Res> implements $DashboardStatsModelCopyWith<$Res> {
  factory _$DashboardStatsModelCopyWith(_DashboardStatsModel value, $Res Function(_DashboardStatsModel) _then) = __$DashboardStatsModelCopyWithImpl;
@override @useResult
$Res call({
 String sessionsToday, String newRequests, String rating, String weekEarnings
});




}
/// @nodoc
class __$DashboardStatsModelCopyWithImpl<$Res>
    implements _$DashboardStatsModelCopyWith<$Res> {
  __$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final _DashboardStatsModel _self;
  final $Res Function(_DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionsToday = null,Object? newRequests = null,Object? rating = null,Object? weekEarnings = null,}) {
  return _then(_DashboardStatsModel(
sessionsToday: null == sessionsToday ? _self.sessionsToday : sessionsToday // ignore: cast_nullable_to_non_nullable
as String,newRequests: null == newRequests ? _self.newRequests : newRequests // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,weekEarnings: null == weekEarnings ? _self.weekEarnings : weekEarnings // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
