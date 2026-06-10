import 'package:freezed_annotation/freezed_annotation.dart';

part 'discovery_models.freezed.dart';
part 'discovery_models.g.dart';

@freezed
abstract class TherapistModel with _$TherapistModel {
  const factory TherapistModel({
    required String id,
    required String name,
    required String title,
    required String spec,
    @Default(<String>[]) List<String> tags,
    required double rating,
    required int reviews,
    required int years,
    @Default(false) bool verified,
    required int price,
    required String location,
    required String next,
    @Default(<String>[]) List<String> langs,
    required String about,
    @Default(<String>[]) List<String> quals,
  }) = _TherapistModel;

  factory TherapistModel.fromJson(Map<String, dynamic> json) =>
      _$TherapistModelFromJson(json);
}

@freezed
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    required String name,
    required int rating,
    required String time,
    required String text,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

@freezed
abstract class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required String id,
    required String tid,
    required String date,
    required String time,
    required String type,
    required String status,
    required int mins,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}
