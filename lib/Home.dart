import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(
        child: Text("Home"),
      ),
      bottomNavigationBar: BottomNavaigation(),
    );
  }
}

// ignore: must_be_immutable
class BottomNavaigation extends StatefulWidget {
  ValueChanged<int>? onTabTapped;
  BottomNavaigation({super.key, this.onTabTapped});
  @override
  State<StatefulWidget> createState() {
    return BottomNavaigationState();
  }
}

class BottomNavaigationState extends State<BottomNavaigation> {
  var selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Promp",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      currentIndex: selectIndex,
      onTap: (index) {
        setState(() {
          selectIndex = index;
        });
      },
    );
  }
}
