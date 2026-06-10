import 'package:injectable/injectable.dart';

@lazySingleton
class OnboardingLocalDataSource {
  /// Persists the questionnaire answers. Stubbed for now — a real
  /// implementation would write to local storage or sync to a backend.
  Future<void> saveAnswers(Map<String, dynamic> answers) async {}
}
