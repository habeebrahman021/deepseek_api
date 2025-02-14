// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCompletionRequest _$ChatCompletionRequestFromJson(
        Map<String, dynamic> json) =>
    ChatCompletionRequest(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: (json['temperature'] as num?)?.toDouble(),
      maxTokens: (json['max_tokens'] as num?)?.toInt(),
      topP: (json['top_p'] as num?)?.toDouble(),
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble(),
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble(),
      stop: (json['stop'] as List<dynamic>?)?.map((e) => e as String).toList(),
      stream: json['stream'] as bool?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$ChatCompletionRequestToJson(
        ChatCompletionRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'temperature': instance.temperature,
      'max_tokens': instance.maxTokens,
      'top_p': instance.topP,
      'frequency_penalty': instance.frequencyPenalty,
      'presence_penalty': instance.presencePenalty,
      'stop': instance.stop,
      'stream': instance.stream,
      'user': instance.user,
    };

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

ChatCompletionResponse _$ChatCompletionResponseFromJson(
        Map<String, dynamic> json) =>
    ChatCompletionResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      created: (json['created'] as num).toInt(),
      model: json['model'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChatChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatCompletionResponseToJson(
        ChatCompletionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
    };

ChatChoice _$ChatChoiceFromJson(Map<String, dynamic> json) => ChatChoice(
      index: (json['index'] as num).toInt(),
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
      finishReason: json['finish_reason'] as String?,
    );

Map<String, dynamic> _$ChatChoiceToJson(ChatChoice instance) =>
    <String, dynamic>{
      'index': instance.index,
      'message': instance.message.toJson(),
      'finish_reason': instance.finishReason,
    };

Usage _$UsageFromJson(Map<String, dynamic> json) => Usage(
      promptTokens: (json['prompt_tokens'] as num).toInt(),
      completionTokens: (json['completion_tokens'] as num).toInt(),
      totalTokens: (json['total_tokens'] as num).toInt(),
    );

Map<String, dynamic> _$UsageToJson(Usage instance) => <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };

ModelsListResponse _$ModelsListResponseFromJson(Map<String, dynamic> json) =>
    ModelsListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ModelData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelsListResponseToJson(ModelsListResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

ModelData _$ModelDataFromJson(Map<String, dynamic> json) => ModelData(
      id: json['id'] as String,
      object: json['object'] as String,
      ownedBy: json['owned_by'] as String?,
    );

Map<String, dynamic> _$ModelDataToJson(ModelData instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'owned_by': instance.ownedBy,
    };
