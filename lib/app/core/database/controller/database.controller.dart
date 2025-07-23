import 'package:sqflite/sqflite.dart';
import 'package:studly/app/core/database/service/database.service.dart';
import 'package:studly/app/core/database/repository/database.repository.dart';
import 'package:uuid/uuid.dart';

class DatabaseController extends BaseDatabaseRepository {
  static final DatabaseController _instance = DatabaseController._internal();
  factory DatabaseController() => _instance;

  DatabaseController._internal();

  final _dbService = DatabaseService();

  Future<void> setThemeMode(bool isDarkMode) async {
    final userId = await getCurrentUserId();
    final int darkModeValue = isDarkMode ? 1 : 0;
    await updateValue('setting', 'dark_mode', darkModeValue, 'user_id', userId);
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final db = await _dbService.database;
  }

  Future<Map<String, dynamic>> getValue(String key) async {
    final db = await _dbService.database;
    final result = await db.query(key);
    if (result.isEmpty) return {};
    return result.first;
  }

  Future<Map<String, dynamic>> getUserUuid() async {
    final db = await _dbService.database;
    final result = await db.query('user', where: 'username = ?', whereArgs: ['user']);
    if (result.isEmpty) return {};
    return result.first;
  }

  Future<void> setValue(String key, dynamic value) async {
    final db = await _dbService.database;
    await db.insert(key, {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Updates a single value in a specified table and row.
  ///
  /// - [tableName]: The name of the table to update.
  /// - [columnToUpdate]: The name of the column you want to change.
  /// - [newValue]: The new value for the column.
  /// - [whereColumn]: The column to use in the WHERE clause (e.g., 'id').
  /// - [whereValue]: The value to match in the WHERE clause.
  Future<void> updateValue(
    String tableName,
    String columnToUpdate,
    dynamic newValue,
    String whereColumn,
    dynamic whereValue,
  ) async {
    try {
      final db = await _dbService.database;
      await db.update(
        tableName,
        {columnToUpdate: newValue}, // The data to update, e.g., {'name': 'John'}
        where: '$whereColumn = ?', // The dynamic WHERE clause, e.g., 'id = ?'
        whereArgs: [whereValue], // The value for the WHERE clause, e.g., [123]
      );
    } catch (error) {
      print('\x1B[31mError updating value: $error\x1B[0m');
    }
  }

  Future<bool> getThemeMode() async {
    final db = await _dbService.database;
    final userId = await getCurrentUserId();
    final result = await db.query(
      'setting', // Correct table name
      where: 'user_id = ?',
      whereArgs: [userId], // Pass the variable here
    );
    return result.isNotEmpty && result.first['dark_mode'] == 1;
  }

  Future<void> saveCurrentUserId(String userId) async {
    final db = await _dbService.database;
    await db.insert('setting', {'user_id': userId, 'dark_mode': 0}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getCurrentUserId() async {
    final db = await _dbService.database;
    final result = await db.query('user');
    return result.isNotEmpty ? result.first['id'].toString() : null;
  }
}
