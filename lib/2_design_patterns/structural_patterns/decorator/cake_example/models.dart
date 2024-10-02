/// abstract class for a cake
abstract class Cake {
  String getDescription();
  double getPrice();
}

/// base cake class
class BaseCake extends Cake {
  @override
  String getDescription() => "Basistorte";

  @override
  double getPrice() => 10.0;
}

/// abstract class for a cake decorator
abstract class CakeDecorator extends Cake {
  final Cake cake;

  CakeDecorator(this.cake);
}

/// concrete decorator class for a chocolate glaze
class ChocolateGlazeDecorator extends CakeDecorator {
  ChocolateGlazeDecorator(super.cake);

  @override
  String getDescription() => "${cake.getDescription()}, mit Schokoglasur";

  @override
  double getPrice() => cake.getPrice() + 3.0;
}

/// concrete decorator class for a fruit decoration
class FruitDecorator extends CakeDecorator {
  FruitDecorator(super.cake);

  @override
  String getDescription() => "${cake.getDescription()}, mit Früchten";

  @override
  double getPrice() => cake.getPrice() + 4.0;
}
