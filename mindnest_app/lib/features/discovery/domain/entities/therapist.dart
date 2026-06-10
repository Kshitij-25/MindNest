import 'package:equatable/equatable.dart';

/// Core domain entity for a mental-health professional. Owned by the discovery
/// feature and reused (read-only) by home, feed and messaging.
class Therapist extends Equatable {
  const Therapist({
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
  });

  final String id, name, title, spec, location, next, about;
  final List<String> tags, langs, quals;
  final double rating;
  final int reviews, years, price;
  final bool verified;

  String get firstName => name.split(' ').first;

  @override
  List<Object?> get props => [id];
}

class Review extends Equatable {
  const Review({
    required this.id,
    required this.name,
    required this.rating,
    required this.time,
    required this.text,
  });
  final String id, name, time, text;
  final int rating;

  @override
  List<Object?> get props => [id];
}
