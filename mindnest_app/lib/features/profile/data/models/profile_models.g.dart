// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileActivityModel _$ProfileActivityModelFromJson(
  Map<String, dynamic> json,
) => _ProfileActivityModel(
  icon: json['icon'] as String,
  value: json['value'] as String,
  label: json['label'] as String,
  colorKey: json['colorKey'] as String,
);

Map<String, dynamic> _$ProfileActivityModelToJson(
  _ProfileActivityModel instance,
) => <String, dynamic>{
  'icon': instance.icon,
  'value': instance.value,
  'label': instance.label,
  'colorKey': instance.colorKey,
};

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      name: json['name'] as String,
      email: json['email'] as String,
      checkIns: json['checkIns'] as String,
      entries: json['entries'] as String,
      streak: json['streak'] as String,
      weekActivity:
          (json['weekActivity'] as List<dynamic>?)
              ?.map(
                (e) => ProfileActivityModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ProfileActivityModel>[],
      moodWeek:
          (json['moodWeek'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'checkIns': instance.checkIns,
      'entries': instance.entries,
      'streak': instance.streak,
      'weekActivity': instance.weekActivity,
      'moodWeek': instance.moodWeek,
    };
