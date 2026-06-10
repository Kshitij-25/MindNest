import 'package:freezed_annotation/freezed_annotation.dart';

part 'professional_models.freezed.dart';
part 'professional_models.g.dart';

@freezed
abstract class BookingRequestModel with _$BookingRequestModel {
  const factory BookingRequestModel({
    required String id,
    required String name,
    required String when,
    required String reason,
    @Default('Pending') String status,
    required int mins,
  }) = _BookingRequestModel;

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestModelFromJson(json);
}

@freezed
abstract class ProSessionModel with _$ProSessionModel {
  const factory ProSessionModel({
    required String id,
    required String name,
    required String when,
    required String type,
    required int mins,
    @Default('Accepted') String status,
  }) = _ProSessionModel;

  factory ProSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ProSessionModelFromJson(json);
}

@freezed
abstract class ProPostModel with _$ProPostModel {
  const factory ProPostModel({
    required String id,
    required String topic,
    required String time,
    @Default('Published') String status,
    @Default(false) bool image,
    @Default(0) int likes,
    @Default(0) int comments,
    @Default(0) int views,
    required String title,
  }) = _ProPostModel;

  factory ProPostModel.fromJson(Map<String, dynamic> json) =>
      _$ProPostModelFromJson(json);
}

@freezed
abstract class ProClientModel with _$ProClientModel {
  const factory ProClientModel({
    required String id,
    required String name,
    required String last,
    required String time,
    @Default(0) int unread,
    @Default(false) bool online,
  }) = _ProClientModel;

  factory ProClientModel.fromJson(Map<String, dynamic> json) =>
      _$ProClientModelFromJson(json);
}

@freezed
abstract class DashboardStatsModel with _$DashboardStatsModel {
  const factory DashboardStatsModel({
    required String sessionsToday,
    required String newRequests,
    required String rating,
    required String weekEarnings,
  }) = _DashboardStatsModel;

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);
}
