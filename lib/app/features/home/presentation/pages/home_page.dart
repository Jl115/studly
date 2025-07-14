import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../music/presentation/providers/music_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studly'),
        actions: [
          IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) => Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
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
                        Text(
                          'Ready to discover new music?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            // Music Player Section
            Text(
              'Music Player',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<MusicProvider>(
                  builder: (context, musicProvider, child) {
                    return Column(
                      children: [
                        if (musicProvider.currentTrack != null) ...
                          [
                            Text(
                              musicProvider.currentTrack!.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              musicProvider.currentTrack!.artist,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                          ]
                        else
                          const Text('No track selected'),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                musicProvider.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: () {
                                if (musicProvider.isPlaying) {
                                  musicProvider.pause();
                                } else {
                                  musicProvider.resume();
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.stop),
                              onPressed: () {
                                musicProvider.stop();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Features Section
            Text(
              'Features',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Music Library',
                  Icons.library_music,
                  'Browse your music collection',
                  () {
                    // TODO: Navigate to music library
                  },
                ),
                _buildFeatureCard(
                  context,
                  'Playlists',
                  Icons.playlist_play,
                  'Create and manage playlists',
                  () {
                    // TODO: Navigate to playlists
                  },
                ),
                _buildFeatureCard(
                  context,
                  'Settings',
                  Icons.settings,
                  'Customize your experience',
                  () {
                    // TODO: Navigate to settings
                  },
                ),
                _buildFeatureCard(
                  context,
                  'Profile',
                  Icons.person,
                  'Manage your profile',
                  () {
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
  
  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
