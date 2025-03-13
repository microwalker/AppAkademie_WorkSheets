import 'dart:math';

abstract class bonus {
  static num greaterNum(num x, num y) => x>y?y:y;
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
        words.add({word.toString(): word.toString().length}));
    return words;
  }

  static num changeTemperature(num t, [bool isF = false]) => isF ? (t-32)/1.8 : t*1.8+32;
  static String foldStrings(List<String> texts) => texts.fold("", (p, e) => p + e);
  static bool isPrime(int number) { 
    for(int d=2;d<number;d++)
      if(number % d == 0)
        return true;
    return false;
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
}