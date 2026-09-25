// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'JournalEvent()';
}


}

/// @nodoc
class $JournalEventCopyWith<$Res>  {
$JournalEventCopyWith(JournalEvent _, $Res Function(JournalEvent) __);
}


/// Adds pattern-matching-related methods to [JournalEvent].
extension JournalEventPatterns on JournalEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JournalLoad value)?  load,TResult Function( JournalViewChanged value)?  viewChanged,TResult Function( JournalFilterChanged value)?  filterChanged,TResult Function( JournalMonthChanged value)?  monthChanged,TResult Function( JournalSelected value)?  selected,TResult Function( JournalComposeToggled value)?  composeToggled,TResult Function( JournalSaved value)?  saved,TResult Function( JournalDeleted value)?  deleted,TResult Function( JournalFavouriteToggled value)?  favouriteToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JournalLoad() when load != null:
return load(_that);case JournalViewChanged() when viewChanged != null:
return viewChanged(_that);case JournalFilterChanged() when filterChanged != null:
return filterChanged(_that);case JournalMonthChanged() when monthChanged != null:
return monthChanged(_that);case JournalSelected() when selected != null:
return selected(_that);case JournalComposeToggled() when composeToggled != null:
return composeToggled(_that);case JournalSaved() when saved != null:
return saved(_that);case JournalDeleted() when deleted != null:
return deleted(_that);case JournalFavouriteToggled() when favouriteToggled != null:
return favouriteToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JournalLoad value)  load,required TResult Function( JournalViewChanged value)  viewChanged,required TResult Function( JournalFilterChanged value)  filterChanged,required TResult Function( JournalMonthChanged value)  monthChanged,required TResult Function( JournalSelected value)  selected,required TResult Function( JournalComposeToggled value)  composeToggled,required TResult Function( JournalSaved value)  saved,required TResult Function( JournalDeleted value)  deleted,required TResult Function( JournalFavouriteToggled value)  favouriteToggled,}){
final _that = this;
switch (_that) {
case JournalLoad():
return load(_that);case JournalViewChanged():
return viewChanged(_that);case JournalFilterChanged():
return filterChanged(_that);case JournalMonthChanged():
return monthChanged(_that);case JournalSelected():
return selected(_that);case JournalComposeToggled():
return composeToggled(_that);case JournalSaved():
return saved(_that);case JournalDeleted():
return deleted(_that);case JournalFavouriteToggled():
return favouriteToggled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JournalLoad value)?  load,TResult? Function( JournalViewChanged value)?  viewChanged,TResult? Function( JournalFilterChanged value)?  filterChanged,TResult? Function( JournalMonthChanged value)?  monthChanged,TResult? Function( JournalSelected value)?  selected,TResult? Function( JournalComposeToggled value)?  composeToggled,TResult? Function( JournalSaved value)?  saved,TResult? Function( JournalDeleted value)?  deleted,TResult? Function( JournalFavouriteToggled value)?  favouriteToggled,}){
final _that = this;
switch (_that) {
case JournalLoad() when load != null:
return load(_that);case JournalViewChanged() when viewChanged != null:
return viewChanged(_that);case JournalFilterChanged() when filterChanged != null:
return filterChanged(_that);case JournalMonthChanged() when monthChanged != null:
return monthChanged(_that);case JournalSelected() when selected != null:
return selected(_that);case JournalComposeToggled() when composeToggled != null:
return composeToggled(_that);case JournalSaved() when saved != null:
return saved(_that);case JournalDeleted() when deleted != null:
return deleted(_that);case JournalFavouriteToggled() when favouriteToggled != null:
return favouriteToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( JournalView view)?  viewChanged,TResult Function( JournalFilter filter)?  filterChanged,TResult Function( int delta)?  monthChanged,TResult Function( String? id)?  selected,TResult Function( bool composing)?  composeToggled,TResult Function( JournalEntry entry)?  saved,TResult Function( String id)?  deleted,TResult Function( String id)?  favouriteToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JournalLoad() when load != null:
return load();case JournalViewChanged() when viewChanged != null:
return viewChanged(_that.view);case JournalFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case JournalMonthChanged() when monthChanged != null:
return monthChanged(_that.delta);case JournalSelected() when selected != null:
return selected(_that.id);case JournalComposeToggled() when composeToggled != null:
return composeToggled(_that.composing);case JournalSaved() when saved != null:
return saved(_that.entry);case JournalDeleted() when deleted != null:
return deleted(_that.id);case JournalFavouriteToggled() when favouriteToggled != null:
return favouriteToggled(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( JournalView view)  viewChanged,required TResult Function( JournalFilter filter)  filterChanged,required TResult Function( int delta)  monthChanged,required TResult Function( String? id)  selected,required TResult Function( bool composing)  composeToggled,required TResult Function( JournalEntry entry)  saved,required TResult Function( String id)  deleted,required TResult Function( String id)  favouriteToggled,}) {final _that = this;
switch (_that) {
case JournalLoad():
return load();case JournalViewChanged():
return viewChanged(_that.view);case JournalFilterChanged():
return filterChanged(_that.filter);case JournalMonthChanged():
return monthChanged(_that.delta);case JournalSelected():
return selected(_that.id);case JournalComposeToggled():
return composeToggled(_that.composing);case JournalSaved():
return saved(_that.entry);case JournalDeleted():
return deleted(_that.id);case JournalFavouriteToggled():
return favouriteToggled(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( JournalView view)?  viewChanged,TResult? Function( JournalFilter filter)?  filterChanged,TResult? Function( int delta)?  monthChanged,TResult? Function( String? id)?  selected,TResult? Function( bool composing)?  composeToggled,TResult? Function( JournalEntry entry)?  saved,TResult? Function( String id)?  deleted,TResult? Function( String id)?  favouriteToggled,}) {final _that = this;
switch (_that) {
case JournalLoad() when load != null:
return load();case JournalViewChanged() when viewChanged != null:
return viewChanged(_that.view);case JournalFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case JournalMonthChanged() when monthChanged != null:
return monthChanged(_that.delta);case JournalSelected() when selected != null:
return selected(_that.id);case JournalComposeToggled() when composeToggled != null:
return composeToggled(_that.composing);case JournalSaved() when saved != null:
return saved(_that.entry);case JournalDeleted() when deleted != null:
return deleted(_that.id);case JournalFavouriteToggled() when favouriteToggled != null:
return favouriteToggled(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class JournalLoad implements JournalEvent {
  const JournalLoad();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'JournalEvent.load()';
}


}




/// @nodoc


class JournalViewChanged implements JournalEvent {
  const JournalViewChanged(this.view);
  

 final  JournalView view;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalViewChangedCopyWith<JournalViewChanged> get copyWith => _$JournalViewChangedCopyWithImpl<JournalViewChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalViewChanged&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode {
    return Object.hash(runtimeType,view);
}

@override
String toString() {
    return 'JournalEvent.viewChanged(view: $view)';
}


}

/// @nodoc
abstract mixin class $JournalViewChangedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalViewChangedCopyWith(JournalViewChanged value, $Res Function(JournalViewChanged) _then) = _$JournalViewChangedCopyWithImpl;
@useResult
$Res call({
 JournalView view
});




}
/// @nodoc
class _$JournalViewChangedCopyWithImpl<$Res>
    implements $JournalViewChangedCopyWith<$Res> {
  _$JournalViewChangedCopyWithImpl(this._self, this._then);

  final JournalViewChanged _self;
  final $Res Function(JournalViewChanged) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? view = null,}) {
  return _then(JournalViewChanged(
null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as JournalView,
  ));
}


}

/// @nodoc


class JournalFilterChanged implements JournalEvent {
  const JournalFilterChanged(this.filter);
  

 final  JournalFilter filter;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalFilterChangedCopyWith<JournalFilterChanged> get copyWith => _$JournalFilterChangedCopyWithImpl<JournalFilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalFilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filter);
}

@override
String toString() {
    return 'JournalEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $JournalFilterChangedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalFilterChangedCopyWith(JournalFilterChanged value, $Res Function(JournalFilterChanged) _then) = _$JournalFilterChangedCopyWithImpl;
@useResult
$Res call({
 JournalFilter filter
});




}
/// @nodoc
class _$JournalFilterChangedCopyWithImpl<$Res>
    implements $JournalFilterChangedCopyWith<$Res> {
  _$JournalFilterChangedCopyWithImpl(this._self, this._then);

  final JournalFilterChanged _self;
  final $Res Function(JournalFilterChanged) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(JournalFilterChanged(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as JournalFilter,
  ));
}


}

/// @nodoc


class JournalMonthChanged implements JournalEvent {
  const JournalMonthChanged(this.delta);
  

 final  int delta;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalMonthChangedCopyWith<JournalMonthChanged> get copyWith => _$JournalMonthChangedCopyWithImpl<JournalMonthChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalMonthChanged&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode {
    return Object.hash(runtimeType,delta);
}

@override
String toString() {
    return 'JournalEvent.monthChanged(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $JournalMonthChangedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalMonthChangedCopyWith(JournalMonthChanged value, $Res Function(JournalMonthChanged) _then) = _$JournalMonthChangedCopyWithImpl;
@useResult
$Res call({
 int delta
});




}
/// @nodoc
class _$JournalMonthChangedCopyWithImpl<$Res>
    implements $JournalMonthChangedCopyWith<$Res> {
  _$JournalMonthChangedCopyWithImpl(this._self, this._then);

  final JournalMonthChanged _self;
  final $Res Function(JournalMonthChanged) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(JournalMonthChanged(
null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class JournalSelected implements JournalEvent {
  const JournalSelected(this.id);
  

 final  String? id;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalSelectedCopyWith<JournalSelected> get copyWith => _$JournalSelectedCopyWithImpl<JournalSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalSelected&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'JournalEvent.selected(id: $id)';
}


}

/// @nodoc
abstract mixin class $JournalSelectedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalSelectedCopyWith(JournalSelected value, $Res Function(JournalSelected) _then) = _$JournalSelectedCopyWithImpl;
@useResult
$Res call({
 String? id
});




}
/// @nodoc
class _$JournalSelectedCopyWithImpl<$Res>
    implements $JournalSelectedCopyWith<$Res> {
  _$JournalSelectedCopyWithImpl(this._self, this._then);

  final JournalSelected _self;
  final $Res Function(JournalSelected) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(JournalSelected(
freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class JournalComposeToggled implements JournalEvent {
  const JournalComposeToggled(this.composing);
  

 final  bool composing;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalComposeToggledCopyWith<JournalComposeToggled> get copyWith => _$JournalComposeToggledCopyWithImpl<JournalComposeToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalComposeToggled&&(identical(other.composing, composing) || other.composing == composing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,composing);
}

@override
String toString() {
    return 'JournalEvent.composeToggled(composing: $composing)';
}


}

/// @nodoc
abstract mixin class $JournalComposeToggledCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalComposeToggledCopyWith(JournalComposeToggled value, $Res Function(JournalComposeToggled) _then) = _$JournalComposeToggledCopyWithImpl;
@useResult
$Res call({
 bool composing
});




}
/// @nodoc
class _$JournalComposeToggledCopyWithImpl<$Res>
    implements $JournalComposeToggledCopyWith<$Res> {
  _$JournalComposeToggledCopyWithImpl(this._self, this._then);

  final JournalComposeToggled _self;
  final $Res Function(JournalComposeToggled) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? composing = null,}) {
  return _then(JournalComposeToggled(
null == composing ? _self.composing : composing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class JournalSaved implements JournalEvent {
  const JournalSaved(this.entry);
  

 final  JournalEntry entry;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalSavedCopyWith<JournalSaved> get copyWith => _$JournalSavedCopyWithImpl<JournalSaved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalSaved&&(identical(other.entry, entry) || other.entry == entry));
}


@override
int get hashCode {
    return Object.hash(runtimeType,entry);
}

@override
String toString() {
    return 'JournalEvent.saved(entry: $entry)';
}


}

/// @nodoc
abstract mixin class $JournalSavedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalSavedCopyWith(JournalSaved value, $Res Function(JournalSaved) _then) = _$JournalSavedCopyWithImpl;
@useResult
$Res call({
 JournalEntry entry
});


$JournalEntryCopyWith<$Res> get entry;

}
/// @nodoc
class _$JournalSavedCopyWithImpl<$Res>
    implements $JournalSavedCopyWith<$Res> {
  _$JournalSavedCopyWithImpl(this._self, this._then);

  final JournalSaved _self;
  final $Res Function(JournalSaved) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entry = null,}) {
  return _then(JournalSaved(
null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as JournalEntry,
  ));
}

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<$Res> get entry {
  
  return $JournalEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

/// @nodoc


class JournalDeleted implements JournalEvent {
  const JournalDeleted(this.id);
  

 final  String id;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalDeletedCopyWith<JournalDeleted> get copyWith => _$JournalDeletedCopyWithImpl<JournalDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'JournalEvent.deleted(id: $id)';
}


}

/// @nodoc
abstract mixin class $JournalDeletedCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalDeletedCopyWith(JournalDeleted value, $Res Function(JournalDeleted) _then) = _$JournalDeletedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$JournalDeletedCopyWithImpl<$Res>
    implements $JournalDeletedCopyWith<$Res> {
  _$JournalDeletedCopyWithImpl(this._self, this._then);

  final JournalDeleted _self;
  final $Res Function(JournalDeleted) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(JournalDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class JournalFavouriteToggled implements JournalEvent {
  const JournalFavouriteToggled(this.id);
  

 final  String id;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalFavouriteToggledCopyWith<JournalFavouriteToggled> get copyWith => _$JournalFavouriteToggledCopyWithImpl<JournalFavouriteToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalFavouriteToggled&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'JournalEvent.favouriteToggled(id: $id)';
}


}

/// @nodoc
abstract mixin class $JournalFavouriteToggledCopyWith<$Res> implements $JournalEventCopyWith<$Res> {
  factory $JournalFavouriteToggledCopyWith(JournalFavouriteToggled value, $Res Function(JournalFavouriteToggled) _then) = _$JournalFavouriteToggledCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$JournalFavouriteToggledCopyWithImpl<$Res>
    implements $JournalFavouriteToggledCopyWith<$Res> {
  _$JournalFavouriteToggledCopyWithImpl(this._self, this._then);

  final JournalFavouriteToggled _self;
  final $Res Function(JournalFavouriteToggled) _then;

/// Create a copy of JournalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(JournalFavouriteToggled(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$JournalState {

 LoadStatus get status; List<JournalEntry> get entries; JournalView get view; JournalFilter get filter; DateTime get month; String? get selectedId; bool get composing; String? get error;
/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalStateCopyWith<JournalState> get copyWith => _$JournalStateCopyWithImpl<JournalState>(this as JournalState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JournalState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.selectedId, _this.selectedId) || other.selectedId == _this.selectedId)&&(identical(other.composing, _this.composing) || other.composing == _this.composing)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as JournalState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.entries),_this.view,_this.filter,_this.month,_this.selectedId,_this.composing,_this.error);
}

@override
String toString() {
  final _this = this as JournalState;
  return 'JournalState(status: ${_this.status}, entries: ${_this.entries}, view: ${_this.view}, filter: ${_this.filter}, month: ${_this.month}, selectedId: ${_this.selectedId}, composing: ${_this.composing}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $JournalStateCopyWith<$Res>  {
  factory $JournalStateCopyWith(JournalState value, $Res Function(JournalState) _then) = _$JournalStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<JournalEntry> entries, JournalView view, JournalFilter filter, DateTime month, String? selectedId, bool composing, String? error
});




}
/// @nodoc
class _$JournalStateCopyWithImpl<$Res>
    implements $JournalStateCopyWith<$Res> {
  _$JournalStateCopyWithImpl(this._self, this._then);

  final JournalState _self;
  final $Res Function(JournalState) _then;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? entries = null,Object? view = null,Object? filter = null,Object? month = null,Object? selectedId = freezed,Object? composing = null,Object? error = freezed,}) {
  return _then(JournalState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<JournalEntry>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as JournalView,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as JournalFilter,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,composing: null == composing ? _self.composing : composing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalState].
extension JournalStatePatterns on JournalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalState value)  $default,){
final _that = this;
switch (_that) {
case _JournalState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalState value)?  $default,){
final _that = this;
switch (_that) {
case _JournalState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<JournalEntry> entries,  JournalView view,  JournalFilter filter,  DateTime month,  String? selectedId,  bool composing,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalState() when $default != null:
return $default(_that.status,_that.entries,_that.view,_that.filter,_that.month,_that.selectedId,_that.composing,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<JournalEntry> entries,  JournalView view,  JournalFilter filter,  DateTime month,  String? selectedId,  bool composing,  String? error)  $default,) {final _that = this;
switch (_that) {
case _JournalState():
return $default(_that.status,_that.entries,_that.view,_that.filter,_that.month,_that.selectedId,_that.composing,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<JournalEntry> entries,  JournalView view,  JournalFilter filter,  DateTime month,  String? selectedId,  bool composing,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _JournalState() when $default != null:
return $default(_that.status,_that.entries,_that.view,_that.filter,_that.month,_that.selectedId,_that.composing,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _JournalState extends JournalState {
  const _JournalState({this.status = LoadStatus.initial,  List<JournalEntry> entries = const <JournalEntry>[], this.view = JournalView.list, this.filter = JournalFilter.all, required this.month, this.selectedId, this.composing = false, this.error}): _entries = entries,super._();
  

@override@JsonKey() final  LoadStatus status;
 final  List<JournalEntry> _entries;
@override@JsonKey() List<JournalEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override@JsonKey() final  JournalView view;
@override@JsonKey() final  JournalFilter filter;
@override final  DateTime month;
@override final  String? selectedId;
@override@JsonKey() final  bool composing;
@override final  String? error;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalStateCopyWith<_JournalState> get copyWith => __$JournalStateCopyWithImpl<_JournalState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.view, view) || other.view == view)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.month, month) || other.month == month)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.composing, composing) || other.composing == composing)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_entries),view,filter,month,selectedId,composing,error);
}

@override
String toString() {
    return 'JournalState(status: $status, entries: $entries, view: $view, filter: $filter, month: $month, selectedId: $selectedId, composing: $composing, error: $error)';
}


}

/// @nodoc
abstract mixin class _$JournalStateCopyWith<$Res> implements $JournalStateCopyWith<$Res> {
  factory _$JournalStateCopyWith(_JournalState value, $Res Function(_JournalState) _then) = __$JournalStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<JournalEntry> entries, JournalView view, JournalFilter filter, DateTime month, String? selectedId, bool composing, String? error
});




}
/// @nodoc
class __$JournalStateCopyWithImpl<$Res>
    implements _$JournalStateCopyWith<$Res> {
  __$JournalStateCopyWithImpl(this._self, this._then);

  final _JournalState _self;
  final $Res Function(_JournalState) _then;

/// Create a copy of JournalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? entries = null,Object? view = null,Object? filter = null,Object? month = null,Object? selectedId = freezed,Object? composing = null,Object? error = freezed,}) {
  return _then(_JournalState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<JournalEntry>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as JournalView,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as JournalFilter,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,composing: null == composing ? _self.composing : composing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
