class SensoryUtils {
  static Map<String, double> map4To6Axis(Map<String, dynamic> points) {
    // 1. Direct hit: check if the original 6 core keys already exist
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

    // 2. Map new keys (aroma, flavor, balance) back to original if needed
    final bitterness = (points['bitterness'] ?? points['aroma'] ?? 3.0) as num;
    final sweetness = (points['sweetness'] ?? points['flavor'] ?? 3.0) as num;
    final acidity = (points['acidity'] ?? 3.0) as num;
    final body = (points['body'] ?? 3.0) as num;
    final aftertaste = (points['aftertaste'] ?? 3.0) as num;
    final intensity = (points['intensity'] ?? points['balance'] ?? 3.0) as num;

    return {
      'bitterness': bitterness.toDouble(),
      'acidity': acidity.toDouble(),
      'sweetness': sweetness.toDouble(),
      'body': body.toDouble(),
      'intensity': intensity.toDouble(),
      'aftertaste': aftertaste.toDouble(),
    };
  }
}

