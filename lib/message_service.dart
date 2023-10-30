import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt_client/model/entities.dart';
import 'package:get/utils.dart';

import 'prompt_service.dart';

class MessageModel {

  MessageModel();

  String conversationId = "";
   getMessages(ValueChanged<Message> onResponse, ValueChanged<Message> onError, ValueChanged<Message> onSuccess) async {
    // Mock data
    List<Message> messages = [Message(conversationId: "lalala", text: "nihao", role:Role.assistant )];
    ChatGpt().getResponse(messages, onResponse,onError,onSuccess);
  }

   Future<OpenAIChatCompletionModel> getMessagesSync(String  text) async {
    List<Message> messages = [Message(conversationId: this.conversationId, text: text, role:Role.assistant )];
    return ChatGpt().getResponseSync(messages);
  }

   MessageModel._internal() {
     _init();
  }

  void _init(){
    ChatGpt().init();
  }
}

