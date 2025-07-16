import 'package:go_router/go_router.dart';
import 'package:studly/app/features/settings/presentation/pages/settings.dart';
import 'package:studly/app/wrapper/auth_wrapper.dart';
import 'package:studly/app/features/home/presentation/pages/home_page.dart';
import 'package:studly/app/features/music_library/presentation/pages/music_library.dart';

class AppRoutes {
  static List<GoRoute> get routes => [
    GoRoute(path: '/', pageBuilder: (_, __) => const NoTransitionPage(child: AuthWrapper())),
    GoRoute(path: '/home', pageBuilder: (_, __) => const NoTransitionPage(child: HomePage())),
    GoRoute(path: '/musicLibrary', pageBuilder: (_, __) => const NoTransitionPage(child: MusicLibrary())),
    GoRoute(path: '/settings', pageBuilder: (_, __) => const NoTransitionPage(child: Settings())),
  ];
}
