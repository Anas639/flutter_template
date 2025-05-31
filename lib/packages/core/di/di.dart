import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/session/secure_user_session.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

Future<void> registerCoreDependencies() async {
  final FlutterSecureStorage fsStorage = FlutterSecureStorage();
  serviceLocator.registerSingleton<UserSessionService>(
    SecureUserSessionService(
      storage: SecureStorage(fsStorage),
    ),
  );
  await serviceLocator.get<UserSessionService>().init();
  serviceLocator.registerSingleton<UserSecureStorage>(
    UserSecureStorage(fsStorage, userSession: serviceLocator.get<UserSessionService>()),
  );
}
