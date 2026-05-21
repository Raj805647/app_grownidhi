import 'package:base_module/core/models/product_service_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/ui_design.dart';
import '../agent_client_apply_form/agent_client_apply_form_screen.dart';
import 'agent_portfolio_product_provider.dart';

class AgentPortfolioProductScreen extends StatefulWidget {
  final int category_id, subCategoy_id;
  final String appbarName;
  const AgentPortfolioProductScreen({
    super.key,
    required this.category_id,
    required this.subCategoy_id,
    required this.appbarName,
  });

  @override
  State<AgentPortfolioProductScreen> createState() =>
      _AgentPortfolioProductScreenState();
}

class _AgentPortfolioProductScreenState extends State<AgentPortfolioProductScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AgentPortfolioProductProvider>().fetchAgentPortfolioProduct(
        categoryId: widget.category_id,
        subCategoryId: widget.subCategoy_id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.appbarName),
      body: Stack(
        children: [
          /// BACKGROUND
          const AppGradientBackground(),

          /// MAIN CONTENT
          Consumer<AgentPortfolioProductProvider>(
            builder: (context, provider, child) {
              /// LOADING STATE
              if (provider.productLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              /// EMPTY STATE
              if (provider.productListData.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.white54,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Products Found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Try adjusting your search or filter",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// PRODUCT GRID
              return ListView.builder(
                shrinkWrap: true,
                itemCount: provider.productListData.length,
                itemBuilder: (context, index) {
                  final product = provider.productListData[index];

                  return _buildProductCard(product);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductListData product) {
    return GestureDetector(
      onTap: () {
        _showProductDetails(product);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Name
            Text(
              product.name ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// Interest & Premium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(
                  "Interest",
                  "${product.interestRate}%",
                  Icons.percent,
                ),
                _infoTile(
                  "Premium",
                  "₹${product.premium}",
                  Icons.currency_rupee,
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// Amount Range
            Text(
              "Amount: ₹${product.minAmount} - ₹${product.maxAmount}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 6),

            /// Tenure
            Text(
              "Tenure: ${product.tenure}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 10),

            /// Companies
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: product.companies!.map((company) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    company.companyName ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.deepPurple,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Small Info Widget
  Widget _infoTile(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.deepPurple),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Bottom Sheet
  void _showProductDetails(ProductListData product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  product.name ?? "",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                _detailRow(
                  "Interest Rate",
                  "${product.interestRate}%",
                ),

                _detailRow(
                  "Premium",
                  "₹${product.premium}",
                ),

                _detailRow(
                  "Tenure",
                  product.tenure ?? "",
                ),

                _detailRow(
                  "Min Amount",
                  "₹${product.minAmount}",
                ),

                _detailRow(
                  "Max Amount",
                  "₹${product.maxAmount}",
                ),

                const SizedBox(height: 15),

                const Text(
                  "Eligibility",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(product.eligibility ?? ""),

                const SizedBox(height: 15),

                const Text(
                  "Required Documents",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(product.requiredDocuments ?? ""),

                const SizedBox(height: 15),

                const Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(product.description ?? ""),

                const SizedBox(height: 20),

                /// Add Now Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AgentClientApplyFormScreen(productId: product.id ?? 0)));
                      /// Add your action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Add Now",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Detail Row
  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(value),
          ),
        ],
      ),
    );
  }}