// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TherapistModel _$TherapistModelFromJson(Map<String, dynamic> json) =>
    TherapistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      spec: json['spec'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      reviews: (json['reviews'] as num).toInt(),
      years: (json['years'] as num).toInt(),
      verified: json['verified'] as bool,
      price: (json['price'] as num).toInt(),
      location: json['location'] as String,
      next: json['next'] as String,
      langs: (json['langs'] as List<dynamic>).map((e) => e as String).toList(),
      about: json['about'] as String,
      quals: (json['quals'] as List<dynamic>).map((e) => e as String).toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const ['Video', 'Voice', 'Chat'],
      hours:
          (json['hours'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          defaultWorkingHours,
      acceptingClients: json['acceptingClients'] as bool? ?? true,
    );

Map<String, dynamic> _$TherapistModelToJson(TherapistModel instance) =>
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
      'types': instance.types,
      'hours': instance.hours,
      'acceptingClients': instance.acceptingClients,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: json['id'] as String,
  name: json['name'] as String,
  rating: (json['rating'] as num).toInt(),
  time: json['time'] as String,
  text: json['text'] as String,
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'time': instance.time,
      'text': instance.text,
    };
