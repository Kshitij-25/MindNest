import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class ProfileActivityModel with _$ProfileActivityModel {
  const factory ProfileActivityModel({
    required String icon,
    required String value,
    required String label,
    required String colorKey,
  }) = _ProfileActivityModel;

  factory ProfileActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileActivityModelFromJson(json);
}

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String name,
    required String email,
    required String checkIns,
    required String entries,
    required String streak,
    @Default(<ProfileActivityModel>[]) List<ProfileActivityModel> weekActivity,
    @Default(<int>[]) List<int> moodWeek,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
