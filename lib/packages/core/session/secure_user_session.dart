import 'dart:async';
import 'dart:convert';

import 'package:flutter_template/packages/core/session/session_data.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';
import 'package:flutter_template/packages/core/storage/secure_storage.dart';

/// An Implementation of [UserSessionService] that uses [SecureStorage] to safely persist
/// the sessoin
class SecureUserSessionService implements UserSessionService {
  SecureUserSessionService({required this.storage});
  final SecureStorage storage;

  SessionData? _session;
  final StreamController<SessionData?> _sessionStreamController = StreamController<SessionData?>.broadcast();

  @override
  Future<void> createSession(SessionData session) async {
    await storage.set('session', jsonEncode(session.toJson()));
    _session = session;
    _sessionStreamController.add(_session);
  }

  @override
  Future<void> destroySession() async {
    await storage.remove("session");
    _session = null;
    _sessionStreamController.add(null);
  }

  @override
  Future<void> init() async {
    try {
      final sessionJSON = await storage.get("session");
      if (sessionJSON == null || sessionJSON.isEmpty) {
        return;
      }
      _session = SessionData.fromJson(jsonDecode(sessionJSON));
      _sessionStreamController.add(_session);
    } catch (_) {}
  }

  @override
  SessionData? get session => _session;

  @override
  Stream<SessionData?> get sessionStream => _sessionStreamController.stream;

  @override
  bool get isAuthenticated => (session != null) && !(session?.isExpired ?? true);
}
