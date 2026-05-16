import 'package:app_grownidhi/features/screens/individual/product/product_screen.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';
import 'all_service_provider.dart';

class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({super.key});

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AllServiceProvider>().fetchServiceCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Services'),
      body: Stack(
        children: [
          AppGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<AllServiceProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.categoryList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.categoryList.isEmpty) {
                  return const Center(child: Text("No categories found"));
                }
                return Column(
                  children: [
                    _buildSearchBar(),

                    spaceHeight(14),

                    _buildFilters(provider),

                    spaceHeight(18),

                    Expanded(
                      child: provider.isSubLoading
                          ? const Center(child: CircularProgressIndicator())
                          : provider.subCategoryList.isEmpty
                          ? const Center(child: Text('No Data Available'))
                          : ListView.builder(
                              itemCount: provider.subCategoryList.length,
                              itemBuilder: (context, index) {
                                final item = provider.subCategoryList[index];

                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: Duration(
                                    milliseconds: 500 + (index * 150),
                                  ),
                                  curve: Curves.easeOutBack,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, 40 * (1 - value)),
                                      child: Opacity(
                                        opacity: value
                                            .clamp(0.0, 1.0)
                                            .toDouble(),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: _productCard(item, provider, context),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search products...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFilters(AllServiceProvider provider) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categoryList.length,
        itemBuilder: (context, index) {
          final filter = provider.categoryList[index];
          final isSelected = provider.selectedFilter == filter.id;

          return GestureDetector(
            onTap: () => provider.changeFilter(filter.id ?? 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter.name ?? '',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productCard(
    ServiceSubCategoryData item,
    AllServiceProvider provider,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductScreen(item: item)),
      ),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Section
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.icon != null && item.icon!.isNotEmpty
                    ? Image.network(
                        '${AppConfig.imageUrl}/${item.icon}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.blue[100],
                          child: const Icon(
                            Icons.health_and_safety,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.blue[100],
                        child: const Icon(
                          Icons.health_and_safety,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
              ),

              const SizedBox(width: 12),

              // Details Section - Takes remaining space
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Status in same row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: item.status!
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            item.status! ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: item.status!
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Description - single line with ellipsis
                    if (item.description != null &&
                        item.description!.isNotEmpty)
                      Text(
                        item.description!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 6),

                    // Type and Dates in a single row (wrapped if needed)
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        if (item.type != null)
                          _buildCompactChip(
                            icon: Icons.label_outline,
                            label: item.type!,
                            color: Colors.purple,
                          ),
                        _buildCompactChip(
                          icon: Icons.calendar_today,
                          label: _formatDate(item.createdAt),
                          color: Colors.blue,
                        ),
                        if (item.updatedAt != null &&
                            item.updatedAt != item.createdAt)
                          _buildCompactChip(
                            icon: Icons.update,
                            label: _formatDate(item.updatedAt),
                            color: Colors.orange,
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Created/Updated By in a single row
                    if (item.createdBy != null || item.updatedBy != null)
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          if (item.createdBy != null)
                            _buildCompactChip(
                              icon: Icons.person_add,
                              label: item.createdBy!,
                              color: Colors.green,
                            ),
                          if (item.updatedBy != null)
                            _buildCompactChip(
                              icon: Icons.person,
                              label: item.updatedBy!,
                              color: Colors.grey,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Compact chip for better space utilization
  Widget _buildCompactChip({
    required IconData icon,
    required String label,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color[200]!, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color[700]),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format date
  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
