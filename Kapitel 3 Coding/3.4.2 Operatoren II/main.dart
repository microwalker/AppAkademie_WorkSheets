import '../3.2.4 Programmablaufpläne/Bonus Sortiermethoden.dart';

void main() {
  /* Aufgabe 1:
     ========== 
  */
  // Test 1
  int age = 15;
  bool hasParentalConsent = true;
  int movieAgeRating = 16;
  print("Darf den Film schauen: ${allowViewing(age, hasParentalConsent, movieAgeRating)?"Ja":"Nein"}");

  // Test 2
  age = 13;
  hasParentalConsent = false;
  movieAgeRating = 16;
  print("Darf den Film schauen: ${allowViewing(age, hasParentalConsent, movieAgeRating)?"Ja":"Nein"}");

  /* Aufgabe 2:
     ==========
  */
  bool isLoggedIn = true;
  bool isBanned = false;
  bool isSubscribed = true;
  age = 18; // Variable wurde schon in Aufgabe 1 deklariert

  if(!isLoggedIn) {
    print("Bitte logge Dich ein");
  } else {
    if(isBanned) {
      print("Dein Account wurde gesperrt");
    } else if(age < 18) {
      print("Du bist zu jung");
    } else if(!isSubscribed) {
      print("Bitte abonniere");
    } else {
      print("Willkommen");
    }
  }
}

bool allowViewing(int age, bool hasParentalConsent, int movieAgeRating) {
  return age>=movieAgeRating || age >= movieAgeRating-2 && hasParentalConsent;
}