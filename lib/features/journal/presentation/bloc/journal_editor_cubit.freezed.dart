// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalEditorState {

 JournalEntry get entry; bool get saving; bool get saved; String? get error;
/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalEditorStateCopyWith<JournalEditorState> get copyWith => _$JournalEditorStateCopyWithImpl<JournalEditorState>(this as JournalEditorState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JournalEditorState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEditorState&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as JournalEditorState;
  return Object.hash(runtimeType,_this.entry,_this.saving,_this.saved,_this.error);
}

@override
String toString() {
  final _this = this as JournalEditorState;
  return 'JournalEditorState(entry: ${_this.entry}, saving: ${_this.saving}, saved: ${_this.saved}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $JournalEditorStateCopyWith<$Res>  {
  factory $JournalEditorStateCopyWith(JournalEditorState value, $Res Function(JournalEditorState) _then) = _$JournalEditorStateCopyWithImpl;
@useResult
$Res call({
 JournalEntry entry, bool saving, bool saved, String? error
});


$JournalEntryCopyWith<$Res> get entry;

}
/// @nodoc
class _$JournalEditorStateCopyWithImpl<$Res>
    implements $JournalEditorStateCopyWith<$Res> {
  _$JournalEditorStateCopyWithImpl(this._self, this._then);

  final JournalEditorState _self;
  final $Res Function(JournalEditorState) _then;

/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = null,Object? saving = null,Object? saved = null,Object? error = freezed,}) {
  return _then(JournalEditorState(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as JournalEntry,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<$Res> get entry {
  
  return $JournalEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}


/// Adds pattern-matching-related methods to [JournalEditorState].
extension JournalEditorStatePatterns on JournalEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalEditorState value)  $default,){
final _that = this;
switch (_that) {
case _JournalEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _JournalEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JournalEntry entry,  bool saving,  bool saved,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalEditorState() when $default != null:
return $default(_that.entry,_that.saving,_that.saved,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JournalEntry entry,  bool saving,  bool saved,  String? error)  $default,) {final _that = this;
switch (_that) {
case _JournalEditorState():
return $default(_that.entry,_that.saving,_that.saved,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JournalEntry entry,  bool saving,  bool saved,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _JournalEditorState() when $default != null:
return $default(_that.entry,_that.saving,_that.saved,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _JournalEditorState implements JournalEditorState {
  const _JournalEditorState({required this.entry, this.saving = false, this.saved = false, this.error});
  

@override final  JournalEntry entry;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;
@override final  String? error;

/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalEditorStateCopyWith<_JournalEditorState> get copyWith => __$JournalEditorStateCopyWithImpl<_JournalEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalEditorState&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,entry,saving,saved,error);
}

@override
String toString() {
    return 'JournalEditorState(entry: $entry, saving: $saving, saved: $saved, error: $error)';
}


}

/// @nodoc
abstract mixin class _$JournalEditorStateCopyWith<$Res> implements $JournalEditorStateCopyWith<$Res> {
  factory _$JournalEditorStateCopyWith(_JournalEditorState value, $Res Function(_JournalEditorState) _then) = __$JournalEditorStateCopyWithImpl;
@override @useResult
$Res call({
 JournalEntry entry, bool saving, bool saved, String? error
});


@override $JournalEntryCopyWith<$Res> get entry;

}
/// @nodoc
class __$JournalEditorStateCopyWithImpl<$Res>
    implements _$JournalEditorStateCopyWith<$Res> {
  __$JournalEditorStateCopyWithImpl(this._self, this._then);

  final _JournalEditorState _self;
  final $Res Function(_JournalEditorState) _then;

/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = null,Object? saving = null,Object? saved = null,Object? error = freezed,}) {
  return _then(_JournalEditorState(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as JournalEntry,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JournalEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<$Res> get entry {
  
  return $JournalEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

// dart format on
