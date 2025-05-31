import 'package:flutter_template/packages/core/session/session_data.dart';

/// Represents a User Session
///
///
abstract interface class UserSessionService {
  /// Loads and initializes the session
  ///
  Future<void> init();

  /// The current session data
  ///
  SessionData? get session;

  /// A stream that emits session changes
  ///
  Stream<SessionData?> get sessionStream;

  /// Create and save a new session
  ///
  Future<void> createSession(SessionData session);

  /// Destroy the current sessoin
  ///
  Future<void> destroySession();

  /// Whether the user is isAuthenticated
  ///
  /// This is different than only checking if the session exists
  /// because a session can get expired, hence [isAuthenticated] will return *false*.
  bool get isAuthenticated;
}
