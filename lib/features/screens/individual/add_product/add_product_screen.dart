import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';
import 'add_product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  late AddProductProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<AddProductProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.init(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xfff5f7fb),
          body: Stack(
            children: [
              AppGradientBackground(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),

                    spaceHeight(20),

                    Expanded(
                      child: GridView.builder(
                        itemCount: provider.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final item = provider.categories[index];

                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(
                              milliseconds: 500 + (index * 180),
                            ),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              final safeOpacity = value
                                  .clamp(0.0, 1.0)
                                  .toDouble();

                              return Transform.translate(
                                offset: Offset(0, 50 * (1 - value)),
                                child: Transform.rotate(
                                  angle: (0.08 - (index * 0.015)) * (1 - value),
                                  child: Transform.scale(
                                    scale: 0.85 + (0.15 * value),
                                    child: Opacity(
                                      opacity: safeOpacity,
                                      child: child,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: _categoryCard(
                              item["icon"],
                              item["title"],
                              item["color"],
                            ),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        spaceHeight(20),
        const Text(
          "Add Product",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        spaceHeight(6),
        const Text(
          "Select a category to get started",
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _categoryCard(IconData icon, String title, Color color) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () =>
          provider.navigateTo(context, RouteNames.addProductDetailsScreen),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            spaceHeight(14),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
