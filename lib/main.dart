import 'package:chat_gpt_client/SettingDataSource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Theme.dart';
import 'chat_page.dart';
import 'prompt_page.dart';
import 'setting_page.dart';

void main() async{
  GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    Get.put(SettingDataSource());
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
    HomeController homeController = Get.find<HomeController>();

    return Scaffold(
        appBar: AppBar(
          title: Obx(
              () => Text(HomeModel.title[homeController.currentIndex.value])),
        ),
        body: PageView(
          controller: homeController.pageController,
          children: [
            const PromptPage(),
            ChatPage(),
            SettingPage(),
          ],
          onPageChanged: (index) {
            homeController.currentIndex.value = index;
          },
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: homeController.currentIndex.value,
              onTap: (index) {
                homeController.changePage(index);
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
            )));
  }
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var pageController = PageController();

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }
}

class HomeModel {
  static List<String> title = ['Prompt', 'Chat', 'Settings'];
}
