import 'package:flutter/material.dart';

import 'help_widget.dart';

class CustomLoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final String text;
  final String loadingText;
  final double height;
  final BorderRadius? borderRadius;

  const CustomLoadingButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.text,
    this.loadingText = "Loading...",
    this.height = 50,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(30),
          gradient: customGradientDesign(),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? Row(
              key: const ValueKey("loading"),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
               spaceWidth( 10),
                Text(
                  loadingText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
                : Text(
              text,
              key: const ValueKey("text"),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}