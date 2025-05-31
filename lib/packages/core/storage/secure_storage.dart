import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/packages/core/session/session_data.dart';

import '../session/user_session.dart';
import 'key_value_storage.dart';

class SecureStorage implements KeyValueStorage<String, String?> {
  const SecureStorage(
    this.storage,
  );
  final FlutterSecureStorage storage;
  @override
  FutureOr clear() {
    storage.deleteAll();
  }

  @override
  Future<String?> get(String key) {
    return storage.read(key: key);
  }

  @override
  Future remove(String key) {
    return storage.delete(key: key);
  }

  @override
  Future set(String key, String? value) {
    return storage.write(key: key, value: value);
  }
}

/// An extension to `SecureStorage` that depends on the current `SessionData`
/// to save keys per user.
///
/// Suppose the current session has a userId equal to 1
///
/// ```dart
/// void main(){
///   final storage = UserSecureStorage();
///   storage.set("favorites", '["🍊","🍌","🍎"]');
/// }
/// ```
///
/// The value will be saved under a new key `1favorites`
/// where `1` is the id and `favorites` is the original key.
class UserSecureStorage extends SecureStorage {
  UserSecureStorage(
    super.storage, {
    required this.userSession,
  }) {
    _updateUserId(userSession.session);
    userSession.sessionStream.listen(_updateUserId);
  }

  final UserSessionService userSession;

  String _userId = "";

  void _updateUserId(SessionData? session) {
    _userId = session?.userId ?? "";
  }

  @override
  FutureOr clear() {
    // we can't clear all without knowing all the keys
  }

  @override
  Future<String?> get(String key) async {
    return super.get("$_userId$key");
  }

  @override
  Future set(String key, String? value) {
    return super.set("$_userId$key", value);
  }

  @override
  Future remove(String key) {
    return super.remove("$_userId$key");
  }
}
