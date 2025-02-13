void main(List<String> args) {
  List liste = [9,84,36,71,12,8,44,69,32,108,11,71,14,3,92];
  print("Bubble: ${BubbleSort(liste.toList())}");
  print("Selection ${SelectionSort(liste.toList())}");
}

List BubbleSort(List liste) {
  for(int j = 0;j < liste.length - 2;j++)
    for(int i = 0;i < liste.length - 1;i++)
      if(liste[i + 1] < liste[i] ) {
        var tmp = liste[i];
        liste[i] = liste[i + 1];
        liste[i + 1] = tmp;
      }
  return liste;
}

List SelectionSort(List liste) {
  int pos = 0;
  while(pos < liste.length) {
    for(int i = pos + 1;i < liste.length; i++)
      if(liste[i] < liste[pos]) {
        var tmp = liste[pos];
        liste[pos] = liste[i];
        liste[i] = tmp;
      }
    pos++;
  }
  return liste;
}