import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_screen.dart';
import 'package:app_grownidhi/features/screens/individual/product/product_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';

class ProductScreen extends StatefulWidget {
  final ServiceSubCategoryData item;

  const ProductScreen({super.key, required this.item});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().fetchSubCategory(
        widget.item.categoryId ?? 0,
        widget.item.id ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          CustomScrollView(
            slivers: [
              /// App Bar
              const CustomSliverAppBar(title: "Products Details"),

              SliverPadding(
                padding: EdgeInsetsGeometry.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSearchField(),

                    Expanded(
                      child: Consumer<ProductProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return SizedBox(
                              height: 400,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (provider.products.isEmpty) {
                            return buildEmptyState(
                              title: 'No Products Found',
                              subTitle:
                                  "No products available for this category.",
                              icon: Icons.inventory_2_outlined,
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.products.length,
                            itemBuilder: (context, index) {
                              return _buildProductCard(
                                provider.products[index],
                                provider,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => customTextField(
        hintText: 'Search products by name or company...',
        controller: provider.searchController,
        suffixIcon: provider.searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  provider.searchController.clear();
                },
              )
            : null,
        prefixIcon: Icons.search,
      ),
    );
  }

  Widget _buildProductCard(
      ServiceProductsData product,
      ProductProvider provider,
      ) {
    final isActive = product.status == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),

        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormSubmitDetailsScreen(
                  productDetails: product,
                ),
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TOP SECTION
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    /// ICON
                    Container(
                      height: 58,
                      width: 58,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),

                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff6C63FF).withOpacity(0.9),
                            const Color(0xff8F67FF).withOpacity(0.8),
                          ],
                        ),
                      ),

                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// TITLE
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            product.name ?? '',

                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            product.companyName ?? '',

                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// STATUS
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),

                        color: isActive
                            ? Colors.green.withOpacity(0.18)
                            : Colors.red.withOpacity(0.18),
                      ),

                      child: Text(
                        isActive ? "Active" : "Inactive",

                        style: TextStyle(
                          color: isActive
                              ? Colors.greenAccent
                              : Colors.redAccent,

                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// DESCRIPTION
                if (product.description != null &&
                    product.description!.isNotEmpty)
                  Text(
                    product.description ?? '',

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.70),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),

                const SizedBox(height: 18),

                /// INFO CARDS
                Row(
                  children: [

                    Expanded(
                      child: _historyInfoCard(
                        icon: Icons.currency_rupee_rounded,
                        title: "Amount",
                        value:
                        "₹${product.minAmount} - ₹${product.maxAmount}",
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _historyInfoCard(
                        icon: Icons.percent_rounded,
                        title: "Interest",
                        value:
                        "${product.interestRate ?? '0'}%",
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _historyInfoCard(
                        icon: Icons.schedule_rounded,
                        title: "Tenure",
                        value:
                        "${product.tenure ?? '0'} M",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// BOTTOM ACTIONS
                Row(
                  children: [

                    /// TYPE CHIP
                    if (product.companyName != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),

                          color: Colors.blue.withOpacity(0.12),
                        ),

                        child: Text(
                          product.companyName ?? '',

                          style: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    const Spacer(),

                    /// DETAILS BUTTON
                    InkWell(
                      borderRadius: BorderRadius.circular(14),

                      onTap: () {
                        _showProductBottomSheet(product);
                      },

                      child: Container(
                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(14),

                          color: Colors.white.withOpacity(0.06),
                        ),

                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _historyInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 10,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        color: Colors.white.withOpacity(0.05),

        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),

          const SizedBox(height: 8),

          Text(
            title,

            style: TextStyle(
              color: Colors.white.withOpacity(0.60),
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,

            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showProductBottomSheet(ServiceProductsData product) {
    final isActive = product.status == 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.82,
          maxChildSize: 0.95,
          minChildSize: 0.55,

          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(34),
                ),

                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  colors: [
                    Color(0xff161A24),
                    Color(0xff0F1117),
                  ],
                ),
              ),

              child: SingleChildScrollView(
                controller: controller,

                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    /// DRAG HANDLE
                    Center(
                      child: Container(
                        height: 5,
                        width: 60,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white24,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// HEADER CARD
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),

                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,

                          colors: [
                            const Color(0xff6C63FF)
                                .withOpacity(0.35),

                            Colors.white.withOpacity(0.05),
                          ],
                        ),

                        border: Border.all(
                          color: Colors.white10,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          /// ICON
                          Container(
                            height: 62,
                            width: 62,

                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(20),

                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff6C63FF),
                                  Color(0xff8F67FF),
                                ],
                              ),
                            ),

                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  product.name ?? '',

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  product.companyName ?? '',

                                  style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.65),

                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                      30,
                                    ),

                                    color: isActive
                                        ? Colors.green
                                        .withOpacity(0.18)
                                        : Colors.red
                                        .withOpacity(0.18),
                                  ),

                                  child: Text(
                                    isActive
                                        ? "Active"
                                        : "Inactive",

                                    style: TextStyle(
                                      color: isActive
                                          ? Colors.greenAccent
                                          : Colors.redAccent,

                                      fontWeight:
                                      FontWeight.w600,

                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// QUICK STATS
                    Row(
                      children: [

                        Expanded(
                          child: _bottomStatCard(
                            icon:
                            Icons.currency_rupee_rounded,
                            title: "Min Amount",
                            value:
                            "₹${product.minAmount ?? '0'}",
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _bottomStatCard(
                            icon:
                            Icons.percent_rounded,
                            title: "Interest",
                            value:
                            "${product.interestRate ?? '0'}%",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [

                        Expanded(
                          child: _bottomStatCard(
                            icon:
                            Icons.account_balance_wallet,
                            title: "Max Amount",
                            value:
                            "₹${product.maxAmount ?? '0'}",
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _bottomStatCard(
                            icon:
                            Icons.schedule_rounded,
                            title: "Tenure",
                            value:
                            "${product.tenure ?? '0'} Months",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// DETAILS SECTION
                    _modernSection(
                      title: "Product Details",

                      child: Column(
                        children: [

                          _modernTile(
                            icon: Icons.category_outlined,
                            title: "Type",
                            value: product.companyName ?? 'N/A',
                          ),

                          _modernTile(
                            icon: Icons.workspace_premium,
                            title: "Premium",
                            value:
                            product.premium ?? 'N/A',
                          ),

                          _modernTile(
                            icon: Icons.verified_user,
                            title: "Status",
                            value: isActive
                                ? "Active"
                                : "Inactive",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// DESCRIPTION
                    if (product.description != null &&
                        product.description!
                            .trim()
                            .isNotEmpty)
                      _modernSection(
                        title: "Description",

                        child: Text(
                          product.description ?? '',

                          style: TextStyle(
                            color:
                            Colors.white.withOpacity(0.72),

                            height: 1.7,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    if (product.description != null)
                      const SizedBox(height: 22),

                    /// ELIGIBILITY
                    if (product.eligibility != null &&
                        product.eligibility!
                            .trim()
                            .isNotEmpty)
                      _modernSection(
                        title: "Eligibility",

                        child: Text(
                          product.eligibility ?? '',

                          style: TextStyle(
                            color:
                            Colors.white.withOpacity(0.72),

                            height: 1.7,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    if (product.eligibility != null)
                      const SizedBox(height: 22),

                    /// DOCUMENTS
                    if (product.requiredDocuments !=
                        null &&
                        product.requiredDocuments!
                            .trim()
                            .isNotEmpty)
                      _modernSection(
                        title: "Required Documents",

                        child: Text(
                          product.requiredDocuments ?? '',

                          style: TextStyle(
                            color:
                            Colors.white.withOpacity(0.72),

                            height: 1.7,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// STAT CARD
  Widget _bottomStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),

        color: Colors.white.withOpacity(0.05),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),

          const SizedBox(height: 10),

          Text(
            title,

            style: TextStyle(
              color: Colors.white.withOpacity(0.60),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION
  Widget _modernSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),

        color: Colors.white.withOpacity(0.05),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }

  /// TILE
  Widget _modernTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
