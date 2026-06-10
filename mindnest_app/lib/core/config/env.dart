/// Build environments. Selected at bootstrap and exposed through [AppConfig].
enum Environment { dev, staging, prod }

/// Immutable per-environment configuration. In a real deployment these values
/// would come from `--dart-define`s or a secrets manager.
class Env {
  const Env({
    required this.environment,
    required this.apiBaseUrl,
    this.connectTimeout = const Duration(seconds: 20),
    this.receiveTimeout = const Duration(seconds: 20),
    this.enableNetworkLogs = true,
  });

  final Environment environment;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableNetworkLogs;

  bool get isProd => environment == Environment.prod;

  // Local FastAPI backend (mindnest_backend) — `uvicorn app.main:app --reload`.
  // iOS simulator / macOS / web use localhost; for an Android emulator swap to
  // http://10.0.2.2:8000/api/v1.
  factory Env.dev() => const Env(
    environment: Environment.dev,
    apiBaseUrl: 'http://localhost:8000/api/v1',
  );

  factory Env.staging() => const Env(
    environment: Environment.staging,
    apiBaseUrl: 'https://api.staging.mindnest.app/v1',
  );

  factory Env.prod() => const Env(
    environment: Environment.prod,
    apiBaseUrl: 'https://api.mindnest.app/v1',
    enableNetworkLogs: false,
  );
}
