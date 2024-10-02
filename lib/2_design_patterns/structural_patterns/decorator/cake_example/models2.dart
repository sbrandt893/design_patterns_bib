abstract class Cake {
  String getDescription();
  double getPrice();
  Map<String, int> getDecorations();
}

class BaseCake extends Cake {
  @override
  String getDescription() => "Basistorte";

  @override
  double getPrice() => 10.0;

  @override
  Map<String, int> getDecorations() => {};
}

abstract class CakeDecorator extends Cake {
  final Cake cake;

  CakeDecorator(this.cake);

  @override
  Map<String, int> getDecorations() {
    return Map.from(cake.getDecorations());
  }
}

class ChocolateGlazeDecorator extends CakeDecorator {
  ChocolateGlazeDecorator(super.cake);

  @override
  String getDescription() => cake.getDescription();

  @override
  double getPrice() => cake.getPrice() + 3.0;

  @override
  Map<String, int> getDecorations() {
    var decorations = super.getDecorations();
    decorations['Schokoglasur'] = (decorations['Schokoglasur'] ?? 0) + 1;
    return decorations;
  }
}

class FruitDecorator extends CakeDecorator {
  FruitDecorator(super.cake);

  @override
  String getDescription() => cake.getDescription();

  @override
  double getPrice() => cake.getPrice() + 4.0;

  @override
  Map<String, int> getDecorations() {
    var decorations = super.getDecorations();
    decorations['Frucht'] = (decorations['Frucht'] ?? 0) + 1;
    return decorations;
  }
}

String formatDescription(Cake cake) {
  var baseDescription = cake.getDescription();
  var decorations = cake.getDecorations();
  var decorationDescriptions =
      decorations.entries.where((entry) => entry.value > 0).map((entry) => entry.value > 1 ? "mit ${entry.value}x ${entry.key}" : "mit ${entry.key}").join(", ");
  return decorationDescriptions.isEmpty ? baseDescription : "$baseDescription, $decorationDescriptions";
}
