import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'message_service.dart';

class ChatPage extends StatelessWidget {
  static const routeName = '/chat';
  ChatPageController controller = Get.put(ChatPageController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatPageController>(
      builder: (_) {
        return Column(children: [
          const Expanded(
            child:Text("lala"),
          ),
        //输入框和发送button
        Row(children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: const InputDecoration(
                hintText: "Enter message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )
              ),
            )
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Send"))
        ])
        ]);
      },
    );
  }
}

class ChatPageController extends GetxController {
  final messageController = TextEditingController();
  final model = MessageModel();


}
