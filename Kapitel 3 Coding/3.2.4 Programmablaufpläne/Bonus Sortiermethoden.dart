import 'dart:math';

void main(List<String> args) {
  List liste = []; [9,84,36,71,12,8,44,69,32,108,11,71,14,3,92,22,79,37,3,19,102];
  for(int i=0;i<1000;i++)
    liste.add((Random().nextInt(10000)));
  Stopwatch c = new Stopwatch();
  print("Original: $liste");
  c.start();
  print("Bubble: ${BubbleSort(liste.toList())} (Dauer: ${c.elapsed})");
  c.reset();
  print("Selection ${SelectionSort(liste.toList())} (Dauer: ${c.elapsed})");
  c.reset();
  print("ExtSelection ${ExtSelectionSort(liste.toList())} (Dauer: ${c.elapsed})");
  c.reset();
  liste.sort();
  print("List.Sort: $liste (Dauer: ${c.elapsed})");
  c..stop();
}

List BubbleSort(List liste) {
  int swaps = 0;
  int loops = 0;
  for(int j = 0;j < liste.length - 2;j++) {
    for(int i = 0;i < liste.length - 1;i++) {
      if(liste[i + 1] < liste[i] ) {
        var tmp = liste[i];
        liste[i] = liste[i + 1];
        liste[i + 1] = tmp;
        swaps++;
      }
      loops++;
    }
    loops++;
  }
  print("BubbleSort: $swaps Swaps / $loops Loops");
  return liste;
}

List SelectionSort(List liste) {
  int swaps = 0;
  int loops = 0;
  int pos = 0;
  while(pos < liste.length) {
    for(int i = pos + 1;i < liste.length; i++) {
      if(liste[i] < liste[pos]) {
        var tmp = liste[pos];
        liste[pos] = liste[i];
        liste[i] = tmp;
        swaps++;
      }
      loops++;
    }
    pos++;
    loops++;
  }
  print("SelectionSort: $swaps Swaps / $loops Loops");
  return liste;
}

List ExtSelectionSort(List liste) {
  int swaps = 0;
  int loops = 0;
  int pos = 0;
  while(pos < liste.length) {
    int min = pos;
    
    for(int i = pos + 1;i < liste.length; i++) {
      min = liste[i] < liste[min] ? i : min;
      loops++;
    }
    
    if(min != pos) {
      var tmp = liste[pos];
      liste[pos] = liste[min];
      liste[min] = tmp;
      swaps++;
    }
    pos++;
    loops++;
  }
  print("ExtSelectionSort: $swaps Swaps / $loops Loops");
  return liste;
}
