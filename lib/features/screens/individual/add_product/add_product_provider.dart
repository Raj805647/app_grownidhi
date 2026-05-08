import 'package:base_module/base_module.dart';

import 'package:flutter/material.dart';

class AddProductProvider extends BaseProvider {
  late AnimationController animationController;

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.shield_outlined,
      "title": "Insurance",
      "color": Colors.blue,
    },
    {
      "icon": Icons.account_balance_wallet,
      "title": "Loan",
      "color": Colors.purple,
    },
    {
      "icon": Icons.trending_up,
      "title": "Mutual Fund",
      "color": Colors.green,
    },
    {
      "icon": Icons.credit_card,
      "title": "Credit Card",
      "color": Colors.orange,
    },
    {
      "icon": Icons.home,
      "title": "Property",
      "color": Colors.red,
    },
    {
      "icon": Icons.directions_car,
      "title": "Vehicle",
      "color": Colors.deepPurple,
    },
  ];

  void init(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 900),
    );

    animationController.forward();
    notifyListeners();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}