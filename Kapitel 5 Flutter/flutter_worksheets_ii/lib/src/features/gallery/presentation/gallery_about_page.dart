import 'package:flutter/material.dart';
import '../../../themes/styles.dart';

class AboutMePageWidget extends StatelessWidget {
  const AboutMePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SingleChildScrollView(
      child: Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround, spacing: 16, children: [
          Text("Hinweis", style: carterBlue18),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
"Da ich in Dart schon ab Kapitel 3 bzw. in Flutter im Kapitel 4 vieles mit API-Zugriffen gemacht habe, habe ich mich entschieden, für P20 einfach nur meine "+
"Bildergalerie-App aus Kapitel 4 mit einigen geringfügigen Modifizierungen abzugeben, um nicht erneut wieder eine komplett neue App zu erstellen, die einfach "+
"nur das gleiche macht, wie schon so viele zuvor.\nWährend des (sehr kurzen) Ladevorgangs der API-Daten wird ein CircularProgressIndicator angezeigt und die "+
"Gallerie kann nun mittels RefreshIndicator (durch herunterziehen der Gallerie) mit neuen, zufälligen Bildern refresht werden!\nDas wars eigentlich auch schon...",
            style: carterBlue14),
          ),
        ]),
      ),
    ));
  }
}