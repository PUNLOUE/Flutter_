import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum ReminderCategory {
  work('Work',Icons.work),
  fitness('GYM', Iconsax.filter),
  personal('People', Iconsax.people),
  shopping('Shopping',Iconsax.shop),
  travel('Travel', Iconsax.airplane),
  finance('Finance', Iconsax.money),
  health('Health', Iconsax.health),
  education('Education', Iconsax.book),
  family('Family', Iconsax.people5),
  hobbies('Hobbies',Iconsax.happyemoji),
  social('Social',  Iconsax.game),
  maintenance('Maintenance',  Iconsax.activity),
  birthdays('Birthdays',  Iconsax.cake),
  anniversaries('Anniversaries', Iconsax.note_favorite),
  miscellaneous('Book',  Iconsax.magic_star),
  others('Others', Iconsax.more);

  final String name;
  final IconData icon;


  const ReminderCategory(this.name, this.icon);

}
