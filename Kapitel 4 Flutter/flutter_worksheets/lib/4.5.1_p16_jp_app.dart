import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/features/snackish/features/splash/splash_page4.dart';

void main() {
  runApp(const MaterialApp(title: "P16 JP App", debugShowCheckedModeBanner: false, 
      home: Ws451()));
}

class Ws451 extends StatelessWidget {
  const Ws451({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashPage4();
  }
}
