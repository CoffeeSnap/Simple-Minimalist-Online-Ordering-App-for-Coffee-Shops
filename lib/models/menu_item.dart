enum ItemCategory {
  coffee,
  patisserie,
}

enum CoffeeTemperature {
  hot,
  iced,
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final ItemCategory category;
  final CoffeeTemperature? temperature;
  final String emoji;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.temperature,
    required this.emoji,
  });
}

class CartItem {
  final MenuItem menuItem;
  int quantity;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
  });

  double get totalPrice => menuItem.price * quantity;
}
