import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/features/shared_preferences/shared_prefs_bonus1.dart';
import 'package:flutter_worksheets_ii/src/features/shared_preferences/shared_prefs_bonus2.dart';

class Ws532b extends StatelessWidget {
  const Ws532b({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent)),
      home: SharedPrefsBonus2(),
    );
  }
}
