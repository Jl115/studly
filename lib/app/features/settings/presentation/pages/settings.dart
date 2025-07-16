import 'package:flutter/material.dart';
import 'package:studly/app/shared/widgets/bottom_navigation.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyWidget')),
      bottomNavigationBar: BottomNavigation(),
      body: Center(child: Text('Hello, Flutter!')),
    );
  }
}
