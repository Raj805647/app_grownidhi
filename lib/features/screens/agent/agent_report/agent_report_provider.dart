import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class AgentReportProvider extends BaseProvider {
  bool isLoading = false;

  String selectedReport = "Client Report";

  DateTime startDate = DateTime.now().subtract(
    const Duration(days: 30),
  );

  DateTime endDate = DateTime.now();

  List<Map<String, dynamic>> reportTypes = [
    {
      "title": "Client Report",
      "icon": Icons.people,
    },

    {
      "title": "Commission",
      "icon": Icons.currency_rupee,
    },

    {
      "title": "Performance",
      "icon": Icons.bar_chart,
    },

    {
      "title": "Renewal",
      "icon": Icons.refresh,
    },
  ];

  List<Map<String, dynamic>> reports = [
    {
      "name": "Commission Summary",
      "date": "12 May 2026",
      "size": "2.4 MB",
    },

    {
      "name": "Client Analysis",
      "date": "09 May 2026",
      "size": "3.1 MB",
    },
  ];

  void setReport(String title) {
    selectedReport = title;
    notifyListeners();
  }

  Future<void> generateReport() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }
}