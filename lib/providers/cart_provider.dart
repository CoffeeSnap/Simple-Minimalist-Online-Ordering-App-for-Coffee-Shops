import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(MenuItem menuItem) {
    final existingIndex =
        _items.indexWhere((item) => item.menuItem.id == menuItem.id);

    if (existingIndex >= 0) {
      // Add maximum quantity limit
      if (_items[existingIndex].quantity >= 99) {
        return; // Don't add more, silently ignore
      }
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(menuItem: menuItem));
    }
    notifyListeners();
  }

  void removeItem(String menuItemId) {
    final existingIndex =
        _items.indexWhere((item) => item.menuItem.id == menuItemId);

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getItemQuantity(String menuItemId) {
    final existingIndex =
        _items.indexWhere((item) => item.menuItem.id == menuItemId);
    return existingIndex >= 0 ? _items[existingIndex].quantity : 0;
  }
}
