import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/therapist.dart';

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
  });

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

  final String id;
  final String name;
  final int rating;
  final String time;
  final String text;

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  Review toEntity() => Review(id: id, author: name, rating: rating, timeAgo: time, text: text);
}
