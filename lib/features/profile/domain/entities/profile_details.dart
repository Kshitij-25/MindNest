import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_details.freezed.dart';

@freezed
abstract class ProfileDetails with _$ProfileDetails {
  const factory ProfileDetails({
    @Default('') String phone,
    @Default('') String bio,
  }) = _ProfileDetails;
}
