import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/core/providers/theme_provider.dart';
import 'package:studly/app/shared/themes/app_theme.dart';
import 'package:studly/app/wrapper/auth_wrapper.dart';
import 'package:studly/main.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: musicProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder:
            (context, themeProvider, child) => MaterialApp(
              title: 'Studly',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              home: const AuthWrapper(),
            ),
      ),
    );
  }
}
