import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/features/auth/di.dart';
import 'package:flutter_template/features/settings/di.dart';
import 'package:flutter_template/features/settings/presentatin/store/settings_store.dart';
import 'package:flutter_template/features/todo/di.dart';
import 'package:flutter_template/features/todo/presentation/store/todos_store.dart';
import 'package:flutter_template/packages/core/core.dart';
import 'package:flutter_template/packages/core/di/di.dart';
import 'package:flutter_template/packages/core/session/user_session.dart';

Future<void> injectDependencies() async {
  String flavor = Platform.environment['flavor'] ?? 'dev';
  final String dotEnvFile = '.env.$flavor';
  await dotenv.load(fileName: dotEnvFile);
  String baseUrl = dotenv.get('BASE_URL', fallback: '');
  if (baseUrl.isEmpty) {
    throw Exception("BASE_URL not found in .env file");
  }
  final dio = createDioClient(baseUrl: baseUrl);

  await registerCoreDependencies();

  await registerSettingsDependencies(
    storage: serviceLocator.get<UserSecureStorage>(),
  );

  await registerAuthDependencies(
    dio: dio,
    minPasswordLength: int.parse(
      dotenv.get(
        'MIN_PASSWORD_LENGTH',
        fallback: '6',
      ),
    ),
  );
  await registerTodoDependencies(dio: dio);

  // If we gonna support multiple users in a single device then we must reset stores
  // and refresh them in case session changed.
  serviceLocator.get<UserSessionService>().sessionStream.listen((sData) async {
    if (sData == null) {
      serviceLocator.get<TodosStore>().clear();
    } else {
      await serviceLocator.get<SettingsStore>().init();
    }
  });
}
