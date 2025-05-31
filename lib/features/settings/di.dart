import 'package:flutter_template/features/settings/presentatin/store/settings_store.dart';
import 'package:flutter_template/packages/core/core.dart';

Future registerSettingsDependencies({required SecureStorage storage}) async {
  final settingStore = serviceLocator.registerSingleton<SettingsStore>(
    SettingsStore(
      storage: storage,
    ),
  );
  await settingStore.init();
}
