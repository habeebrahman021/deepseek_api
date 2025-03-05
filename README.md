# DeepSeek API

![Validate](https://github.com/habeebrahman021/deepseek_api/actions/workflows/validate.yml/badge.svg)
[![Pub Version](https://img.shields.io/pub/v/deepseek_api)](https://pub.dev/packages/deepseek_api)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern Flutter package for seamless integration with DeepSeek's powerful AI APIs. Supports all major features, including chat completions, model management, and streaming.

## Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  deepseek_api: ^latest_version
```

Then run:

```bash
flutter pub get
```

## Initialization

```dart
import 'package:deepseek_api/deepseek_api.dart';

final deepseek = DeepSeekAPI(
  apiKey: 'your-api-key',
  // Optional: baseUrl: 'https://api.deepseek.com/v1' (default)
);
```

🔗 [Get API Key](https://platform.deepseek.com/api-keys) | 💵 [Pricing Details](https://www.deepseek.com/pricing)

## Quick Start

### Basic Chat Completion

```dart
final response = await deepseek.createChatCompletion(
  ChatCompletionRequest(
    model: 'deepseek-chat',
    messages: [
      ChatMessage(
        role: 'user',
        content: 'Explain quantum computing in 50 words'
      )
    ],
    temperature: 0.7,
    maxTokens: 100,
  ),
);

print(response.choices.first.message.content);
```

### Streaming Responses

```dart
final response = await deepseek.createChatCompletion(
  ChatCompletionRequest(
    model: 'deepseek-chat',
    messages: [/* your messages */],
    stream: true,
  ),
);

// Handle stream using Dio's response stream
```

## Supported Models

### Latest Models (2024)

| Model ID            | Description                      | Best For                  |
|---------------------|--------------------------------|---------------------------|
| `deepseek-chat`    | General-purpose chat model     | Everyday conversations    |
| `deepseek-coder`   | Code-focused model             | Programming assistance    |
| `deepseek-math`    | Advanced mathematical reasoning | Complex calculations      |
| `deepseek-chat-pro`| Premium chat model             | Enterprise applications   |

🔍 [Full Model List](https://platform.deepseek.com/docs/models) | 🔄 [Model Updates](https://status.deepseek.com)

## Parameters Reference

### ChatCompletionRequest

| Parameter         | Type     | Default | Description                                   |
|------------------|---------|---------|-----------------------------------------------|
| `model`         | String  | Required | The model ID to use                          |
| `messages`      | List    | Required | Conversation history as ChatMessage objects  |
| `temperature`   | double? | 1.0     | Creativity control (0.0-2.0)                 |
| `maxTokens`     | int?    | null    | Maximum number of tokens to generate        |
| `topP`         | double? | 1.0     | Nucleus sampling threshold (0.0-1.0)         |
| `frequencyPenalty` | double? | 0.0 | Penalize new tokens based on frequency (-2.0 to 2.0) |
| `presencePenalty` | double? | 0.0 | Penalize new tokens based on presence (-2.0 to 2.0) |
| `stop`         | List?   | null    | Up to 4 sequences where the API will stop generating |
| `stream`       | bool?   | false   | Whether to stream back partial progress     |
| `user`         | String? | null    | Unique identifier for end-user              |

## Advanced Features

### Model Management

```dart
// List all available models
final models = await deepseek.listModels();
print(models.data.map((m) => m.id).join(', '));
```

### Error Handling

```dart
try {
  // API call
} on RateLimitException catch (e) {
  print('Slow down! ${e.message}');
} on ApiException catch (e) {
  print('API Error: ${e.message}');
} on NetworkException {
  print('Check your internet connection');
}
```

### Custom Configuration

```dart
final customDio = Dio()
  ..interceptors.add(LogInterceptor());

final deepseek = DeepSeekAPI(
  apiKey: 'your-key',
  baseUrl: 'https://api.deepseek.com/v2', // Custom endpoint
);
```

## API Resources

- [Official Documentation](https://platform.deepseek.com/docs)
- [API Status Dashboard](https://status.deepseek.com)
- [Pricing Calculator](https://www.deepseek.com/pricing-calculator)
- [Rate Limits Guide](https://platform.deepseek.com/docs/rate-limits)

## Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create your feature branch
3. Submit a PR with tests

[📌 Report Issues](https://github.com/habeebrahman021/deepseek_api/issues) | [📖 View Source](https://github.com/habeebrahman021/deepseek_api/repo)

---

*Disclaimer*: This package is not officially affiliated with DeepSeek. Always refer to the [official API documentation](https://platform.deepseek.com/docs) for the most accurate information.

