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





