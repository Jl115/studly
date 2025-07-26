import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/core/service/go_router.service.dart';
import 'package:studly/app/features/home/presentation/widgets/feature_card.dart';
import 'package:studly/app/features/settings/presentation/providers/settings_provider.dart';
import 'package:studly/app/shared/widgets/bottom_navigation.dart';
import '../../../auth/presentation/providers/auth.provider.dart';
// import '../../../music/presentation/providers/music_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studly'),
        actions: [
          IconButton(
            icon: Consumer<SettingsProvider>(
              builder:
                  (context, themeProvider, child) =>
                      Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
            onPressed: () {
              context.read<SettingsProvider>().toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, ${authProvider.currentUser?.username ?? 'User'}!',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text('Ready to discover new music?', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // // Music Player Section
            // Text('Music Player', style: Theme.of(context).textTheme.headlineSmall),
            // const SizedBox(height: 16),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Consumer<MusicProvider>(
            //       builder: (context, musicProvider, child) {
            //         return Column(
            //           children: [
            //             if (musicProvider.currentTrack != null) ...[
            //               Text(musicProvider.currentTrack!.title, style: Theme.of(context).textTheme.titleMedium),
            //               Text(musicProvider.currentTrack!.artist, style: Theme.of(context).textTheme.bodyMedium),
            //               const SizedBox(height: 16),
            //             ] else
            //               const Text('No track selected'),
            //
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 IconButton(
            //                   icon: Icon(musicProvider.isPlaying ? Icons.pause : Icons.play_arrow),
            //                   onPressed: () {
            //                     if (musicProvider.isPlaying) {
            //                       musicProvider.pause();
            //                     } else {
            //                       musicProvider.resume();
            //                     }
            //                   },
            //                 ),
            //                 IconButton(
            //                   icon: const Icon(Icons.stop),
            //                   onPressed: () {
            //                     musicProvider.stop();
            //                   },
            //                 ),
            //               ],
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 24),

            // Features Section
            Text('Features', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FeatureCard(
                  title: 'Music Library',
                  icon: Icons.library_music,
                  subtitle: 'Browse your music collection',
                  onTap: () {
                    GoRouterService().go('/musicLibrary');
                  },
                ),
                FeatureCard(
                  title: 'Playlists',
                  icon: Icons.playlist_play,
                  subtitle: 'Create and manage playlists',
                  onTap: () {
                    // TODO: Navigate to playlists
                  },
                ),
                FeatureCard(
                  title: 'Settings',
                  icon: Icons.settings,
                  subtitle: 'Customize your experience',
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
                FeatureCard(
                  title: 'Profile',
                  icon: Icons.person,
                  subtitle: 'Manage your profile',
                  onTap: () {
                    // TODO: Navigate to profile
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
