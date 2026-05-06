import 'package:app_grownidhi/features/screens/form_submit_details/form_submit_details_screen.dart';
import 'package:app_grownidhi/features/screens/product/product_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        widget.item.id ?? 0,
        widget.item.categoryId ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Search Field
          _buildSearchField(),

          // Products List
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
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
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.all(16),
        child: customTextField(
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
      ),
    );
  }

  Widget _buildProductCard(
    ServiceProductsData product,
    ProductProvider provider,
  ) {
    final isActive = product.status == 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FormSubmitDetailsScreen(id: product.id ?? 0),
            ),
          );
          provider.navigateTo(
            context,
            RouteNames.formSubmitDetailsScreen,
            arguments: product.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Company
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.companyName ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isActive ? "Active" : "Inactive",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  /// Details Icon
                  InkWell(
                    onTap: () {
                      _showProductBottomSheet(product);
                    },
                    child: const Icon(Icons.info_outline, size: 18),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Divider
              Divider(color: Colors.grey.shade200, height: 1),

              const SizedBox(height: 10),

              /// Info Row (Icons + Data)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoItem(
                    Icons.currency_rupee,
                    "${product.minAmount} - ${product.maxAmount}",
                  ),
                  _infoItem(Icons.percent, "${product.interestRate}%"),
                  _infoItem(Icons.timer, "${product.tenure}m"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _showProductBottomSheet(ServiceProductsData product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    product.companyName ?? '',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 16),

                  /// Info rows with icons
                  _detailTile(
                    Icons.currency_rupee,
                    "Min Amount",
                    "₹${product.minAmount}",
                  ),
                  _detailTile(
                    Icons.currency_rupee,
                    "Max Amount",
                    "₹${product.maxAmount}",
                  ),
                  _detailTile(
                    Icons.percent,
                    "Interest",
                    "${product.interestRate}%",
                  ),
                  _detailTile(
                    Icons.timer,
                    "Tenure",
                    "${product.tenure} months",
                  ),
                  _detailTile(
                    Icons.verified,
                    "Status",
                    product.status.toString(),
                  ),

                  if (product.premium != null)
                    _detailTile(Icons.star, "Premium", product.premium!),

                  const Divider(),

                  /// Expand sections
                  if (product.description != null)
                    _section("Description", product.description!),

                  if (product.eligibility != null)
                    _section("Eligibility", product.eligibility!),

                  if (product.requiredDocuments != null)
                    _section("Documents", product.requiredDocuments!),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: const TextStyle(fontSize: 13)),
      subtitle: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(content, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}
