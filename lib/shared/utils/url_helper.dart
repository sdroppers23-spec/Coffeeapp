class UrlHelper {
  /// Validates if a string is a valid HTTP/HTTPS URL.
  /// Handles unencoded characters like spaces by using Uri.encodeFull internally.
  static bool isValidUrl(String? url) {
    if (url == null || url.trim().isEmpty) return false;

    final trimmed = url.trim();
    try {
      // Encode full URL to handle spaces and other non-encoded characters that are common in copy-paste
      final encoded = Uri.encodeFull(trimmed);
      final uri = Uri.tryParse(encoded);

      return uri != null &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Attempts to fix a URL by adding https:// if missing.
  static String fixUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return trimmed;

    if (!trimmed.startsWith('http://') && !trimmed.startsWith('https://')) {
      return 'https://$trimmed';
    }
    return trimmed;
  }
}
