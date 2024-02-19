import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt_client/model/entities.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:uuid/uuid.dart';

import 'prompt_service.dart';

class MessageModel {
  MessageModel();

  List<Message> history = [];
  var currentMessage = "".obs;

// use uuid as conversation id
  String conversationId = Uuid().v4();

  getMessages() async {
    // Mock data
    List<Message> messages = [];
    ChatGpt().getResponse(messages).listen((event) {

    },onDone: (){

    },onError: (){});
  }

  MessageModel._internal() {
    _init();
  }

  void _init() {
    ChatGpt().init();
  }
}
