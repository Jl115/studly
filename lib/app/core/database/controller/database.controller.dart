// controllers/database_controller.dart
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
    final db = await _dbService.database;
    await db.insert('setting', {
      'key': 'theme_mode',
      'value': isDarkMode ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final db = await _dbService.database;
    for (var entry in settings.entries) {
      await db.insert('setting', {
        'key': entry.key,
        'value': entry.value,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<Map<String, dynamic>> getJoinedValue({
    required String table1,
    required String table2,
    String? where, // Optional WHERE clause, e.g., 'users.id = ?'
    List<Object?>? whereArgs, // Arguments for the WHERE clause
  }) async {
    final db = await _dbService.database;

    // Base query with the JOIN
    String sql = 'SELECT * FROM $table1 LEFT JOIN $table2 ON $table2.id = $table1.${table2}_id';

    // Add a WHERE clause if provided
    if (where != null && where.isNotEmpty) {
      sql += ' WHERE $where';
    }

    final result = await db.rawQuery(sql, whereArgs);

    print('\x1B[32mresult getJoinedValue-------------------- ${result.toString()}\x1B[0m');

    if (result.isNotEmpty) {
      return result.first;
    }
    return {};
  }

  Future<Map<String, dynamic>> getValue(String key) async {
    final db = await _dbService.database;
    final result = await db.query(key);
    print('\x1B[32mresult getValue-------------------- ${result.toString()}\x1B[0m');
    if (result.isNotEmpty) {
      return result.first;
    }
    return {};
  }

  Future<Map<String, dynamic>> getUserUuid() async {
    final db = await _dbService.database;
    final result = await db.query('user', where: 'username = ?', whereArgs: ['user']);
    if (result.isNotEmpty) {
      return result.first;
    }
    return {};
  }

  Future<void> setValue(String key, dynamic value) async {
    final db = await _dbService.database;
    print('\x1B[32m849386 -------------------- ${849386}\x1B[0m');
    await db.insert(key, {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> getThemeMode() async {
    final db = await _dbService.database;
    final userId = await getCurrentUserId();
    final result = await db.query(
      'setting', // Correct table name
      where: 'user_id = ?',
      whereArgs: [userId], // Pass the variable here
    );
    print('\x1B[32mresult getThemeMode-------------------- ${result.toString()}\x1B[0m');
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

  Future<void> removeCurrentUserId() async {
    final db = await _dbService.database;
    final userId = await getCurrentUserId();
    final t = await db.delete('setting', where: 'user_id = ?', whereArgs: [userId]);
    print(t.toString());
  }
}
