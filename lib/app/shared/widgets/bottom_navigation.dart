import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:studly/app/core/service/go_router.service.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  // Helper method to get the current index from the route location
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/musicLibrary')) {
      return 1;
    }
    if (location.startsWith('/settings')) {
      return 2;
    }
    return 0; // Default to home
  }

  void _onItemTapped(int index) {
    // Navigation logic remains the same
    GoRouterService().go(
      index == 0
          ? '/home'
          : index == 1
          ? '/musicLibrary'
          : '/settings',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the selected index based on the current route
    final selectedIndex = _calculateSelectedIndex(context);

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final icons = [Icons.home, Icons.search, Icons.settings];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icons[index], color: isSelected ? Colors.blue : Colors.grey),
            ),
          );
        }),
      ),
    );
  }
}

