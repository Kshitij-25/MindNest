import 'package:mindnest_app/core/config/env.dart';

/// Globally accessible, immutable configuration set once at bootstrap.
class AppConfig {
  AppConfig._(this.env);

  static AppConfig? _instance;
  static AppConfig get instance {
    final i = _instance;
    if (i == null) {
      throw StateError('AppConfig.init() must be called before use.');
    }
    return i;
  }

  final Env env;

  static AppConfig init(Env env) => _instance ??= AppConfig._(env);
}
