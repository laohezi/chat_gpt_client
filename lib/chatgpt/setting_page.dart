import 'package:flutter/material.dart';

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
    String  url = 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
