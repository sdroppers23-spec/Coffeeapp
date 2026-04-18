class SensoryUtils {
  static Map<String, double> map4To6Axis(Map<String, dynamic> points) {
    // 1. Direct hit: check if the 6 core keys already exist (new AddLotScreen format)
    if (points.containsKey('aroma') &&
        points.containsKey('flavor') &&
        points.containsKey('acidity') &&
        points.containsKey('body') &&
        points.containsKey('aftertaste') &&
        points.containsKey('balance')) {
      return {
        'aroma': (points['aroma'] as num?)?.toDouble() ?? 3.5,
        'flavor': (points['flavor'] as num?)?.toDouble() ?? 3.5,
        'acidity': (points['acidity'] as num?)?.toDouble() ?? 3.5,
        'body': (points['body'] as num?)?.toDouble() ?? 3.5,
        'aftertaste': (points['aftertaste'] as num?)?.toDouble() ?? 3.5,
        'balance': (points['balance'] as num?)?.toDouble() ?? 3.5,
        'sweetness': (points['sweetness'] as num?)?.toDouble() ?? 3.5, // Optional legacy baggage
        'bitterness': (points['bitterness'] as num?)?.toDouble() ?? 1.0,
      };
    }

    // 2. Indicator format (from encyclopedia_entries)
    if (points.containsKey('indicators')) {
      final ind = points['indicators'] as Map<String, dynamic>;
      final acidity = (ind['acidity'] as num?)?.toDouble() ?? 3.5;
      final sweetness = (ind['sweetness'] as num?)?.toDouble() ?? 3.5;
      final intensity = (ind['intensity'] as num?)?.toDouble() ?? 3.5;
      final bitterness = (ind['bitterness'] as num?)?.toDouble() ?? 1.0;

      double bodyScore = intensity;
      final bodyType = points['bodyType']?.toString().toLowerCase();
      if (bodyType == 'light') {
        bodyScore = 2.5;
      } else if (bodyType == 'medium') {
        bodyScore = 3.5;
      } else if (bodyType == 'full' || bodyType == 'heavy') {
        bodyScore = 5.0;
      }

      double balance = (sweetness + acidity + (5 - bitterness)) / 3;

      return {
        'aroma': intensity,
        'flavor': (sweetness + intensity) / 2,
        'acidity': acidity,
        'body': bodyScore,
        'aftertaste': (sweetness + balance) / 2,
        'balance': balance.clamp(1.0, 5.0),
        'sweetness': sweetness,
        'bitterness': bitterness,
      };
    }

    // 3. Legacy AddLotScreen format (4-axis or varied keys)
    if (points.containsKey('aroma') || points.containsKey('sweetness')) {
      final intensity = (points['intensity'] as num?)?.toDouble() ?? 3.5;
      final aroma = (points['aroma'] as num?)?.toDouble() ?? intensity;
      final sweetness = (points['sweetness'] as num?)?.toDouble() ?? intensity;
      final acidity = (points['acidity'] as num?)?.toDouble() ?? 3.5;
      final bitterness = (points['bitterness'] as num?)?.toDouble() ?? 1.0;
      final body = (points['body'] as num?)?.toDouble() ?? intensity;

      double balance = (sweetness + acidity + (5 - bitterness)) / 3;

      return {
        'aroma': aroma,
        'flavor': (sweetness + intensity) / 2,
        'acidity': acidity,
        'body': body,
        'aftertaste': (sweetness + balance) / 2,
        'balance': balance.clamp(1.0, 5.0),
        'sweetness': sweetness,
        'bitterness': bitterness,
      };
    }

    // 4. Ultimate Fallback
    return {
      'aroma': 3.5,
      'flavor': 3.5,
      'acidity': 3.5,
      'body': 3.5,
      'aftertaste': 3.5,
      'balance': 3.5,
    };
  }
}
