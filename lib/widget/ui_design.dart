import 'package:flutter/material.dart';

class AppGradientBackground extends StatelessWidget {
  final Widget? child;
  final bool showGlowEffect;

  const AppGradientBackground({
    super.key,
    this.child,
    this.showGlowEffect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Main Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB9E4D5),
                Color(0xFF90C3A9),
                Color(0xFF8FAFD1),
              ],
            ),
          ),
        ),

        /// Soft Glow Overlay
        if (showGlowEffect)
          Positioned(
            top: -80,
            right: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),

        /// Bottom Glow
        if (showGlowEffect)
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),

        /// Optional Child Content
        if (child != null) child!,
      ],
    );
  }
}