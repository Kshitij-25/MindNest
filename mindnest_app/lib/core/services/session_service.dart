import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the current auth session (access + refresh tokens) and role.
///
/// Tokens are kept in memory for fast synchronous access (the Dio interceptor
/// reads [token] on every request) and mirrored to [SharedPreferences] so the
/// session survives an app restart. Call [restore] once at startup before the
/// router is built.
@lazySingleton
class SessionService {
  static const _kToken = 'session.token';
  static const _kRefresh = 'session.refresh';
  static const _kRole = 'session.role';

  SharedPreferences? _prefs;

  String? _token;
  String? _refreshToken;
  String role = 'user';

  String? get token => _token;
  String? get refreshToken => _refreshToken;
  bool get isAuthenticated => _token != null;

  /// Loads any persisted session into memory. Safe to call once at boot.
  Future<void> restore() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs!.getString(_kToken);
    _refreshToken = _prefs!.getString(_kRefresh);
    role = _prefs!.getString(_kRole) ?? 'user';
  }

  void start({
    required String token,
    String? refreshToken,
    String role = 'user',
  }) {
    _token = token;
    _refreshToken = refreshToken;
    this.role = role;
    final p = _prefs;
    if (p != null) {
      p.setString(_kToken, token);
      if (refreshToken != null) {
        p.setString(_kRefresh, refreshToken);
      } else {
        p.remove(_kRefresh);
      }
      p.setString(_kRole, role);
    }
  }

  void clear() {
    _token = null;
    _refreshToken = null;
    role = 'user';
    _prefs?.remove(_kToken);
    _prefs?.remove(_kRefresh);
    _prefs?.remove(_kRole);
  }
}
