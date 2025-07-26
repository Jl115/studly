import 'package:flutter/material.dart';
import 'package:studly/app/shared/widgets/bottom_navigation.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyWidget')),
      body: Center(child: Text('Hello, NotesPage')),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
