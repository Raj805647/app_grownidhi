import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_details_screen.dart';
import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_loader.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/individual_product_policies_response.dart';
import 'package:base_module/core/models/portfolio_details_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_textfield.dart';
import '../../../../widget/help_widget.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PortfolioProvider>().fetchPortfolioData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          Consumer<PortfolioProvider>(
            builder: (context, provider, child) {
              if(provider.isLoading){
                return customLoader();
              }
              if(provider.portfolioList.isEmpty){
                return Center(child: Text('No Data Available'));
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildHeader(provider),
                    spaceHeight(50),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.portfolioList.length,
                      itemBuilder: (context, index) =>  buildPortfolioCard(provider.portfolioList[index]),

                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(PortfolioProvider provider) {
    return Row(
      children: [
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Portfolio",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text("${provider.portfolioList.length} products", style: TextStyle(color: Colors.grey)),
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


  Widget buildPortfolioCard(ProductPoliciesData portfolioData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PortfolioDetailsScreen(
              formDetails: portfolioData.formData ?? {},
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),

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
              color: Colors.black.withOpacity(0.15),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// PRODUCT ICON
            Container(
              height: 68,
              width: 68,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

                color: Colors.white.withOpacity(0.06),
              ),

              child: Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 34,
              ),
            ),

            const SizedBox(width: 14),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  /// TITLE + STATUS
                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          portfolioData.productName ?? '',

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      _statusBadge(
                        (portfolioData.status ?? '').toLowerCase(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// CATEGORY
                  Text(
                    portfolioData.categoryName ?? '',

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.70),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// CHIPS
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: [

                      _glassChip(
                        Icons.description_outlined,
                        portfolioData.applicationNo ?? '',
                      ),

                      _glassChip(
                        Icons.calendar_today_outlined,
                        formatDate(
                          portfolioData.createdAt,
                        ),
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
  Widget _statusBadge(String status) {

    final Color color = status == 'approved'
        ? Colors.greenAccent
        : status == 'rejected'
        ? Colors.redAccent
        : Colors.orangeAccent;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),

      child: Text(
        status.toUpperCase(),

        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _glassChip(IconData icon, String title) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

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
            size: 14,
            color: Colors.white70,
          ),

          const SizedBox(width: 6),

          Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
