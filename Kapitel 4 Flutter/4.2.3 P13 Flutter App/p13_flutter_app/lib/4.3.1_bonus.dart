import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("Aufgabe 1"), backgroundColor: Colors.blue, centerTitle: true),
      body: Padding(padding: EdgeInsets.fromLTRB(8,48,8,48),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, spacing: 24, children: [
          HelloAppAkademie(),
          HelloAppAkademie(),
          EdgedFilledButtonsRow(),
          EdgedFilledButtonsRow(),
          FacesInRow(),
          FacesInRow()
        ]),
      )
      
    ));
  }
}

class HelloAppAkademie extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Text("Hallo App Akademie!", style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w800));
  }
}

class EdgedFilledButtonsRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, spacing: 8, children: [
            Container(color: Colors.red, padding: EdgeInsets.all(24), child: 
              FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("A", style: TextStyle(color: Colors.white)))),
            Container(color: Colors.green, padding: EdgeInsets.all(24), child: 
              FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("B", style: TextStyle(color: Colors.white)))),
            Container(color: Colors.blue, padding: EdgeInsets.all(24), child: 
              FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("C", style: TextStyle(color: Colors.white)))),
          ]);
  }
}

class FacesInRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.face, size: 48), Icon(Icons.face, size: 48)]);
  }
}
