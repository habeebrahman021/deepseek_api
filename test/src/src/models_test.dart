import 'package:deepseek_api/deepseek_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatMessage', () {
    test('toJson test', () {
      final message = ChatMessage(role: "user", content: "Hello!");

      final json = message.toJson();

      expect(json, {"role": "user", "content": "Hello!"});
    });

    test('fromJson test', () {
      final json = {"role": "user", "content": "Hello!"};

      final message = ChatMessage.fromJson(json);

      expect(message.role, "user");
      expect(message.content, "Hello!");
    });
  });

  group('ChatCompletionRequest', () {
    test('toJson test', () {
      final request = ChatCompletionRequest(
        model: "deepseek",
        messages: [ChatMessage(role: "user", content: "Hello!")],
        temperature: 0.7,
        maxTokens: 100,
        topP: 1.0,
        frequencyPenalty: 0.0,
        presencePenalty: 0.0,
        stop: ["\n"],
        stream: false,
        user: "123",
      );

      final json = request.toJson();

      expect(json, {
        "model": "deepseek",
        "messages": [
          {"role": "user", "content": "Hello!"}
        ],
        "temperature": 0.7,
        "max_tokens": 100,
        "top_p": 1.0,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": ["\n"],
        "stream": false,
        "user": "123"
      });
    });

    test('fromJson test', () {
      final json = {
        "model": "deepseek",
        "messages": [
          {"role": "user", "content": "Hello!"}
        ],
        "temperature": 0.7,
        "max_tokens": 100,
        "top_p": 1.0,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": ["\n"],
        "stream": false,
        "user": "123"
      };

      final request = ChatCompletionRequest.fromJson(json);

      expect(request.model, "deepseek");
      expect(request.messages.length, 1);
      expect(request.messages[0].role, "user");
      expect(request.messages[0].content, "Hello!");
      expect(request.temperature, 0.7);
      expect(request.maxTokens, 100);
      expect(request.topP, 1.0);
      expect(request.frequencyPenalty, 0.0);
      expect(request.presencePenalty, 0.0);
      expect(request.stop, ["\n"]);
      expect(request.stream, false);
      expect(request.user, "123");
    });
  });

  group('ChatCompletionResponse', () {
    test('toJson test', () {
      final response = ChatCompletionResponse(
        id: "123",
        object: "chat.completion",
        created: 1677664799,
        model: "deepseek",
        choices: [
          ChatChoice(
            index: 0,
            message: ChatMessage(role: "assistant", content: "Hi there!"),
            finishReason: "stop",
          )
        ],
        usage: Usage(
          promptTokens: 10,
          completionTokens: 20,
          totalTokens: 30,
        ),
      );

      final json = response.toJson();

      expect(json, {
        "id": "123",
        "object": "chat.completion",
        "created": 1677664799,
        "model": "deepseek",
        "choices": [
          {
            "index": 0,
            "message": {"role": "assistant", "content": "Hi there!"},
            "finish_reason": "stop"
          }
        ],
        "usage": {
          "prompt_tokens": 10,
          "completion_tokens": 20,
          "total_tokens": 30
        }
      });
    });

    test('fromJson test', () {
      final json = {
        "id": "123",
        "object": "chat.completion",
        "created": 1677664799,
        "model": "deepseek",
        "choices": [
          {
            "index": 0,
            "message": {"role": "assistant", "content": "Hi there!"},
            "finish_reason": "stop"
          }
        ],
        "usage": {
          "prompt_tokens": 10,
          "completion_tokens": 20,
          "total_tokens": 30
        }
      };

      final response = ChatCompletionResponse.fromJson(json);

      expect(response.id, "123");
      expect(response.object, "chat.completion");
      expect(response.created, 1677664799);
      expect(response.model, "deepseek");
      expect(response.choices.length, 1);
      expect(response.choices[0].index, 0);
      expect(response.choices[0].message.role, "assistant");
      expect(response.choices[0].message.content, "Hi there!");
      expect(response.choices[0].finishReason, "stop");
      expect(response.usage?.promptTokens, 10);
      expect(response.usage?.completionTokens, 20);
      expect(response.usage?.totalTokens, 30);
    });
  });

  group('ChatChoice', () {
    test('toJson test', () {
      final choice = ChatChoice(
        index: 0,
        message: ChatMessage(role: "assistant", content: "Hi there!"),
        finishReason: "stop",
      );

      final json = choice.toJson();

      expect(json, {
        "index": 0,
        "message": {"role": "assistant", "content": "Hi there!"},
        "finish_reason": "stop"
      });
    });

    test('fromJson test', () {
      final json = {
        "index": 0,
        "message": {"role": "assistant", "content": "Hi there!"},
        "finish_reason": "stop"
      };

      final choice = ChatChoice.fromJson(json);

      expect(choice.index, 0);
      expect(choice.message.role, "assistant");
      expect(choice.message.content, "Hi there!");
      expect(choice.finishReason, "stop");
    });
  });

  group('Usage', () {
    test('toJson test', () {
      final usage = Usage(
        promptTokens: 10,
        completionTokens: 20,
        totalTokens: 30,
      );

      final json = usage.toJson();

      expect(json,
          {"prompt_tokens": 10, "completion_tokens": 20, "total_tokens": 30});
    });

    test('fromJson test', () {
      final json = {
        "prompt_tokens": 10,
        "completion_tokens": 20,
        "total_tokens": 30
      };

      final usage = Usage.fromJson(json);

      expect(usage.promptTokens, 10);
      expect(usage.completionTokens, 20);
      expect(usage.totalTokens, 30);
    });
  });

  group('ModelsListResponse', () {
    test('toJson test', () {
      final response = ModelsListResponse(
        data: [
          ModelData(id: "model-1", object: "model", ownedBy: "openai"),
          ModelData(id: "model-2", object: "model", ownedBy: "deepseek"),
        ],
      );

      final json = response.toJson();

      expect(json, {
        "data": [
          {"id": "model-1", "object": "model", "owned_by": "openai"},
          {"id": "model-2", "object": "model", "owned_by": "deepseek"}
        ]
      });
    });

    test('fromJson test', () {
      final json = {
        "data": [
          {"id": "model-1", "object": "model", "owned_by": "openai"},
          {"id": "model-2", "object": "model", "owned_by": "deepseek"}
        ]
      };

      final response = ModelsListResponse.fromJson(json);

      expect(response.data.length, 2);
      expect(response.data[0].id, "model-1");
      expect(response.data[0].object, "model");
      expect(response.data[0].ownedBy, "openai");
      expect(response.data[1].id, "model-2");
      expect(response.data[1].object, "model");
      expect(response.data[1].ownedBy, "deepseek");
    });
  });

  group('ModelData', () {
    test('toJson test', () {
      final model = ModelData(
        id: "model-1",
        object: "model",
        ownedBy: "openai",
      );

      final json = model.toJson();

      expect(json, {"id": "model-1", "object": "model", "owned_by": "openai"});
    });

    test('fromJson test', () {
      final json = {"id": "model-1", "object": "model", "owned_by": "openai"};

      final model = ModelData.fromJson(json);

      expect(model.id, "model-1");
      expect(model.object, "model");
      expect(model.ownedBy, "openai");
    });
  });
}
