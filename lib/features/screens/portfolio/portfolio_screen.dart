import 'package:app_grownidhi/features/screens/portfolio/portfolio_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/help_widget.dart';
import '../../../widget/ui_design.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late PortfolioProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<PortfolioProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xfff5f7fb),
          body: Stack(
            children: [
              AppGradientBackground(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildHeader(),

                    spaceHeight(18),

                    _buildSearchBar(),

                    spaceHeight(14),

                    _buildFilters(provider),

                    spaceHeight(18),

                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final item = provider.products[index];

                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(milliseconds: 500 + (index * 150)),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 40 * (1 - value)),
                                child: Opacity(
                                  opacity: value.clamp(0.0, 1.0).toDouble(),
                                  child: child,
                                ),
                              );
                            },
                            child: _productCard(item, context),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Portfolio",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("5 products", style: TextStyle(color: Colors.grey)),
          ],
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        ),
      ],
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

  Widget _buildFilters(PortfolioProvider provider) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.filters.length,
        itemBuilder: (context, index) {
          final filter = provider.filters[index];
          final isSelected = provider.selectedFilter == filter;

          return GestureDetector(
            onTap: () => provider.changeFilter(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
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

  Widget _productCard(Map<String, dynamic> item, BuildContext context) {
    return InkWell(
      onTap: () => provider.navigateTo(context, RouteNames.productDetailScreen),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: item["color"],
                  child: Text(
                    item["avatar"],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item["subtitle"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Active",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ),
              ],
            ),

            spaceHeight(12),

            Divider(color: Colors.grey.shade200),

            spaceHeight(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _columnText("Amount", item["amount"]),
                _columnText("Next Payment", item["payment"]),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _columnText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        spaceHeight(4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
