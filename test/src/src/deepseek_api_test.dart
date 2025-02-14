import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:deepseek_api/deepseek_api.dart';

class MockDio extends Mock implements Dio {
  @override
  final Interceptors interceptors = Interceptors();
}

void main() {
  group('DeepSeekAPI', () {
    const apiKey = 'test_api_key';
    late DeepSeekAPI api;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      api = DeepSeekAPI(apiKey: apiKey, dio: mockDio);
    });

    group('createChatCompletion', () {
      final request = ChatCompletionRequest(
        model: 'deepseek-chat',
        messages: [ChatMessage(role: 'user', content: 'Hello')],
      );

      test('returns ChatCompletionResponse on success', () async {
        const responseData = {
          'id': 'chat-123',
          'object': 'chat.completion',
          'created': 1677652288,
          'model': 'deepseek-chat',
          'choices': [
            {
              'index': 0,
              'message': {'role': 'assistant', 'content': 'Hi there!'},
              'finish_reason': 'stop',
            }
          ],
          'usage': {
            'prompt_tokens': 10,
            'completion_tokens': 20,
            'total_tokens': 30,
          },
        };

        when(() => mockDio.post(
              '/chat/completions',
              data: any(named: 'data'),
            )).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/'),
          ),
        );

        final response = await api.createChatCompletion(request);
        expect(response, isA<ChatCompletionResponse>());
        expect(response.id, 'chat-123');
        expect(response.choices.first.message.content, 'Hi there!');
      });

      test('throws UnauthorizedException on 401', () async {
        when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/'),
            response: Response(
              statusCode: 401,
              data: {
                'error': {'message': 'Invalid API key'}
              },
              requestOptions: RequestOptions(path: '/'),
            ),
          ),
        );

        expect(
          () => api.createChatCompletion(request),
          throwsA(isA<UnauthorizedException>()),
        );
      });
    });

    group('listModels', () {
      test('returns ModelsListResponse on success', () async {
        const responseData = {
          'data': [
            {
              'id': 'model-1',
              'object': 'model',
              'owned_by': 'deepseek',
            },
            {
              'id': 'model-2',
              'object': 'model',
              'owned_by': 'deepseek',
            },
          ],
        };

        when(() => mockDio.get('/models')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/'),
          ),
        );

        final response = await api.listModels();
        expect(response, isA<ModelsListResponse>());
        expect(response.data.length, 2);
        expect(response.data.first.id, 'model-1');
      });
    });

    group('error handling', () {
      test('throws NetworkException on connection error', () async {
        when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/'),
            error: 'Connection failed',
          ),
        );

        expect(
          () => api.createChatCompletion(
            ChatCompletionRequest(
              model: 'test',
              messages: [ChatMessage(role: 'user', content: 'test')],
            ),
          ),
          throwsA(isA<NetworkException>()),
        );
      });
    });
  });
}
