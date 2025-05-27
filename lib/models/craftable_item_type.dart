// lib/models/craftable_item_type.dart

enum CraftableItemType {
  // Special type to represent "show all items"
  all,

  // Ball types
  pokeball,

  // Food/consumable types
  cake,
  medicine,
  consumable, // For general consumables not specifically cakes or medicine

  // Utility/tool types
  bomb, // Could also be considered a type of utility item
}