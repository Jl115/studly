import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({required super.darkMode});

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      SettingsModel(darkMode: json['darkMode'] ?? false);

  Map<String, dynamic> toJson() => {'darkMode': darkMode};
  @override
  String toString() {
    return 'SettingsModel{darkMode: $darkMode}';
  }
}
