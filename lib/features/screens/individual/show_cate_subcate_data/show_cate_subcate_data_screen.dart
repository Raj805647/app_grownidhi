import 'package:app_grownidhi/features/screens/individual/product/product_screen.dart';
import 'package:app_grownidhi/features/screens/individual/show_cate_subcate_data/show_cate_subcate_data_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';

class ShowCateSubcateDataScreen extends StatefulWidget {
  const ShowCateSubcateDataScreen({super.key});

  @override
  State<ShowCateSubcateDataScreen> createState() =>
      _ShowCateSubcateDataScreenState();
}

class _ShowCateSubcateDataScreenState
    extends State<ShowCateSubcateDataScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<ShowCateSubcateDataProvider>()
          .fetchServiceCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Background
          AppGradientBackground(),

          Consumer<ShowCateSubcateDataProvider>(
            builder: (context, provider, child) {

              return CustomScrollView(
                slivers: [

                  /// App Bar
                  const CustomSliverAppBar(
                    title: "Service History",
                  ),

                  /// Content
                  SliverPadding(
                    padding: const EdgeInsets.all(16),

                    sliver: SliverList(
                      delegate: SliverChildListDelegate([

                        /// Search
                        _buildSearchBar(),

                        const SizedBox(height: 18),

                        /// Filters
                        _buildFilters(provider),

                        const SizedBox(height: 22),

                        /// Loading
                        if (provider.isLoading &&
                            provider.categoryList.isEmpty)
                          const SizedBox(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )

                        /// Empty
                        else if (provider.subCategoryList.isEmpty)
                          _buildEmptyState()

                        /// History List
                        else
                          ListView.builder(
                            shrinkWrap: true,

                            physics:
                            const NeverScrollableScrollPhysics(),

                            itemCount:
                            provider.subCategoryList.length,

                            itemBuilder: (context, index) {

                              final item =
                              provider.subCategoryList[index];

                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),

                                duration: Duration(
                                  milliseconds:
                                  350 + (index * 80),
                                ),

                                curve: Curves.easeOutCubic,

                                builder:
                                    (context, value, child) {

                                  return Transform.translate(
                                    offset:
                                    Offset(0, 40 * (1 - value)),

                                    child: Opacity(
                                      opacity: value,

                                      child: child,
                                    ),
                                  );
                                },

                                child: _historyCard(
                                  item,
                                  context,
                                ),
                              );
                            },
                          ),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// ================= SEARCH =================

  Widget _buildSearchBar() {
    return Container(
      height: 56,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: Colors.white.withOpacity(0.06),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: TextField(
        style: const TextStyle(color: Colors.white),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: "Search services...",

          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.45),
          ),

          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  /// ================= FILTER =================

  Widget _buildFilters(
      ShowCateSubcateDataProvider provider,
      ) {
    return SizedBox(
      height: 42,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: provider.categoryList.length,

        itemBuilder: (context, index) {

          final item = provider.categoryList[index];

          final isSelected =
              provider.selectedFilter == item.id;

          return GestureDetector(
            onTap: () {
              provider.changeFilter(item.id ?? 0);
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              margin: const EdgeInsets.only(right: 12),

              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),

                gradient: isSelected
                    ? const LinearGradient(
                  colors: [
                    Color(0xff6C63FF),
                    Color(0xff8B84FF),
                  ],
                )
                    : null,

                color: isSelected
                    ? null
                    : Colors.white.withOpacity(0.06),

                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white10,
                ),
              ),

              child: Center(
                child: Text(
                  item.name ?? '',

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: 13,

                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================= HISTORY CARD =================

  Widget _historyCard(
      ServiceSubCategoryData item,
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => ProductScreen(item: item),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.03),
            ],
          ),

          border: Border.all(
            color: Colors.white10,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// Icon
            Container(
              height: 74,
              width: 74,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                color: Colors.white.withOpacity(0.06),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: item.icon != null &&
                    item.icon!.isNotEmpty
                    ? Image.network(
                  '${AppConfig.imageUrl}/${item.icon}',
                  fit: BoxFit.cover,

                  errorBuilder:
                      (_, __, ___) {
                    return const Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                      size: 34,
                    );
                  },
                )
                    : const Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  /// Title
                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          item.name ?? '',

                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      _statusBadge(item.status == true),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Description
                  if (item.description != null)
                    Text(
                      item.description ?? '',

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: Colors.white
                            .withOpacity(0.65),

                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                  const SizedBox(height: 14),

                  /// Chips
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: [

                      _glassChip(
                        Icons.category_outlined,
                        item.type ?? "Service",
                      ),

                      _glassChip(
                        Icons.calendar_today_outlined,
                        _formatDate(item.createdAt),
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
  }

  /// ================= CHIP =================

  Widget _glassChip(
      IconData icon,
      String label,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),

        color: Colors.white.withOpacity(0.06),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [

          Icon(
            icon,
            size: 13,
            color: Colors.white70,
          ),

          const SizedBox(width: 6),

          Text(
            label,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= STATUS =================

  Widget _statusBadge(bool status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        color: status
            ? Colors.green.withOpacity(0.16)
            : Colors.red.withOpacity(0.16),
      ),

      child: Text(
        status ? "ACTIVE" : "INACTIVE",

        style: TextStyle(
          color: status
              ? Colors.greenAccent
              : Colors.redAccent,

          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  /// ================= EMPTY =================

  Widget _buildEmptyState() {
    return SizedBox(
      height: 450,

      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.history_toggle_off_rounded,
              size: 72,
              color: Colors.white.withOpacity(0.18),
            ),

            const SizedBox(height: 18),

            const Text(
              "No History Found",

              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Your service history will appear here.",

              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= DATE =================

  String _formatDate(String? dateString) {
    if (dateString == null) return "N/A";

    try {
      final date = DateTime.parse(dateString);

      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }
}
