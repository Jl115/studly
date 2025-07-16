import 'package:provider/provider.dart';
import 'package:studly/app/core/providers/theme.provider.dart';
import 'package:studly/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:studly/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:studly/app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:studly/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:studly/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:studly/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:studly/app/features/auth/presentation/providers/auth.provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:studly/app/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:studly/app/features/settings/domain/repositories/settings_repository_impl.dart';
import 'package:studly/app/features/settings/domain/usecases/load_settings_usecase.dart';
import 'package:studly/app/features/settings/domain/usecases/save_settings_usecase.dart';
import 'package:studly/app/features/settings/presentation/providers/settings_provider.dart';

class ProviderService {
  static final ProviderService _instance = ProviderService._internal();

  factory ProviderService() => _instance;

  late final ThemeProvider themeProvider;
  late final AuthProvider authProvider;
  late final SettingsProvider settingsProvider;

  ProviderService._internal() {
    themeProvider = ThemeProvider();

    // Initialize Auth Provider
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
    // Initialize Settings Provider
    final settingsLocalDataSource = SettingsLocalDataSource();
    final settingsRepository = SettingsRepositoryImpl(settingsLocalDataSource);
    final loadSettingsUseCase = LoadSettingsUseCase(settingsRepository);
    final saveSettingsUseCase = SaveSettingsUseCase(settingsRepository);
    settingsProvider = SettingsProvider(
      loadSettingsUseCase,
      saveSettingsUseCase,
    );
  }

  List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ChangeNotifierProvider<SettingsProvider>.value(value: settingsProvider),
    ];
  }

  Future<void> init() async {
    await settingsProvider.load();
    await themeProvider.loadTheme();
    await authProvider.checkAuthStatus();
  }
}
