import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider {
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  bool isLoad = false;
  bool isOtpSent = false;

  void sendOtp(BuildContext context) async {
    Map<String, dynamic> body = {
      "mobile": mobileController.text,
      "type": "individual",
    };

    final response = await authRepository.signInSendOtp(body);
    if (response.isSuccess) {
      isOtpSent = true;
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

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
