import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studly/app/core/service/go_router.service.dart';

class NavbarProvider with ChangeNotifier {
  // Private state variable
  bool _isNavBarVisible = true;

  // Public getter to access the state
  bool get isNavBarVisible => _isNavBarVisible;

  // Method to show the nav bar
  void show() {
    if (!_isNavBarVisible) {
      _isNavBarVisible = true;
      notifyListeners(); // Notify widgets that are listening
    }
  }

  // Method to hide the nav bar
  void hide() {
    if (_isNavBarVisible) {
      _isNavBarVisible = false;
      notifyListeners(); // Notify widgets that are listening
    }
  }

  int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/musicLibrary')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0; // Default to home
  }

  void onItemTapped(int index) {
    // Navigation logic remains the same
    GoRouterService().go(
      index == 0
          ? '/home'
          : index == 1
          ? '/musicLibrary'
          : '/settings',
    );
  }
}
