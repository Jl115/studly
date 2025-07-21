import 'package:flutter/material.dart';
import 'package:studly/app/core/database/controller/database.controller.dart';
import 'package:studly/app/features/settings/domain/entities/settings_entity.dart';
import 'package:studly/app/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:studly/app/features/settings/domain/usecases/save_settings_usecase.dart';

class SettingsProvider extends ChangeNotifier {
  final DatabaseController _databaseController = DatabaseController();

  final LoadSettingsUseCase loadSettingsUseCase;
  final SaveSettingsUseCase saveSettingsUseCase;
  bool _isDarkMode = false;
  String _username = '';
  String _password = '';
  String _themeModeName = 'light';

  SettingsEntity _settings = const SettingsEntity(darkMode: false, username: '', password: '', themeModeName: 'light');
  bool get isDarkMode => _isDarkMode;
  String get username => _username;
  String get password => _password;
  SettingsEntity get settings => _settings;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  String get themeModeName => _themeModeName;

  set username(String value) {
    _username = value;
    updateUsername(_username).then((_) {
      notifyListeners();
    });
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set themeModeName(String value) {
    _themeModeName = value;
    notifyListeners();
  }

  SettingsProvider(this.loadSettingsUseCase, this.saveSettingsUseCase);

  Future<void> load() async {
    _settings = await loadSettingsUseCase();
    print('\x1B[32m_settings -------------------- ${_settings.toString()}\x1B[0m');
    await loadTheme();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _settings = SettingsEntity(
      darkMode: !_settings.darkMode,
      username: _settings.username,
      password: _settings.password,
      themeModeName: _settings.themeModeName,
    );
    await saveSettingsUseCase(_settings);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _databaseController.setThemeMode(_isDarkMode);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    _isDarkMode = await _databaseController.getThemeMode();
    notifyListeners();
  }

  Future<void> updateUsername(String newUsername) async {
    _username = newUsername;
    await _databaseController.setValue("settings", newUsername);
    notifyListeners();
  }
}
