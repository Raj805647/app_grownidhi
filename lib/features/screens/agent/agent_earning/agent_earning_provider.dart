import 'package:base_module/base_module.dart';

// lib/providers/agent_earning_provider.dart
import 'package:flutter/material.dart';

class AgentEarningProvider extends ChangeNotifier {
  bool isLoading = false;

  int selectedChartIndex = 0;

  Map<String, dynamic> commissionSummary = {};

  List<Map<String, dynamic>> monthlyEarnings = [];


  List<Map<String, dynamic>> revenueSources = [
    {
      'source': 'Life Insurance',
      'amount': '25,000',
      'percentage': 45,
      'color': 0xFF6C63FF,
    },
    {
      'source': 'Health Insurance',
      'amount': '15,000',
      'percentage': 27,
      'color': 0xFF4CAF50,
    },
    {
      'source': 'Motor Insurance',
      'amount': '8,500',
      'percentage': 15,
      'color': 0xFFFF9800,
    },
    {
      'source': 'Travel Insurance',
      'amount': '7,200',
      'percentage': 13,
      'color': 0xFFE91E63,
    },
  ];
}
