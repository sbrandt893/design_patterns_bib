// ignore_for_file: avoid_print

import 'package:design_patterns_bib/02_design_patterns/structural_patterns/decorator/dart_example_cake_decorator/models_extended.dart';

void main() {
  // Initialisierung der Basistorte
  Cake meineTorte = BaseCake();
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte kostet 10.0 €

  // Dekorieren der Basistorte mit Schokoglasur
  meineTorte = ChocolateGlazeDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur kostet 13.0 €

  // Dekorieren der Schokotorte mit einer Frucht
  meineTorte = FruitDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit Frucht kostet 17.0 €

  // Dekorieren der Schokotorte mit einer weiteren Frucht
  meineTorte = FruitDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit 2x Frucht kostet 21.0 €
}
