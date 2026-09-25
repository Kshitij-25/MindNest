// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      therapistId: json['therapistId'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      type:
          $enumDecodeNullable(_$SessionTypeEnumMap, json['type']) ??
          SessionType.video,
      minutes: (json['minutes'] as num?)?.toInt() ?? 50,
      status:
          $enumDecodeNullable(_$AppointmentStatusEnumMap, json['status']) ??
          AppointmentStatus.pending,
      recurrence:
          $enumDecodeNullable(_$RecurrenceEnumMap, json['recurrence']) ??
          Recurrence.oneTime,
      reminders:
          (json['reminders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['24h', '1h'],
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'therapistId': instance.therapistId,
      'startsAt': instance.startsAt.toIso8601String(),
      'type': _$SessionTypeEnumMap[instance.type]!,
      'minutes': instance.minutes,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'recurrence': _$RecurrenceEnumMap[instance.recurrence]!,
      'reminders': instance.reminders,
    };

const _$SessionTypeEnumMap = {
  SessionType.video: 'video',
  SessionType.voice: 'voice',
  SessionType.chat: 'chat',
};

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.accepted: 'accepted',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
};

const _$RecurrenceEnumMap = {
  Recurrence.oneTime: 'oneTime',
  Recurrence.weekly: 'weekly',
  Recurrence.fortnightly: 'fortnightly',
  Recurrence.monthly: 'monthly',
};
