// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalEntry {

 String get id; String get title; String get body; int get mood; List<String> get tags; DateTime get createdAt; bool get draft; bool get favourite;
/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<JournalEntry> get copyWith => _$JournalEntryCopyWithImpl<JournalEntry>(this as JournalEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JournalEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.favourite, _this.favourite) || other.favourite == _this.favourite));
}


@override
int get hashCode {
  final _this = this as JournalEntry;
  return Object.hash(runtimeType,_this.id,_this.title,_this.body,_this.mood,const DeepCollectionEquality().hash(_this.tags),_this.createdAt,_this.draft,_this.favourite);
}

@override
String toString() {
  final _this = this as JournalEntry;
  return 'JournalEntry(id: ${_this.id}, title: ${_this.title}, body: ${_this.body}, mood: ${_this.mood}, tags: ${_this.tags}, createdAt: ${_this.createdAt}, draft: ${_this.draft}, favourite: ${_this.favourite})';
}


}

/// @nodoc
abstract mixin class $JournalEntryCopyWith<$Res>  {
  factory $JournalEntryCopyWith(JournalEntry value, $Res Function(JournalEntry) _then) = _$JournalEntryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, int mood, List<String> tags, DateTime createdAt, bool draft, bool favourite
});




}
/// @nodoc
class _$JournalEntryCopyWithImpl<$Res>
    implements $JournalEntryCopyWith<$Res> {
  _$JournalEntryCopyWithImpl(this._self, this._then);

  final JournalEntry _self;
  final $Res Function(JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? mood = null,Object? tags = null,Object? createdAt = null,Object? draft = null,Object? favourite = null,}) {
  return _then(JournalEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as bool,favourite: null == favourite ? _self.favourite : favourite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalEntry].
extension JournalEntryPatterns on JournalEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalEntry value)  $default,){
final _that = this;
switch (_that) {
case _JournalEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  int mood,  List<String> tags,  DateTime createdAt,  bool draft,  bool favourite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.mood,_that.tags,_that.createdAt,_that.draft,_that.favourite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  int mood,  List<String> tags,  DateTime createdAt,  bool draft,  bool favourite)  $default,) {final _that = this;
switch (_that) {
case _JournalEntry():
return $default(_that.id,_that.title,_that.body,_that.mood,_that.tags,_that.createdAt,_that.draft,_that.favourite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  int mood,  List<String> tags,  DateTime createdAt,  bool draft,  bool favourite)?  $default,) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.mood,_that.tags,_that.createdAt,_that.draft,_that.favourite);case _:
  return null;

}
}

}

/// @nodoc


class _JournalEntry extends JournalEntry {
  const _JournalEntry({required this.id, this.title = '', this.body = '', this.mood = 4,  List<String> tags = const <String>[], required this.createdAt, this.draft = false, this.favourite = false}): _tags = tags,super._();
  

@override final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
@override@JsonKey() final  int mood;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime createdAt;
@override@JsonKey() final  bool draft;
@override@JsonKey() final  bool favourite;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalEntryCopyWith<_JournalEntry> get copyWith => __$JournalEntryCopyWithImpl<_JournalEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.favourite, favourite) || other.favourite == favourite));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,body,mood,const DeepCollectionEquality().hash(_tags),createdAt,draft,favourite);
}

@override
String toString() {
    return 'JournalEntry(id: $id, title: $title, body: $body, mood: $mood, tags: $tags, createdAt: $createdAt, draft: $draft, favourite: $favourite)';
}


}

/// @nodoc
abstract mixin class _$JournalEntryCopyWith<$Res> implements $JournalEntryCopyWith<$Res> {
  factory _$JournalEntryCopyWith(_JournalEntry value, $Res Function(_JournalEntry) _then) = __$JournalEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, int mood, List<String> tags, DateTime createdAt, bool draft, bool favourite
});




}
/// @nodoc
class __$JournalEntryCopyWithImpl<$Res>
    implements _$JournalEntryCopyWith<$Res> {
  __$JournalEntryCopyWithImpl(this._self, this._then);

  final _JournalEntry _self;
  final $Res Function(_JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? mood = null,Object? tags = null,Object? createdAt = null,Object? draft = null,Object? favourite = null,}) {
  return _then(_JournalEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as bool,favourite: null == favourite ? _self.favourite : favourite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
