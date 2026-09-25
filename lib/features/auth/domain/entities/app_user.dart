import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_role.dart';

part 'app_user.freezed.dart';

enum VerificationStatus { none, pending, verified }

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    @Default('+44 ••• ••892') String maskedPhone,
    @Default(false) bool onboarded,
    @Default(VerificationStatus.none) VerificationStatus verification,
    String? title,
  }) = _AppUser;

  const AppUser._();

  bool get isProfessional => role == UserRole.professional;
  String get firstName => name.split(' ').first;
}
