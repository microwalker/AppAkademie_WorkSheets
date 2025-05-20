import 'package:flutter/material.dart';
import 'package:flutter_worksheets/4.4.5_p15_bildergalerie.dart';
import 'package:flutter_worksheets/4.5.1_p16_jp_app.dart';
import 'package:flutter_worksheets/src/features/five_times/main.dart';
import 'package:flutter_worksheets/src/features/flattrige_liste/main.dart';
import 'package:flutter_worksheets/src/features/practices/steckbrief_berlin.dart';
import '4.2.1_hello_world.dart';
// import '4.2.2_ws_bonus.dart';
import '4.2.3_p13_first_app.dart';
import '4.3.1_ws_bonus.dart';
import '4.3.1_ws_main.dart';
import '4.3.5_p14_first_screen.dart';
import '4.4.3_ws_bonus.dart';
import '4.4.3_ws_main.dart';
import '4.4.4_ws_main.dart';

class Worksheets extends StatelessWidget {
  const Worksheets({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<(Widget, String)> dests = const [(Ws421(), "4.2.1 Hello World"), (Ws423(), "4.2.3 P13 First App"), (Ws431(), "4.3.1 Main"), (Ws431b(), "4.3.1 Bonus"), 
                                          (Ws435(), "4.3.5 P14 First Screen"), (Ws443(), "4.4.3 Main"), (Ws443b(), "4.4.3 Bonus"), (Ws444(), "4.4.4 Main"),
                                          (FlattrigeListe(), "Übung - Listen"), (FiveTimes(), "Übung - InkWell/GestureDetector"),
                                          (Ws445(), "4.4.5 P15 Gallery App"), (Ws451(), "P16 JP App ('Snackish')"), (Sbb(), "Übung - Steckbrief Berlin")];
    
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

