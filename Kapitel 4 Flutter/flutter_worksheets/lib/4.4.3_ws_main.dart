import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Ws443()));
}

class Ws443 extends StatelessWidget {
  const Ws443({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.indigo, appBar: AppBar(title: Text("Random Picture")),
      body: Column(
        children: [
          Expanded(flex: 1,
            child: Container(
              color: Colors.indigo,
              child: Center(
                child: Text('Showing Random Image', style: TextStyle(color: Colors.cyan, fontSize: 40)),
              ),
            ),
          ),
          Expanded(flex: 3, child: Container(
            color: Colors.blueAccent, child: Image.network('https://picsum.photos/600/600', fit: BoxFit.cover))),
              // Scheinbar liefert Picsum nur Bilder bis zu einer bestimmten Größe...
          Expanded(flex: 1, child: Container(
            color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text("Just showing a new random Picture everytime you refresh the Screen... 😜", style: TextStyle(fontSize: 32, color: Colors.white), ),
            ),
          ))
        ]),
      );
  }
}
