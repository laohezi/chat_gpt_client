import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chat_gpt_client/prompt_service.dart';

class PromptPage extends StatelessWidget {
  static const routeName = '/prompt';

  const PromptPage({super.key}); // 页面路由名称

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: PromptList(),
    );
  }
}

class PromptList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PromptListState createState() => _PromptListState();
}

class _PromptListState extends State<PromptList> {
  List<String> _prompts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("init state for promp page");
    _getPrompts();
  }

  Future<void> _getPrompts() async {
    final prompts = await PromptService.getPrompts();
    setState(() {
      _prompts = prompts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading // 根据加载状态显示不同的 Widget
          ? const CircularProgressIndicator()
          : _buildPromptList(),
    );
  }

  Widget _buildPromptList() {
    return ListView.builder(
      itemCount: _prompts.length,
      itemBuilder: (context, index) {
        return Card(
            // 使用 Card 包装 ListTile
            child: ListTile(
          title: Text(_prompts[index]),
          onTap: () {
            final prompt = _prompts[index];
            // Do something with selected prompt
          },
        ));
      },
    );
  }
}
