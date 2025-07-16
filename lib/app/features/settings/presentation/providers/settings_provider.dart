import 'package:flutter/material.dart';
import 'package:studly/app/features/settings/domain/entities/settings_entity.dart';
import 'package:studly/app/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:studly/app/features/settings/domain/usecases/save_settings_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final LoadSettingsUseCase loadSettingsUseCase;
  final SaveSettingsUseCase saveSettingsUseCase;

  SettingsEntity _settings = const SettingsEntity(darkMode: false);
  SettingsEntity get settings => _settings;

  SettingsProvider(this.loadSettingsUseCase, this.saveSettingsUseCase);

  Future<void> load() async {
    _settings = await loadSettingsUseCase();
    print(
      '\x1B[32m_settings -------------------- ${_settings.toString()}\x1B[0m',
    );
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _settings = SettingsEntity(darkMode: !_settings.darkMode);
    await saveSettingsUseCase(_settings);
    notifyListeners();
  }
}
