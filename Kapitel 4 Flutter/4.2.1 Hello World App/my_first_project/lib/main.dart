import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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


