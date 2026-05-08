import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils.dart';
import '../../../../routes/route_names.dart';

import 'package:flutter/material.dart';

class OnboardingProvider extends BaseProvider {
  final PageController pageController = PageController();

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool get isLastPage => _currentIndex == 2;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
