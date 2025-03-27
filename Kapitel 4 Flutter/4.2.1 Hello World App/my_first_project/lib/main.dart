import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('This is my first Flutter-App!', 
            style: TextStyle(
              fontFamily: "Acme", 
              fontSize: 27,
              fontStyle: FontStyle.italic, 
              color: Color.fromARGB(255, 169, 109, 21)
            )
          )
        ),
      ),
    );
  }
}
