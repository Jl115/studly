import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studly/app/core/providers/navbar_provider.dart';

const double kBottomNavBarHeight = 90.0;
// New constant for the small, invisible handle when the bar is "hidden"
const double kBottomNavHandleHeight = 20.0;

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavbarProvider>(context);
    final isVisible = navBarProvider.isNavBarVisible;
    final selectedIndex = navBarProvider.calculateSelectedIndex(context);

    return GestureDetector(
      // This makes the entire area draggable, including the transparent handle.
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (details) {
        // Use `listen: false` inside event handlers for performance.
        final provider = Provider.of<NavbarProvider>(context, listen: false);

        // Swipe down on the visible bar to hide it
        if (details.delta.dy > 5 && isVisible) {
          provider.hide();
        }
        // Swipe up on the handle area to show it
        else if (details.delta.dy < -5 && !isVisible) {
          provider.show();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        // Animate between the full height and the handle's height, NOT 0.
        height: isVisible ? kBottomNavBarHeight : kBottomNavHandleHeight,
        child: Wrap(
          // Wrap prevents overflow errors when the height shrinks.
          clipBehavior: Clip.hardEdge,
          children: [
            BottomAppBar(
              height: kBottomNavBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  final icons = [Icons.home, Icons.search, Icons.settings];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () => navBarProvider.onItemTapped(index),
                    behavior: HitTestBehavior.translucent,
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
            ),
          ],
        ),
      ),
    );
  }
}
