import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt_client/model/entities.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import 'SettingDataSource.dart';
import 'prompt_service.dart';

class MessageModel {

  MessageModel();
  List<Message> messages = [];
  var currentResponse = "".obs;
// generated uuid
  String conversationId ="" ;
   getMessages(String inputContent) async {
    // Mock data
     messages.add(Message(
       conversationId: conversationId,
       text: inputContent,
       role: Role.user,
     ));
    ChatGpt().getResponse(messages).map((event) => currentResponse.value += event.choices.first.delta.content?.first.text??"").listen((event) {

    },onDone: (){
      messages.add(Message(text: currentResponse.value, role: Role.assistant));
      currentResponse.value = "";
    });
  }



   MessageModel._internal() {
     _init();
  }

  void _init(){
    ChatGpt().init();
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
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text( text)
      ],
    );
  }
}

extension OpenAIChatCompletionMessageModelList on OpenAICompletionModel {


}


abstract class LLM {
  Stream<OpenAIStreamChatCompletionModel> getResponse(List<Message> messages);
  init();
}

class ChatGpt extends LLM {
  SettingDataSource settingDataSource = Get.find<SettingDataSource>();
  ChatGpt._privateConstructor(){
    init();
  }
  static final ChatGpt _instance = ChatGpt._privateConstructor();
  factory ChatGpt() {
    return _instance;
  }


  @override
  Stream<OpenAIStreamChatCompletionModel> getResponse(List<Message> messages) {
    OpenAI.instance.model.list();

    List<OpenAIChatCompletionChoiceMessageModel> ms = [];

    for (Message message in messages) {
      ms.insert(
          0,
        message.asOpenAIChatCompletionChoiceMessageModel);
    }
    Stream<OpenAIStreamChatCompletionModel> stream =
    OpenAI.instance.chat.createStream(model: 'gpt-3.5-turbo', messages: ms);
    return stream;


  }

  @override
  init() {
    OpenAI.baseUrl = settingDataSource.readUrl();
    OpenAI.apiKey = settingDataSource.readToken();
  }

  @override
  Future<Message> getResponseSync(List<Message> messages) {
    // TODO: implement getResponseSync
    throw UnimplementedError();
  }



}



