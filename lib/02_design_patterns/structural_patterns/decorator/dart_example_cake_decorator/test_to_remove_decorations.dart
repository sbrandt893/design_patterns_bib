abstract class Cake {
  String getDescription();
  double getPrice();
  Map<String, int> getDecorations();

  // Neue Methode zum gezielten Entfernen von Dekorationen
  Cake removeSpecificDecoration(String decorationType);
}

class BaseCake extends Cake {
  @override
  String getDescription() => "Basistorte";

  @override
  double getPrice() => 10.0;

  @override
  Map<String, int> getDecorations() => {};

  @override
  Cake removeSpecificDecoration(String decorationType) {
    return this;
  }
}

abstract class CakeDecorator extends Cake {
  final Cake cake;

  CakeDecorator(this.cake);

  @override
  Map<String, int> getDecorations() {
    return Map.from(cake.getDecorations());
  }

  // Abstrakte Methode zum gezielten Entfernen von Dekorationen
  @override
  Cake removeSpecificDecoration(String decorationType);
}

class ChocolateGlazeDecorator extends CakeDecorator {
  ChocolateGlazeDecorator(super.cake);

  @override
  String getDescription() => cake.getDescription();

  @override
  double getPrice() => cake.getPrice() + 0.05;

  @override
  Map<String, int> getDecorations() {
    var decorations = super.getDecorations();
    decorations['Schokoglasur'] = (decorations['Schokoglasur'] ?? 0) + 1;
    return decorations;
  }

  @override
  Cake removeSpecificDecoration(String decorationType) {
    if (decorationType == 'Schokoglasur') {
      // Wenn Schokoglasur entfernt wird, gib die vorherige Torte zurück
      // ABER erlaube weitere Dekorationen
      return cake;
    }
    // Wenn nicht Schokoglasur, delegiere an vorherige Torte
    return ChocolateGlazeDecorator(cake.removeSpecificDecoration(decorationType));
  }
}

class FruitDecorator extends CakeDecorator {
  FruitDecorator(super.cake);

  @override
  String getDescription() => cake.getDescription();

  @override
  double getPrice() => cake.getPrice() + 0.10;

  @override
  Map<String, int> getDecorations() {
    var decorations = super.getDecorations();
    decorations['Frucht'] = (decorations['Frucht'] ?? 0) + 1;
    return decorations;
  }

  @override
  Cake removeSpecificDecoration(String decorationType) {
    if (decorationType == 'Frucht') {
      // Wenn Frucht entfernt wird, gib die vorherige Torte zurück
      // ABER erlaube weitere Dekorationen
      return cake;
    }
    // Wenn nicht Frucht, delegiere an vorherige Torte
    return FruitDecorator(cake.removeSpecificDecoration(decorationType));
  }
}

String formatDescription(Cake cake) {
  var baseDescription = cake.getDescription();
  var decorations = cake.getDecorations();
  var decorationDescriptions =
      decorations.entries.where((entry) => entry.value > 0).map((entry) => entry.value > 1 ? "mit ${entry.value}x ${entry.key}" : "mit ${entry.key}").join(", ");
  return decorationDescriptions.isEmpty ? baseDescription : "$baseDescription, $decorationDescriptions";
}

void main() {
  // Beispielhafte Nutzung
  Cake myCake = BaseCake();
  myCake = FruitDecorator(myCake);
  myCake = ChocolateGlazeDecorator(myCake);
  myCake = FruitDecorator(myCake);
  myCake = ChocolateGlazeDecorator(myCake);

  print("Ursprüngliche Torte:");
  print(formatDescription(myCake));

  // Gezieltes Entfernen von Früchten
  print("\nNach Entfernen der Früchte:");
  myCake = myCake.removeSpecificDecoration('Frucht');
  print(formatDescription(myCake));

  // Gezieltes Entfernen von Schokoglasur
  print("\nNach Entfernen der Schokoglasur:");
  myCake = myCake.removeSpecificDecoration('Schokoglasur');
  print(formatDescription(myCake));
}
