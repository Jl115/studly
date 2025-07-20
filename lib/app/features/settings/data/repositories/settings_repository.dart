import 'package:studly/app/features/settings/data/repositories/settings_repository.dart';
import 'package:studly/app/features/settings/domain/entities/settings_entity.dart';

import '../../data/datasources/settings_local_datasource.dart';
import '../../data/models/settings_model.dart';

class SettingsRepository {
  final SettingsLocalDataSource local;

  SettingsRepository(this.local);

  Future<SettingsEntity> loadSettings() => local.load();

  Future<void> saveSettings(SettingsEntity settings) => local.save(SettingsModel(darkMode: settings.darkMode));
}
