import 'package:chat_gpt_client/chatgpt/Theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_gpt_client/chatgpt/NaviBar/NaviModel.dart';

import 'chat_page.dart';
import 'prompt_page.dart';
import 'setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Chat GPT Client',
              theme: themeProvider.getCurrent(),
              home: const HomePage(),
            );
          },
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NaviModel()),
        ChangeNotifierProvider(create: (context) => HomeModel())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Consumer2<NaviModel, HomeModel>(
            builder: (context, naviModel, homeModel, child) {
              return Text(homeModel.title[naviModel.selectedIndex]);
            },
          ),
        ),
        body: Consumer<NaviModel>(
          builder: (context, naviModel, child) {
            return IndexedStack(
              index: naviModel.selectedIndex,
              children: [PromptPage(), ChatPage(), SettingPage()],
            );
          },
        ),
        bottomNavigationBar: BottomNavi(),
      ),
    );
  }
}

class HomeModel extends ChangeNotifier {
  List<String> title = ['Prompt', 'Chat', 'Settings'];
}
