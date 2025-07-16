import 'package:studly/app/features/settings/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> loadSettings();
  Future<void> saveSettings(SettingsEntity settings);
}
