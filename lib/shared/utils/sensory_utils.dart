class SensoryUtils {
  static Map<String, double> map4To6Axis(Map<String, dynamic> points) {
    // 1. Direct hit: check if the new 6 core keys already exist
    if (points.containsKey('bitterness') &&
        points.containsKey('acidity') &&
        points.containsKey('sweetness') &&
        points.containsKey('body') &&
        points.containsKey('intensity') &&
        points.containsKey('aftertaste')) {
      return {
        'bitterness': (points['bitterness'] as num?)?.toDouble() ?? 3.0,
        'acidity': (points['acidity'] as num?)?.toDouble() ?? 3.0,
        'sweetness': (points['sweetness'] as num?)?.toDouble() ?? 3.0,
        'body': (points['body'] as num?)?.toDouble() ?? 3.0,
        'intensity': (points['intensity'] as num?)?.toDouble() ?? 3.0,
        'aftertaste': (points['aftertaste'] as num?)?.toDouble() ?? 3.0,
      };
    }

    // 2. Legacy "4 core + 2 extra" format (aroma, flavor, acidity, body, aftertaste, balance)
    if (points.containsKey('aroma') || points.containsKey('flavor') || points.containsKey('balance')) {
      final flavor = (points['flavor'] as num?)?.toDouble() ?? 3.0;
      final acidity = (points['acidity'] as num?)?.toDouble() ?? 3.0;
      final body = (points['body'] as num?)?.toDouble() ?? 3.0;
      final aftertaste = (points['aftertaste'] as num?)?.toDouble() ?? 3.0;
      final balance = (points['balance'] as num?)?.toDouble() ?? 3.0;

      // Map to new axes
      return {
        'bitterness': 1.0, // Default low bitterness for specialty unless specified
        'acidity': acidity,
        'sweetness': flavor, // Flavor usually correlates with sweetness in user perception
        'body': body,
        'intensity': balance, // Balance/Overall intensity
        'aftertaste': aftertaste,
      };
    }

    // 3. Indicator format (from encyclopedia_entries / radar_json)
    if (points.containsKey('indicators')) {
      final ind = points['indicators'] as Map<String, dynamic>;
      return {
        'bitterness': (ind['bitterness'] as num?)?.toDouble() ?? 1.0,
        'acidity': (ind['acidity'] as num?)?.toDouble() ?? 3.0,
        'sweetness': (ind['sweetness'] as num?)?.toDouble() ?? 3.0,
        'body': (ind['body'] as num?)?.toDouble() ?? 3.0,
        'intensity': (ind['intensity'] as num?)?.toDouble() ?? 3.0,
        'aftertaste': (ind['aftertaste'] as num?)?.toDouble() ?? 3.0,
      };
    }

    // 4. Ultimate Fallback
    return {
      'bitterness': 3.0,
      'acidity': 3.0,
      'sweetness': 3.0,
      'body': 3.0,
      'intensity': 3.0,
      'aftertaste': 3.0,
    };
  }
}

