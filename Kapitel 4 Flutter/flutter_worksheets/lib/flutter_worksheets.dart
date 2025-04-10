import 'package:flutter/material.dart';
import '4.2.1_hello_world.dart';
// import '4.2.2_ws_bonus.dart';
import '4.2.3_p13_first_app.dart';
import '4.3.1_ws_bonus.dart';
import '4.3.1_ws_main.dart';
import '4.3.5_p14_first_screen.dart';
import '4.4.3_ws_bonus.dart';
import '4.4.3_ws_main.dart';

class worksheets extends StatelessWidget {
  const worksheets({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<(Widget, String)> dests = const [(ws421(), "4.2.1 Hello World"), (ws423(), "4.2.3 P13 First App"), (ws431(), "4.3.1 Main"), (ws431b(), "4.3.1 Bonus"), 
                                          (ws435(), "4.3.5 P14 First Screen"), (ws443(), "4.4.3 Main"), (ws443b(), "4.4.3 Bonus")];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Übersicht"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(padding: const EdgeInsets.all(16), scrollDirection: Axis.vertical, 
          children: [ for(int i=0;i<dests.length;i++) 
            Container(height: 40, margin: const EdgeInsets.all(12), child:ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => dests[i].$1)), 
            style: const ButtonStyle(shadowColor: WidgetStatePropertyAll(Colors.green), elevation: WidgetStatePropertyAll(4)), child: Text("Worksheet ${dests[i].$2}")))])
      ));
  }
}

