import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_data.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/cart_fab.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ItemCategory _selectedCategory = ItemCategory.coffee;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = _selectedCategory == ItemCategory.coffee
        ? MenuData.coffeeItems
        : MenuData.patisserieItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pierre's Cafe"),
        actions: [
          if (cart.itemCount > 0)
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Category selector
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryChip(
                  context,
                  '☕ Coffee',
                  ItemCategory.coffee,
                ),
                const SizedBox(width: 12),
                _buildCategoryChip(
                  context,
                  '🥐 Patisseries',
                  ItemCategory.patisserie,
                ),
              ],
            ),
          ),
          // Menu items grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MenuItemCard(
                  menuItem: items[index],
                  onAdd: () => cart.addItem(items[index]),
                  onRemove: () => cart.removeItem(items[index].id),
                  quantity: cart.getItemQuantity(items[index].id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: cart.itemCount > 0
          ? CartFAB(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            )
          : null,
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    ItemCategory category,
  ) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
