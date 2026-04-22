class SensoryUtils {
  static Map<String, double> map4To6Axis(Map<String, dynamic> points) {
    double parseNum(dynamic value) {
      if (value == null) return 3.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 3.0;
      return 3.0;
    }

    // 1. Direct hit: check if the original 6 core keys already exist
    if (points.containsKey('bitterness') &&
        points.containsKey('acidity') &&
        points.containsKey('sweetness') &&
        points.containsKey('body') &&
        points.containsKey('intensity') &&
        points.containsKey('aftertaste')) {
      return {
        'bitterness': parseNum(points['bitterness']),
        'acidity': parseNum(points['acidity']),
        'sweetness': parseNum(points['sweetness']),
        'body': parseNum(points['body']),
        'intensity': parseNum(points['intensity']),
        'aftertaste': parseNum(points['aftertaste']),
      };
    }

    // 2. Map new keys (aroma, flavor, balance) back to original if needed
    final bitterness = parseNum(points['bitterness'] ?? points['aroma']);
    final sweetness = parseNum(points['sweetness'] ?? points['flavor']);
    final acidity = parseNum(points['acidity']);
    final body = parseNum(points['body']);
    final aftertaste = parseNum(points['aftertaste']);
    final intensity = parseNum(points['intensity'] ?? points['balance']);

    return {
      'bitterness': bitterness,
      'acidity': acidity,
      'sweetness': sweetness,
      'body': body,
      'intensity': intensity,
      'aftertaste': aftertaste,
    };
  }
}

