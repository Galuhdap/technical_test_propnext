import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiErrorHandler {
  /// 🔹 Fungsi utama untuk memetakan error dari response HTTP
  static String mapError(http.Response response) {
    Map<String, dynamic>? errorBody;

    try {
      if (response.body.isNotEmpty) {
        errorBody = jsonDecode(response.body);
      }
    } catch (_) {
      // kalau bukan JSON valid, biarkan null
    }

    switch (response.statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Invalid password or unauthorized access.';
      case 403:
        return 'Access forbidden. You do not have permission.';
      case 404:
        return 'Resource not found.';
      case 422:
        return errorBody?['message'] ?? 'Validation error.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Request failed with status: ${response.statusCode}';
    }
  }

  /// 🔹 Optional: untuk menangani exception dari network
  static String mapException(Object e) {
    if (e.toString().contains('SocketException')) {
      return 'No internet connection.';
    } else if (e.toString().contains('TimeoutException')) {
      return 'Connection timed out.';
    } else {
      return 'Unexpected error: ${e.toString()}';
    }
  }
}
