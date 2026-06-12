enum Complexity {
  simple,
  medium,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class ItemModel {
  final String img;
  final String time;
  final String name;
  final int cost;
  final Complexity complexity;
  final Affordability affordability;
  final bool isVeg;
  final bool isGlutenFree;
  final List<String> ingridents;
  final List<String> steps;

  ItemModel({
    required this.img,
    required this.time,
    required this.name,
    required this.cost,
    required this.complexity,
    required this.affordability,
    required this.isVeg,
    required this.isGlutenFree,
    required this.ingridents,
    required this.steps
  });
}
  