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
          child: Text("Golden times dor Developers!", 
            style: TextStyle(
              fontFamily: "CupertinoSystemDisplay", 
              fontFeatures: [FontFeature.randomize()],
              fontSize: 24,
              fontStyle: FontStyle.italic, 
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 184, 210, 111)
            ), 
          ), 
        ), 
        backgroundColor: Color.fromARGB(243, 26, 88, 40), 
      ),
    );
  }

}
