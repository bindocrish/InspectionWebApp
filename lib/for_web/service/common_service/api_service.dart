import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  final T? body;
  final int statusCode;
  final String message;
  final bool success;

  ApiResponse({
    this.body,
    required this.statusCode,
    required this.message,
    required this.success,
  });
}

class ApiService {

  Future<ApiResponse<T>> getData<T>(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      final body = json.decode(response.body);
      return ApiResponse<T>(
        body: body,
        statusCode: response.statusCode,
        message: "Success",
        success: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      return ApiResponse<T>(
        body: null,
        statusCode: 500,
        message: "GET error: $e",
        success: false,
      );
    }
  }

  Future<ApiResponse<T>> postData<T>(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      final statusCode = response.statusCode;
      dynamic decodedBody;
      try {
        decodedBody = json.decode(response.body);
      } catch (_) {
        decodedBody = null;
      }

      String errorMessage = _handleHttpError(statusCode, decodedBody);
      return ApiResponse<T>(
        body: decodedBody,
        statusCode: response.statusCode,
        message: errorMessage,
        success: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      return ApiResponse<T>(
        body: null,
        statusCode: 500,
        message: "POST error: $e",
        success: false,
      );
    }
  }

  Future<ApiResponse<T>> putData<T>(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      final body = json.decode(response.body);
      return ApiResponse<T>(
        body: body,
        statusCode: response.statusCode,
        message: "Success",
        success: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      return ApiResponse<T>(
        body: null,
        statusCode: 500,
        message: "PUT error: $e",
        success: false,
      );
    }
  }

  Future<ApiResponse<T>> deleteData<T>(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse(endpoint));
      final body = json.decode(response.body);
      return ApiResponse<T>(
        body: body,
        statusCode: response.statusCode,
        message: "Success",
        success: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      return ApiResponse<T>(
        body: null,
        statusCode: 500,
        message: "DELETE error: $e",
        success: false,
      );
    }
  }
  String _handleHttpError(int statusCode, dynamic body) {
    switch (statusCode) {
      case 200:
      case 201:
        return "Success";
      case 400:
        return body?['message'] ?? "Bad request. Please check your input.";
      case 401:
        return body?['message'] ?? "Unauthorized. Please login again.";
      case 403:
        return body?['message'] ?? "Access denied.";
      case 404:
        return body?['message'] ?? "Resource not found.";
      case 422:
        if (body is Map && body.containsKey('errors')) {
          return _formatValidationErrors(body['errors']);
        }
        return "Validation failed.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Unexpected error: $statusCode";
    }
  }

  String _formatValidationErrors(dynamic errors) {
    if (errors is Map<String, dynamic>) {
      return errors.entries.map((e) => "${e.key}: ${e.value.join(', ')}").join("\n");
    }
    return "Validation error.";
  }
}

