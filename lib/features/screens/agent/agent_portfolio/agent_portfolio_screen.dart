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
  State<AgentPortfolioScreen> createState() =>
      _AgentPortfolioScreenState();
}

class _AgentPortfolioScreenState
    extends State<AgentPortfolioScreen> {

  @override
  void initState() {

    Future.microtask(() {

      context
          .read<AgentPortfolioProvider>()
          .fetchCategroyPortfolio();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xff081C15),

      body: Stack(
        children: [

          /// BACKGROUND
          const AppGradientBackground(),

          /// MAIN UI
          SafeArea(
            child: Consumer<AgentPortfolioProvider>(
              builder: (context, provider, child) {

                return RefreshIndicator(

                  onRefresh: () async {

                    await provider
                        .fetchCategroyPortfolio();
                  },

                  child: SingleChildScrollView(

                    physics:
                    const AlwaysScrollableScrollPhysics(),

                    padding:
                    const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 10,
                      bottom: 100,
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// APP BAR
                        _buildHeader(),

                        const SizedBox(height: 24),

                        /// CATEGORY
                        _buildCategorySection(provider),

                        const SizedBox(height: 28),

                        /// TITLE
                        const Text(
                          "Portfolio Services",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// LOADING
                        if (provider.subCategoryLoading)
                          const Center(
                            child: Padding(
                              padding:
                              EdgeInsets.all(30),

                              child:
                              CircularProgressIndicator(),
                            ),
                          )

                        /// EMPTY
                        else if (provider
                            .serviceSubCategoryData
                            .isEmpty)

                          Container(

                            width: double.infinity,

                            padding:
                            const EdgeInsets.all(40),

                            decoration: BoxDecoration(

                              color: Colors.white
                                  .withOpacity(0.05),

                              borderRadius:
                              BorderRadius.circular(
                                  24),
                            ),

                            child: const Column(
                              children: [

                                Icon(
                                  Icons.inventory_2_outlined,
                                  color: Colors.white54,
                                  size: 50,
                                ),

                                SizedBox(height: 12),

                                Text(
                                  "No Portfolio Found",

                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )

                        /// GRID
                        else
                          GridView.builder(

                            itemCount: provider
                                .serviceSubCategoryData
                                .length,

                            shrinkWrap: true,

                            physics:
                            const NeverScrollableScrollPhysics(),

                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(

                              crossAxisCount: 2,

                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,

                              childAspectRatio: 0.76,
                            ),

                            itemBuilder:
                                (context, index) {

                              final item = provider
                                  .serviceSubCategoryData[index];

                              return InkWell(

                                borderRadius:
                                BorderRadius.circular(
                                    28),

                                onTap: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (context) =>
                                          AgentPortfolioProductScreen(

                                            category_id:
                                            provider.selectedCategoryId ??
                                                0,

                                            subCategoy_id:
                                            item.id ?? 0,

                                            appbarName:
                                            item.name ??
                                                '',
                                          ),
                                    ),
                                  );
                                },

                                child: Container(

                                  padding:
                                  const EdgeInsets.all(
                                      14),

                                  decoration: BoxDecoration(

                                    color: Colors.white
                                        .withOpacity(
                                        0.08),

                                    borderRadius:
                                    BorderRadius.circular(
                                        28),

                                    border: Border.all(
                                      color: Colors.white
                                          .withOpacity(
                                          0.05),
                                    ),
                                  ),

                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      /// TOP ICON
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,

                                        children: [

                                          Container(

                                            height: 65,
                                            width: 65,

                                            padding:
                                            const EdgeInsets
                                                .all(10),

                                            decoration:
                                            BoxDecoration(

                                              color: Colors
                                                  .white
                                                  .withOpacity(
                                                  0.08),

                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  20),
                                            ),

                                            child:
                                            (item.icon
                                                ?.isEmpty ??
                                                true)

                                                ? const Icon(
                                              Icons
                                                  .account_balance_wallet_outlined,

                                              color:
                                              Colors.greenAccent,

                                              size:
                                              34,
                                            )

                                                : ClipRRect(

                                              borderRadius:
                                              BorderRadius.circular(
                                                  14),

                                              child:
                                              Image.network(

                                                '${AppConfig.imageUrl}/${item.icon}',

                                                fit: BoxFit
                                                    .cover,
                                              ),
                                            ),
                                          ),

                                          Container(

                                            padding:
                                            const EdgeInsets
                                                .symmetric(

                                              horizontal:
                                              10,

                                              vertical:
                                              6,
                                            ),

                                            decoration:
                                            BoxDecoration(

                                              color: Colors
                                                  .greenAccent
                                                  .withOpacity(
                                                  0.12),

                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  14),
                                            ),

                                            child: Text(

                                              item.type ??
                                                  "Portfolio",

                                              style:
                                              const TextStyle(

                                                color: Colors
                                                    .greenAccent,

                                                fontSize:
                                                11,

                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Spacer(),

                                      /// NAME
                                      Text(

                                        item.name ??
                                            "N/A",

                                        maxLines: 2,

                                        overflow:
                                        TextOverflow
                                            .ellipsis,

                                        style:
                                        const TextStyle(

                                          color:
                                          Colors.white,

                                          fontSize: 17,

                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 8),

                                      /// VALUE
                                      Row(
                                        children: [

                                          const Icon(
                                            Icons
                                                .currency_rupee,

                                            color: Colors
                                                .greenAccent,

                                            size: 16,
                                          ),

                                          Expanded(
                                            child: Text(

                                              item.value ??
                                                  "00,000",

                                              overflow:
                                              TextOverflow
                                                  .ellipsis,

                                              style:
                                              TextStyle(

                                                color: Colors
                                                    .white
                                                    .withOpacity(
                                                    0.7),

                                                fontSize:
                                                14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                          height: 12),

                                      /// BUTTON
                                      Container(

                                        width:
                                        double.infinity,

                                        padding:
                                        const EdgeInsets
                                            .symmetric(

                                          vertical: 10,
                                        ),

                                        decoration:
                                        BoxDecoration(

                                          gradient:
                                          const LinearGradient(

                                            colors: [

                                              Color(
                                                  0xff22C55E),

                                              Color(
                                                  0xff16A34A),
                                            ],
                                          ),

                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              16),
                                        ),

                                        child: const Center(

                                          child: Text(

                                            "View Products",

                                            style:
                                            TextStyle(

                                              color:
                                              Colors.white,

                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                            ),
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// HEADER
  Widget _buildHeader() {

    return Row(

      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(

              "Portfolio",

              style: TextStyle(

                color: Colors.white,

                fontSize: 30,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(

              "Manage your services",

              style: TextStyle(

                color:
                Colors.white.withOpacity(0.7),

                fontSize: 14,
              ),
            ),
          ],
        ),

        Container(

          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(

            color:
            Colors.white.withOpacity(0.08),

            borderRadius:
            BorderRadius.circular(18),
          ),

          child: const Icon(

            Icons.notifications_none_rounded,

            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// CATEGORY SECTION
  Widget _buildCategorySection(
      AgentPortfolioProvider provider) {

    if (provider.categoryLoading) {

      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(

      height: 52,

      child: ListView.separated(

        scrollDirection: Axis.horizontal,

        itemCount:
        provider.serviceCategoryData.length,

        separatorBuilder: (_, __) =>
        const SizedBox(width: 12),

        itemBuilder: (context, index) {

          final category =
          provider.serviceCategoryData[index];

          final isSelected =
              provider.selectedCategoryId ==
                  category.id;

          return InkWell(

            borderRadius:
            BorderRadius.circular(18),

            onTap: () async {

              await provider
                  .fetchSubCategoryPortfolio(
                category.id ?? 0,
              );
            },

            child: AnimatedContainer(

              duration:
              const Duration(milliseconds: 250),

              padding:
              const EdgeInsets.symmetric(

                horizontal: 22,
                vertical: 14,
              ),

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(18),

                gradient: isSelected

                    ? const LinearGradient(

                  colors: [

                    Color(0xff22C55E),

                    Color(0xff16A34A),
                  ],
                )

                    : null,

                color: isSelected
                    ? null
                    : Colors.white
                    .withOpacity(0.08),

                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.05),
                ),
              ),

              child: Center(

                child: Text(

                  category.name ??
                      "Category",

                  style: TextStyle(

                    color: Colors.white,

                    fontWeight:
                    isSelected

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
}