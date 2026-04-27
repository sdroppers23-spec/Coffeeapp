import 'package:flutter/material.dart';

class WheelCategory {
  final String key;
  final String name; 
  final Color color;
  final List<WheelSub> sub;
  WheelCategory({
    required this.key,
    required this.name,
    required this.color,
    required this.sub,
  });
}

class WheelSub {
  final String key;
  final String name; 
  final Color color;
  final List<String> noteKeys;
  WheelSub({
    required this.key,
    required this.name,
    required this.color,
    required this.noteKeys,
  });
}

class ScaFlavorData {
  static List<WheelCategory> get localizedData => [
    WheelCategory(
      key: 'wheel_cat_fruity',
      name: 'wheel_cat_fruity',
      color: const Color(0xFFE31B23),
      sub: [
        WheelSub(
          key: 'wheel_sub_berry',
          name: 'wheel_sub_berry',
          color: const Color(0xFFA6192E),
          noteKeys: [
            'wheel_note_blackberry',
            'wheel_note_raspberry',
            'wheel_note_blueberry',
            'wheel_note_strawberry',
          ],
        ),
        WheelSub(
          key: 'wheel_sub_dried_fruit',
          name: 'wheel_sub_dried_fruit',
          color: const Color(0xFFC76F16),
          noteKeys: ['wheel_note_raisin', 'wheel_note_prune'],
        ),
        WheelSub(
          key: 'wheel_sub_other_fruit',
          name: 'wheel_sub_other_fruit',
          color: const Color(0xFFDA291C),
          noteKeys: [
            'wheel_note_coconut',
            'wheel_note_cherry',
            'wheel_note_pomegranate',
            'wheel_note_pineapple',
            'wheel_note_grape',
            'wheel_note_apple',
            'wheel_note_peach',
            'wheel_note_pear',
          ],
        ),
        WheelSub(
          key: 'wheel_sub_citrus',
          name: 'wheel_sub_citrus',
          color: const Color(0xFFFDB913),
          noteKeys: [
            'wheel_note_grapefruit',
            'wheel_note_orange',
            'wheel_note_lemon',
            'wheel_note_lime',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_floral',
      name: 'wheel_cat_floral',
      color: const Color(0xFFE5007D),
      sub: [
        WheelSub(
          key: 'wheel_sub_tea',
          name: 'wheel_sub_tea',
          color: const Color(0xFF634D2E),
          noteKeys: ['wheel_note_black_tea', 'wheel_note_green_tea'],
        ),
        WheelSub(
          key: 'wheel_sub_floral',
          name: 'wheel_sub_floral',
          color: const Color(0xFFE5007D),
          noteKeys: [
            'wheel_note_chamomile',
            'wheel_note_rose',
            'wheel_note_jasmine',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_sweet',
      name: 'wheel_cat_sweet',
      color: const Color(0xFFD3A13B),
      sub: [
        WheelSub(
          key: 'wheel_sub_sweet_aromatics',
          name: 'wheel_sub_sweet_aromatics',
          color: const Color(0xFFEBD89D),
          noteKeys: ['wheel_note_vanilla', 'wheel_note_vanilla_bean'],
        ),
        WheelSub(
          key: 'wheel_sub_sugar_brown',
          name: 'wheel_sub_sugar_brown',
          color: const Color(0xFF9E6532),
          noteKeys: [
            'wheel_note_molasses',
            'wheel_note_maple_syrup',
            'wheel_note_caramel',
            'wheel_note_honey',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_nutty_cocoa',
      name: 'wheel_cat_nutty_cocoa',
      color: const Color(0xFF6B4226),
      sub: [
        WheelSub(
          key: 'wheel_sub_nutty',
          name: 'wheel_sub_nutty',
          color: const Color(0xFF9E6532),
          noteKeys: [
            'wheel_note_peanuts',
            'wheel_note_hazelnut',
            'wheel_note_almond',
          ],
        ),
        WheelSub(
          key: 'wheel_sub_cocoa',
          name: 'wheel_sub_cocoa',
          color: const Color(0xFF332014),
          noteKeys: ['wheel_note_chocolate', 'wheel_note_dark_chocolate'],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_spices',
      name: 'wheel_cat_spices',
      color: const Color(0xFFC44031),
      sub: [
        WheelSub(
          key: 'wheel_sub_brown_spice',
          name: 'wheel_sub_brown_spice',
          color: const Color(0xFF7B3026),
          noteKeys: [
            'wheel_note_clove',
            'wheel_note_cinnamon',
            'wheel_note_nutmeg',
            'wheel_note_anise',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_roasted',
      name: 'wheel_cat_roasted',
      color: const Color(0xFF967D65),
      sub: [
        WheelSub(
          key: 'wheel_sub_cereal',
          name: 'wheel_sub_cereal',
          color: const Color(0xFFD4B08C),
          noteKeys: ['wheel_note_malt', 'wheel_note_grain'],
        ),
        WheelSub(
          key: 'wheel_sub_burnt',
          name: 'wheel_sub_burnt',
          color: const Color(0xFF423C35),
          noteKeys: ['wheel_note_smoky', 'wheel_note_ashy'],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_green_veg',
      name: 'wheel_cat_green_veg',
      color: const Color(0xFF008D4C),
      sub: [
        WheelSub(
          key: 'wheel_sub_green_vegetative',
          name: 'wheel_sub_green_vegetative',
          color: const Color(0xFF00563B),
          noteKeys: [
            'wheel_note_olive_oil',
            'wheel_note_raw',
            'wheel_note_under_ripe',
            'wheel_note_peapod',
            'wheel_note_fresh',
            'wheel_note_vegetative',
            'wheel_note_hay_like',
            'wheel_note_herb_like',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_sour_fermented',
      name: 'wheel_cat_sour_fermented',
      color: const Color(0xFFE9A000),
      sub: [
        WheelSub(
          key: 'wheel_sub_sour',
          name: 'wheel_sub_sour',
          color: const Color(0xFFC76F16),
          noteKeys: [
            'wheel_note_sour_aromatics',
            'wheel_note_acetic_acid',
            'wheel_note_butyric_acid',
            'wheel_note_isovaleric_acid',
            'wheel_note_citric_acid',
            'wheel_note_malic_acid',
          ],
        ),
        WheelSub(
          key: 'wheel_sub_alcohol_fermented',
          name: 'wheel_sub_alcohol_fermented',
          color: const Color(0xFF93278F),
          noteKeys: [
            'wheel_note_winey',
            'wheel_note_whiskey',
            'wheel_note_over_ripe',
          ],
        ),
      ],
    ),
    WheelCategory(
      key: 'wheel_cat_others',
      name: 'wheel_cat_others',
      color: const Color(0xFF6C6E71),
      sub: [
        WheelSub(
          key: 'wheel_sub_chemical',
          name: 'wheel_sub_chemical',
          color: const Color(0xFF939598),
          noteKeys: [
            'wheel_note_rubber',
            'wheel_note_petroleum',
            'wheel_note_medicinal',
          ],
        ),
        WheelSub(
          key: 'wheel_sub_papery',
          name: 'wheel_sub_papery',
          color: const Color(0xFFBCBEC0),
          noteKeys: [
            'wheel_note_stale',
            'wheel_note_musty',
            'wheel_note_dusty',
          ],
        ),
      ],
    ),
  ];
}
