import 'tutor.dart';
import 'tuts.dart';

void main(List<String> args) {
  tuts Tutoren = new tuts();
  tutor Lehrer = new tutor();
  Lehrer.name = "David";
  Lehrer.faecher.add(["Coding Basic"]);
  Tutoren.tutors.add(Lehrer);
  print(Tutoren.toString());
}