import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/ui_design.dart';
import 'agent_portfolio_product_provider.dart';

class AgentPortfolioProductScreen extends StatefulWidget {
  final int category_id, subCategoy_id;
  const AgentPortfolioProductScreen({
    super.key,
    required this.category_id,
    required this.subCategoy_id,
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
      appBar: CustomAppBar(title: 'widget.title'),
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
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.productListData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
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

  /// Build Individual Product Card
  Widget _buildProductCard(dynamic product) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details screen
        _navigateToProductDetails(product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image Section
            _buildProductImage(product),

            /// Product Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Name
                        Text(
                          product.name ?? "Product Name",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 6),

                        /// Product Category/Type
                        if (product.category != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              product.category,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                        const SizedBox(height: 8),

                        /// Short Description
                        if (product.description != null)
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),

                    /// Price and Action Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Price
                        if (product.price != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _formatPrice(product.price),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ),

                        const SizedBox(height: 8),

                        /// View Details Button
                        Container(
                          width: double.infinity,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade400, Colors.blue.shade700],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Product Image Section
  Widget _buildProductImage(dynamic product) {
    return Stack(
      children: [
        /// Main Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          child: product.imageUrl != null && product.imageUrl.isNotEmpty
              ? Image.network(
            product.imageUrl,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderImage();
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _buildLoadingImage();
            },
          )
              : _buildPlaceholderImage(),
        ),

        /// Badge/Tag (Optional)
        if (product.isPopular == true)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Text(
                "POPULAR",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        /// Favorite Button (Optional)
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () {
              _toggleFavorite(product);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: product.isFavorite == true ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Placeholder Image for Products
  Widget _buildPlaceholderImage() {
    return Container(
      height: 140,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 40,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            "No Image",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  /// Loading Image Placeholder
  Widget _buildLoadingImage() {
    return Container(
      height: 140,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Format Price
  String _formatPrice(dynamic price) {
    if (price == null) return "Price on Request";
    try {
      final numPrice = double.parse(price.toString());
      return "₹${numPrice.toStringAsFixed(0)}";
    } catch (e) {
      return price.toString();
    }
  }

  /// Navigate to Product Details
  void _navigateToProductDetails(dynamic product) {
    // Implement navigation to product details screen
    // Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)));
    debugPrint("Navigate to product details: ${product.name}");
  }

  /// Toggle Favorite
  void _toggleFavorite(dynamic product) {
    setState(() {
      product.isFavorite = !(product.isFavorite ?? false);
    });
    // Implement API call to save favorite status
    debugPrint("Toggle favorite for product: ${product.name}");
  }
}