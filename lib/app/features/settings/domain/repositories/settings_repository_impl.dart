import 'package:studly/app/features/settings/data/repositories/settings_repository.dart';

import '../entities/settings_entity.dart';
import '../../data/datasources/settings_local_datasource.dart';
import '../../data/models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource local;

  SettingsRepositoryImpl(this.local);

  @override
  Future<SettingsEntity> loadSettings() => local.load();

  @override
  Future<void> saveSettings(SettingsEntity settings) =>
      local.save(SettingsModel(darkMode: settings.darkMode));
}
