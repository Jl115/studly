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
    final jsonString = json.encode(model.toJson());
    await _databaseController.setValue(_key, jsonString);
  }
}
