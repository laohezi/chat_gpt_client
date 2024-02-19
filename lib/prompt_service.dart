import 'package:chat_gpt_client/SettingDataSource.dart';
import 'package:chat_gpt_client/setting_page.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_gpt_client/model/entities.dart';
import 'package:get/get.dart';



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



class ChatGpt{
 SettingDataSource settingDataSource = Get.find<SettingDataSource>();
  ChatGpt._privateConstructor();
  static final ChatGpt _instance = ChatGpt._privateConstructor();
  factory ChatGpt() {
    return _instance;
  }

 Stream<OpenAIStreamChatCompletionModel> getResponse(List messages) {
    List<OpenAIChatCompletionChoiceMessageModel> ms = [];
    for (Message message in messages) {
      ms.insert(
          0,
          message.asOpenAIChatCompletionChoiceMessageModel);
    }
    Stream<OpenAIStreamChatCompletionModel> stream =
        OpenAI.instance.chat.createStream(model: settingDataSource.readModel() , messages: ms);
    return stream;
  }

  init() {
    OpenAI.showLogs = true;
    OpenAI.baseUrl = settingDataSource.readUrl();
    OpenAI.apiKey = settingDataSource.readToken();
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

extension Convert2 on Message {
  OpenAIChatCompletionChoiceMessageModel get asOpenAIChatCompletionChoiceMessageModel {
    return OpenAIChatCompletionChoiceMessageModel(
      role: role.asOpenAIChatMessageRole,
      content:[
       OpenAIChatCompletionChoiceMessageContentItemModel.text(text)
      ] ,
    );
  }
}


