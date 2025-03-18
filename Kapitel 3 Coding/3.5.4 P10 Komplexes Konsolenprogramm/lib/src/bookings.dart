import 'dart:convert';
import 'dart:io';

typedef Entry = Map<String, dynamic>;
Entry emptyEntry = {"Datum":null, "Text":null, "Soll":null, "Haben":null};
typedef Entries = List<dynamic>; // List<Entry> wird von JsonDecode nicht akzeptiert...

/**
 * Bookings-Klasse
 *
 * © 2025 Microwalker
 * ==================
 *
 * Datenverwaltungsklasse für das Konsolenprogramm "Haushalt V3"
 * - Verwaltet die dynamische Liste mit Buchungseinträgen (als Type definiert)
 *   - Einträge erstellen oder Löschen
 *   - Einträge suchen
 *   - Alle Einträge (nach Datum) sortieren
 *   - Alle Einträge speichern oder laden (als json)
 * 
 * ...sowie einiger kleiner weiterer Funktionen
 */
class Bookings {
  // privater Datentyp für Datenspeicherung
  Entries _entries = [];
  
  // Konstruktor
  Bookings();

  // Zugriffsmöglichkeit auf private Liste per 'getter'
  Entries get entries => _entries;

  // Methoden für Datenzugriffe, Sortierung und Suche
  int get length => _entries.length;
  add(Entry e) => _entries.add(e);
  remove(Entry e) => _entries.remove(e);
  removeAt(int i) => _entries.removeAt(i);
  indexOf(Entry e) => _entries.indexOf(e);
  Entry getEntry(int i) => _entries[i];
  sortByDate() => _entries.sort((e1, f1) { var e2 = toDateTime(e1["Datum"]); var f2 = toDateTime(f1["Datum"]); return e2.compareTo(f2); }); 
  Iterable<dynamic> searchText(String text) => _entries.where((element) => element["Text"].toString().toLowerCase().contains(text.toLowerCase()));
  empty() => emptyEntry;
  
  /**
   * Das Datum im Format "dd.mm.jjjj" in DateTime kovertieren, um bspw. die Sortierung nach Datum durchführen zu können
   */
  DateTime toDateTime(String datum) {
    return DateTime.parse(datum.split(".").reversed.join("-")); // entspr. (datum.substring(6,10)+"-"+datum.substring(3,5)+"-"+datum.substring(0,2));
  }

  /**
   * Datum zum Format "dd.mm.jjjj" aufbereiten
   * Auch Eingaben wie "4.1.22" (wird "04.01.2022") oder "15.8.89" (wird "15.08.1989") sind möglich!
   * Bei Jahreszahlen >50 wird das Jahr zu 19xx, bei <=50 zu 20xx.
   */
  String formatDate(String date) {
    List<String> tmj = date.split(".");
    if(tmj.length == 3) {
      tmj = [tmj[0].padLeft(2,"0"), tmj[1].padLeft(2,"0"), (int.parse(tmj[2])>100 ? tmj[2] : int.parse(tmj[2])>50 ? int.parse(tmj[2])+1900 : int.parse(tmj[2])+2000).toString()];
      return tmj.join(".");
    }
    return date;
  }

  /**
   * Speichert alle Einträge (Typ Entry) 
   */
  bool saveToJson(String filename) {
    filename = !filename.endsWith(".json") ? filename + ".json" : filename;

    File file = File("./" + filename);
    try {
      file.writeAsStringSync(jsonEncode(_entries), flush: true);
    } catch(e) {
      throw(e);
    }
    return true;
  }

  /**
   * Lädt alle gespeicherten Einträge vom Typ Entry
   */
  bool loadFromJson(String filename) {
    filename = !filename.endsWith(".json") ? filename + ".json" : filename;

    try {
      File file = File("./" + filename);
      String response = file.readAsStringSync();
      _entries = jsonDecode(response);
      // List json = jsonDecode(response);
      // _entries = json;
    } catch(e) {
      throw(e);
    } 

    return true;
  }
} 
