import 'dart:math';

int generiereZahlen(int max) {
  Random random = Random();
  return random.nextInt(max);
}

List<int> quickSort(List<int> list) {
  if (list.length <= 1) {
    return list;
  }

  int quick = list[0];

  List<int> smaller = [];
  List<int> larger = [];

  for (int i = 1; i < list.length; i++) {
    if (list[i] <= quick) {
      smaller.add(list[i]);
    } else {
      larger.add(list[i]);
    }
  }

  return [...quickSort(smaller), quick, ...quickSort(larger)];
}

void main() {
  List<int> zufallsZahlen = [];
  int anzahl = 10000;
  int maxWert = 1000;

  // Zufallszahlen generieren
  for (int i = 0; i < anzahl; i++) {
    int zahl = generiereZahlen(maxWert);
    zufallsZahlen.add(zahl);
  }

  // Zeit messen für das Sortieren
  DateTime startTime = DateTime.now();
  List<int> sortedList = quickSort(zufallsZahlen);
  DateTime endTime = DateTime.now();

  Duration duration = endTime.difference(startTime);

  // Sortierte Liste ausgeben
  print(sortedList);

  // Dauer des Sortierens ausgeben
  print('Sortieren dauerte: ${duration.inMicroseconds} µs');
}
