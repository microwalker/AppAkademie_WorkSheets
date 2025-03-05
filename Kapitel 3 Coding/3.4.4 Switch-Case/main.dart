enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday}

void main(List<String> args) {
  aufg1();
  aufg2();
}

void aufg1() {
  analyseWeekday(null);
  analyseWeekday(Weekday.saturday);
}

void aufg2() {
  averageHeightBySex("male", 27);
  averageHeightBySex("female", 35);
}

void analyseWeekday(Weekday? day) {
  switch(day) {
    case Weekday.monday || Weekday.tuesday:
      print("Montage und Dienstage sind anstrengend");
    case Weekday.wednesday || Weekday.thursday:
      print("Mittwoche und Donnerstage sind ok");
    case Weekday.friday:
      print("Freitag ist super");
    case Weekday.saturday:
      print("Wochenende ist genial");
    default:
      print("Kein Tag ausgewählt");
  }
}

void averageHeightBySex(String sex, int age) {
  switch (sex) {
   case "male":
     switch (age) {
       case >=20 && <25:
         print("Im Schnitt 181,4m");
       case >=25 && <30:
         print("Im Schnitt 181,3m");
       case >=30 && <= 35:
         print("Im Schnitt 180,4m");
     }
   case "female":
     switch (age) {
       case >=20 && <25:
         print("Im Schnitt 167,5m");
       case >=25 && <30:
         print("Im Schnitt 167,3 m");
       case >=30 && <= 35:
         print("Im Schnitt 167,2");
     }
    }
}