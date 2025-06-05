import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/features/future_builder/future_builder.dart';

class Ws523 extends StatelessWidget {
  const Ws523({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent)),      
      home: FutureBuilderExercise(),
    );
  }
}
