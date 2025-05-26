import "package:flutter/widgets.dart";
import "package:placc/crafting_items.dart";

class IngredientQuantity {
  final CraftingItem item;
  final int quantity;
  int get price => item.price * quantity;

  IngredientQuantity(this.item, this.quantity);
}

class Totals {
  final int totalQuantity;
  final int totalCraftingPrice;
  final int totalStorePrice;
  final List<IngredientQuantity> ingredients;
  int get deltaPrice {
    if (totalStorePrice == 0) {
      return 0;
    }
    return totalCraftingPrice - totalStorePrice;
  }
  Totals(this.totalQuantity, this.totalCraftingPrice, this.totalStorePrice, this.ingredients);
}

class CraftableItem {
  final String name;
  final List<IngredientQuantity> ingredients;
  final Image icon;
  final int storePrice;
  int get craftingPrice => ingredients.fold(0, (sum, ingredient) => sum + ingredient.price);
  bool get buyable => storePrice > 0;

  CraftableItem(this.name, this.ingredients, this.storePrice, this.icon);

  Totals calculateTotalByBudget(int budget) {
    //Get the quantity by floor division of budget by crafting price
    int quantity = budget ~/ craftingPrice;
    return Totals(
      quantity,
      craftingPrice * quantity,
      storePrice * quantity,
      ingredients.map((ingredient) => IngredientQuantity(ingredient.item, ingredient.quantity * quantity)).toList(),
    );
  }

  Totals calculateTotalByQuantity(int quantity) {
    return Totals(
      quantity,
      craftingPrice * quantity,
      storePrice * quantity,
      ingredients.map((ingredient) => IngredientQuantity(ingredient.item, ingredient.quantity * quantity)).toList(),
    );
  }
}

class PokeBall extends CraftableItem {
  PokeBall()
      : super(
          'Poké Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(Tumblestone(), 1),
          ],
          100,
          Image.asset('assets/craftable_items/POKEBALL.png'),
        );
}

class GreatBall extends CraftableItem {
  GreatBall()
      : super(
          'Great Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(Tumblestone(), 1),
            IngredientQuantity(IronChunk(), 1),
          ],
          300,
          Image.asset('assets/craftable_items/GREATBALL.png'),
        );
}

class UltraBall extends CraftableItem {
  UltraBall()
      : super(
          'Ultra Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(Tumblestone(), 2),
            IngredientQuantity(IronChunk(), 2),
          ],
          600,
          Image.asset('assets/craftable_items/ULTRABALL.png'),
        );
}

class HeavyBall extends CraftableItem {
  HeavyBall()
      : super(
          'Heavy Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(BlackTumblestone(), 1),
          ],
          120,
          Image.asset('assets/craftable_items/HEAVYBALL.png'),
        );
}

class LeadenBall extends CraftableItem {
  LeadenBall()
      : super(
          'Leaden Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(BlackTumblestone(), 1),
            IngredientQuantity(IronChunk(), 1),
          ],
          320,
          Image.asset('assets/craftable_items/LEADENBALL.png'),
        );
}

class GigatonBall extends CraftableItem {
  GigatonBall()
      : super(
          'Gigaton Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(BlackTumblestone(), 2),
            IngredientQuantity(IronChunk(), 2),
          ],
          0,
          Image.asset('assets/craftable_items/GIGATONBALL.png'),
        );
}