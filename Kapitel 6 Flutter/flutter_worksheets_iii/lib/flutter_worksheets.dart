import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/src/features/6.1.4_firestore_basics/6.1.4_ts.dart';

class Worksheets extends StatelessWidget {
  const Worksheets({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<(Widget, String)> dests = const [(Ts614(), "6.1.4 Firestore Grundlagen")];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kapitel 6 - Flutter III"), backgroundColor: Colors.pinkAccent.shade100, elevation: 12, shadowColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: const EdgeInsets.all(16), scrollDirection: Axis.vertical, 
          children: [ for(int i=0;i<dests.length;i++) 
            Container(height: 40, margin: const EdgeInsets.all(12), child:ElevatedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => dests[i].$1)), 
            style: const ButtonStyle(shadowColor: WidgetStatePropertyAll(Colors.pink), elevation: WidgetStatePropertyAll(4)), child: Text("${dests[i].$2}")))])
      ));
  }
}

