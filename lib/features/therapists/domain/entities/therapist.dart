import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapist.freezed.dart';

@freezed
abstract class Therapist with _$Therapist {
  const factory Therapist({
    required String id,
    required String name,
    required String title,
    required String specialty,
    required List<String> tags,
    required double rating,
    required int reviewCount,
    required int years,
    required bool verified,
    required int price,
    required String location,
    required String nextAvailable,
    required List<String> languages,
    required String about,
    required List<String> qualifications,
    @Default(<String>['Video', 'Voice', 'Chat']) List<String> sessionTypes,
    @Default(false) bool saved,
  }) = _Therapist;

  const Therapist._();

  String get firstName {
    final parts = name.split(' ');
    return parts.first.endsWith('.') && parts.length > 1 ? parts[1] : parts.first;
  }

  String get lastName => name.split(' ').last;
}

@freezed
abstract class Review with _$Review {
  const factory Review({
    required String id,
    required String author,
    required int rating,
    required String timeAgo,
    required String text,
  }) = _Review;
}

/// Weekly availability summary shown on the profile.
@freezed
abstract class DayAvailability with _$DayAvailability {
  const factory DayAvailability({required String day, required int slots}) = _DayAvailability;
}
