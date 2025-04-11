import 'package:flutter/material.dart';

void main() {
  runApp(const Ws421());
}

class Ws421 extends StatelessWidget {
  const Ws421({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MainApp", home: Scaffold(body: Center(child: Column(
      children: [
        Text("Hello World", key: Key("hwText")),
        FilledButton(onPressed: () {}, child: Text("Klick!"))
      ],
    ))));
  }
}


