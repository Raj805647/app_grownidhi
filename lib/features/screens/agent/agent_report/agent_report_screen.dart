import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';
import 'agent_report_provider.dart';

class AgentReportScreen extends StatefulWidget {
  const AgentReportScreen({super.key});

  @override
  State<AgentReportScreen> createState() => _AgentReportScreenState();
}

class _AgentReportScreenState extends State<AgentReportScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> reportTypes = [
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Portfolio Report',
      'subtitle': 'Client investment data',
    },
    {
      'icon': Icons.bar_chart,
      'title': 'MIS Report',
      'subtitle': 'Business analytics',
    },
    {
      'icon': Icons.currency_rupee,
      'title': 'Commission Report',
      'subtitle': 'Revenue & earnings',
    },
    {
      'icon': Icons.trending_up,
      'title': 'Performance',
      'subtitle': 'Growth statistics',
    },
    {
      'icon': Icons.refresh,
      'title': 'Renewal Report',
      'subtitle': 'Upcoming renewals',
    },
    {
      'icon': Icons.warning_amber_rounded,
      'title': 'Overdue Report',
      'subtitle': 'Pending follow-ups',
    },
  ];

  final List<Map<String, dynamic>> recentReports = [
    {
      "name": "Client Portfolio Summary",
      "date": "15 Nov 2025",
      "size": "2.4 MB",
    },
    {
      "name": "Commission Earnings Report",
      "date": "12 Nov 2025",
      "size": "1.8 MB",
    },
    {
      "name": "Business MIS Analytics",
      "date": "08 Nov 2025",
      "size": "3.1 MB",
    },
  ];

  int selectedIndex = 0;

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));

  DateTime endDate = DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> generateReport() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report Generated Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          const AppGradientBackground(),

          SafeArea(
            child: RefreshIndicator(
              onRefresh: generateReport,

              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 120,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              "Reports",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Generate business analytics",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),

                            borderRadius: BorderRadius.circular(18),
                          ),

                          child: const Icon(
                            Icons.file_download_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// REPORT TYPES
                    const Text(
                      "Report Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    GridView.builder(
                      shrinkWrap: true,

                      itemCount: reportTypes.length,

                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),

                      itemBuilder: (context, index) {
                        final item = reportTypes[index];

                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            padding: const EdgeInsets.all(18),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),

                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color(0xff00DBDE),
                                  Color(0xffFC00FF),
                                ],
                              )
                                  : LinearGradient(
                                colors: [
                                  Colors.deepPurple.withOpacity(0.12),
                                  Colors.blue.withOpacity(0.06),
                                ],
                              ),

                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.deepPurple.withOpacity(0.08),
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),

                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(18),
                                  ),

                                  child: Icon(
                                    item['icon'],
                                    color: Colors.deepPurple,
                                    size: 28,
                                  ),
                                ),

                                const Spacer(),

                                Text(
                                  item['title'],
                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white,

                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  item['subtitle'],
                                  maxLines: 2,

                                  overflow: TextOverflow.ellipsis,

                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.white,

                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    /// DATE RANGE
                    const Text(
                      "Date Range",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _dateCard(
                            title: "Start Date",
                            date:
                            "${startDate.day}/${startDate.month}/${startDate.year}",
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );

                              if (picked != null) {
                                setState(() {
                                  startDate = picked;
                                });
                              }
                            },
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _dateCard(
                            title: "End Date",
                            date:
                            "${endDate.day}/${endDate.month}/${endDate.year}",
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: endDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );

                              if (picked != null) {
                                setState(() {
                                  endDate = picked;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// EXPORT SECTION
                    const Text(
                      "Export Options",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _exportCard(
                            icon: Icons.picture_as_pdf,
                            title: "PDF",
                            color: Colors.red,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _exportCard(
                            icon: Icons.table_chart,
                            title: "Excel",
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _exportCard(
                            icon: Icons.data_array,
                            title: "CSV",
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// GENERATE BUTTON
                    SizedBox(
                      width: double.infinity,

                      height: 58,

                      child: ElevatedButton(
                        onPressed: isLoading ? null : generateReport,

                        style: ElevatedButton.styleFrom(
                          elevation: 0,

                          backgroundColor: Colors.transparent,

                          shadowColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),

                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff00DBDE),
                                Color(0xffFC00FF),
                              ],
                            ),
                          ),

                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text(
                              "Generate Report",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// RECENT REPORTS
                    const Text(
                      "Recent Reports",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    ListView.builder(
                      itemCount: recentReports.length,

                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),

                      itemBuilder: (context, index) {
                        final item = recentReports[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),

                          padding: const EdgeInsets.all(18),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),

                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withOpacity(0.10),
                                Colors.blue.withOpacity(0.05),
                              ],
                            ),

                            border: Border.all(
                              color: Colors.deepPurple.withOpacity(0.08),
                            ),
                          ),

                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),

                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: const Icon(
                                  Icons.description,
                                  color: Colors.deepPurple,
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      item['date'],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Text(
                                    item['size'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Container(
                                    padding: const EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),

                                    child: const Icon(
                                      Icons.download,
                                      size: 18,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateCard({
    required String title,
    required String date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),

          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.10),
              Colors.blue.withOpacity(0.05),
            ],
          ),

          border: Border.all(
            color: Colors.deepPurple.withOpacity(0.08),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.deepPurple,
                  size: 20,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _exportCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.withOpacity(0.10),
            Colors.blue.withOpacity(0.05),
          ],
        ),

        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.08),
        ),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 34,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}