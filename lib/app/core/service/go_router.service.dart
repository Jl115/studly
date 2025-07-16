import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studly/app/core/constants/app.routes.dart';

class GoRouterService {
  static final GoRouterService _instance = GoRouterService._internal();
  factory GoRouterService() => _instance;
  GoRouterService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: AppRoutes.routes,
    errorBuilder: (context, state) => Scaffold(body: Center(child: Text('404: ${state.error}'))),
  );

  GoRouter get router => _router;

  // Navigate without context
  void go(String path) => _router.go(path);
  void push(String path) => _router.push(path);
}
