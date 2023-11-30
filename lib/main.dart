import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'NaviBar/NaviModel.dart';
import 'Theme.dart';
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
    Get.put(HomeController());
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

    return Scaffold(
        appBar: AppBar(
          title:Obx(()=> Text(HomeModel.title[Get.find<HomeController>().currentIndex.value])),
          ),

        body: PageView(
          controller: Get.find<HomeController>().pageController,
          children: [
            const PromptPage(),
            const ChatPage(),
            SettingPage(),
          ],
          onPageChanged: (index) {
            Get.find<HomeController>().currentIndex.value = index;
          },
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: Get.find<HomeController>().currentIndex.value,
          onTap: (index) {
            Get.find<HomeController>().changePage(index);
          },
          items: const [
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
        ))
    );


  }
}

class HomeController extends  GetxController{
  var currentIndex = 0.obs;
  var pageController = PageController();
  void changePage(int index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}

class HomeModel extends ChangeNotifier{
 static List<String> title = ['Prompt', 'Chat', 'Settings'];
}



class Body extends StatelessWidget {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {

      return PageView(
        children: [
          PromptPage(),
          ChatPage(),
          SettingPage(),
        ],
        onPageChanged: (index) {

        },
      );

  }
}
