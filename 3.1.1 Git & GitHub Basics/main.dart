import 'tutor.dart';
import 'tuts.dart';

tuts Tutoren = new tuts();

void main(List<String> args) {
  addTutor("Jean Paul", ["Figma", "UI/UX-Design"]);
  addTutor("David", ["Coding", "Git", "GitHub"]);
  print(Tutoren.toString());
}

void addTutor(String name, List faecher) {
  tutor Lehrer = new tutor();
  Lehrer.name = name;
  faecher.forEach((fach) => Lehrer.addFach(fach));
  Tutoren.addTutor(Lehrer);
}