import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'message_service.dart';
import 'model/entities.dart';

class ChatPage extends StatelessWidget {
  static const routeName = '/chat';
  MessageModel model  = Get.put(MessageModel());
  ChatPageController controller = Get.put(ChatPageController());



  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatPageController>(
      builder: (_) {
        return Column(children: [
           Expanded(
            child: Obx(() => ListView.builder(
              itemCount: model.history.length,
              itemBuilder: (context, index) {
                return Text(model.history[index].text);
              },
            ).build(context))
          ),
        //输入框和发送button
        Obx(() => Text(model.currentMessage.value)),
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
          ElevatedButton(onPressed: () {
            controller.sendRequest();
          }, child: const Text("Send"))
        ])
        ]);
      },
    );
  }
}

class ChatPageController extends GetxController {
  final messageController = TextEditingController();
  final messageList = <Message>[].obs;
  final model = Get.find<MessageModel>();


  void sendRequest(){
    model.getMessages(messageController.text);
  }


}
