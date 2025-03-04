void main(List<String> args) {
  List<Map<String, double?>> weatherData = [
    {"temp": 5.3, "rain": 0.9, "wind": null},
    {"temp": 4.5, "rain": null, "wind": 16.8},
    {"temp": null, "rain": 3.8, "wind": null}
  ];

  /* BEMERKUNG:
     Statt drei Listen anzulegen, wie in der Aufgabe gestellt, hätte ich nur eine Liste mit
     den Keywords erstellt und wäre direkt zur Berechnung der Durchschnittswerte die Maps 
     in der Liste durchgegangen... */
  
  List<double> temps = [];
  List<double> rains = [];
  List<double> winds = [];

  // Listen mit gültigen Werten füllen
  weatherData.forEach((element) {
    if(element["temp"] != null)
       temps.add(element["temp"]!);
    if(element["rain"] != null)
       rains.add(element["rain"]!);
    if(element["wind"] != null)
       winds.add(element["wind"]!);
  }); 

  // Ab hier kann sicher ohne lästige Null-Werte gearbeitet werden!
  double avgTemp = 0;
  temps.forEach((element) { avgTemp += element; });
  if(temps.length>0) 
    avgTemp /= temps.length;

  double avgRain = 0;
  rains.forEach((element) { avgRain += element; });
  if(rains.length > 0)
    avgRain /= rains.length;

  double avgWind = 0;
  winds.forEach((element) { avgWind += element; });
  if(winds.length > 0)
    avgWind /= winds.length;

  // Ausgabe der errechneten Werte (mit Prüfung auf deren Vorhandensein)
  print("\n                       Durchschnittswerte:\n" +
        "Temperatur:            ${temps.length > 0 ? avgTemp.toStringAsFixed(1) + " °C" : "k.A."}\n" +
        "Niederschlag:          ${rains.length > 0 ? avgRain.toStringAsFixed(2) + " mm" : "k.A."}\n" +
        "Windgeschwindigkeit:   ${winds.length > 0 ? avgWind.toStringAsFixed(1) + " km/h" : "k.A."}\n");
}