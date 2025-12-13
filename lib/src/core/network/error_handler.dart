import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please check your internet connection and try again.";
      case DioExceptionType.sendTimeout:
        return "Request took too long to send. Please try again later.";
      case DioExceptionType.receiveTimeout:
        return "Server response timed out. Please try again later.";
      case DioExceptionType.badCertificate:
        return "Invalid security certificate detected. Please check your network settings.";
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled. Please try again.";
      case DioExceptionType.connectionError:
        return "Failed to connect to the server. Please check your internet connection.";
      case DioExceptionType.unknown:
        return "An unexpected error occurred. Please try again later.";
    }
  }

  static String _handleBadResponse(Response<dynamic>? response) {
    if (response == null) {
      return "Server returned an invalid response. Please try again later.";
    }

    switch (response.statusCode) {
      case 400:
        return "Bad request. Please check your input and try again.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Access denied. You do not have permission to perform this action.";
      case 404:
        return "Requested resource not found. Please check and try again.";
      case 500:
        return "Server error. Please try again later.";
      case 502:
        return "Bad gateway. The server might be down. Please try again later.";
      case 503:
        return "Service unavailable. The server is temporarily down. Please try again later.";
      case 504:
        return "Gateway timeout. The server is taking too long to respond.";
      default:
        return "Unexpected error: ${response.statusCode}. Please try again later.";
    }
  }
}
