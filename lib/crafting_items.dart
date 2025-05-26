//Stores prices of crafting items in the Jublife Village crafting shop

import 'package:flutter/material.dart';

class CraftingItem {
  final String name;
  final int price;
  final Image icon;

  CraftingItem(this.name, this.price, this.icon);
}

class Apricorn extends CraftingItem {
  Apricorn()
      : super(
          'Apricorn',
          40,
          Image.asset('assets/crafting_items/APRICORN.png'),
        );
}

class Tumblestone extends CraftingItem {
  Tumblestone()
      : super(
          'Tumblestone',
          60,
          Image.asset('assets/crafting_items/TUMBLESTONE.png'),
        );
}

class BlackTumblestone extends CraftingItem {
  BlackTumblestone()
      : super(
          'Black Tumblestone',
          80,
          Image.asset('assets/crafting_items/BLACK_TUMBLESTONE.png'),
        );
}

class SkyTumblestone extends CraftingItem {
  SkyTumblestone()
      : super(
          'Sky Tumblestone',
          100,
          Image.asset('assets/crafting_items/SKY_TUMBLESTONE.png'),
        );
}

class IronChunk extends CraftingItem {
  IronChunk()
      : super(
          'Iron Chunk',
          200,
          Image.asset('assets/crafting_items/IRON_CHUNK.png'),
        );
}

class LureBase extends CraftingItem {
  LureBase()
      : super(
          'Lure Base',
          100,
          Image.asset('assets/crafting_items/LURE_BASE.png'),
        );
}

class SpringyMushroom extends CraftingItem {
  SpringyMushroom()
      : super(
          'Springy Mushroom',
          200,
          Image.asset('assets/crafting_items/SPRINGY_MUSHROOM.png'),
        );
}

class DazzlingHoney extends CraftingItem {
  DazzlingHoney()
      : super(
          'Dazzling Honey',
          200,
          Image.asset('assets/crafting_items/DAZZLING_HONEY.png'),
        );
}

class HeartyGrains extends CraftingItem {
  HeartyGrains()
      : super(
          'Hearty Grains',
          200,
          Image.asset('assets/crafting_items/HEARTY_GRAINS.png'),
        );
}

class PlumpBeans extends CraftingItem {
  PlumpBeans()
      : super(
          'Plump Beans',
          200,
          Image.asset('assets/crafting_items/PLUMP_BEANS.png'),
        );
}

class CrunchySalt extends CraftingItem {
  CrunchySalt()
      : super(
          'Crunchy Salt',
          200,
          Image.asset('assets/crafting_items/CRUNCHY_SALT.png'),
        );
}

class CasterFern extends CraftingItem {
  CasterFern()
      : super(
          'Caster Fern',
          140,
          Image.asset('assets/crafting_items/CASTER_FERN.png'),
        );
}

class SootfootRoot extends CraftingItem {
  SootfootRoot()
      : super(
          'Sootfoot Root',
          300,
          Image.asset('assets/crafting_items/SOOTFOOT_ROOT.png'),
        );
}

class PopPod extends CraftingItem {
  PopPod()
      : super(
          'Pop Pod',
          400,
          Image.asset('assets/crafting_items/POP_POD.png'),
        );
}