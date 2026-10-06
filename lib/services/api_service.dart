import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/destination_item.dart';
import '../models/review_item.dart';
import '../models/trek_item.dart';

/// Singleton service handling all dynamic Celtic Trekking API calls
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();
  final Duration _timeout = const Duration(seconds: 4);
  bool _hostValidated = false;

  Map<String, String> get _headers => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  /// Ensure we find a responsive host among candidates
  Future<void> _ensureWorkingHost() async {
    if (_hostValidated) return;
    for (final host in ApiConstants.candidateHosts) {
      try {
        final checkUrl = Uri.parse('$host/api/v1/destinations');
        final res = await _client.get(checkUrl, headers: _headers).timeout(const Duration(seconds: 2));
        if (res.statusCode == 200) {
          ApiConstants.activeHost = host;
          _hostValidated = true;
          debugPrint('ApiService: Connected successfully to host $host');
          return;
        }
      } catch (_) {
        // Continue to next candidate
      }
    }
  }

  /// Fetch all active destinations from /api/v1/destinations
  Future<List<DestinationItem>> fetchDestinations() async {
    await _ensureWorkingHost();
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.destinations}?all=1');
      final response = await _client.get(url, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final list = (decoded['data'] as List)
              .map((item) => DestinationItem.fromJson(item as Map<String, dynamic>))
              .toList();
          if (list.isNotEmpty) return list;
        }
      }
    } catch (e) {
      debugPrint('ApiService.fetchDestinations error/fallback: $e');
    }
    return DestinationItem.defaultDestinations;
  }

  /// Fetch approved traveler reviews from /api/v1/reviews
  Future<List<ReviewItem>> fetchReviews({int perPage = 100}) async {
    await _ensureWorkingHost();
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.reviews}?per_page=$perPage');
      final response = await _client.get(url, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final list = (decoded['data'] as List)
              .map((item) => ReviewItem.fromJson(item as Map<String, dynamic>))
              .toList();
          if (list.isNotEmpty) return list;
        }
      }
    } catch (e) {
      debugPrint('ApiService.fetchReviews error/fallback: $e');
    }
    return ReviewItem.defaultReviews;
  }

  /// Fetch popular treks from /api/v1/treks
  Future<List<TrekItem>> fetchTreks({int perPage = 10}) async {
    await _ensureWorkingHost();
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.treks}?per_page=$perPage');
      final response = await _client.get(url, headers: _headers).timeout(_timeout);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final list = (decoded['data'] as List)
              .map((item) => TrekItem.fromJson(item as Map<String, dynamic>))
              .toList();
          if (list.isNotEmpty) return list;
        }
      }
    } catch (e) {
      debugPrint('ApiService.fetchTreks error/fallback: $e');
    }
    return [TrekItem.defaultTrek];
  }
}
