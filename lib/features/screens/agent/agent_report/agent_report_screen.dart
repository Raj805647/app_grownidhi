import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import 'agent_report_provider.dart';

class AgentReportScreen extends StatelessWidget {
  const AgentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AgentReportProvider(),
      child: const _ReportContent(),
    );
  }
}

class _ReportContent extends StatelessWidget {
  const _ReportContent();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgentReportProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: () => provider.generateReport(),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
               spaceHeight( 8),
                _buildReportTypes(provider),
               spaceHeight( 24),
                _buildDateRangePicker(context, provider),
               spaceHeight( 24),
                _buildExportOptions(provider),
               spaceHeight( 24),
                _buildSavedReports(provider),
               spaceHeight( 80),
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
              'Reports',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Generate & export business reports',
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
          child: CircleAvatar(
            backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
            child: const Icon(Icons.help_outline, color: Color(0xFF6C63FF)),
          ),
        ),
      ],
    );
  }

  Widget _buildReportTypes(AgentReportProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Report Types',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         spaceHeight( 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: provider.reportTypes.length,
            itemBuilder: (context, index) {
              final report = provider.reportTypes[index];
              final isSelected = provider.selectedReportType == report['title'];

              return GestureDetector(
                onTap: () => provider.setSelectedReportType(report['title']),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(report['icon'], style: const TextStyle(fontSize: 28)),
                       spaceHeight( 8),
                        Text(
                          report['title'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Selected',
                              style: TextStyle(fontSize: 8, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context, AgentReportProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Date Range',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
             spaceHeight( 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDateButton(
                      context,
                      'Start Date',
                      provider.startDate,
                          () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: provider.startDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) provider.setStartDate(date);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDateButton(
                      context,
                      'End Date',
                      provider.endDate,
                          () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: provider.endDate,
                          firstDate: provider.startDate,
                          lastDate: DateTime(2025),
                        );
                        if (date != null) provider.setEndDate(date);
                      },
                    ),
                  ),
                ],
              ),
             spaceHeight( 16),
              Row(
                children: [
                  _buildQuickDateChip('Last 7 days', () {
                    provider.setStartDate(DateTime.now().subtract(const Duration(days: 7)));
                    provider.setEndDate(DateTime.now());
                  }),
                  const SizedBox(width: 8),
                  _buildQuickDateChip('Last 30 days', () {
                    provider.setStartDate(DateTime.now().subtract(const Duration(days: 30)));
                    provider.setEndDate(DateTime.now());
                  }),
                  const SizedBox(width: 8),
                  _buildQuickDateChip('This Year', () {
                    provider.setStartDate(DateTime(DateTime.now().year, 1, 1));
                    provider.setEndDate(DateTime.now());
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateButton(BuildContext context, String label, DateTime date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
           spaceHeight( 4),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickDateChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6C63FF),
          ),
        ),
      ),
    );
  }

  Widget _buildExportOptions(AgentReportProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Export Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         spaceHeight( 12),
          Row(
            children: [
              Expanded(
                child: _buildExportButton(
                  'PDF',
                  'Document',
                  Icons.picture_as_pdf,
                  const Color(0xFFF44336),
                      () => provider.exportData('PDF'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildExportButton(
                  'Excel',
                  'Spreadsheet',
                  Icons.table_chart,
                  const Color(0xFF4CAF50),
                      () => provider.exportData('Excel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildExportButton(
                  'CSV',
                  'Data File',
                  Icons.data_usage,
                  const Color(0xFF2196F3),
                      () => provider.exportData('CSV'),
                ),
              ),
            ],
          ),
         spaceHeight( 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: provider.isLoading ? null : () => provider.generateReport(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: provider.isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.file_download, size: 20),
                  SizedBox(width: 8),
                  Text('Generate Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(String format, String type, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
           spaceHeight( 8),
            Text(
              format,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
           spaceHeight( 2),
            Text(
              type,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedReports(AgentReportProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Reports',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'View All',
                style: TextStyle(fontSize: 12, color: Color(0xFF6C63FF)),
              ),
            ],
          ),
         spaceHeight( 12),
          ...provider.savedReports.map((report) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.insert_drive_file, color: Color(0xFF6C63FF)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                       spaceHeight( 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 10, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              report['date'],
                              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.description, size: 10, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              report['size'],
                              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, size: 20),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}