import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'help_widget.dart';

class CustomLoader extends StatelessWidget {
  final String message;

  const CustomLoader({super.key, this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer rotating ring
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 2 * 3.14159),
                    duration: const Duration(seconds: 2),
                    builder: (context, double angle, child) {
                      return Transform.rotate(
                        angle: angle,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.pink, Colors.blue],
                            ),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(57),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Lottie animation
                  Lottie.asset(
                    'assets/animations/profile_loading.json',
                    height: 100,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ],
              ),
             spaceHeight(24),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),
              ),
             spaceHeight(12),
              // Pulsing dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPulsingDot(0),
                  _buildPulsingDot(1),
                  _buildPulsingDot(2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulsingDot(int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.5, end: 1.2),
      duration: Duration(milliseconds: 800 + (index * 200)),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.pink],
              ),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
