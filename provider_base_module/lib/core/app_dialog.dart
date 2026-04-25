import 'package:base_module/core/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDialogs {
  static Future<bool> showExitDialog(BuildContext context) async {
    final result = await _showAnimatedDialog(
      context,
      title: "Exit App",
      message: "Are you sure you want to exit the app?",
      confirmText: "Exit",
      icon: Icons.exit_to_app_rounded,
      confirmColor: Colors.redAccent,
    );

    if (result == true) {
      SystemNavigator.pop();
    }

    return result ?? false;
  }

  static Future<bool> showLogoutDialog(BuildContext context, String routesName) async {
    final result = await _showAnimatedDialog(
      context,
      title: "Logout",
      message: "Are you sure you want to logout?",
      confirmText: "Logout",
      icon: Icons.logout_rounded,
      confirmColor: Colors.orange,
    );

    if (result == true) {
      await StorageService.clearAllData();
      Navigator.popAndPushNamed(context,routesName);
    }

    return result ?? false;
  }

  static Future<bool?> _showAnimatedDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required IconData icon,
    required Color confirmColor,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: title,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(
            animation.value,
          ),
          child: Opacity(
            opacity: animation.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(icon, color: confirmColor),
                  const SizedBox(width: 10),
                  Text(title),
                ],
              ),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
