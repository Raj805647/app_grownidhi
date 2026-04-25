import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class CalenderProvider extends BaseProvider {
  int selectedDay = 16;

  late AnimationController controller;

  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // 🔥 continuous animation
  }

  void selectDay(int day) {
    selectedDay = day;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
