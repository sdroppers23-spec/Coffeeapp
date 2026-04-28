class ProcessingMethodInfo {
  final String id;
  final String nameKey;
  final String descKey;
  final String? extendedInfoKey;
  final String? characterKey;
  final Map<String, double> sensoryPreset;
  final List<String> traits; // Legacy tags, characters are now in characterKey

  const ProcessingMethodInfo({
    required this.id,
    required this.nameKey,
    required this.descKey,
    this.extendedInfoKey,
    this.characterKey,
    required this.sensoryPreset,
    required this.traits,
  });
}

class ProcessingMethodsRepository {
  static const List<ProcessingMethodInfo> methods = [
    // Level 1: Basic
    ProcessingMethodInfo(
      id: 'natural',
      nameKey: 'process_natural',
      descKey: 'process_natural_desc',
      extendedInfoKey: 'process_natural_extended',
      characterKey: 'process_natural_character',
      sensoryPreset: {
        'bitterness': 2.0,
        'acidity': 3.0,
        'sweetness': 5.0,
        'body': 4.5,
        'intensity': 4.0,
        'aftertaste': 4.0,
      },
      traits: ['Sweet', 'Heavy Body', 'Fruity'],
    ),
    ProcessingMethodInfo(
      id: 'washed',
      nameKey: 'process_washed',
      descKey: 'process_washed_desc',
      extendedInfoKey: 'process_washed_extended',
      characterKey: 'process_washed_character',
      sensoryPreset: {
        'bitterness': 1.0,
        'acidity': 5.0,
        'sweetness': 3.5,
        'body': 2.5,
        'intensity': 3.5,
        'aftertaste': 4.0,
      },
      traits: ['Clean', 'High Acidity', 'Elegant'],
    ),
    ProcessingMethodInfo(
      id: 'honey',
      nameKey: 'process_honey',
      descKey: 'process_honey_desc',
      extendedInfoKey: 'process_honey_extended',
      characterKey: 'process_honey_character',
      sensoryPreset: {
        'bitterness': 1.5,
        'acidity': 3.5,
        'sweetness': 4.5,
        'body': 3.5,
        'intensity': 3.5,
        'aftertaste': 4.0,
      },
      traits: ['Syrupy', 'Balanced', 'Sweet'],
    ),

    // Level 2: Advanced
    ProcessingMethodInfo(
      id: 'anaerobic',
      nameKey: 'process_anaerobic',
      descKey: 'process_anaerobic_desc',
      extendedInfoKey: 'process_anaerobic_extended',
      characterKey: 'process_anaerobic_character',
      sensoryPreset: {
        'bitterness': 2.0,
        'acidity': 4.0,
        'sweetness': 4.5,
        'body': 4.0,
        'intensity': 5.0,
        'aftertaste': 4.5,
      },
      traits: ['Funky', 'Tropical', 'Intense'],
    ),
    ProcessingMethodInfo(
      id: 'carbonic',
      nameKey: 'process_carbonic',
      descKey: 'process_carbonic_desc',
      extendedInfoKey: 'process_carbonic_extended',
      characterKey: 'process_carbonic_character',
      sensoryPreset: {
        'bitterness': 1.5,
        'acidity': 4.5,
        'sweetness': 4.0,
        'body': 3.0,
        'intensity': 4.5,
        'aftertaste': 4.0,
      },
      traits: ['Winey', 'Clear', 'Refined'],
    ),
    ProcessingMethodInfo(
      id: 'thermal',
      nameKey: 'process_thermal',
      descKey: 'process_thermal_desc',
      extendedInfoKey: 'process_thermal_extended',
      characterKey: 'process_thermal_character',
      sensoryPreset: {
        'bitterness': 2.0,
        'acidity': 5.0,
        'sweetness': 5.0,
        'body': 4.0,
        'intensity': 5.0,
        'aftertaste': 5.0,
      },
      traits: ['Explosive', 'Vibrant', 'Complex'],
    ),

    ProcessingMethodInfo(
      id: 'wet_hulled',
      nameKey: 'process_wet_hulled',
      descKey: 'process_wet_hulled_desc',
      sensoryPreset: {
        'bitterness': 4.0,
        'acidity': 1.5,
        'sweetness': 2.0,
        'body': 5.0,
        'intensity': 4.5,
        'aftertaste': 3.0,
      },
      traits: ['Earthy', 'Thick Body', 'Spicy'],
    ),
    ProcessingMethodInfo(
      id: 'lactic',
      nameKey: 'process_lactic',
      descKey: 'process_lactic_desc',
      extendedInfoKey: 'process_lactic_extended',
      characterKey: 'process_lactic_character',
      sensoryPreset: {
        'bitterness': 1.5,
        'acidity': 4.0,
        'sweetness': 4.0,
        'body': 5.0,
        'intensity': 4.0,
        'aftertaste': 4.5,
      },
      traits: ['Silky', 'Creamy', 'Yogurt'],
    ),
    ProcessingMethodInfo(
      id: 'yeast',
      nameKey: 'process_yeast',
      descKey: 'process_yeast_desc',
      extendedInfoKey: 'process_yeast_extended',
      characterKey: 'process_yeast_character',
      sensoryPreset: {
        'bitterness': 1.5,
        'acidity': 3.5,
        'sweetness': 4.0,
        'body': 3.0,
        'intensity': 3.5,
        'aftertaste': 4.0,
      },
      traits: ['Clean', 'Aromatic', 'Refined'],
    ),
    ProcessingMethodInfo(
      id: 'koji',
      nameKey: 'process_koji',
      descKey: 'process_koji_desc',
      extendedInfoKey: 'process_koji_extended',
      characterKey: 'process_koji_character',
      sensoryPreset: {
        'bitterness': 1.0,
        'acidity': 3.0,
        'sweetness': 5.0,
        'body': 4.5,
        'intensity': 4.5,
        'aftertaste': 5.0,
      },
      traits: ['Umami', 'Deep Sweet', 'Complex'],
    ),
  ];

  static ProcessingMethodInfo? getById(String id) {
    try {
      return methods.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  static ProcessingMethodInfo? getByMatchingName(String name) {
    final lower = name.toLowerCase();
    for (final method in methods) {
      if (lower.contains(method.id.replaceAll('_', ' '))) {
        return method;
      }
    }
    // Specific hardcoded legacy mappings
    if (lower.contains('natural') || lower.contains('натур')) {
      return getById('natural');
    }
    if (lower.contains('wash') || lower.contains('мит')) {
      return getById('washed');
    }
    if (lower.contains('honey') || lower.contains('хан')) {
      return getById('honey');
    }
    if (lower.contains('anaerob') || lower.contains('анаер')) {
      return getById('anaerobic');
    }
    if (lower.contains('thermal') || lower.contains('термал')) {
      return getById('thermal');
    }
    if (lower.contains('wet hull') ||
        lower.contains('giling') ||
        lower.contains('вет-халд')) {
      return getById('wet_hulled');
    }
    if (lower.contains('carbonic') || lower.contains('вуглекисл')) {
      return getById('carbonic');
    }
    if (lower.contains('lactic') || lower.contains('молочн')) {
      return getById('lactic');
    }
    if (lower.contains('yeast') || lower.contains('дріждж')) {
      return getById('yeast');
    }
    if (lower.contains('koji') || lower.contains('коджі')) {
      return getById('koji');
    }

    return null;
  }
}
