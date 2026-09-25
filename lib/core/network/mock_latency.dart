/// Simulated network latency for the mock data sources.
Future<void> mockLatency([int ms = 350]) =>
    Future<void>.delayed(Duration(milliseconds: ms));
