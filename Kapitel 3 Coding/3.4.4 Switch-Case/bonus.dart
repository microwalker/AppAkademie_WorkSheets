import 'dart:math';

enum classes { warrior, mage, archer }
enum daytimes { morning, noon, evening, night }
enum weathers { sunny, rainy, stormy }

void main(List<String> args) {
  // Zum Test: 10 Zufällige Charaktere mit zufälligem Zeitpunkt und Wetterbedingungen erstellen
  for(int i=0;i<10;i++) {
    classes hero = classes.values[Random().nextInt(classes.values.length)];
    daytimes dt = daytimes.values[Random().nextInt(daytimes.values.length)];
    weathers wt = weathers.values[Random().nextInt(weathers.values.length)];
    calcPoweredHero(hero, dt, wt);
  }
}

void calcPoweredHero(classes c, daytimes d, weathers w) {
  // Zufälliger Startwert (zwischen 25 und 75) für die Angriffsstärke
  int power = Random().nextInt(50)+25;

  // Von Wetter und Tageszeit abhängige Veränderung der Angriffsstärke ermitteln
  power += powerByDaytimeOrWeather(c, d, w);

  // Ausgabe:
  String heroText = "";
  switch(c) {
    case classes.warrior:
      heroText+="Krieger";
    case classes.mage:
      heroText+="Magier";
    case classes.archer:
      heroText+="Bogenschütze";
  }

  String conditions = "";
  switch(w) {
    case weathers.sunny:
      conditions="Sonnenschein";
    case weathers.rainy:
      conditions="Regen";
    case weathers.stormy:
      conditions="Sturm";
  }

  conditions+=" und ";
  switch(d) {
    case daytimes.morning:
      conditions+="so früh Morgens";
    case daytimes.noon:
      conditions+="zur Mittagszeit";
    case daytimes.evening:
      conditions+="in den Abendstunden";
    case daytimes.night:
      conditions+="in der Nacht";
  }

  String powerText = "Das ist ziemlich schwach.";
  switch(power) {
    case >20 && <=40:
      powerText = "Nicht wirklich optimal!";
    case <=60:
      powerText = "Gutes Mittelmaß...";
    case <=80:
      powerText = "Schon richtig kräftig!";
    case >80:
      powerText = "Sehr gefährlich!!!";
  }

  // Ausgabe in gut lesbarer Form
  print("Dein $heroText hat bei $conditions eine Angriffsstärke von $power! $powerText");
}

int powerByDaytimeOrWeather(classes c, daytimes d, weathers w) {
  int diffPower = 0;

  switch(c) {
    case classes.warrior:
      switch(d) {
        case daytimes.morning || daytimes.evening:
          diffPower = 10;
        case daytimes.noon:
          diffPower = 25;
        case daytimes.night:
          diffPower = -5;
      }
    case classes.mage:
      switch(w) {
        case weathers.rainy:
          diffPower = 10;
        case weathers.stormy:
          diffPower = 25;
        case weathers.sunny:
          diffPower = -5;
      }
    case classes.archer:
      switch(w) {
        case weathers.stormy:
          diffPower = 10;
        case weathers.sunny:
          diffPower = 25;
        case weathers.rainy:
          diffPower = -5;
      }
  }
  return diffPower;
}


