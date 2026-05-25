import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class IndividualSettingProvider extends BaseProvider {
  late AnimationController controller;

  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // 🔥 continuous animation
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
