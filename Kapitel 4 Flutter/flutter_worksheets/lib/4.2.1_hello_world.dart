import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "Hello World", home: Ws421()));
}

class Ws421 extends StatelessWidget {
  const Ws421({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${ModalRoute.settingsOf(context)!.name}"), backgroundColor: Colors.blueAccent),
      body: Center(child: Column(
      children: [
        Text("Hello World", key: Key("hwText")),
        FilledButton(onPressed: () {}, child: Text("Klick!"))
      ],
    )));
  }
}


