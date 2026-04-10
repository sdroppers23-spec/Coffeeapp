import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class PriceSyncService {
  Future<Map<String, String?>> fetch3ChampsPrices(String url) async {
    try {
      if (url.isEmpty || !url.contains('3champsroastery')) {
        return {};
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return {};

      final document = parse(response.body);

      // 1. Try to find wholesale prices in data-wholesale-prices attribute
      // <div class="product-info" data-wholesale-prices='{"250g":"...", "1kg":"..."}'>
      final infoDiv = document.querySelector('[data-wholesale-prices]');
      Map<String, String?> wholesale = {};
      if (infoDiv != null) {
        final attr = infoDiv.attributes['data-wholesale-prices'];
        if (attr != null) {
          try {
            final Map<String, dynamic> data = jsonDecode(attr);
            wholesale['wholesale_250'] = data['250g']?.toString();
            wholesale['wholesale_1k'] = data['1kg']?.toString();
          } catch (_) {}
        }
      }

      // 2. Try to find retail prices in .regular-price or .price span
      // This is more complex as it might be a dropdown.
      // Usually, 3 Champs uses standard WooCommerce structure.
      final priceElements =
          document.querySelectorAll('.woocommerce-Price-amount');
      String? retail250;
      if (priceElements.isNotEmpty) {
        retail250 =
            priceElements.first.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
      }

      return {
        ...wholesale,
        'retail_250': retail250,
      };
    } catch (e) {
      return {};
    }
  }
}
