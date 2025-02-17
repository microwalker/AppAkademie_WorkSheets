import 'dart:math';

int zahlen = 500;
int maxZahl = 100;
bool showList = false;

void main(List<String> args) {
  // List liste = [9,84,36,71,12,8,44,69,32,108,11,71,14,3,92,22,79,37,3,19,102];
  List liste = new List.generate(zahlen, (int i) => Random().nextInt(maxZahl), growable: false);
  // GenerateRandomsIntNumbers(liste, zahlen, maxZahl);
  print("\nRunning INT Sort Competition ($zahlen Zahlen):");
  startCompetitiom(liste, showList);

  // liste.clear();
  liste = new List.generate(zahlen, (int i) => Random().nextDouble() * maxZahl, growable: false);
  // GenerateRandomsDblNumbers(liste, zahlen, maxZahl);
  print("\nRunning DOUBLE Sort Competition ($zahlen Zahlen):");
  startCompetitiom(liste, showList);

  /* benötigt Modifikation der Sort-Routinen zum dynamischen Vergleich von Strings, Stichwort (a,b) => b.compareTo(a) 
  fillWithWords(liste);
  startCompetitiom(liste);
  */

  print("Measurement finished!");
}

void startCompetitiom(List<dynamic> liste, bool showList) {
  Stopwatch c = new Stopwatch();
  
  if(showList) print("Original: $liste");
  
  List tList = liste.toList();
  
  c.start(); // Zeitmessung für BubbleSort starten
  BubbleSort(tList);
  c.stop();
  print("Bubble: ${showList?tList:""} (Dauer: ${c.elapsed})");
  c.reset(); // Zeitmessung für SelectionSort neu starten

  tList = liste.toList();
  c.start();
  SelectionSort(tList);
  c.stop();
  print("Selection ${showList?tList:""} (Dauer: ${c.elapsed})");
  c.reset(); // Zeitmessung für ExtSelectionSort neu starten
  
  tList = liste.toList();
  c.start();
  ExtSelectionSort(tList);
  c.stop();
  print("ExtSelection ${showList?tList:""} (Dauer: ${c.elapsed})");
  c.reset(); // Zeitmessung für List.Sort() neu starten

  c.start();
  liste.sort();
  print("List.Sort: ${showList?liste:""} (Dauer: ${c.elapsed})");
  c..stop(); // Stopuhr beenden
}

/**
 * Generiert in der übergebenen Liste die übergebene anzahl an zufälligen Ganzzahlen zwischen 0 und max
 */
void GenerateRandomsIntNumbers(List list, int anzahl, int max) {
  for(int i=0;i<anzahl;i++)
    list.add((Random().nextInt(max)));
}

void GenerateRandomsDblNumbers(List list, int anzahl, int max) {
  for(int i=0; i < anzahl;i++)
    list.add(Random().nextDouble() * max);
}

/**
 * BubbleSort, die typische Sortiermethode. Führt sehr viele Tauschvorgänge und etliche Schleifendurchgänge durch...
 * Etwas langsam, aber Zuverlässig :-)
 */
List BubbleSort(List liste) {
  int swaps = 0;
  int loops = 0;
  for(int j = 0;j < liste.length - 2;j++) {
    for(int i = 0;i < liste.length - 1;i++) {
      if(liste[i + 1] < liste[i] ) {
        var tmp = liste[i];
        liste[i] = liste[i + 1];
        liste[i + 1] = tmp;
        swaps++;
      }
      loops++;
    }
    loops++;
  }
  print("Bubble Stats: $swaps Swaps / $loops Loops");
  return liste;
}

/**
 * SelectionSort, tauscht noch mehrfach in der inneren Schleife
 */
List SelectionSort(List liste) {
  int swaps = 0;
  int loops = 0;
  int pos = 0;
  while(pos < liste.length) {
    for(int i = pos + 1;i < liste.length; i++) {
      if(liste[i] < liste[pos]) {
        var tmp = liste[pos];
        liste[pos] = liste[i];
        liste[i] = tmp;
        swaps++;
      }
      loops++;
    }
    pos++;
    loops++;
  }
  print("Selection Stats: $swaps Swaps / $loops Loops");
  return liste;
}

/**
 * SelectionSort mit minimierten Swaps (nur noch 1 Umtausch pro durchlaufene innere Schleife!)
 */
List ExtSelectionSort(List liste) {
  int swaps = 0;
  int loops = 0;
  
  int pos = 0;
  while(pos < liste.length) {
    int min = pos;
    
    for(int i = pos + 1;i < liste.length; i++) {
      min = liste[i] < liste[min] ? i : min;
      loops++;
    }
    
    if(min != pos) {
      var tmp = liste[pos];
      liste[pos] = liste[min];
      liste[min] = tmp;
      swaps++;
    }
    pos++;
    loops++;
  }
  print("ExtSelection Stats: $swaps Swaps / $loops Loops");
  return liste;
}

void fillWithWords(List list) {
  list = ["Erwachsener","Flugzeug","Luft","Flugzeugträger","Luftwaffe","Flughafen","Album","Alphabet","Apfel","Arm","Meer","Baby","Baby","Rucksack",
          "Ballon","Banane","Bank","Grill","Bad","Badewanne","Bett","Biene","Bibel","Vogel","Bombe","Buch","Boss","Flasche","Schüssel","Box","Junge",
          "Gehirn","Brücke","Schmetterling","Taste","Cappuccino","Wagen","Autorennen","Teppich","Karotte","Höhle","Stuhl","Schachbrett","Chef","Kind",
          "Meißel","Pralinen","Kirche","Kreis","Zirkus","Zirkus","Uhr","Clown","Kaffee","Café","Unkraut","Komet","Compact Disc","Kompass","Computer",
          "Kristall","Tasse","Zyklus","Datenbank","Schreibtisch","Diamant","Kleid","Bohren","Trinken","Trommel","Dung","Ohren","Erde","Ei","Elektrizität",
          "Elefant","Radiergummi","Explosiv","Augen","Familie","Ventilator","Feder","Festival","Film","Finger","Feuer","Scheinwerfer","Blume","Fuß","Gabel",
          "Obst","Pilz","Spiel","Garten","Gas","Tor","Edelstein","Mädchen","Handschuhe","Gott","Trauben","Gitarre","Hammer","Hut","Hieroglyphe","Autobahn",
          "Horoskop","Pferd","Schlauch","Eis","Insekt","Düsenjäger","Junk","Kaleidoskop","Küche","Messer","Lederjacke","Bein","Bibliothek","Flüssigkeit",
          "Magnet","Mann","Karte","Matze","Fleisch","Meteor","Mikroskop","Milch","Milchshake","Nebel","Geld","Monster","Moskito","Mund","Nagel","Marine",
          "Halskette","Nadel","Zwiebel","Pinsel","Hose","Fallschirm","Reisepass","Kieselstein","Pendel","Pfeffer","Parfüm","Kissen","Flugzeug","Planet",
          "Tasche","Postamt","Kartoffel","Drucker","Gefängnis","Pyramide","Radar","Regenbogen","Aufzeichnung","Restaurant","Gewehr","Ring","Roboter",
          "Felsen","Rakete","Dach","Zimmer","Seil","Sattel","Salz","Sandpapier","Sandwich","Satellit","Schule","Sex","Schiff","Schuhe","Geschäft",
          "Dusche","Unterschrift","Skelett","Sklave","Schnecke","Software","Fester Körper","Space Shuttle","Spektrum","Kugel","Würzen","Spiral","Löffel",
          "Sportwagen","Scheinwerfer","Quadrat","Treppe","Star","Bauch","Sonne","Sonnenbrille","Landvermesser","Schwimmbad","Schwert","Tabelle","Tapisserie",
          "Zähne","Fernrohr","Fernsehen","Tennisschläger","Thermometer","Tiger","Toilette","Zunge","Fackel","Torpedo","Zug","Laufband","Dreieck","Tunnel",
          "Schreibmaschine","Regenschirm","Vakuum","Vampir","Videoband","Geier","Wasser","Waffe"];
}