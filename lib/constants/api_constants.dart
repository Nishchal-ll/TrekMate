/// Base configuration for Celtic Trekking backend API
class ApiConstants {
  /// Candidate hosts tried in order for Android physical device, emulator, and local
  static const List<String> candidateHosts = [
    'http://127.0.0.1:8080',
    'http://192.168.1.71:8080',
    'http://10.0.2.2:8080',
  ];

  /// Currently active and validated host base
  static String activeHost = 'http://127.0.0.1:8080';

  /// Base API URL
  static String get baseUrl => '$activeHost/api/v1';

  // Endpoints
  static const String destinations = '/destinations';
  static const String reviews = '/reviews';
  static const String treks = '/treks';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String customerReviews = '/customer/reviews';
  static const String contactSend = '/contact/send';

  /// Normalize media/image URLs returned from backend
  static String normalizeImageUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    String normalized = url.trim();

    // Replace 127.0.0.1:8080 or localhost:8080 with activeHost if needed
    if (normalized.startsWith('http://127.0.0.1:8080') ||
        normalized.startsWith('http://localhost:8080')) {
      final path = normalized
          .replaceFirst('http://127.0.0.1:8080', '')
          .replaceFirst('http://localhost:8080', '');
      return '$activeHost$path';
    }
    
    // Relative upload path
    if (normalized.startsWith('/uploads/')) {
      return '$activeHost$normalized';
    }

    return normalized;
  }
}
