import 'package:app_grownidhi/core/constants/app_images.dart';
import 'package:app_grownidhi/features/auth/splash/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/help_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SplashProvider>().init(context, this); // ✅ correct
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: AnimatedBuilder(
            animation: provider.progressController,
            builder: (context, _) {
              return Stack(
                children: [
                  /// Premium Gradient Background
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0.8, -0.8),
                          radius: 1.6,
                          colors: [
                            Color(0xFF134E4A),
                            Color(0xFF0B1E2D),
                            Color(0xFF2E1A47),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Floating Finance Icons
                  _floatingIcon(
                    Icons.trending_up,
                    top: 120,
                    left: 60,
                    animationValue: provider.progressAnimation.value,
                  ),

                  _floatingIcon(
                    Icons.account_balance_wallet_outlined,
                    top: 180,
                    right: 70,
                    animationValue: provider.progressAnimation.value,
                  ),

                  _floatingIcon(
                    Icons.shield_outlined,
                    bottom: 50,
                    left: 30,
                    animationValue: provider.progressAnimation.value,
                  ),

                  _floatingIcon(
                    Icons.bar_chart,
                    bottom: 120,
                    right: 60,
                    animationValue: provider.progressAnimation.value,
                  ),

                  /// Main Center UI
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Animated Logo Glow
                        ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.85,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: provider.progressController,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xFF132B3A),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: const Color(0xFF2EE6A6).withOpacity(0.4),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF2EE6A6).withOpacity(0.35),
                                  blurRadius: 35,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                AppImages.appLogo,
                                height: 75,
                              ),
                            ),
                          ),
                        ),

                       spaceHeight(35),

                        FadeTransition(
                          opacity: provider.progressAnimation,
                          child: const Text(
                            "Grownidhi",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),

                       spaceHeight(12),

                        FadeTransition(
                          opacity: provider.progressAnimation,
                          child: const Text(
                            "Smart Financial Management",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF7EE7C1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                       spaceHeight(60),

                        /// Premium Progress Bar
                        SizedBox(
                          width: 240,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: provider.progressAnimation.value,
                              minHeight: 7,
                              backgroundColor: Colors.white.withOpacity(0.12),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF2EE6A6),
                              ),
                            ),
                          ),
                        ),

                       spaceHeight(15),

                        FadeTransition(
                          opacity: provider.progressAnimation,
                          child: Text(
                            "Preparing your dashboard...",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Floating Particles
                  ...List.generate(
                    20,
                        (index) => Positioned(
                      left: (index * 30) %
                          MediaQuery.of(context).size.width,
                      top: (index * 55) %
                          MediaQuery.of(context).size.height,
                      child: Opacity(
                        opacity: 0.15,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            -30 * provider.progressAnimation.value,
                          ),
                          child: const CircleAvatar(
                            radius: 2.5,
                            backgroundColor: Color(0xFF2EE6A6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _floatingIcon(
      IconData icon, {
        double? top,
        double? left,
        double? right,
        double? bottom,
        required double animationValue,
      }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.translate(
        offset: Offset(0, -10 * animationValue),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.9, end: 1.1),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF7EE7C1),
                  size: 22,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

