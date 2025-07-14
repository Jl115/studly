import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/core/providers/theme_provider.dart';
import 'app/features/auth/presentation/providers/auth_provider.dart';
import 'app/features/auth/data/repositories/auth_repository_impl.dart';
import 'app/features/auth/data/datasources/auth_local_datasource.dart';
import 'app/features/auth/domain/usecases/auth_usecases.dart';
import 'app/shared/themes/app_theme.dart';
import 'app/features/music/presentation/providers/music_provider.dart';
import 'app/features/auth/presentation/pages/auth_screen.dart';
import 'app/features/home/presentation/pages/home_page.dart';
import 'app/core/database/database.service.dart';
import 'app/app.dart';

late AuthProvider authProvider;
late ThemeProvider themeProvider;
late MusicProvider musicProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.database; // Ensure the database is initialized

  final authLocalDataSource = AuthLocalDataSourceImpl();
  final authRepository = AuthRepositoryImpl(authLocalDataSource);
  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);

  authProvider = AuthProvider(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    logoutUseCase: logoutUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
  );

  themeProvider = ThemeProvider();
  musicProvider = MusicProvider();

  await themeProvider.loadTheme();
  await authProvider.checkAuthStatus();

  runApp(const App());
}
