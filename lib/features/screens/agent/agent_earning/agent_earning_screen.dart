import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'agent_earning_provider.dart';

class AgentEarningScreen extends StatelessWidget {
  const AgentEarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AgentEarningProvider(),
      child: const _EarningContent(),
    );
  }
}

class _EarningContent extends StatefulWidget {
  const _EarningContent();

  @override
  State<_EarningContent> createState() => _EarningContentState();
}

class _EarningContentState extends State<_EarningContent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgentEarningProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: () => provider.refreshData(),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            if (provider.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _buildCommissionSummary(provider),
                  const SizedBox(height: 24),
                  _buildRevenueGraph(provider),
                  const SizedBox(height: 24),
                  _buildRevenueSources(provider),
                  const SizedBox(height: 24),
                  _buildPendingCommissions(provider),
                  const SizedBox(height: 80),
                ]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Track your commissions & revenue',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF6C63FF)),
              const SizedBox(width: 6),
              DropdownButton<String>(
                value: '2024',
                items: ['2023', '2024', '2025'].map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year, style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (value) {},
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                isDense: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommissionSummary(AgentEarningProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Commission Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'View Details',
                style: TextStyle(fontSize: 12, color: Color(0xFF6C63FF)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryCard(
                        'Total Commission',
                        provider.getFormattedCommission('totalCommission'),
                        Icons.account_balance_wallet,
                        const Color(0xFF6C63FF),
                      ),
                      _buildSummaryCard(
                        'This Month',
                        provider.getFormattedCommission('thisMonth'),
                        Icons.trending_up,
                        const Color(0xFF4CAF50),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummaryCard(
                        'Last Month',
                        provider.getFormattedCommission('lastMonth'),
                        Icons.calendar_view_month,
                        const Color(0xFFFF9800),
                      ),
                      _buildSummaryCard(
                        'Avg Monthly',
                        provider.getFormattedCommission('averageMonthly'),
                        Icons.show_chart,
                        const Color(0xFF9C27B0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C63FF).withOpacity(0.1),
                          const Color(0xFF8B84FF).withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Yearly Target Progress',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '\$${provider.commissionSummary['yearlyProgress']} / \$${provider.commissionSummary['yearlyTarget']}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: provider.getYearlyProgressPercentage() / 100,
                            backgroundColor: Colors.grey.shade200,
                            color: const Color(0xFF6C63FF),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${provider.getYearlyProgressPercentage().toStringAsFixed(1)}% Achieved',
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('📊 Total Policies', '${provider.commissionSummary['totalPolicies']}', '+12 this year'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard('👥 Active Clients', '${provider.commissionSummary['activeClients']}', '+8 new'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard('🎯 Conversion', '${provider.commissionSummary['conversionRate']}%', '+5% vs last year'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String emoji, String value, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueGraph(AgentEarningProvider provider) {
    final months = provider.monthlyEarnings;
    final maxAmount = months.map((m) => m['amount'] as int).reduce((a, b) => a > b ? a : b).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Revenue Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildChartToggle(provider, 'Earnings', 0),
                    const SizedBox(width: 4),
                    _buildChartToggle(provider, 'Policies', 1),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: Row(
                    children: [
                      _buildYAxis(months, maxAmount, provider.selectedChartIndex),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(months.length, (index) {
                              final month = months[index];
                              final value = provider.selectedChartIndex == 0
                                  ? (month['amount'] as int).toDouble()
                                  : (month['policies'] as int).toDouble();
                              final max = provider.selectedChartIndex == 0 ? maxAmount : 20.0;
                              final height = (value / max) * 160;
                              final isTargetMet = provider.selectedChartIndex == 0
                                  ? (month['amount'] as int) >= (month['target'] as int)
                                  : true;

                              return AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Container(
                                    width: 40,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (provider.selectedChartIndex == 0)
                                          Text(
                                            '\$${month['amount']}',
                                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                                          ),
                                        Container(
                                          height: height * _animationController.value,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: isTargetMet
                                                  ? [const Color(0xFF6C63FF), const Color(0xFF8B84FF)]
                                                  : [Colors.orange, Colors.orange.shade300],
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          month['month'],
                                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (provider.selectedChartIndex == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Actual', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 20),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Target', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatChange('+15.5%', 'vs last month', Icons.trending_up, Colors.green),
                    _buildStatChange('+42.3%', 'vs last year', Icons.trending_up, Colors.green),
                    _buildStatChange('+28', 'new policies', Icons.add_circle, const Color(0xFF6C63FF)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartToggle(AgentEarningProvider provider, String label, int index) {
    final isSelected = provider.selectedChartIndex == index;
    return GestureDetector(
      onTap: () => provider.setSelectedChartIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildYAxis(List<Map<String, dynamic>> months, double maxAmount, int chartType) {
    final max = chartType == 0 ? maxAmount : 20.0;
    final step = max / 4;

    return Container(
      width: 45,
      height: 220,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final value = (step * (4 - index)).toInt();
          return Text(
            chartType == 0 ? '\$$value' : value.toString(),
            style: const TextStyle(fontSize: 9, color: Colors.grey),
          );
        }),
      ),
    );
  }

  Widget _buildStatChange(String change, String label, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(change, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
      ],
    );
  }

  Widget _buildRevenueSources(AgentEarningProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue by Product',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: CircularProgressIndicator(
                            value: 0.75,
                            strokeWidth: 20,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '\$${provider.commissionSummary['totalCommission']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...provider.revenueSources.map((source) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(source['color']),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              source['source'],
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            '\$${source['amount']}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${source['percentage']}%',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: source['percentage'] / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: Color(source['color']),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingCommissions(AgentEarningProvider provider) {
    final pending = provider.pendingCommissions;
    final totalPending = pending.fold<int>(0, (sum, item) => sum + int.parse(item['amount']!.replaceAll(',', '')));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pending Commissions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: \$${totalPending.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pending.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final commission = pending[index];
              final isProcessing = commission['status'] == 'processing';

              return Container(
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
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isProcessing ? Colors.blue.withOpacity(0.1) : const Color(0xFFFF9800).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              isProcessing ? Icons.hourglass_empty : Icons.pending,
                              color: isProcessing ? Colors.blue : const Color(0xFFFF9800),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commission['clientName']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${commission['policyType']} • ${commission['policyNumber']}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${commission['amount']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isProcessing ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  commission['stage']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isProcessing ? Colors.blue : const Color(0xFFFF9800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  'Expected: ${commission['expectedDate']}',
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 12, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Text(
                                  '${_getDaysRemaining(commission['expectedDate']!)} days left',
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int _getDaysRemaining(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      return date.difference(now).inDays;
    } catch (e) {
      return 0;
    }
  }
}
