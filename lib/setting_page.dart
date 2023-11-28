import 'package:chat_gpt_client/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'TokenManager.dart';

class SettingPage extends StatelessWidget {
  SettingController controller = Get.put(SettingController());



  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: TextEditingController(text: controller.token),

                  decoration: const InputDecoration(
                    labelText: 'Token',
                    hintText: 'Enter your token',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: controller.url),
                  decoration: const InputDecoration(
                    labelText: 'BaseUrl',
                    hintText: 'Enter your baseUrl',
                  ),
                ),
                const SizedBox(height: 16.0),
                ChatModel(),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {

                    SettingDataSource.saveUrl(controller.url);// 保存 url
                    SettingDataSource.saveToken(controller.token);// 保存 token
                  },
                ),
                const SizedBox(height: 16.0),
                Consumer<ThemeModel>(builder: (context, theme, child) {
                  return ElevatedButton(
                    child: const Text('Switch Theme'),
                    onPressed: () {
                      theme.switchTheme();
                    },
                  );
                })
              ]),
        );
      },
    );
  }
}

class ChatModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Model"),
              DropdownButton(
                value: controller.model,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  controller.changeModel(newValue!);
                },
                items: SettingDataSource.getModelList()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }
}

class SettingController extends GetxController {
  String token = "";
  String url = "";
  String model = "";

  @override
  void onInit() {
    super.onInit();
    debugPrint("ChatModelController onInit");
    token = SettingDataSource.readToken() ?? '';
    url = SettingDataSource.readUrl() ?? '';
    model = SettingDataSource.readModel() ?? 'gpt-3.5turbo';
  }

  void changeModel(String model) {
    this.model = model;
    update();
    SettingDataSource.saveModel(model);
  }

}
