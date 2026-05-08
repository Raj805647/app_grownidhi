import 'package:base_module/base_module.dart';

class AgentPortfolioProvider extends BaseProvider{
  bool _isLoading = false;
  String? _error;
  int _selectedTabIndex = 0;

  bool get isLoading => _isLoading;
  String? get error => _error;
  int get selectedTabIndex => _selectedTabIndex;

  // Direct lists with maps for portfolio data
  final List<Map<String, String>> clientPortfolio = [
  {
  'id': '1',
  'name': 'John Anderson',
  'email': 'john.anderson@email.com',
  'phone': '+1 234 567 8900',
  'totalPolicies': '3',
  'totalPremium': '\$1,250',
  'status': 'active',
  'avatar': 'JA',
  'joinedDate': 'Jan 2024',
  },
  {
  'id': '2',
  'name': 'Sarah Johnson',
  'email': 'sarah.j@email.com',
  'phone': '+1 234 567 8901',
  'totalPolicies': '2',
  'totalPremium': '\$890',
  'status': 'active',
  'avatar': 'SJ',
  'joinedDate': 'Feb 2024',
  },
  {
  'id': '3',
  'name': 'Michael Chen',
  'email': 'michael.chen@email.com',
  'phone': '+1 234 567 8902',
  'totalPolicies': '4',
  'totalPremium': '\$2,340',
  'status': 'active',
  'avatar': 'MC',
  'joinedDate': 'Dec 2023',
  },
  {
  'id': '4',
  'name': 'Emily Davis',
  'email': 'emily.davis@email.com',
  'phone': '+1 234 567 8903',
  'totalPolicies': '1',
  'totalPremium': '\$450',
  'status': 'inactive',
  'avatar': 'ED',
  'joinedDate': 'Mar 2024',
  },
  {
  'id': '5',
  'name': 'Robert Wilson',
  'email': 'robert.w@email.com',
  'phone': '+1 234 567 8904',
  'totalPolicies': '3',
  'totalPremium': '\$1,890',
  'status': 'active',
  'avatar': 'RW',
  'joinedDate': 'Nov 2023',
  },
  ];

  final List<Map<String, String>> policies = [
  {
  'id': 'POL-001',
  'type': 'Life Insurance',
  'clientName': 'John Anderson',
  'premium': '\$450',
  'coverage': '\$250,000',
  'startDate': '2024-01-15',
  'endDate': '2034-01-15',
  'status': 'active',
  'icon': '🛡️',
  },
  {
  'id': 'POL-002',
  'type': 'Health Insurance',
  'clientName': 'Sarah Johnson',
  'premium': '\$320',
  'coverage': '\$100,000',
  'startDate': '2024-02-10',
  'endDate': '2025-02-10',
  'status': 'active',
  'icon': '🏥',
  },
  {
  'id': 'POL-003',
  'type': 'Auto Insurance',
  'clientName': 'Michael Chen',
  'premium': '\$280',
  'coverage': '\$50,000',
  'startDate': '2023-12-05',
  'endDate': '2024-12-05',
  'status': 'active',
  'icon': '🚗',
  },
  {
  'id': 'POL-004',
  'type': 'Home Insurance',
  'clientName': 'Emily Davis',
  'premium': '\$380',
  'coverage': '\$300,000',
  'startDate': '2024-03-20',
  'endDate': '2025-03-20',
  'status': 'pending',
  'icon': '🏠',
  },
  {
  'id': 'POL-005',
  'type': 'Term Life',
  'clientName': 'Robert Wilson',
  'premium': '\$620',
  'coverage': '\$500,000',
  'startDate': '2023-11-01',
  'endDate': '2033-11-01',
  'status': 'active',
  'icon': '⭐',
  },
  ];

  final List<Map<String, String>> renewals = [
  {
  'clientName': 'Michael Chen',
  'policyType': 'Auto Insurance',
  'policyNumber': 'POL-003',
  'dueDate': '2024-12-05',
  'premium': '\$280',
  'daysLeft': '18',
  'status': 'upcoming',
  'priority': 'medium',
  },
  {
  'clientName': 'Sarah Johnson',
  'policyType': 'Health Insurance',
  'policyNumber': 'POL-002',
  'dueDate': '2025-02-10',
  'premium': '\$320',
  'daysLeft': '85',
  'status': 'upcoming',
  'priority': 'low',
  },
  {
  'clientName': 'John Taylor',
  'policyType': 'Life Insurance',
  'policyNumber': 'POL-008',
  'dueDate': '2024-11-28',
  'premium': '\$510',
  'daysLeft': '7',
  'status': 'urgent',
  'priority': 'high',
  },
  ];

  final List<Map<String, String>> followups = [
  {
  'clientName': 'Lisa Martinez',
  'type': 'Policy Discussion',
  'scheduledDate': '2024-11-25',
  'time': '2:00 PM',
  'status': 'pending',
  'priority': 'high',
  'notes': 'Discuss new life insurance policy',
  },
  {
  'clientName': 'David Brown',
  'type': 'Document Submission',
  'scheduledDate': '2024-11-26',
  'time': '11:00 AM',
  'status': 'pending',
  'priority': 'medium',
  'notes': 'Submit KYC documents',
  },
  {
  'clientName': 'Emma Wilson',
  'type': 'Claim Follow-up',
  'scheduledDate': '2024-11-24',
  'time': '3:30 PM',
  'status': 'completed',
  'priority': 'high',
  'notes': 'Health insurance claim status',
  },
  {
  'clientName': 'James Anderson',
  'type': 'Renewal Reminder',
  'scheduledDate': '2024-11-27',
  'time': '10:00 AM',
  'status': 'pending',
  'priority': 'urgent',
  'notes': 'Policy expires in 5 days',
  },
  ];

  final List<Map<String, String>> overdue = [
  {
  'clientName': 'Robert Wilson',
  'policyType': 'Home Insurance',
  'policyNumber': 'POL-006',
  'dueDate': '2024-11-15',
  'overdueDays': '10',
  'premium': '\$450',
  'penalty': '\$45',
  'status': 'critical',
  },
  {
  'clientName': 'Nancy Garcia',
  'policyType': 'Health Insurance',
  'policyNumber': 'POL-009',
  'dueDate': '2024-11-18',
  'overdueDays': '7',
  'premium': '\$390',
  'penalty': '\$39',
  'status': 'warning',
  },
  ];

  final List<Map<String, String>> familyMembers = [
  {
  'clientName': 'John Anderson',
  'memberName': 'Mary Anderson',
  'relation': 'Spouse',
  'age': '45',
  'policyLinked': 'POL-001',
  'coverage': '\$200,000',
  },
  {
  'clientName': 'John Anderson',
  'memberName': 'Tom Anderson',
  'relation': 'Son',
  'age': '18',
  'policyLinked': 'POL-001',
  'coverage': '\$50,000',
  },
  {
  'clientName': 'Sarah Johnson',
  'memberName': 'Mike Johnson',
  'relation': 'Spouse',
  'age': '42',
  'policyLinked': 'POL-002',
  'coverage': '\$100,000',
  },
  {
  'clientName': 'Michael Chen',
  'memberName': 'Lisa Chen',
  'relation': 'Spouse',
  'age': '38',
  'policyLinked': 'POL-003',
  'coverage': '\$50,000',
  },
  {
  'clientName': 'Michael Chen',
  'memberName': 'Kevin Chen',
  'relation': 'Son',
  'age': '12',
  'policyLinked': 'POL-003',
  'coverage': '\$25,000',
  },
  ];

  void setSelectedTab(int index) {
  _selectedTabIndex = index;
  notifyListeners();
  }

  Future<void> refreshData() async {
  _isLoading = true;
  notifyListeners();

  await Future.delayed(const Duration(milliseconds: 800));

  _isLoading = false;
  notifyListeners();
  }
}