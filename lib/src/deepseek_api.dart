import 'dart:async';
import 'package:deepseek_api/src/exceptions.dart';
import 'package:deepseek_api/src/models.dart';
import 'package:dio/dio.dart';

/// DeepSeekAPI provides methods to interact with the DeepSeek API.
///
/// This class handles authentication, error handling, and API requests.
class DeepSeekAPI {
  /// The base URL for the DeepSeek API.
  final Dio _dio;

  /// The API key for authentication.
  final String _apiKey;

  /// Creates an instance of [DeepSeekAPI].
  ///
  /// Requires an [apiKey] for authentication.
  ///
  /// Optional parameters:
  /// - [baseUrl]: Base URL for API endpoints (default: 'https://api.deepseek.com/v1')
  /// - [dio]: Custom Dio instance. If not provided, a default instance with [baseUrl] will be created.
  DeepSeekAPI({
    required String apiKey,
    String baseUrl = 'https://api.deepseek.com/v1',
    Dio? dio,
  })  : _apiKey = apiKey,
        _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $_apiKey';
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
    ));
  }

  /// Creates a chat completion request.
  ///
  /// Sends a request with the provided [ChatCompletionRequest] and returns a [ChatCompletionResponse].
  /// Optionally, a [cancelToken] can be provided to cancel the request.
  ///
  /// Throws:
  /// - [BadRequestException] for invalid requests.
  /// - [UnauthorizedException] if authentication fails.
  /// - [RateLimitException] if rate limits are exceeded.
  /// - [ServerException] for server errors.
  /// - [ApiException] for other API-related errors.
  /// - [NetworkException] for network failures.
  Future<ChatCompletionResponse> createChatCompletion(
    ChatCompletionRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return ChatCompletionResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Retrieves a list of available models from the DeepSeek API.
  ///
  /// Returns a [ModelsListResponse] containing the list of models.
  ///
  /// Throws:
  /// - [UnauthorizedException] if authentication fails.
  /// - [RateLimitException] if rate limits are exceeded.
  /// - [ServerException] for server errors.
  /// - [ApiException] for other API-related errors.
  /// - [NetworkException] for network failures.
  Future<ModelsListResponse> listModels() async {
    try {
      final response = await _dio.get('/models');
      return ModelsListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handles API errors by mapping Dio exceptions to custom exceptions.
  ///
  /// Takes a [DioException] and returns an appropriate exception based on the HTTP status code.
  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode ?? 500;
      final data = e.response?.data as Map<String, dynamic>?;
      final error = data?['error'] as Map<String, dynamic>?;
      final message = error?['message'] as String?;
      switch (statusCode) {
        case 400:
        case 422:
          return BadRequestException(message ?? 'Invalid request');
        case 401:
          return UnauthorizedException(message ?? 'Unauthorized');
        case 402:
          return InsufficientBalanceException(
            message ?? 'Insufficient Balance',
          );
        case 429:
          return RateLimitException(message ?? 'Rate limit exceeded');
        case 500:
        case 503:
          return ServerException(message ?? 'Server error');
        default:
          return ApiException(message ?? 'Unknown API error');
      }
    }
    return NetworkException('Network error occurred');
  }
}
