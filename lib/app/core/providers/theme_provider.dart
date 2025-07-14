import 'package:flutter/material.dart';
import 'package:studly/app/core/database/controller/database.controller.dart';

class ThemeProvider extends ChangeNotifier {
  final DatabaseController _databaseController = DatabaseController();
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> loadTheme() async {
    _isDarkMode = await _databaseController.getThemeMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _databaseController.setThemeMode(_isDarkMode);
    notifyListeners();
  }
}
