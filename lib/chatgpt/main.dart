import 'package:chat_gpt_client/chatgpt/Theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt_client/chatgpt/chat_page.dart';
import 'package:chat_gpt_client/chatgpt/prompt_page.dart';
import 'package:chat_gpt_client/chatgpt/setting_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   var window = WidgetsBinding.instance.window;
   window.onPlatformBrightnessChanged = (){
      Provider.of<ThemeProvider>(context, listen: false).changeThemeModeBySystem(context);
   };


    return MaterialApp(
     // title: 'Your App Name Here',
     theme: Provider.of<ThemeProvider>(context).current,
      home: HomePage(),
     /* routes: {
        // 页面路由
        PromptPage.routeName: (context) => PromptPage(),
        ChatPage.routeName: (context) => ChatPage(),
        SettingPage.routeName: (context) => SettingPage(),
      },*/
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    PromptPage(),
    ChatPage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    print('onItemTaped');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Prompt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
