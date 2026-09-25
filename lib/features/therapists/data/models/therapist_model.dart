import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/firebase/collections.dart';

import '../../domain/entities/therapist.dart';
import 'working_hours.dart';

part 'therapist_model.g.dart';

@JsonSerializable()
class TherapistModel {
  const TherapistModel({
    required this.id,
    required this.name,
    required this.title,
    required this.spec,
    required this.tags,
    required this.rating,
    required this.reviews,
    required this.years,
    required this.verified,
    required this.price,
    required this.location,
    required this.next,
    required this.langs,
    required this.about,
    required this.quals,
    this.types = const ['Video', 'Voice', 'Chat'],
    this.hours = defaultWorkingHours,
    this.acceptingClients = true,
  });

  factory TherapistModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data() ?? const <String, dynamic>{};
    final hours = readWorkingHours(d['hours']);
    final accepting = d['acceptingClients'] as bool? ?? true;
    return TherapistModel(
      id: s.id,
      name: d['name'] as String? ?? '',
      title: d['title'] as String? ?? 'Therapist',
      spec: d['spec'] as String? ?? '',
      tags: readStrings(d['tags']),
      rating: (d['rating'] as num?)?.toDouble() ?? 0,
      reviews: readInt(d['reviews']),
      years: readInt(d['years']),
      verified: d['verified'] as bool? ?? false,
      price: readInt(d['price'], 80),
      location: d['location'] as String? ?? 'Remote',
      next: nextAvailableLabel(hours, accepting: accepting),
      langs: readStrings(d['langs']),
      about: d['about'] as String? ?? '',
      quals: readStrings(d['quals']),
      types: d['types'] == null ? const ['Video', 'Voice', 'Chat'] : readStrings(d['types']),
      hours: hours,
      acceptingClients: accepting,
    );
  }

  factory TherapistModel.fromJson(Map<String, dynamic> json) => _$TherapistModelFromJson(json);

  final String id;
  final String name;
  final String title;
  final String spec;
  final List<String> tags;
  final double rating;
  final int reviews;
  final int years;
  final bool verified;
  final int price;
  final String location;
  final String next;
  final List<String> langs;
  final String about;
  final List<String> quals;
  final List<String> types;
  final WorkingHours hours;
  final bool acceptingClients;

  Map<String, dynamic> toJson() => _$TherapistModelToJson(this);

  Therapist toEntity({bool saved = false}) => Therapist(
        id: id,
        name: name,
        title: title,
        specialty: spec,
        tags: tags,
        rating: rating,
        reviewCount: reviews,
        years: years,
        verified: verified,
        price: price,
        location: location,
        nextAvailable: next,
        languages: langs,
        about: about,
        qualifications: quals,
        sessionTypes: types,
        saved: saved,
      );
}

@JsonSerializable()
class ReviewModel {
  const ReviewModel({required this.id, required this.name, required this.rating, required this.time, required this.text});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  factory ReviewModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> s) {
    final d = s.data()!;
    final ago = DateTime.now().difference(readDate(d['createdAt']));
    return ReviewModel(
      id: s.id,
      name: d['name'] as String? ?? 'Anonymous',
      rating: readInt(d['rating'], 5),
      time: ago.inDays < 1
          ? 'Today'
          : ago.inDays < 7
              ? '${ago.inDays} day${ago.inDays == 1 ? '' : 's'} ago'
              : ago.inDays < 30
                  ? '${ago.inDays ~/ 7} week${ago.inDays < 14 ? '' : 's'} ago'
                  : '${ago.inDays ~/ 30} month${ago.inDays < 60 ? '' : 's'} ago',
      text: d['text'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final int rating;
  final String time;
  final String text;

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  Review toEntity() => Review(id: id, author: name, rating: rating, timeAgo: time, text: text);
}
