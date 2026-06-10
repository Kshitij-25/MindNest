// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TherapistModel _$TherapistModelFromJson(Map<String, dynamic> json) =>
    _TherapistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      spec: json['spec'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      rating: (json['rating'] as num).toDouble(),
      reviews: (json['reviews'] as num).toInt(),
      years: (json['years'] as num).toInt(),
      verified: json['verified'] as bool? ?? false,
      price: (json['price'] as num).toInt(),
      location: json['location'] as String,
      next: json['next'] as String,
      langs:
          (json['langs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      about: json['about'] as String,
      quals:
          (json['quals'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TherapistModelToJson(_TherapistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'spec': instance.spec,
      'tags': instance.tags,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'years': instance.years,
      'verified': instance.verified,
      'price': instance.price,
      'location': instance.location,
      'next': instance.next,
      'langs': instance.langs,
      'about': instance.about,
      'quals': instance.quals,
    };

_ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => _ReviewModel(
  id: json['id'] as String,
  name: json['name'] as String,
  rating: (json['rating'] as num).toInt(),
  time: json['time'] as String,
  text: json['text'] as String,
);

Map<String, dynamic> _$ReviewModelToJson(_ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'time': instance.time,
      'text': instance.text,
    };

_AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    _AppointmentModel(
      id: json['id'] as String,
      tid: json['tid'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      mins: (json['mins'] as num).toInt(),
    );

Map<String, dynamic> _$AppointmentModelToJson(_AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tid': instance.tid,
      'date': instance.date,
      'time': instance.time,
      'type': instance.type,
      'status': instance.status,
      'mins': instance.mins,
    };
