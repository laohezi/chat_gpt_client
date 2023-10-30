import 'package:flutter/material.dart';

import 'message_service.dart';

class ChatPage extends StatelessWidget {
  static const routeName = '/chat';

  const ChatPage({super.key}); // 页面路由名称

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ChatList(),
    );
  }
}

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  ChatListState createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  final List<String> _messages = [];
  bool _isLoading = false;

  var textEditingController = TextEditingController();
  var model = MessageModel();

  @override
  void initState() {
    super.initState();
    _getMessagesSync();
  }

  Future<void> _getMessages() async {
    final messages = await model.getMessages((message) {
      setState(() {
        /*_isLoading = false;
            _messages.add(message.text);*/
      });
    }, (error) {
      debugPrint(error.text ?? "error");
    }, (success) {
      setState(() {
        _isLoading = false;
        _messages.add(success.text);
      });
    });
  }

  Future<void> _getMessagesSync() async {
    model.getMessagesSync(textEditingController.text).then((value) => {
          setState(() {
            _isLoading = false;
            _messages.add(value.choices.last.message.content);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading // 根据加载状态显示不同的 Widget
          ? const CircularProgressIndicator()
          : _buildChatList(),
    );
  }

  Widget _buildChatList() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                })),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '输入消息',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _getMessagesSync,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
