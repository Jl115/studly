import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/features/auth/presentation/pages/auth_screen.dart';
import 'package:studly/app/features/auth/presentation/providers/auth.provider.dart';
import 'package:studly/app/features/home/presentation/pages/home_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        print('\x1B[32mauthProvider.isLoggedIn -------------------- ${authProvider.isLoggedIn}\x1B[0m');
        if (authProvider.isLoggedIn) {
          return const HomePage();
        }

        return const AuthScreen();
      },
    );
  }
}
