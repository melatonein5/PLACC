// placc/recipes.dart

import "package:flutter/widgets.dart";
import "package:placc/crafting_items.dart";
import "package:placc/models/craftable_item_type.dart"; // Adjust path if necessary

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
    return totalStorePrice-totalCraftingPrice;
  }
  Totals(this.totalQuantity, this.totalCraftingPrice, this.totalStorePrice, this.ingredients);
}

class CraftableItem {
  final String name;
  final List<IngredientQuantity> ingredients;
  final Image icon;
  final int storePrice;
  final List<CraftableItemType> itemTypes;

  int get craftingPrice => ingredients.fold(0, (sum, ingredient) => sum + ingredient.price);
  bool get buyable => storePrice > 0;

  CraftableItem(this.name, this.ingredients, this.storePrice, this.icon, {required this.itemTypes});


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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
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
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
        );
}

class FeatherBall extends CraftableItem {
  FeatherBall()
      : super(
          'Feather Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(SkyTumblestone(), 1),
          ],
          140,
          Image.asset('assets/craftable_items/FEATHERBALL.png'),
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
        );
}

class WingBall extends CraftableItem {
  WingBall()
      : super(
          'Wing Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(SkyTumblestone(), 1),
            IngredientQuantity(IronChunk(), 1),
          ],
          340,
          Image.asset('assets/craftable_items/WINGBALL.png'),
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
        );
}

class JetBall extends CraftableItem {
  JetBall()
      : super(
          'Jet Ball',
          [
            IngredientQuantity(Apricorn(), 1),
            IngredientQuantity(SkyTumblestone(), 2),
            IngredientQuantity(IronChunk(), 2),
          ],
          0,
          Image.asset('assets/craftable_items/JETBALL.png'),
          itemTypes: [CraftableItemType.pokeball], // --- CHANGED ---
        );
}

class MushroomCake extends CraftableItem {
  MushroomCake()
      : super(
          'Mushroom Cake',
          [
            IngredientQuantity(SpringyMushroom(), 1),
            IngredientQuantity(LureBase(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/MUSHROOMCAKE.png'),
          itemTypes: [CraftableItemType.cake], // --- CHANGED ---
        );
}

class HoneyCake extends CraftableItem {
  HoneyCake()
      : super(
          'Honey Cake',
          [
            IngredientQuantity(DazzlingHoney(), 1),
            IngredientQuantity(LureBase(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/HONEYCAKE.png'),
          itemTypes: [CraftableItemType.cake], // --- CHANGED ---
        );
}

class GrainCake extends CraftableItem {
  GrainCake()
      : super(
          'Grain Cake',
          [
            IngredientQuantity(HeartyGrains(), 1),
            IngredientQuantity(LureBase(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/GRAINCAKE.png'),
          itemTypes: [CraftableItemType.cake], // --- CHANGED ---
        );
}

class BeanCake extends CraftableItem {
  BeanCake()
      : super(
          'Bean Cake',
          [
            IngredientQuantity(PlumpBeans(), 1),
            IngredientQuantity(LureBase(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/BEANCAKE.png'),
          itemTypes: [CraftableItemType.cake], // --- CHANGED ---
        );
}

class SaltCake extends CraftableItem {
  SaltCake()
      : super(
          'Salt Cake',
          [
            IngredientQuantity(LureBase(), 1),
            IngredientQuantity(CrunchySalt(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/SALTCAKE.png'),
          itemTypes: [CraftableItemType.cake], // --- CHANGED ---
        );
}

class SmokeBomb extends CraftableItem {
  SmokeBomb()
      : super(
          'Smoke Bomb',
          [
            IngredientQuantity(SootfootRoot(), 1),
            IngredientQuantity(CasterFern(), 1),
          ],
          400,
          Image.asset('assets/craftable_items/SMOKEBOMB.png'),
          itemTypes: [CraftableItemType.bomb], // --- CHANGED ---
        );
}

class ScatterBang extends CraftableItem {
  ScatterBang()
      : super(
          'Scatter Bang',
          [
            IngredientQuantity(SootfootRoot(), 1),
            IngredientQuantity(CasterFern(), 1),
            IngredientQuantity(IronChunk(), 1),
          ],
          500,
          Image.asset('assets/craftable_items/SCATTERBANG.png'),
          itemTypes: [CraftableItemType.bomb], // --- CHANGED ---
        );
}

class OldGateau extends CraftableItem {
  OldGateau()
      : super(
          'Old Gateau',
          [
            IngredientQuantity(DazzlingHoney(), 1),
            IngredientQuantity(PlumpBeans(), 1),
            IngredientQuantity(SootfootRoot(), 1),
            IngredientQuantity(LureBase(), 1),
          ],
          0,
          Image.asset('assets/craftable_items/OLDGATEAU.png'),
          itemTypes: [CraftableItemType.cake, CraftableItemType.medicine], // --- CHANGED: Multiple types ---
        );
}