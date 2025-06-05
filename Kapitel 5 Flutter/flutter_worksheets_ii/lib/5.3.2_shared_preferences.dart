import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/features/shared_preferences/shared_prefs_bonus1.dart';

class Ws532 extends StatelessWidget {
  const Ws532({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent)),
      home: SharedPreferencesExercise(),
    );
  }
}
