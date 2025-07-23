import 'dart:convert';
import 'package:studly/app/core/database/controller/database.controller.dart';

import '../models/settings_model.dart';

class SettingsLocalDataSource {
  final _key = 'setting';

  final _databaseController = DatabaseController();

  Future<SettingsModel> load() async {
    final jsonMap = await _databaseController.getJoinedValue(table1: _key, table2: 'user');
    return SettingsModel.fromJson(jsonMap);
  }

  Future<void> save(SettingsModel model) async {
    final userId = await _databaseController.getCurrentUserId();

    print('\x1B[32mmodel -------------------- ${model.toString()}\x1B[0m');
    print('\x1B[32mmodel.toDatabaseModel(), -------------------- ${model.toDatabaseModel()}\x1B[0m');
    await _databaseController.update(
      table: 'setting',
      data: model.toDatabaseModel(),
      where: 'user_id',
      whereArgs: [userId],
    );
  }
}
