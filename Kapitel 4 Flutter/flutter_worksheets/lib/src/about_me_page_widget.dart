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
          Material(elevation: 12, shadowColor: Color(0xff4040c0), shape: CircleBorder(), child: CircleAvatar(radius: 128, backgroundImage: AssetImage("assets/images/kaya.jpeg"))),
          Text("Kaya Müller", style: carterBlue18),
          Text("Fotograf", style: carterBlue14),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Mein Name ist Kaya Müller, ein Fotograf im Alter von 32 Jahren, der die Welt durch die Linse entdeckt. Mit einem Hintergrund in der visuellen "+
              "Kunst und jahrelanger Erfahrung in der Fotografie habe ich einen Blick für die Schönheit im Alltäglichen entwickelt. Meine Spezialität liegt "+
              "in der Sport- und Naturfotografie, wo ich das Spiel von Licht und Schatten einfange, um emotionale und aussagekräftige Bilder zu schaffen.\n\nIch "+
              "glaube daran, dass jeder Moment einzigartig ist und seine eigene Geschichte erzählt. In meinen Arbeiten strebe ich danach, diese Geschichten visuell "+
              "zu interpretieren und sie durch kreative Kompositionen und Nuancen zum Leben zu erwecken. Meine fotografische Reise hat mich durch verschiedene Länder "+
              "geführt, wo ich die Vielfalt der Kulturen und Landschaften festhalte, immer auf der Suche nach neuen Perspektiven und Herausforderungen.\n\nMein "+
              "Anspruch ist es, mit meinen Bildern nicht nur zu dokumentieren, sondern auch zu inspirieren und zu berühren. Jeder Auftrag und jedes Projekt ist "+
              "für mich eine Möglichkeit, meine Leidenschaft und mein Können zu zeigen und eine Verbindung zwischen dem Betrachter und dem Bild herzustellen.",
              style: carterBlue14),
            ),
          ),
        ]),
      ),
    ));
  }
}