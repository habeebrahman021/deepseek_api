import 'package:deepseek_api/src/deepseek_api.dart';
import 'package:deepseek_api/src/exceptions.dart';
import 'package:deepseek_api/src/models.dart';

void main() async {
  // Initialize the DeepSeekClient with your API key
  final client = DeepSeekAPI(apiKey: 'sk-31999bba50954807bd0897682a148b95');

  try {
    // Example: List available models
    final modelsResponse = await client.listModels();

    print('Available Models: ${modelsResponse.data}');

    // Example: Create a chat completion
    final chatRequest = ChatCompletionRequest(
      model: 'deepseek-chat', // Replace with a valid model ID
      messages: [
        ChatMessage(role: 'user', content: 'Hello, how are you?'),
      ],
    );

    final chatResponse = await client.createChatCompletion(chatRequest);
    print('Chat Completion Response: ${chatResponse.choices}');
  } on BadRequestException catch (e) {
    print('Bad Request: ${e.message}');
  } on UnauthorizedException catch (e) {
    print('Unauthorized: ${e.message}');
  } on RateLimitException catch (e) {
    print('Rate Limit Exceeded: ${e.message}');
  } on ServerException catch (e) {
    print('Server Error: ${e.message}');
  } on ApiException catch (e) {
    print('API Error: ${e.message}');
  }

}
