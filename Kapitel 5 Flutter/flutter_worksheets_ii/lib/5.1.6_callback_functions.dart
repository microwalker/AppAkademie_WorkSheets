import 'package:flutter/material.dart';

import 'src/features/call_back/cbf_screen.dart';

void main() {
  runApp(const Ws516());
}

class Ws516 extends StatelessWidget {
  const Ws516({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent)),
      // debugShowCheckedModeBanner: false,
      home: CbfScreen(),
    );
  }
}
