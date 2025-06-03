import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart';

void main() {
  runApp(const PortolineApp());
}

class PortolineApp extends StatelessWidget {
  const PortolineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RoleSelectionScreen(),
    );
  }
}
