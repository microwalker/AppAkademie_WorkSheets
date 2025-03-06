
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
  // bool isLoggedIn = true;
  // bool isBanned = false;
  // bool isSubscribed = true;
  // age = 18; // Variable wurde schon in Aufgabe 1 deklariert

  checkLogin(true, age: 18, isBanned: false, isSubscribed: true);
  checkLogin(false);
  checkLogin(true, age: 37, isBanned: true, isSubscribed: false);
  checkLogin(true, isBanned: false, isSubscribed: true);
}

bool allowViewing(int age, bool hasParentalConsent, int movieAgeRating) {
  return age>=movieAgeRating || age >= movieAgeRating-2 && hasParentalConsent;
}

void checkLogin(bool isLoggedIn, {int? age = null, bool isBanned = false, isSubscribed = false}) {
  if(!isLoggedIn) {
    print("Bitte logge Dich ein");
  } else {
    if(isBanned) {
      print("Dein Account wurde gesperrt");
    } else if((age ?? 0) < 18) {
      print((age == null ? "Bitte ergänze Dein Alter" : "Du bist zu jung"));
    } else if(!isSubscribed) {
      print("Bitte abonniere");
    } else {
      print("Willkommen");
    }
  }
}