// controllers/database_controller.dart
import 'package:sqflite/sqflite.dart';
import 'package:studly/app/core/database/service/database.service.dart';
import 'package:studly/app/core/database/repository/database.repository.dart';

class DatabaseController extends BaseDatabaseRepository {
  static final DatabaseController _instance = DatabaseController._internal();
  factory DatabaseController() => _instance;

  DatabaseController._internal();

  final _dbService = DatabaseService();

  Future<void> setThemeMode(bool isDarkMode) async {
    final db = await _dbService.database;
    await db.insert('settings', {
      'key': 'theme_mode',
      'value': isDarkMode ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> getThemeMode() async {
    final db = await _dbService.database;
    final result = await db.query('settings', where: 'key = ?', whereArgs: ['theme_mode']);
    return result.isNotEmpty && result.first['value'] == 1;
  }

  Future<void> saveCurrentUserId(int userId) async {
    final db = await _dbService.database;
    await db.insert('settings', {
      'key': 'current_user_id',
      'value': userId,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int?> getCurrentUserId() async {
    final db = await _dbService.database;
    final result = await db.query('settings', where: 'key = ?', whereArgs: ['current_user_id']);
    return result.isNotEmpty ? result.first['value'] as int : null;
  }

  Future<void> removeCurrentUserId() async {
    final db = await _dbService.database;
    await db.delete('settings', where: 'key = ?', whereArgs: ['current_user_id']);
  }
}
