import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_details_screen.dart';
import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_loader.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/portfolio_details_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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


  Widget buildPortfolioCard(PortfolioDetailsData portfolioData) {
    return InkWell(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder:  (context) => PortfolioDetailsScreen(formDetails: portfolioData.formDetails ?? {},))),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric( vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Status
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(portfolioData.status ?? '').withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(portfolioData.status ?? ''),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(portfolioData.status ?? ''),
                            size: 14,
                            color: _getStatusColor(portfolioData.status ?? ''),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            portfolioData.status!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(portfolioData.status ?? ''),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Policy ID Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'ID: ${portfolioData.policyId}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
               spaceHeight( 10),
      
                // Product Name & Service Type
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            portfolioData.productName ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                         spaceHeight( 2),
                          Text(
                            portfolioData.serviceType ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        portfolioData.service ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
               spaceHeight( 10),
      
                // Application Number
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.numbers, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          portfolioData.applicationNumber ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Icon(Icons.copy, size: 14, color: Colors.grey.shade500),
                    ],
                  ),
                ),
               spaceHeight( 10),
      
                // User Info Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.person_outline, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              portfolioData.filledBy ?? '',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              portfolioData.userEmail ?? '',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               spaceHeight( 8),
      
                // Phone & Date Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            portfolioData.userPhone ?? '',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            portfolioData.formFilledAt ?? '',
                            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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

// Helper methods for status styling
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'approved':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
