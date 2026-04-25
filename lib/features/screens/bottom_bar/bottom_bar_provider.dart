import 'package:base_module/base_module.dart';

import 'package:flutter/material.dart';

class BottomBarProvider extends BaseProvider {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeTab(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }
}