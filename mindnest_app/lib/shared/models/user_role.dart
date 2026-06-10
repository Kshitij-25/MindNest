/// Cross-cutting role value object shared by auth, shell and professional.
enum UserRole {
  user,
  professional;

  bool get isPro => this == UserRole.professional;

  String get wire => this == UserRole.professional ? 'pro' : 'user';

  static UserRole fromWire(String value) =>
      value == 'pro' ? UserRole.professional : UserRole.user;
}
