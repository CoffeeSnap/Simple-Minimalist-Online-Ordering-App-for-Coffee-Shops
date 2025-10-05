import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int quantity;

  const MenuItemCard({
    super.key,
    required this.menuItem,
    required this.onAdd,
    required this.onRemove,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: quantity == 0 ? onAdd : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji and name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem.emoji,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuItem.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    menuItem.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // Price and add button
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${menuItem.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Add/Remove controls
                  if (quantity == 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onAdd,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Add', style: TextStyle(fontSize: 14)),
                      ),
                    )
                  else
                    Row(
                      children: [
                        IconButton(
                          onPressed: onRemove,
                          icon: const Icon(Icons.remove_circle),
                          color: Theme.of(context).colorScheme.secondary,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onAdd,
                          icon: const Icon(Icons.add_circle),
                          color: Theme.of(context).colorScheme.secondary,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
