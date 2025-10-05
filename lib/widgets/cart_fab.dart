import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CartFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      icon: const Icon(Icons.shopping_cart, color: Colors.white),
      label: Text(
        'View Cart • \$${cart.totalAmount.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
