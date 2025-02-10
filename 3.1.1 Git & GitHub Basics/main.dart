import 'tutor.dart';
import 'tuts.dart';

void main(List<String> args) {
  tuts Tutoren = new tuts();
  tutor Lehrer = new tutor();
  Lehrer.name = "David";
  Lehrer.addFach("Coding Basics");
  Tutoren.addTutor(Lehrer);
  print(Tutoren.toString());
}