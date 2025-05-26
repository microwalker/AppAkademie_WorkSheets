import 'package:flutter/material.dart';

import 'src/features/call_back/cbf_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CbfScreen(),
    );
  }
}
