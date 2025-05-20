import 'package:flutter/material.dart';

import '5.1.3_user_input.dart';

class Worksheets extends StatelessWidget {
  const Worksheets({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<(Widget, String)> dests = const [(Ws513(), "5.1.3 User Input")];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kapitel 4 - Flutter I"), backgroundColor: Colors.lightGreen, elevation: 12, shadowColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: const EdgeInsets.all(16), scrollDirection: Axis.vertical, 
          children: [ for(int i=0;i<dests.length;i++) 
            Container(height: 40, margin: const EdgeInsets.all(12), child:ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => dests[i].$1)), 
            style: const ButtonStyle(shadowColor: WidgetStatePropertyAll(Colors.green), elevation: WidgetStatePropertyAll(4)), child: Text("${dests[i].$2}")))])
      ));
  }
}

