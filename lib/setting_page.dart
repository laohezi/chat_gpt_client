import 'package:chat_gpt_client/Theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TokenManager.dart';



class SettingPage extends StatefulWidget {
  static const routeName = '/setting';

  const SettingPage({super.key}); // 页面路由名称

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 读取已经持久化的 token
    String token = SettingDataSource.readToken();
    _textEditingController.text = token;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Token',
                hintText: 'Enter your token',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final token = _textEditingController.text;
                SettingDataSource.saveToken(token); // 保存 token
                // Navigator.pop(context); // 返回上一个页面
              },
            ),
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
