import 'package:flutter/material.dart';
import 'app/core/providers/theme.provider.dart';
import 'app/features/auth/presentation/providers/auth.provider.dart';
import 'app/core/database/service/database.service.dart';
import 'app/core/service/provider.service.dart';
import 'app/app.dart';

late AuthProvider authProvider;
late ThemeProvider themeProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.database; // Ensure the database is initialized
  final providerService = ProviderService();
  themeProvider = ThemeProvider();

  await providerService.init();

  runApp(const App());
}
