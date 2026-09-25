// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUserModel _$AppUserModelFromJson(Map<String, dynamic> json) => AppUserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  maskedPhone: json['maskedPhone'] as String? ?? '+44 ••• ••892',
  onboarded: json['onboarded'] as bool? ?? false,
  verification:
      $enumDecodeNullable(_$VerificationStatusEnumMap, json['verification']) ??
      VerificationStatus.none,
  title: json['title'] as String?,
);

Map<String, dynamic> _$AppUserModelToJson(AppUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'maskedPhone': instance.maskedPhone,
      'onboarded': instance.onboarded,
      'verification': _$VerificationStatusEnumMap[instance.verification]!,
      'title': instance.title,
    };

const _$UserRoleEnumMap = {
  UserRole.client: 'client',
  UserRole.professional: 'professional',
};

const _$VerificationStatusEnumMap = {
  VerificationStatus.none: 'none',
  VerificationStatus.pending: 'pending',
  VerificationStatus.verified: 'verified',
};
