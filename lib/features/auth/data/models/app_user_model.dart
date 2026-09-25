import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/user_role.dart';

part 'app_user_model.g.dart';

@JsonSerializable()
class AppUserModel {
  const AppUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.maskedPhone = '+44 ••• ••892',
    this.onboarded = false,
    this.verification = VerificationStatus.none,
    this.title,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  factory AppUserModel.fromEntity(AppUser u) => AppUserModel(
    id: u.id,
    name: u.name,
    email: u.email,
    role: u.role,
    maskedPhone: u.maskedPhone,
    onboarded: u.onboarded,
    verification: u.verification,
    title: u.title,
  );

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String maskedPhone;
  final bool onboarded;
  final VerificationStatus verification;
  final String? title;

  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);

  AppUser toEntity() => AppUser(
    id: id,
    name: name,
    email: email,
    role: role,
    maskedPhone: maskedPhone,
    onboarded: onboarded,
    verification: verification,
    title: title,
  );
}
