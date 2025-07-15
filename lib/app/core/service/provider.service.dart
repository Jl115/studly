import 'package:provider/provider.dart';
import 'package:studly/app/core/providers/theme.provider.dart';
import 'package:studly/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:studly/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:studly/app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:studly/app/features/auth/presentation/providers/auth.provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderService {
  static final ProviderService _instance = ProviderService._internal();

  factory ProviderService() => _instance;

  late final ThemeProvider themeProvider;
  late final AuthProvider authProvider;

  ProviderService._internal() {
    themeProvider = ThemeProvider();

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
  }

  List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
    ];
  }

  Future<void> init() async {
    await themeProvider.loadTheme();
    await authProvider.checkAuthStatus();
  }
}
