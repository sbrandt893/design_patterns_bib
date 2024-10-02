// ignore_for_file: avoid_print

import 'package:design_patterns_bib/2_design_patterns/structural_patterns/decorator/cake_example/models.dart';

void main() {
  Cake meineTorte = BaseCake();
  print("${meineTorte.getDescription()} kostet ${meineTorte.getPrice()} €"); // Basistorte kostet 10.0 €

  meineTorte = ChocolateGlazeDecorator(meineTorte);
  print("${meineTorte.getDescription()} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur kostet 13.0 €

  meineTorte = FruitDecorator(meineTorte);
  print("${meineTorte.getDescription()} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit Früchten kostet 17.0 €

  meineTorte = FruitDecorator(meineTorte);
  print("${meineTorte.getDescription()} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit Früchten, mit Früchten kostet 21.0 €
}
