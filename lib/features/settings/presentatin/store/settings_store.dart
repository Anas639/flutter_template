import 'package:fl_mvvm/fl_mvvm.dart';
import 'package:flutter_template/packages/core/core.dart';

class SettingsStore {
  SettingsStore({
    required this.storage,
  });
  final SecureStorage storage;
  final _useDarkMode = signal<bool>(false);

  ReadonlySignal<bool> get useDarkMode => _useDarkMode.readonly();

  Future init() async {
    _useDarkMode.value = (await storage.get('dark_mode')) == '1';
  }

  void enableDarkMode(bool enabled) {
    _useDarkMode.value = enabled;
    storage.set('dark_mode', enabled ? '1' : '0');
  }
}
