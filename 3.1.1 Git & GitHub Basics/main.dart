import 'tutor.dart';
import 'tuts.dart';

tuts Tutoren = new tuts();

void main(List<String> args) {
  addTutor("Jean Paul", ["Figma", "UI/UX-Design"]);
  addTutor("David", ["Coding", "Git", "GitHub"]);
  print(Tutoren.toString());

  List<int> z1 = [1,2,3,4,5];
  z1.forEach((z) => print(z*3));
}

/* sdfsdfsdf */

void addTutor(String name, List faecher) {
  tutor Lehrer = new tutor(name);
  Lehrer.name = name;
  faecher.forEach((fach) => Lehrer.addFach(fach));
  Tutoren.addTutor(Lehrer);
}