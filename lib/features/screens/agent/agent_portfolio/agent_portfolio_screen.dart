import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import 'agent_portfolio_provider.dart';

class AgentPortfolioScreen extends StatelessWidget {
  const AgentPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PortfolioContent();
  }
}

class _PortfolioContent extends StatefulWidget {
  const _PortfolioContent();

  @override
  State<_PortfolioContent> createState() => _PortfolioContentState();
}

class _PortfolioContentState extends State<_PortfolioContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<AgentPortfolioProvider>().setSelectedTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgentPortfolioProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: () => provider.refreshData(),
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                controller: _tabController,
                children: [
                  _buildClientPortfolio(provider),
                  _buildPolicies(provider),
                  _buildRenewals(provider),
                  _buildFollowups(provider),
                  _buildOverdue(provider),
                  _buildFamilyMembers(provider),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.folder_outlined,
                color: Color(0xFF6C63FF),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    'Manage your clients and policies',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.search, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        labelColor: const Color(0xFF6C63FF),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF6C63FF),
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 13),
        tabs: const [
          Tab(text: '📂 Clients'),
          Tab(text: '📄 Policies'),
          Tab(text: '🔄 Renewals'),
          Tab(text: '📞 Follow-ups'),
          Tab(text: '⚠️ Overdue'),
          Tab(text: '👨‍👩‍👧‍👦 Family'),
        ],
      ),
    );
  }

  Widget _buildClientPortfolio(AgentPortfolioProvider provider) {
    final clients = provider.clientPortfolio;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              client['avatar']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      client['name']!,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: client['status'] == 'active'
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      client['status']!,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: client['status'] == 'active' ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                             spaceHeight( 6),
                              Row(
                                children: [
                                  const Icon(Icons.email, size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    client['email']!,
                                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                             spaceHeight( 4),
                              Row(
                                children: [
                                  const Icon(Icons.phone, size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    client['phone']!,
                                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                   spaceHeight( 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoChip('📄 ${client['totalPolicies']}', 'Policies'),
                          Container(width: 1, height: 30, color: Colors.grey.shade300),
                          _buildInfoChip('💰 ${client['totalPremium']}', 'Premium'),
                          Container(width: 1, height: 30, color: Colors.grey.shade300),
                          _buildInfoChip('📅 ${client['joinedDate']}', 'Client Since'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
       spaceHeight( 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildPolicies(AgentPortfolioProvider provider) {
    final policies = provider.policies;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: policies.length,
      itemBuilder: (context, index) {
        final policy = policies[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          policy['icon']!,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            policy['type']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         spaceHeight( 4),
                          Text(
                            policy['clientName']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: policy['status'] == 'active'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        policy['status']!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: policy['status'] == 'active' ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
               spaceHeight( 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildPolicyDetail('Policy #', policy['id']!),
                    ),
                    Expanded(
                      child: _buildPolicyDetail('Premium', policy['premium']!),
                    ),
                  ],
                ),
               spaceHeight( 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildPolicyDetail('Coverage', policy['coverage']!),
                    ),
                    Expanded(
                      child: _buildPolicyDetail('Valid Till', policy['endDate']!.split('-')[0]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPolicyDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
        ),
       spaceHeight( 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRenewals(AgentPortfolioProvider provider) {
    final renewals = provider.renewals;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: renewals.length,
      itemBuilder: (context, index) {
        final renewal = renewals[index];
        final daysLeft = int.parse(renewal['daysLeft']!);
        final isUrgent = daysLeft <= 10;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isUrgent ? Border.all(color: Colors.red.shade200, width: 1.5) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUrgent ? Colors.red.shade50 : const Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.access_time,
                    color: isUrgent ? Colors.red : const Color(0xFFFF9800),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        renewal['clientName']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     spaceHeight( 4),
                      Text(
                        '${renewal['policyType']} • ${renewal['policyNumber']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                     spaceHeight( 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isUrgent
                                  ? Colors.red.shade50
                                  : Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Due in $daysLeft days',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isUrgent ? Colors.red : const Color(0xFFFF9800),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            renewal['premium']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFollowups(AgentPortfolioProvider provider) {
    final followups = provider.followups;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: followups.length,
      itemBuilder: (context, index) {
        final followup = followups[index];
        Color priorityColor;
        IconData priorityIcon;

        switch(followup['priority']) {
          case 'urgent':
            priorityColor = Colors.red;
            priorityIcon = Icons.priority_high;
            break;
          case 'high':
            priorityColor = Colors.orange;
            priorityIcon = Icons.warning_amber;
            break;
          default:
            priorityColor = Colors.blue;
            priorityIcon = Icons.low_priority;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: followup['status'] == 'completed' ? Colors.grey.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(priorityIcon, color: priorityColor, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            followup['clientName']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: priorityColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              followup['priority']!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: priorityColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                     spaceHeight( 4),
                      Text(
                        followup['type']!,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                      ),
                     spaceHeight( 6),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${followup['scheduledDate']} at ${followup['time']}',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (followup['status'] == 'pending')
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6C63FF),
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverdue(AgentPortfolioProvider provider) {
    final overdue = provider.overdue;

    return overdue.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.green.shade200),
         spaceHeight( 16),
          Text(
            'No overdue items',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    )
        : ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: overdue.length,
      itemBuilder: (context, index) {
        final item = overdue[index];
        final isCritical = item['status'] == 'critical';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.red.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.warning, color: Colors.red, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['clientName']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         spaceHeight( 4),
                          Text(
                            '${item['policyType']} • ${item['policyNumber']}',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item['overdueDays']} days overdue',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
               spaceHeight( 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Premium', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                         spaceHeight( 4),
                          Text(item['premium']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(width: 1, height: 30, color: Colors.red.shade200),
                      Column(
                        children: [
                          Text('Penalty', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                         spaceHeight( 4),
                          Text(item['penalty']!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(width: 1, height: 30, color: Colors.red.shade200),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(80, 35),
                        ),
                        child: const Text('Pay Now', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFamilyMembers(AgentPortfolioProvider provider) {
    final families = provider.familyMembers;

    // Group by client name
    final Map<String, List<Map<String, String>>> groupedFamilies = {};
    for (var member in families) {
      final clientName = member['clientName']!;
      if (!groupedFamilies.containsKey(clientName)) {
        groupedFamilies[clientName] = [];
      }
      groupedFamilies[clientName]!.add(member);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedFamilies.keys.length,
      itemBuilder: (context, index) {
        final clientName = groupedFamilies.keys.elementAt(index);
        final members = groupedFamilies[clientName]!;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.family_restroom, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        clientName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${members.length} members',
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
              ...members.map((member) => Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person, color: Color(0xFF6C63FF), size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                member['memberName']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  member['relation']!,
                                  style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                                ),
                              ),
                            ],
                          ),
                         spaceHeight( 4),
                          Text(
                            'Age: ${member['age']} • Coverage: ${member['coverage']}',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert, size: 18),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
