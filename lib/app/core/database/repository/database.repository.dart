import 'package:sqflite/sqflite.dart';
import 'package:studly/app/core/database/database.service.dart';

abstract class BaseDatabaseRepository {
  final DatabaseService _dbService = DatabaseService();

  Future<Database> get db async => await _dbService.database;

  Future<List<Map<String, Object?>>> findAll({required String table, String? where, List<Object?>? whereArgs}) async {
    return await (await db).query(table, where: where, whereArgs: whereArgs);
  }

  Future<Map<String, Object?>?> findOne({
    required String table,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final result = await (await db).query(table, where: where, whereArgs: whereArgs, limit: 1);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> create({required String table, required Map<String, Object?> data}) async {
    return await (await db).insert(table, data, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<int> update({
    required String table,
    required Map<String, Object?> data,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    return await (await db).update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete({required String table, required String where, required List<Object?> whereArgs}) async {
    return await (await db).delete(table, where: where, whereArgs: whereArgs);
  }
}
