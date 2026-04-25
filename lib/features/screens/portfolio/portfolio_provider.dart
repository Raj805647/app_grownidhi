import 'package:base_module/base_module.dart';

import 'package:flutter/material.dart';

class PortfolioProvider extends BaseProvider {
  final List<String> filters = [
    "All",
    "Insurance",
    "Loans",
    "Investments",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "avatar": "H",
      "title": "HDFC Life Insurance",
      "subtitle": "HDFC Life",
      "amount": "₹12,500",
      "payment": "15 Mar 2026",
      "color": Colors.blue,
    },
    {
      "avatar": "H",
      "title": "Home Loan",
      "subtitle": "ICICI Bank",
      "amount": "₹45,000",
      "payment": "22 Feb 2026",
      "color": Colors.purple,
    },
    {
      "avatar": "S",
      "title": "SBI Bluechip Fund",
      "subtitle": "SBI Mutual Fund",
      "amount": "₹5,000",
      "payment": "SIP Active",
      "color": Colors.green,
    },
  ];

  String selectedFilter = "All";

  void changeFilter(String value) {
    selectedFilter = value;
    notifyListeners();
  }
}