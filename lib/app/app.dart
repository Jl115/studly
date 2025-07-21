import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/core/service/go_router.service.dart';
import 'package:studly/app/core/service/provider.service.dart';
import 'package:studly/app/features/settings/presentation/providers/settings_provider.dart';
import 'package:studly/app/shared/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final ProviderService _providerService = ProviderService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providerService.getProviders(),
      child: Consumer<SettingsProvider>(
        builder:
            (context, themeProvider, _) => MaterialApp.router(
              title: 'Studly',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              routerConfig: GoRouterService().router, // ✅ correct usage
            ),
      ),
    );
  }
}
