// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoodSummary {

 MoodEntry? get today;/// Last 7 days, oldest first (level 1..5).
 List<int> get week;/// Last 28 days, oldest first.
 List<int> get month; int get streak; int get bestStreak;/// Week-over-week change, e.g. 12 for +12%.
 int get trendPercent; List<MoodEntry> get recent; List<MoodInsight> get insights;
/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodSummaryCopyWith<MoodSummary> get copyWith => _$MoodSummaryCopyWithImpl<MoodSummary>(this as MoodSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoodSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodSummary&&(identical(other.today, _this.today) || other.today == _this.today)&&const DeepCollectionEquality().equals(other.week, _this.week)&&const DeepCollectionEquality().equals(other.month, _this.month)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&(identical(other.trendPercent, _this.trendPercent) || other.trendPercent == _this.trendPercent)&&const DeepCollectionEquality().equals(other.recent, _this.recent)&&const DeepCollectionEquality().equals(other.insights, _this.insights));
}


@override
int get hashCode {
  final _this = this as MoodSummary;
  return Object.hash(runtimeType,_this.today,const DeepCollectionEquality().hash(_this.week),const DeepCollectionEquality().hash(_this.month),_this.streak,_this.bestStreak,_this.trendPercent,const DeepCollectionEquality().hash(_this.recent),const DeepCollectionEquality().hash(_this.insights));
}

@override
String toString() {
  final _this = this as MoodSummary;
  return 'MoodSummary(today: ${_this.today}, week: ${_this.week}, month: ${_this.month}, streak: ${_this.streak}, bestStreak: ${_this.bestStreak}, trendPercent: ${_this.trendPercent}, recent: ${_this.recent}, insights: ${_this.insights})';
}


}

/// @nodoc
abstract mixin class $MoodSummaryCopyWith<$Res>  {
  factory $MoodSummaryCopyWith(MoodSummary value, $Res Function(MoodSummary) _then) = _$MoodSummaryCopyWithImpl;
@useResult
$Res call({
 MoodEntry? today, List<int> week, List<int> month, int streak, int bestStreak, int trendPercent, List<MoodEntry> recent, List<MoodInsight> insights
});


$MoodEntryCopyWith<$Res>? get today;

}
/// @nodoc
class _$MoodSummaryCopyWithImpl<$Res>
    implements $MoodSummaryCopyWith<$Res> {
  _$MoodSummaryCopyWithImpl(this._self, this._then);

  final MoodSummary _self;
  final $Res Function(MoodSummary) _then;

/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = freezed,Object? week = null,Object? month = null,Object? streak = null,Object? bestStreak = null,Object? trendPercent = null,Object? recent = null,Object? insights = null,}) {
  return _then(MoodSummary(
today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as MoodEntry?,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as List<int>,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as List<int>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,trendPercent: null == trendPercent ? _self.trendPercent : trendPercent // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<MoodEntry>,insights: null == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<MoodInsight>,
  ));
}
/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoodEntryCopyWith<$Res>? get today {
    if (_self.today == null) {
    return null;
  }

  return $MoodEntryCopyWith<$Res>(_self.today!, (value) {
    return _then(_self.copyWith(today: value));
  });
}
}


/// Adds pattern-matching-related methods to [MoodSummary].
extension MoodSummaryPatterns on MoodSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodSummary value)  $default,){
final _that = this;
switch (_that) {
case _MoodSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MoodEntry? today,  List<int> week,  List<int> month,  int streak,  int bestStreak,  int trendPercent,  List<MoodEntry> recent,  List<MoodInsight> insights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
return $default(_that.today,_that.week,_that.month,_that.streak,_that.bestStreak,_that.trendPercent,_that.recent,_that.insights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MoodEntry? today,  List<int> week,  List<int> month,  int streak,  int bestStreak,  int trendPercent,  List<MoodEntry> recent,  List<MoodInsight> insights)  $default,) {final _that = this;
switch (_that) {
case _MoodSummary():
return $default(_that.today,_that.week,_that.month,_that.streak,_that.bestStreak,_that.trendPercent,_that.recent,_that.insights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MoodEntry? today,  List<int> week,  List<int> month,  int streak,  int bestStreak,  int trendPercent,  List<MoodEntry> recent,  List<MoodInsight> insights)?  $default,) {final _that = this;
switch (_that) {
case _MoodSummary() when $default != null:
return $default(_that.today,_that.week,_that.month,_that.streak,_that.bestStreak,_that.trendPercent,_that.recent,_that.insights);case _:
  return null;

}
}

}

/// @nodoc


class _MoodSummary extends MoodSummary {
  const _MoodSummary({this.today, required  List<int> week, required  List<int> month, required this.streak, required this.bestStreak, required this.trendPercent, required  List<MoodEntry> recent, required  List<MoodInsight> insights}): _week = week,_month = month,_recent = recent,_insights = insights,super._();
  

@override final  MoodEntry? today;
/// Last 7 days, oldest first (level 1..5).
 final  List<int> _week;
/// Last 7 days, oldest first (level 1..5).
@override List<int> get week {
  if (_week is EqualUnmodifiableListView) return _week;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_week);
}

/// Last 28 days, oldest first.
 final  List<int> _month;
/// Last 28 days, oldest first.
@override List<int> get month {
  if (_month is EqualUnmodifiableListView) return _month;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_month);
}

@override final  int streak;
@override final  int bestStreak;
/// Week-over-week change, e.g. 12 for +12%.
@override final  int trendPercent;
 final  List<MoodEntry> _recent;
@override List<MoodEntry> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  List<MoodInsight> _insights;
@override List<MoodInsight> get insights {
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insights);
}


/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodSummaryCopyWith<_MoodSummary> get copyWith => __$MoodSummaryCopyWithImpl<_MoodSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodSummary&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.week, _week)&&const DeepCollectionEquality().equals(other.month, _month)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.trendPercent, trendPercent) || other.trendPercent == trendPercent)&&const DeepCollectionEquality().equals(other.recent, _recent)&&const DeepCollectionEquality().equals(other.insights, _insights));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,const DeepCollectionEquality().hash(_week),const DeepCollectionEquality().hash(_month),streak,bestStreak,trendPercent,const DeepCollectionEquality().hash(_recent),const DeepCollectionEquality().hash(_insights));
}

@override
String toString() {
    return 'MoodSummary(today: $today, week: $week, month: $month, streak: $streak, bestStreak: $bestStreak, trendPercent: $trendPercent, recent: $recent, insights: $insights)';
}


}

/// @nodoc
abstract mixin class _$MoodSummaryCopyWith<$Res> implements $MoodSummaryCopyWith<$Res> {
  factory _$MoodSummaryCopyWith(_MoodSummary value, $Res Function(_MoodSummary) _then) = __$MoodSummaryCopyWithImpl;
@override @useResult
$Res call({
 MoodEntry? today, List<int> week, List<int> month, int streak, int bestStreak, int trendPercent, List<MoodEntry> recent, List<MoodInsight> insights
});


@override $MoodEntryCopyWith<$Res>? get today;

}
/// @nodoc
class __$MoodSummaryCopyWithImpl<$Res>
    implements _$MoodSummaryCopyWith<$Res> {
  __$MoodSummaryCopyWithImpl(this._self, this._then);

  final _MoodSummary _self;
  final $Res Function(_MoodSummary) _then;

/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = freezed,Object? week = null,Object? month = null,Object? streak = null,Object? bestStreak = null,Object? trendPercent = null,Object? recent = null,Object? insights = null,}) {
  return _then(_MoodSummary(
today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as MoodEntry?,week: null == week ? _self._week : week // ignore: cast_nullable_to_non_nullable
as List<int>,month: null == month ? _self._month : month // ignore: cast_nullable_to_non_nullable
as List<int>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,trendPercent: null == trendPercent ? _self.trendPercent : trendPercent // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<MoodEntry>,insights: null == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<MoodInsight>,
  ));
}

/// Create a copy of MoodSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoodEntryCopyWith<$Res>? get today {
    if (_self.today == null) {
    return null;
  }

  return $MoodEntryCopyWith<$Res>(_self.today!, (value) {
    return _then(_self.copyWith(today: value));
  });
}
}

/// @nodoc
mixin _$MoodInsight {

 InsightKind get kind; String get title; String get body;
/// Create a copy of MoodInsight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoodInsightCopyWith<MoodInsight> get copyWith => _$MoodInsightCopyWithImpl<MoodInsight>(this as MoodInsight, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MoodInsight;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoodInsight&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body));
}


@override
int get hashCode {
  final _this = this as MoodInsight;
  return Object.hash(runtimeType,_this.kind,_this.title,_this.body);
}

@override
String toString() {
  final _this = this as MoodInsight;
  return 'MoodInsight(kind: ${_this.kind}, title: ${_this.title}, body: ${_this.body})';
}


}

/// @nodoc
abstract mixin class $MoodInsightCopyWith<$Res>  {
  factory $MoodInsightCopyWith(MoodInsight value, $Res Function(MoodInsight) _then) = _$MoodInsightCopyWithImpl;
@useResult
$Res call({
 InsightKind kind, String title, String body
});




}
/// @nodoc
class _$MoodInsightCopyWithImpl<$Res>
    implements $MoodInsightCopyWith<$Res> {
  _$MoodInsightCopyWithImpl(this._self, this._then);

  final MoodInsight _self;
  final $Res Function(MoodInsight) _then;

/// Create a copy of MoodInsight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? body = null,}) {
  return _then(MoodInsight(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as InsightKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoodInsight].
extension MoodInsightPatterns on MoodInsight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoodInsight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoodInsight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoodInsight value)  $default,){
final _that = this;
switch (_that) {
case _MoodInsight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoodInsight value)?  $default,){
final _that = this;
switch (_that) {
case _MoodInsight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InsightKind kind,  String title,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoodInsight() when $default != null:
return $default(_that.kind,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InsightKind kind,  String title,  String body)  $default,) {final _that = this;
switch (_that) {
case _MoodInsight():
return $default(_that.kind,_that.title,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InsightKind kind,  String title,  String body)?  $default,) {final _that = this;
switch (_that) {
case _MoodInsight() when $default != null:
return $default(_that.kind,_that.title,_that.body);case _:
  return null;

}
}

}

/// @nodoc


class _MoodInsight implements MoodInsight {
  const _MoodInsight({required this.kind, required this.title, required this.body});
  

@override final  InsightKind kind;
@override final  String title;
@override final  String body;

/// Create a copy of MoodInsight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodInsightCopyWith<_MoodInsight> get copyWith => __$MoodInsightCopyWithImpl<_MoodInsight>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodInsight&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,title,body);
}

@override
String toString() {
    return 'MoodInsight(kind: $kind, title: $title, body: $body)';
}


}

/// @nodoc
abstract mixin class _$MoodInsightCopyWith<$Res> implements $MoodInsightCopyWith<$Res> {
  factory _$MoodInsightCopyWith(_MoodInsight value, $Res Function(_MoodInsight) _then) = __$MoodInsightCopyWithImpl;
@override @useResult
$Res call({
 InsightKind kind, String title, String body
});




}
/// @nodoc
class __$MoodInsightCopyWithImpl<$Res>
    implements _$MoodInsightCopyWith<$Res> {
  __$MoodInsightCopyWithImpl(this._self, this._then);

  final _MoodInsight _self;
  final $Res Function(_MoodInsight) _then;

/// Create a copy of MoodInsight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? body = null,}) {
  return _then(_MoodInsight(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as InsightKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
