import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/help_widget.dart';
import '../agent_portfolio_product/agent_portfolio_product_screen.dart';
import 'agent_portfolio_provider.dart';

class AgentPortfolioScreen extends StatefulWidget {
  const AgentPortfolioScreen({super.key});

  @override
  State<AgentPortfolioScreen> createState() => _AgentPortfolioScreenState();
}

class _AgentPortfolioScreenState extends State<AgentPortfolioScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentPortfolioProvider>().fetchCategroyPortfolio();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          AppGradientBackground(),

          /*          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1A1A40),
                  Color(0xff270082),
                  Color(0xff7A0BC0),
                ],

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          )*/
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 20, bottom: 100),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Portfolio",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Manage your assets",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),

                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Consumer<AgentPortfolioProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// CATEGORY LOADING
                        if (provider.categoryLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else
                          /// CATEGORY LIST
                          SizedBox(
                            height: 52,

                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,

                              itemCount: provider.serviceCategoryData.length,

                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),

                              itemBuilder: (context, index) {
                                final category =
                                    provider.serviceCategoryData[index];

                                final isSelected =
                                    provider.selectedCategoryId == category.id;

                                return GestureDetector(
                                  onTap: () async {
                                    provider.selectedCategoryId = category.id;

                                    provider.notifyListeners();

                                    await provider.fetchSubCategoryPortfolio(
                                      category.id ?? 0,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),

                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 14,
                                    ),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),

                                      gradient: isSelected
                                          ? const LinearGradient(
                                              colors: [
                                                Color(0xff00DBDE),
                                                Color(0xffFC00FF),
                                              ],
                                            )
                                          : null,

                                      color: isSelected ? null : Colors.white,
                                    ),

                                    child: Center(
                                      child: Text(
                                        category.name ?? "Category",

                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,

                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 28),

                        /// SUB CATEGORY TITLE
                        const Text(
                          "Portfolio Services",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// SUB CATEGORY LOADING
                        if (provider.subCategoryLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (provider.serviceSubCategoryData.isEmpty)
                          /// EMPTY
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text("No Portfolio Found"),
                            ),
                          )
                        else
                          /// SUB CATEGORY GRID
                          GridView.builder(
                            itemCount: provider.serviceSubCategoryData.length,

                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.82,
                                ),

                            itemBuilder: (context, index) {
                              final item =
                                  provider.serviceSubCategoryData[index];

                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AgentPortfolioProductScreen(
                                          category_id:
                                              provider.selectedCategoryId ?? 0,
                                          subCategoy_id: item.id ?? 0,
                                          appbarName: item.name ?? '',
                                        ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),

                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.deepPurple.withOpacity(0.15),

                                        Colors.blue.withOpacity(0.08),
                                      ],
                                    ),

                                    border: Border.all(
                                      color: Colors.deepPurple.withOpacity(
                                        0.10,
                                      ),
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      /// ICON
                                      Container(
                                        padding: const EdgeInsets.all(14),

                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),

                                        child:(item.icon?.isEmpty ?? true)
                                  ? const Icon(
                                          Icons.account_balance_wallet,
                                          color: Colors.deepPurple,
                                          size: 30,
                                        ): 
                                        Image.network('${AppConfig.imageUrl}/${item.icon}',height: 75,fit: BoxFit.cover,),
                                      ),

                                      const Spacer(),

                                      /// NAME
                                      Text(
                                        item.name ?? "N/A",

                                        maxLines: 2,

                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 5),
                                      /// VALUE
                                      Text(
                                        item.value ?? "₹ 00,000",

                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      /// TYPE BADGE
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 7,
                                        ),

                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.withOpacity(
                                            0.08,
                                          ),

                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),

                                        child: Text(
                                          item.type ?? "Portfolio",

                                          style: const TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
