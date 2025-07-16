import 'package:flutter/material.dart';
import 'app/core/database/service/database.service.dart';
import 'app/core/service/provider.service.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.database; // Ensure the database is initialized
  final providerService = ProviderService();

  await providerService.init();

  runApp(const App());
}
