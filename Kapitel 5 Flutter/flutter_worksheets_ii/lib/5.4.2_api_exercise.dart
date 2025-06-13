import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/features/first_api/api_example.dart';

class Ws532b extends StatelessWidget {
  const Ws532b({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent.shade200)),
      home: ApiExample(),
    );
  }
}
