import 'package:flutter/material.dart';

import 'TokenManager.dart';


class SettingPage extends StatefulWidget {
  static const routeName = '/setting'; // 页面路由名称

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _textEditingController =
  TextEditingController();
  String _token = '';

  @override
  void initState() async {
    super.initState();
    // 读取已经持久化的 token
    String token =  TokenManager.readToken();
    _textEditingController.text = token;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textEditingController,

              decoration: InputDecoration(
                labelText: 'Token',

                hintText: 'Enter your token',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final token = _textEditingController.text;
                TokenManager.saveToken(token); // 保存 token
               // Navigator.pop(context); // 返回上一个页面
              },
            )
          ],
        ),
      ),
    );
  }
}




