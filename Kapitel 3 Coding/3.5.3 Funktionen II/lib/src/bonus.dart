import 'dart:math';

abstract class bonus {
  static num greaterNum(num x, num y) => x>y?x:y;
  static bool even(num x) => x%2==0;
  static num sumFromList(List<num> nums) => nums.fold(0, (p,e) => p + e);
  static num avgFromList(List<num> nums) => sumFromList(nums)/nums.length;
  static int countChars(String text, String char) => new RegExp('[$char]').allMatches(text).length;
  static bool contains(String text, String char) => text.contains(char);
  static int valence(num number) => number < 0 ? -1 : number > 0 ? 1 : 0;
  
  static List<String> charsOf(String text) {
    List<String> l = [];
    for(int i=0;i<text.length;i++) l.add(text.toUpperCase()[i]);
    return l;
  }

  static List<Map<String, int>> getCharCount(List<String> texts) {
    List<Map<String, int>> ergs = [];
    for(String s in texts)
      ergs.add({s: s.length});
    return ergs;
  } 

  static int product(int x, int y) => x*y;
  static int productOfList(List<int> nums) {
    int prod = nums.isEmpty ? 0 : nums[0];
    for(int i=1; i<nums.length; i++)
      prod = product(prod, nums[i]);
    return prod;
  }

  static num neg(num n) => -n;
  static num smallest(List<num> nums) => nums.fold(nums[0], (p, e) => p < e ? p : e);

  static List<Map<String, int>> countWordChars(List<String> sentences) {
    List<Map<String, int>> words = [];
    for(String s in sentences)
      new RegExp(r'\w+').allMatches(s).forEach((word) => 
        words.add({word.group(0).toString(): word.group(0)!.length}));
    return words;
  }

  static num changeTemperature(num t, [bool isF = false]) => isF ? (t-32)/1.8 : t*1.8+32;
  static String foldStrings(List<String> texts) => texts.fold("", (p, e) => p + e);
  static bool isPrime(int number) { 
    bool erg = true;
    for(int d=2;d<number;d++)
      if(number % d == 0)
        return false;
    return erg;
  }

  static int reverseNumber(int number) {
    int maxDez = 0;
    while(number > pow(10, maxDez + 1)) maxDez++;
    
    num erg = 0;
    for(int p=0; p<=maxDez; p++) 
      erg += ((number ~/ pow(10, p)) % 10) * pow(10,maxDez - p);
    return erg.toInt();
  }

  static String toHMS(int seconds) {
    String erg = "";
    for(int e=2; e>=0; e--) {
      int _hms = seconds ~/ pow(60, e);
      seconds -= _hms * pow(60, e).toInt();
      erg += "$_hms${e>0?":":" (HH:MM:SS)"}";
    } 
    return erg; 
  }

  static bool isAnagram(String word1, String word2) {
    List w1 = [for(int i=0;i <word1.length;i++) word1[i].toUpperCase()]..sort();
    List w2 = [for(int i=0;i <word2.length;i++) word2[i].toUpperCase()]..sort();
    
    if(w1.length != w2.length)
      return false;
    else
      for(int i=0; i<w1.length; i++)
        if(w1[i] != w2[i])
          return false;
    
    
    return true;
  }

  static num multiplicateWithoutMultiplicationOperator(num zahl1, num zahl2) {
    num zahl = zahl1;
    for(int i=2; i<=zahl2; i++) 
      zahl += zahl1;
    return zahl;
  }

  static List<String> getWords(String text) {
    List<String> words = [];
    String _word = "";
    for(int i=0; i<text.length;i++) {
      _word += text[i] != " " ? text[i] : "";
      if(text[i] == " " || i == text.length-1) {
        words.add(_word);
        _word = "";
      }
    }
    return words;
  }

  static bool isPalindrom(String word) {
    String reversedWord = "";
    for(int i=word.length;i>0;i--) {
      reversedWord += word[i-1];
    }
    
    return reversedWord.toLowerCase() == word.toLowerCase();
  }

  static bool checkBrackets(String line) {
    int opened = 0;
    int closed = 0;
    for(int i=0;i<line.length;i++) {
      opened += line[i] == "(" ? 1 : 0;
      closed += line[i] == ")" ? 1 : 0;
      if(closed>opened) return false;
    }
    if(opened>closed) return false;
    return true;
  }
}