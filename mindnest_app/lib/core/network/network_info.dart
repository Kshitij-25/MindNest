import 'package:injectable/injectable.dart';

/// Connectivity check used by repositories before hitting the network.
/// Stubbed to `true` here (no `connectivity_plus` dependency in the prototype).
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}
