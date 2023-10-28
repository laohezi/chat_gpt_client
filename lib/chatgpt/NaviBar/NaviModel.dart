import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NaviModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Prompt'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}


class BottomNavi extends StatelessWidget {
  const BottomNavi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NaviModel>(
          builder: (context, naviModel, child) {
            return BottomNavigationBar(
              items: naviModel.navigationItems,
              currentIndex: naviModel.selectedIndex,
              onTap: (index) {
                naviModel.setIndex(index);
              },

            );
          },
        );
    // TODO: implement build
  }
}








