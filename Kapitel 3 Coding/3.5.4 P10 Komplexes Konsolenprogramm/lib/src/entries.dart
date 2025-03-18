final class Entries extends Iterable {
  List<Entry> _entries = [];

  get () => _entries;
  
  /// Ermittelt den Index eines Eintrags
  int indexOf(Entry entry) => _entries.indexOf(entry);

  @override
  Iterator get iterator => _entries.iterator;
 
  /// Fügt einen neuen Eintrag hinzu und sortiert die Liste
  add(Entry entry) { 
    _entries.add(entry); 
    sortByDate();
  }

  @override
  String toString() {
    return _entries.toString();
  }

  /// Sortiert die Liste der Einträge nach deren Datum
  void sortByDate() => _entries.sort((p, e) => p.date.compareTo(e.date));

  double getSaldoAtDate(DateTime date) => _entries.where((e) => !e._date!.isAfter(date)).fold(0.0, (p, e) => p += e.value);
  double getSaldoToEntry(Entry entry) => _entries.where((e) => indexOf(e) <= indexOf(entry)).fold(0.0, (p, e) => p += e.value);
}

abstract class Entry {
  int? _id;
  DateTime? _date;
  String? _description; 

  Entry.empty(); 
  Entry(this._date, this._description) {this._id = this.hashCode;}

  get id => this._id;

  @override
  String toString() {
    return "[$_id] $_description am ${getDatumToString()}";
  }

  /// Gibt den Saldo als positiven oder negativen Wert zurück
  get value;
  get soll;
  get haben;

  get description => _description;
  get date => _date;

  String getDatumToString() => this._date.toString().split(" ")[0].split("-").reversed.join(".");
}

final class Soll extends Entry {
  double? _soll;

  Soll(_date, _description, this._soll) : super(_date, _description);
  Soll.empty() : super.empty();

  @override
  get value => (_soll ?? 0);

  @override
  String toString() {
    return super.toString() + " SOLL: $_soll";
  }
  
  @override
  get haben => 0.0;
  
  @override
  get soll => _soll;
}

final class Haben extends Entry {
  double? _haben;

  Haben(_date, _description, this._haben) : super(_date, _description);
  Haben.empty() : super.empty();

  @override
  get value => -(_haben ?? 0);

  @override
  String toString() {
    return super.toString() + " HABEN: $_haben";
  }
  
  @override
  get haben => _haben;
  
  @override
  get soll => 0.0;
}

