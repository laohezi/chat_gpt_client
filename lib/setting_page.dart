import 'package:chat_gpt_client/Theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TokenManager.dart';

class SettingPage extends StatelessWidget {
  final TextEditingController _tokeTextController = TextEditingController();
  final TextEditingController _urlTextController = TextEditingController();

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    _tokeTextController.text = SettingDataSource.readToken() ?? '';
    _urlTextController.text = SettingDataSource.readUrl() ?? '';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _tokeTextController,
              decoration: const InputDecoration(
                labelText: 'Token',
                hintText: 'Enter your token',
              ),
            ),
            TextField(
              controller: _urlTextController,
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
                final token = _tokeTextController.text;
                SettingDataSource.saveToken(token); // 保存 token
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
  }
}

class ChatModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      padding: const EdgeInsets.symmetric(horizontal:80),
      items: SettingDataSource.getModelList()
          .map((e) => DropdownMenuItem(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Text(e),
                )
              ))
          .toList(),
      onChanged: (value) {
        SettingDataSource.saveModel(value!);
      },
    );
  }
}
