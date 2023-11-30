import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class NaviModel extends ChangeNotifier {

  List<BottomNavigationBarItem> navigationItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Prompt'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),

  ];
}











