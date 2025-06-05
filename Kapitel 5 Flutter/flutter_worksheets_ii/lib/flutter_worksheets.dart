import 'package:flutter/material.dart';
import 'package:flutter_worksheets_ii/5.2.3_futurebuilder.dart';
import 'package:flutter_worksheets_ii/5.3.2_shared_preferences.dart';
import 'package:flutter_worksheets_ii/5.3.2_shared_prefs_bonus2.dart';
import 'package:flutter_worksheets_ii/src/features/call_back/cbf_screen.dart';

import '5.1.3_user_input.dart';

class Worksheets extends StatelessWidget {
  const Worksheets({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<(Widget, String)> dests = const [(Ws513(), "5.1.3 User Input"), (CbfScreen(), "5.1.6 Callback Funktionen"), (Ws523(), "5.2.3 Future Builder"),
                                          (Ws532(), "5.3.2 Shared Preferences"), (Ws532b(), "5.3.2 Shared Prefs Bonus2")];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kapitel 5 - Flutter II"), backgroundColor: Colors.pinkAccent.shade100, elevation: 12, shadowColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: const EdgeInsets.all(16), scrollDirection: Axis.vertical, 
          children: [ for(int i=0;i<dests.length;i++) 
            Container(height: 40, margin: const EdgeInsets.all(12), child:ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => dests[i].$1)), 
            style: const ButtonStyle(shadowColor: WidgetStatePropertyAll(Colors.pink), elevation: WidgetStatePropertyAll(4)), child: Text("${dests[i].$2}")))])
      ));
  }
}

