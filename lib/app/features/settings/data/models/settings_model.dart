import '../../domain/entities/settings_entity.dart';
import 'model_config_model.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required super.darkMode,
    required super.username,
    required super.password,
    required super.themeModeName,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      darkMode: json['darkMode'] ?? false,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      themeModeName: json['themeModeName'] ?? 'light',
    );
  }

  Map<String, dynamic> toJson() {
    return {'darkMode': darkMode, 'username': username, 'password': password, 'themeModeName': themeModeName};
  }

  @override
  String toString() {
    return 'SettingsModel{darkMode: $darkMode, username: $username, password: $password, themeModeName: $themeModeName}';
  }
}
