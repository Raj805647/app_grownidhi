import 'package:base_module/base_module.dart';

class AgentReportProvider extends BaseProvider {
  bool _isLoading = false;
  String? _error;
  String _selectedReportType = 'Client Portfolio';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedReportType => _selectedReportType;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  // Report Data
  final List<Map<String, dynamic>> reportTypes = [
    {'icon': '📋', 'title': 'Client Portfolio Report', 'description': 'Complete client analysis and portfolio summary', 'color': 0xFF6C63FF},
    {'icon': '📊', 'title': 'Business MIS Report', 'description': 'Management information system data', 'color': 0xFF4CAF50},
    {'icon': '💰', 'title': 'Commission Report', 'description': 'Detailed commission breakdown', 'color': 0xFFFF9800},
    {'icon': '📈', 'title': 'Performance Report', 'description': 'Agent performance metrics', 'color': 0xFFE91E63},
    {'icon': '🔄', 'title': 'Renewal Report', 'description': 'Upcoming and completed renewals', 'color': 0xFF9C27B0},
    {'icon': '⚠️', 'title': 'Overdue Report', 'description': 'Overdue policies and follow-ups', 'color': 0xFFF44336},
  ];

  final List<Map<String, dynamic>> savedReports = [
    {'name': 'Q4 Client Analysis', 'date': '2024-11-15', 'type': 'Client Portfolio', 'size': '2.4 MB'},
    {'name': 'October Commission Summary', 'date': '2024-11-01', 'type': 'Commission', 'size': '1.8 MB'},
    {'name': 'Annual Performance 2024', 'date': '2024-10-30', 'type': 'Performance', 'size': '3.2 MB'},
  ];

  void setSelectedReportType(String type) {
    _selectedReportType = type;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  Future<void> generateReport() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> exportData(String format) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}