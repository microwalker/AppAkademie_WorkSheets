abstract class easy {
  static int sum(int x, int y, int z) => x+y+z;
  static int len(String text) => text.length;
  static int vocals(String text, [bool withUmlauts = false]) => 
    new RegExp(r'[aeiou'+(withUmlauts?'äöü':'')+']').allMatches(text.toLowerCase()).length;
}