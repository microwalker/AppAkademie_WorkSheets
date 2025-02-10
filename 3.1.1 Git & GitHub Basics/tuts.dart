import 'tutor.dart';

class tuts {
  List<tutor> _tutors = new List<tutor>.empty(growable: true);

  void addTutor(tutor tut) {
    this._tutors.add(tut);
  }
}