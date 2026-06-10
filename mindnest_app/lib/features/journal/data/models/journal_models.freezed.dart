// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalEntryModel {

 String get id; String get day; String get date; String get time; int get mood; String get title; String get body; List<String> get tags; bool get draft;
/// Create a copy of JournalEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalEntryModelCopyWith<JournalEntryModel> get copyWith => _$JournalEntryModelCopyWithImpl<JournalEntryModel>(this as JournalEntryModel, _$identity);

  /// Serializes this JournalEntryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEntryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.day, day) || other.day == day)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.draft, draft) || other.draft == draft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,day,date,time,mood,title,body,const DeepCollectionEquality().hash(tags),draft);

@override
String toString() {
  return 'JournalEntryModel(id: $id, day: $day, date: $date, time: $time, mood: $mood, title: $title, body: $body, tags: $tags, draft: $draft)';
}


}

/// @nodoc
abstract mixin class $JournalEntryModelCopyWith<$Res>  {
  factory $JournalEntryModelCopyWith(JournalEntryModel value, $Res Function(JournalEntryModel) _then) = _$JournalEntryModelCopyWithImpl;
@useResult
$Res call({
 String id, String day, String date, String time, int mood, String title, String body, List<String> tags, bool draft
});




}
/// @nodoc
class _$JournalEntryModelCopyWithImpl<$Res>
    implements $JournalEntryModelCopyWith<$Res> {
  _$JournalEntryModelCopyWithImpl(this._self, this._then);

  final JournalEntryModel _self;
  final $Res Function(JournalEntryModel) _then;

/// Create a copy of JournalEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? day = null,Object? date = null,Object? time = null,Object? mood = null,Object? title = null,Object? body = null,Object? tags = null,Object? draft = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalEntryModel].
extension JournalEntryModelPatterns on JournalEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _JournalEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _JournalEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String day,  String date,  String time,  int mood,  String title,  String body,  List<String> tags,  bool draft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalEntryModel() when $default != null:
return $default(_that.id,_that.day,_that.date,_that.time,_that.mood,_that.title,_that.body,_that.tags,_that.draft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String day,  String date,  String time,  int mood,  String title,  String body,  List<String> tags,  bool draft)  $default,) {final _that = this;
switch (_that) {
case _JournalEntryModel():
return $default(_that.id,_that.day,_that.date,_that.time,_that.mood,_that.title,_that.body,_that.tags,_that.draft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String day,  String date,  String time,  int mood,  String title,  String body,  List<String> tags,  bool draft)?  $default,) {final _that = this;
switch (_that) {
case _JournalEntryModel() when $default != null:
return $default(_that.id,_that.day,_that.date,_that.time,_that.mood,_that.title,_that.body,_that.tags,_that.draft);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JournalEntryModel implements JournalEntryModel {
  const _JournalEntryModel({required this.id, required this.day, required this.date, required this.time, required this.mood, this.title = '', this.body = '', final  List<String> tags = const <String>[], this.draft = false}): _tags = tags;
  factory _JournalEntryModel.fromJson(Map<String, dynamic> json) => _$JournalEntryModelFromJson(json);

@override final  String id;
@override final  String day;
@override final  String date;
@override final  String time;
@override final  int mood;
@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool draft;

/// Create a copy of JournalEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalEntryModelCopyWith<_JournalEntryModel> get copyWith => __$JournalEntryModelCopyWithImpl<_JournalEntryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JournalEntryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalEntryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.day, day) || other.day == day)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.draft, draft) || other.draft == draft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,day,date,time,mood,title,body,const DeepCollectionEquality().hash(_tags),draft);

@override
String toString() {
  return 'JournalEntryModel(id: $id, day: $day, date: $date, time: $time, mood: $mood, title: $title, body: $body, tags: $tags, draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$JournalEntryModelCopyWith<$Res> implements $JournalEntryModelCopyWith<$Res> {
  factory _$JournalEntryModelCopyWith(_JournalEntryModel value, $Res Function(_JournalEntryModel) _then) = __$JournalEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String day, String date, String time, int mood, String title, String body, List<String> tags, bool draft
});




}
/// @nodoc
class __$JournalEntryModelCopyWithImpl<$Res>
    implements _$JournalEntryModelCopyWith<$Res> {
  __$JournalEntryModelCopyWithImpl(this._self, this._then);

  final _JournalEntryModel _self;
  final $Res Function(_JournalEntryModel) _then;

/// Create a copy of JournalEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? day = null,Object? date = null,Object? time = null,Object? mood = null,Object? title = null,Object? body = null,Object? tags = null,Object? draft = null,}) {
  return _then(_JournalEntryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
