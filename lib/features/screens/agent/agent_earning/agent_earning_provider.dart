import 'package:base_module/base_module.dart';

// lib/providers/agent_earning_provider.dart
import 'package:flutter/material.dart';

class AgentEarningProvider extends BaseProvider {
  bool _isLoading = false;
  String? _error;
  int _selectedYear = 2024;
  String _selectedPeriod = 'This Year';
  int _selectedChartIndex = 0; // 0: Earnings, 1: Policies

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get selectedYear => _selectedYear;
  String get selectedPeriod => _selectedPeriod;
  int get selectedChartIndex => _selectedChartIndex;

  // Commission Summary Data
  final Map<String, dynamic> commissionSummary = {
    'totalCommission': 12450,
    'thisMonth': 4320,
    'lastMonth': 3890,
    'averageMonthly': 1037,
    'growth': 12.5,
    'totalPolicies': 147,
    'activeClients': 89,
    'conversionRate': 68,
    'yearlyTarget': 50000,
    'yearlyProgress': 24800,
  };

  // Pending Commissions
  final List<Map<String, String>> pendingCommissions = [
    {
      'id': 'COM-001',
      'clientName': 'John Anderson',
      'policyType': 'Life Insurance',
      'policyNumber': 'POL-001',
      'amount': '1,250',
      'date': '2024-11-15',
      'status': 'pending',
      'expectedDate': '2024-12-15',
      'stage': 'Under Review',
    },
    {
      'id': 'COM-002',
      'clientName': 'Sarah Johnson',
      'policyType': 'Health Insurance',
      'policyNumber': 'POL-002',
      'amount': '890',
      'date': '2024-11-18',
      'status': 'processing',
      'expectedDate': '2024-12-10',
      'stage': 'Approval Pending',
    },
    {
      'id': 'COM-003',
      'clientName': 'Michael Chen',
      'policyType': 'Auto Insurance',
      'policyNumber': 'POL-003',
      'amount': '2,340',
      'date': '2024-11-20',
      'status': 'pending',
      'expectedDate': '2024-12-20',
      'stage': 'Documentation',
    },
    {
      'id': 'COM-004',
      'clientName': 'Emily Davis',
      'policyType': 'Home Insurance',
      'policyNumber': 'POL-004',
      'amount': '1,890',
      'date': '2024-11-22',
      'status': 'pending',
      'expectedDate': '2024-12-22',
      'stage': 'Quality Check',
    },
    {
      'id': 'COM-005',
      'clientName': 'Robert Wilson',
      'policyType': 'Term Life',
      'policyNumber': 'POL-005',
      'amount': '3,200',
      'date': '2024-11-10',
      'status': 'processing',
      'expectedDate': '2024-12-05',
      'stage': 'Final Review',
    },
  ];

  // Monthly Earnings Data
  final List<Map<String, dynamic>> monthlyEarnings = [
    {'month': 'Jan', 'amount': 2850, 'policies': 12, 'target': 3000},
    {'month': 'Feb', 'amount': 3100, 'policies': 14, 'target': 3000},
    {'month': 'Mar', 'amount': 2950, 'policies': 13, 'target': 3200},
    {'month': 'Apr', 'amount': 3400, 'policies': 15, 'target': 3200},
    {'month': 'May', 'amount': 3200, 'policies': 14, 'target': 3400},
    {'month': 'Jun', 'amount': 3650, 'policies': 16, 'target': 3400},
    {'month': 'Jul', 'amount': 3450, 'policies': 15, 'target': 3500},
    {'month': 'Aug', 'amount': 3800, 'policies': 17, 'target': 3500},
    {'month': 'Sep', 'amount': 3950, 'policies': 18, 'target': 3700},
    {'month': 'Oct', 'amount': 4100, 'policies': 19, 'target': 3700},
    {'month': 'Nov', 'amount': 4320, 'policies': 20, 'target': 4000},
    {'month': 'Dec', 'amount': 0, 'policies': 0, 'target': 4200},
  ];

  // Revenue Sources
  final List<Map<String, dynamic>> revenueSources = [
    {'source': 'Life Insurance', 'amount': 8450, 'percentage': 45, 'color': 0xFF6C63FF},
    {'source': 'Health Insurance', 'amount': 5320, 'percentage': 28, 'color': 0xFF4CAF50},
    {'source': 'Auto Insurance', 'amount': 2980, 'percentage': 16, 'color': 0xFFFF9800},
    {'source': 'Home Insurance', 'amount': 2100, 'percentage': 11, 'color': 0xFFE91E63},
  ];

  void setSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void setSelectedPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void setSelectedChartIndex(int index) {
    _selectedChartIndex = index;
    notifyListeners();
  }

  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _isLoading = false;
    notifyListeners();
  }

  double getYearlyProgressPercentage() {
    return (commissionSummary['yearlyProgress'] / commissionSummary['yearlyTarget']) * 100;
  }

  String getFormattedCommission(String key) {
    final value = commissionSummary[key];
    if (value is int) {
      return '\$${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }
    return value.toString();
  }
}