import 'model_config_entity.dart';

class SettingsEntity {
  final bool darkMode;
  final String themeModeName;
  final String username;
  final String password;

  const SettingsEntity({
    required this.darkMode,
    required this.username,
    required this.password,
    required this.themeModeName,
  });
}
