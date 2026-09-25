import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_details.freezed.dart';

@freezed
abstract class ProfileDetails with _$ProfileDetails {
  const factory ProfileDetails({
    @Default('+44 7700 900892') String phone,
    @Default('Learning to slow down and be kinder to myself.') String bio,
  }) = _ProfileDetails;
}
