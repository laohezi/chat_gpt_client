import 'package:chat_gpt_client/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'SettingDataSource.dart';

class SettingPage extends StatelessWidget {
  SettingController controller = Get.put(SettingController());
  SettingDataSource settingDataSource = Get.find<SettingDataSource>();
  TextEditingController tokenController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    tokenController.text = settingDataSource.readToken() ;
    urlController.text = settingDataSource.readUrl() ;

    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: tokenController,

                  decoration: const InputDecoration(
                    labelText: 'Token',
                    hintText: 'Enter your token',
                  ),
                ),
                TextField(
                  controller: urlController,
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
                    controller.changeToken(tokenController.text);
                    controller.changeUrl(urlController.text);
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
  SettingDataSource settingDataSource = Get.find<SettingDataSource>();
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
                items: settingDataSource.getModelList()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 12),
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
  SettingDataSource settingDataSource = Get.find<SettingDataSource>();

  @override
  void onInit() {
    super.onInit();
    debugPrint("ChatModelController onInit");
    token = settingDataSource.readToken() ?? '';
    url = settingDataSource.readUrl() ?? '';
    model = settingDataSource.readModel() ?? 'gpt-3.5turbo';
    debugPrint("selected model is $model");
  }

  void changeModel(String model) {
    this.model = model;
    update();
    settingDataSource.saveModel(model);
  }

  void changeUrl(String url){
    this.url = url;
    update();
    settingDataSource.saveUrl(url);
  }
  void changeToken(String token){
    this.token = token;
    update();
    settingDataSource.saveUrl(token);
  }

}
