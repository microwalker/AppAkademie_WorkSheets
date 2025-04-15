import 'package:flutter/material.dart';
import 'package:flutter_worksheets/src/styles.dart';

class AboutMePageWidget extends StatelessWidget {
  const AboutMePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SingleChildScrollView(
      child: Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround, spacing: 16, children: [
          Text("About Me", style: carterBlue18),
          Material(elevation: 12, shadowColor: Color(0xff4040c0), shape: CircleBorder(), child: CircleAvatar(radius: 128, backgroundImage: AssetImage("assets/images/carsten_und_co.jpeg"))),
          Text("Carsten & Co.", style: carterBlue18),
          Text("Freund aller Coder", style: carterBlue14),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Hallo, ich bin der Carsten! Hier mit meiner Patchwork-Family...\n\nScheinbar bin ich schon sehr bekannt, sogar bei der App Akademie "+
              "wurde ich schon oft, unter anderem von diesem Ibrahim, erwähnt! Warum, das verstehe ich selber nicht...\n\nAch ja, mit auf dem Foto ist meine kleine "+
              "Tochter 'Integer', meine Frau 'BigInt' und die große rechts ist 'Todouble'. Obwohl wir eine ganz normale Familie sind, fangen viele immer an zu lachen, "+
              "wenn ich uns alle vorstelle! Scheinbar finden uns ganz besonders Programmierer oder so Leute aus dem IT-Bereich ganz ungeheuer witzig. Aber "+
              "leider erklärt uns auf Nachfrage dann nie jemand, warum wir ständig ausgelacht werden.\n\nMan, hör auf zu lachen!!!!\n\nAch, legt Euch doch gehackt, Mensch...",
              style: carterBlue14),
            ),
          ),
        ]),
      ),
    ));
  }
}