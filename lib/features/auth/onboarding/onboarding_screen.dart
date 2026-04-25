import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/help_widget.dart';
import '../../../widget/ui_design.dart';
import 'onboarding_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Stack(
              children: [
                const AppGradientBackground(),

                /// Floating decorative icons
                _floatingFinanceIcon(Icons.trending_up, top: 100, left: 40),
                _floatingFinanceIcon(
                  Icons.account_balance_wallet_outlined,
                  top: 180,
                  right: 50,
                ),
                _floatingFinanceIcon(
                  Icons.shield_outlined,
                  bottom: 180,
                  left: 60,
                ),

                Column(
                  children: [
                    /// Skip button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextButton(
                          onPressed: () {
                            provider.navigateAndClearStack(context, RouteNames.signInScreen);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: Color(0xFF0B1E2D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: PageView(
                        controller: provider.pageController,
                        onPageChanged: provider.onPageChanged,
                        children:  [
                          _buildOnboardingPage(
                            icon: Icons.savings,
                            title: "Track Your Wealth",
                            subtitle:
                            "Manage income, expenses and savings effortlessly",
                          ),
                          _buildOnboardingPage(
                            icon: Icons.auto_graph,
                            title: "Smart Insights",
                            subtitle:
                            "AI-powered reports and personalized financial insights",
                          ),
                          _buildOnboardingPage(
                            icon: Icons.shield,
                            title: "Secure Investments",
                            subtitle:
                            "Your wealth protected with bank-level security",
                          ),
                        ],
                      ),
                    ),

                    _bottomSection(context, provider),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _bottomSection(BuildContext context, OnboardingProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          /// Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: provider.currentIndex == index ? 26 : 8,
                decoration: BoxDecoration(
                  color: provider.currentIndex == index
                      ? const Color(0xFF0E9F6E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

        spaceHeight( 25),

          /// CTA button
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                if (provider.isLastPage) {
                  provider.navigateAndClearStack(context, RouteNames.signInScreen);
                } else {
                  provider.nextPage();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E9F6E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(provider.isLastPage ? "Get Started" : "Next",style: TextStyle(color: Colors.white,fontSize: 20),),
            ),
          ),

        spaceHeight( 20),
        ],
      ),
    );
  }

  Widget _floatingFinanceIcon(
    IconData icon, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.95, end: 1.08),
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.55),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: const Color(0xFF0E9F6E), size: 22),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOnboardingPage({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 700),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Icon(icon, size: 90, color: const Color(0xFF0E9F6E)),
                ),
              );
            },
          ),

        spaceHeight( 50),

          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B1E2D),
            ),
          ),

        spaceHeight( 16),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
