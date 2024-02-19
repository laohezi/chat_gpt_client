import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt_client/model/entities.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:uuid/uuid.dart';

import 'prompt_service.dart';

class MessageModel {
  MessageModel(){
    _init();
  }

  var history = [].obs;
  var currentMessage = "nihao".obs;

// use uuid as conversation id
  String conversationId = Uuid().v4();

  getMessages(String text) async {
    // add message to history
    var messages = [];
    messages.addAll(history.value);
    messages.add(Message(
      text: text,
      conversationId: conversationId,
      role: Role.user,
    ));
    ChatGpt().getResponse(messages).listen((event) {
       String content = event.choices.first.delta.content?.first.text ?? "";
       currentMessage.value = content;
       debugPrint(content);
    },onDone: (){
      history.add(Message(text: currentMessage.value, role: Role.assistant));
    },onError: (e){
      debugPrint(e.toString());
    });
  }

  MessageModel._internal() {
    _init();
  }

  void _init() {
    ChatGpt().init();
  }
}
