// lib/providers/agent_dashboard_provider.dart
import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:base_module/core/models/agent_dashboard_response.dart';

class AgentDashboardProvider extends BaseProvider {
  bool isLoading = false;
  AgentDashboardData agentDashboardData = AgentDashboardData();

  bool _isLoading = false;
  String? _error;
  DashboardData? _dashboardData;


  String? get error => _error;
  DashboardData? get dashboardData => _dashboardData;

  Future<void> fetchAgentDashboard() async {
    try {
      isLoading = true;

      final response = await authRepository.agentDashboard();
      print('adbfhbdsaf=> ${response.data}');

      if (response.isSuccess == true) {
        agentDashboardData = AgentDashboardData.fromJson(response.data['data']);
        print('adfbdsakjbf=> $agentDashboardData');
      } else {
        print(response.data);
      }
    } catch (error) {
      print("Dashboard Error: $error");
    } finally {
      isLoading = false;
      notifyListeners();

    }
  }

  Future<void> fetchDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      _dashboardData = DashboardData(
        summaryCards: [
          SummaryCard(
            title: 'Total Commission',
            value: '\$12,450',
            change: '+15%',
            icon: Icons.attach_money,
            color: const Color(0xFF6C63FF),
            trend: Trend.up,
          ),
          SummaryCard(
            title: 'Active Policies',
            value: '147',
            change: '+8',
            icon: Icons.description,
            color: const Color(0xFF4CAF50),
            trend: Trend.up,
          ),
          SummaryCard(
            title: 'Pending Commission',
            value: '\$3,240',
            change: '-2%',
            icon: Icons.pending_actions,
            color: const Color(0xFFFF9800),
            trend: Trend.down,
          ),
          SummaryCard(
            title: 'Client Satisfaction',
            value: '4.8',
            change: '+0.3',
            icon: Icons.star,
            color: const Color(0xFFE91E63),
            trend: Trend.up,
          ),
        ],
        upcomingRenewals: [
          RenewalItem(
            clientName: 'John Anderson',
            policyType: 'Life Insurance',
            renewalDate: DateTime.now().add(const Duration(days: 5)),
            premium: '\$450',
            status: RenewalStatus.upcoming,
          ),
          RenewalItem(
            clientName: 'Sarah Johnson',
            policyType: 'Health Insurance',
            renewalDate: DateTime.now().add(const Duration(days: 12)),
            premium: '\$320',
            status: RenewalStatus.upcoming,
          ),
          RenewalItem(
            clientName: 'Michael Chen',
            policyType: 'Auto Insurance',
            renewalDate: DateTime.now().add(const Duration(days: 18)),
            premium: '\$280',
            status: RenewalStatus.upcoming,
          ),
        ],
        pendingCommissions: [
          CommissionItem(
            clientName: 'Emily Davis',
            policyType: 'Term Life',
            amount: '\$1,250',
            date: DateTime.now().subtract(const Duration(days: 2)),
            status: CommissionStatus.pending,
          ),
          CommissionItem(
            clientName: 'Robert Wilson',
            policyType: 'Health Plus',
            amount: '\$890',
            date: DateTime.now().subtract(const Duration(days: 5)),
            status: CommissionStatus.processing,
          ),
          CommissionItem(
            clientName: 'Lisa Martinez',
            policyType: 'Home Insurance',
            amount: '\$2,100',
            date: DateTime.now().subtract(const Duration(days: 8)),
            status: CommissionStatus.pending,
          ),
        ],
        notifications: [
          NotificationItem(
            title: 'Policy Renewal Reminder',
            message: 'John Anderson\'s policy renews in 5 days',
            time: '2 hours ago',
            isRead: false,
            icon: Icons.notifications_active,
          ),
          NotificationItem(
            title: 'Commission Credited',
            message: '\$1,250 credited for new policy',
            time: '5 hours ago',
            isRead: false,
            icon: Icons.payment,
          ),
          NotificationItem(
            title: 'New Lead Assigned',
            message: 'Premium client inquiry needs follow-up',
            time: '1 day ago',
            isRead: true,
            icon: Icons.person_add,
          ),
        ],
        quickActions: [
          QuickAction(
            title: 'New Policy',
            icon: Icons.add_circle,
            color: const Color(0xFF6C63FF),
          ),
          QuickAction(
            title: 'Kyc Update',
            icon: Icons.autorenew,
            color: const Color(0xFF4CAF50),
          ),
          QuickAction(
            title: 'Claims',
            icon: Icons.assignment,
            color: const Color(0xFFFF9800),
          ),
          QuickAction(
            title: 'Messages',
            icon: Icons.message,
            color: const Color(0xFFE91E63),
          ),
        ],
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void markNotificationAsRead(int index) {
    if (_dashboardData != null && index < _dashboardData!.notifications.length) {
      _dashboardData!.notifications[index].isRead = true;
      notifyListeners();
    }
  }
}

// Models
enum Trend { up, down }

class DashboardData {
  final List<SummaryCard> summaryCards;
  final List<RenewalItem> upcomingRenewals;
  final List<CommissionItem> pendingCommissions;
  final List<NotificationItem> notifications;
  final List<QuickAction> quickActions;

  DashboardData({
    required this.summaryCards,
    required this.upcomingRenewals,
    required this.pendingCommissions,
    required this.notifications,
    required this.quickActions,
  });
}

class SummaryCard {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final Trend trend;

  SummaryCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
    required this.trend,
  });
}

class RenewalItem {
  final String clientName;
  final String policyType;
  final DateTime renewalDate;
  final String premium;
  final RenewalStatus status;

  RenewalItem({
    required this.clientName,
    required this.policyType,
    required this.renewalDate,
    required this.premium,
    required this.status,
  });
}

enum RenewalStatus { upcoming, urgent, expired }

class CommissionItem {
  final String clientName;
  final String policyType;
  final String amount;
  final DateTime date;
  final CommissionStatus status;

  CommissionItem({
    required this.clientName,
    required this.policyType,
    required this.amount,
    required this.date,
    required this.status,
  });
}

enum CommissionStatus { pending, processing, paid }

class NotificationItem {
  String title;
  String message;
  final String time;
  bool isRead;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.icon,
  });
}

class QuickAction {
  final String title;
  final IconData icon;
  final Color color;

  QuickAction({
    required this.title,
    required this.icon,
    required this.color,
  });
}