// ignore_for_file: avoid_print

import 'package:design_patterns_bib/2_design_patterns/structural_patterns/decorator/cake_example/models2.dart';

void main() {
  Cake meineTorte = BaseCake();
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte kostet 10.0 €

  meineTorte = ChocolateGlazeDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur kostet 13.0 €

  meineTorte = FruitDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit Frucht kostet 17.0 €

  meineTorte = FruitDecorator(meineTorte);
  print("${formatDescription(meineTorte)} kostet ${meineTorte.getPrice()} €"); // Basistorte, mit Schokoglasur, mit 2x Frucht kostet 21.0 €
}
