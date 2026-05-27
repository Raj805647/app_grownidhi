import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/individual_dashboard_response.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeProvider extends BaseProvider {
  IndividualDashboardData individualDashboardData = IndividualDashboardData();
  bool isLoad = false;

  String _userName = "Rimjhim Kumar";

  String get userName => _userName;

  final List<FlSpot> graphSpots = const [
    FlSpot(0, 2),
    FlSpot(1, 3),
    FlSpot(2, 2.5),
    FlSpot(3, 4),
    FlSpot(4, 3.5),
    FlSpot(5, 5),
  ];

  final List<Map<String, dynamic>> portfolioItems = [
    {
      "title": "Insurance",
      "value": "₹12.5L",
      "change": "+8%",
      "color": Colors.blue,
    },
    {
      "title": "Loans",
      "value": "₹8.2L",
      "change": "-5%",
      "color": Colors.purple,
    },
    {
      "title": "Investments",
      "value": "₹5.8L",
      "change": "+12%",
      "color": Colors.green,
    },
    {
      "title": "Credit Cards",
      "value": "4 Active",
      "change": "+1",
      "color": Colors.orange,
    },
  ];

  Future<void> fetchDashboard() async {
    try {
      isLoad = false;
      notifyListeners();

      final response = await authRepository.individualDashboard();
      print('adskfjjkdsbf=> ${response.data}');
      if (response.isSuccess == true) {
        individualDashboardData = IndividualDashboardData.fromJson(
          response.data['data'],
        );
        notifyListeners();
      }
    } catch (error) {
      print('abdfkjbdskj=> $error');
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }
}
