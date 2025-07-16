import 'package:studly/app/features/settings/data/repositories/settings_repository.dart';

import '../entities/settings_entity.dart';

class LoadSettingsUseCase {
  final SettingsRepository repository;
  LoadSettingsUseCase(this.repository);

  Future<SettingsEntity> call() => repository.loadSettings();
}
