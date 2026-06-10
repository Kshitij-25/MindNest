import 'package:injectable/injectable.dart';

/// Simple key/value persistence abstraction. Swap the implementation for one
/// backed by `shared_preferences`/`hive` without touching call sites.
abstract interface class KeyValueStorage {
  String? getString(String key);
  Future<void> setString(String key, String value);
  Future<void> remove(String key);
}

@LazySingleton(as: KeyValueStorage)
class InMemoryKeyValueStorage implements KeyValueStorage {
  final _store = <String, String>{};

  @override
  String? getString(String key) => _store[key];

  @override
  Future<void> setString(String key, String value) async => _store[key] = value;

  @override
  Future<void> remove(String key) async => _store.remove(key);
}
