import 'package:app_grownidhi/routes/app_routes.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:base_module/core/models/base_model.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:base_module/core/storage/storage_service.dart';
import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider {
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  bool isLoad = false;

  void sendOtp(BuildContext context) async {
    Map<String, dynamic> body = {
      "mobile": mobileController.text,
      "type": "individual",
    };

    final response = await authRepository.signInSendOtp(body);
    print('adjsvhfdsavf=>${response.data}');
    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP sent successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error ?? "Failed to send OTP"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> sendOtpVerify(BuildContext context) async {
    try {
      isLoad = true;
      notifyListeners();

      Map<String, dynamic> body = {
        "mobile": mobileController.text.trim(),
        "otp": otpController.text,
      };
      final response = await authRepository.signInVerifyOtp(body);

      if (response.isSuccess == true) {
        final userMap = response.data['data']; // ✅ correct level
        final user = UserData.fromJson(userMap); // ✅ convert

        StorageService.setUserData(user); // ✅ FIXED
        StorageService.setUserId(user.id ?? 0);
        StorageService.setUserType(user.role ?? '');
        StorageService.setToken(user.token ?? '');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        navigateAndClearStack(context, RouteNames.bottomNavigationScreen);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Something went wrong")),
        );
      }
    } catch (e) {
      isLoad = false;
      notifyListeners();

      print("Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error. Please try again.")),
      );
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
