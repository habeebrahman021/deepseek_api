import 'package:deepseek_api/src/deepseek_client.dart';
import 'package:deepseek_api/src/exceptions.dart';
import 'package:deepseek_api/src/models.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // Initialize the DeepSeekClient with your API key
  final client = DeepSeekClient(apiKey: 'your_api_key_here');

  try {
    // Example: List available models
    final modelsResponse = await client.listModels();
    if (kDebugMode) {
      print('Available Models: ${modelsResponse.data}');
    }

    // Example: Create a chat completion
    final chatRequest = ChatCompletionRequest(
      model: 'gpt-3.5-turbo', // Replace with a valid model ID
      messages: [
        ChatMessage(role: 'user', content: 'Hello, how are you?'),
      ],
    );

    final chatResponse = await client.createChatCompletion(chatRequest);
    if (kDebugMode) {
      print('Chat Completion Response: ${chatResponse.choices}');
    }
  } on BadRequestException catch (e) {
    if (kDebugMode) {
      print('Bad Request: ${e.message}');
    }
  } on UnauthorizedException catch (e) {
    if (kDebugMode) {
      print('Unauthorized: ${e.message}');
    }
  } on RateLimitException catch (e) {
    if (kDebugMode) {
      print('Rate Limit Exceeded: ${e.message}');
    }
  } on ServerException catch (e) {
    if (kDebugMode) {
      print('Server Error: ${e.message}');
    }
  } on ApiException catch (e) {
    if (kDebugMode) {
      print('API Error: ${e.message}');
    }
  }
}
