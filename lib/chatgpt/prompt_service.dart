import 'package:chat_gpt_client/chatgpt/setting_page.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_gpt_client/model/entities.dart';

import 'TokenManager.dart';

class PromptService {
  static Future<List<String>> getPrompts() async {
    // Mock data
    return Future.delayed(Duration(seconds: 1), () {
      return [
        'What is your favorite hobby?',
        'What is your favorite color?',
        'What is your favorite food?',
      ];
    });
  }
}

abstract class LLM {
  getResponse(List<Message> messages, ValueChanged<Message> onResponse,
      ValueChanged<Message> onError, ValueChanged<Message> onSuccess);
  Future<OpenAIChatCompletionModel> getResponseSync(List<Message> messages);
  init();
}

class ChatGpt extends LLM {
  static final ChatGpt _instance = ChatGpt();
  factory ChatGpt() {
    return _instance;
  }

  @override
  getResponse(List<Message> messages, ValueChanged<Message> onResponse,
      ValueChanged<Message> onError, ValueChanged<Message> onSuccess) {
    OpenAI.instance.model.list();

    List<OpenAIChatCompletionChoiceMessageModel> ms = [];
    String content = "";
    for (Message message in messages) {
      content = content + message.text;
      ms.insert(
          0,
          OpenAIChatCompletionChoiceMessageModel(
              role: message.role.asOpenAIChatMessageRole,
              content: message.text));
    }
    var message = Message(conversationId: "", text: "", role: Role.assistant);
    Stream<OpenAIStreamChatCompletionModel> stream =
        OpenAI.instance.chat.createStream(model: 'gpt-3.5-turbo', messages: ms);

    stream.listen((event) {
      if (event.choices.first.delta.content != null) {
        message.text = message.text + event.choices.first.delta.content!;
        onResponse(message);
      }
    }, onDone: () {
      onSuccess(message);
    });
  }

  @override
  init() {
    OpenAI.baseUrl = "https://oa.api2d.net";
    OpenAI.apiKey = SettingDataSource.readToken();
  }

  @override
  Future<OpenAIChatCompletionModel> getResponseSync(List<Message> messages) {
    OpenAI.instance.model.list();

    List<OpenAIChatCompletionChoiceMessageModel> ms = [];
    String content = "";
    for (Message message in messages) {
      content = content + message.text;
      ms.insert(
          0,
          OpenAIChatCompletionChoiceMessageModel(
              role: message.role.asOpenAIChatMessageRole,
              content: message.text));
    }
    var message = Message(conversationId: "", text: "", role: Role.assistant);
    return OpenAI.instance.chat.create(model: 'gpt-3.5-turbo', messages: ms);
  }
}

extension Convert on Role {
  OpenAIChatMessageRole get asOpenAIChatMessageRole {
    switch (this) {
      case Role.system:
        return OpenAIChatMessageRole.system;

      case Role.user:
        return OpenAIChatMessageRole.user;

      case Role.assistant:
        return OpenAIChatMessageRole.assistant;
    }
  }
}
