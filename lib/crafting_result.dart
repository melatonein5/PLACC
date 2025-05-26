// lib/widgets/crafting_result_dialog.dart
import 'package:flutter/material.dart';
import 'package:placc/recipes.dart'; // Assuming Totals, IngredientQuantity, CraftingItem are here

class CraftingResultDialog extends StatelessWidget {
  final CraftableItem itemCrafted;
  final Totals totals;

  const CraftingResultDialog({
    super.key,
    required this.itemCrafted,
    required this.totals,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: itemCrafted.icon,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    itemCrafted.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            Center(
              child: Column(
                children: [
                  Text(
                    'Total Crafting Cost:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${totals.totalCraftingPrice} ₽',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Crafted: ${totals.totalQuantity} x',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 1),

            Text(
              'Ingredient Breakdown:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: totals.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = totals.ingredients[index];
                    final int ingredientTotalCost = ingredient.item.price * ingredient.quantity;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          // REMOVED the old SizedBox for the icon here

                          // Use Expanded with Text.rich to embed the icon directly
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: ingredient.item.name, // Ingredient name
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const TextSpan(text: ' '), // Small space
                                  // WidgetSpan for the icon
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle, // Vertically align with text
                                    child: SizedBox(
                                      width: 20, // Smaller size for inline icon
                                      height: 20,
                                      child: ingredient.item.icon,
                                    ),
                                  ),
                                  const TextSpan(text: ' '), // Small space
                                  TextSpan(
                                    text: 'x ${ingredient.quantity}', // "x quantity"
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '${ingredientTotalCost} ₽', // Total cost for this ingredient type
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            if (totals.totalStorePrice > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Text(
                      'If bought from store: ${totals.totalStorePrice} ₽',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Savings (Delta): ${totals.deltaPrice} ₽',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: totals.deltaPrice > 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}