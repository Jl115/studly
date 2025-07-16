import 'package:studly/app/features/settings/data/repositories/settings_repository.dart';

import '../entities/settings_entity.dart';

class SaveSettingsUseCase {
  final SettingsRepository repository;
  SaveSettingsUseCase(this.repository);

  Future<void> call(SettingsEntity settings) =>
      repository.saveSettings(settings);
}
