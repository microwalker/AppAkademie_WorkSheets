import 'package:flutter/material.dart';

void main() {
  runApp(Ws431b());
}

class Ws431b extends StatelessWidget {
  const Ws431b({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(title: Text("Aufgabe 1"), backgroundColor: Colors.blue, centerTitle: true),
      body: Padding(padding: EdgeInsets.fromLTRB(8,48,8,48),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, spacing: 24, children: [
          _HelloAppAkademie(),
          _HelloAppAkademie(),
          _EdgedFilledButtonsRow(),
          _EdgedFilledButtonsRow(),
          _FacesInRow(),
          _FacesInRow()
        ]),
      )
      
    ));
  }
}

class _HelloAppAkademie extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Text("Hallo App Akademie!", style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w800));
  }
}

class _EdgedFilledButtonsRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, spacing: 8, children: [
      Container(color: Colors.red, padding: EdgeInsets.all(24), child: 
        FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("A", style: TextStyle(color: Colors.white)))),
      Container(color: Colors.green, padding: EdgeInsets.all(24), child: 
        FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("B", style: TextStyle(color: Colors.white)))),
      Container(color: Colors.blue, padding: EdgeInsets.all(24), child: 
        FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)), child: Text("C", style: TextStyle(color: Colors.white)))),
      ]);
  }
}

class _FacesInRow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Icon(Icons.face, size: 48), Icon(Icons.face, size: 48)]);
  }
}
