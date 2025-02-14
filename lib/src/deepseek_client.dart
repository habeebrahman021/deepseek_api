import 'dart:async';
import 'package:deepseek_api/src/exceptions.dart';
import 'package:deepseek_api/src/models.dart';
import 'package:dio/dio.dart';

class DeepSeekClient {
  final Dio _dio;
  final String _apiKey;

  DeepSeekClient({
    required String apiKey,
    String baseUrl = 'https://api.deepseek.com/v1',
  })  : _apiKey = apiKey,
        _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $_apiKey';
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
    ));
  }

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

  Future<ModelsListResponse> listModels() async {
    try {
      final response = await _dio.get('/models');
      return ModelsListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      switch (statusCode) {
        case 400:
          return BadRequestException(data['error'] ?? 'Invalid request');
        case 401:
          return UnauthorizedException(data['error'] ?? 'Unauthorized');
        case 429:
          return RateLimitException(data['error'] ?? 'Rate limit exceeded');
        case 500:
          return ServerException(data['error'] ?? 'Server error');
        default:
          return ApiException(data['error'] ?? 'Unknown API error');
      }
    }
    return NetworkException('Network error occurred');
  }
}
