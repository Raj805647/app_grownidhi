import 'package:app_grownidhi/routes/route_names.dart';
import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends BaseProvider {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  bool isLoad = false;
  String selectedType = "individual";


  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  bool isPasswordMatching() {
    return passwordController.text == confirmPasswordController.text;
  }


  void setUserType(String value) {
    selectedType = value;
    notifyListeners();
  }

  Future<void> submitRegister(BuildContext context) async {
    try {
      isLoad = true;
      notifyListeners();

      final Map<String, dynamic> bodyData = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": numberController.text.trim(),
        "type": selectedType,
        "password": passwordController.text.trim(),
      };

      print("📤 Request Body: $bodyData");
      final response = await authRepository.signUp(bodyData);

      print("✅ Success: ${response.isSuccess}");
      print("📥 Response Data: ${response.data}");

      isLoad = false;
      notifyListeners();
      if (response.isSuccess == true) {
        final resData = response.data;

        if (resData['status'] == true) {
          // ✅ SUCCESS CASE
          UserData user = UserData.fromJson(resData['data']);

          await StorageService.setToken(user.token ?? '');
          await StorageService.setUserId(user.id ?? 0);
          await StorageService.setUserType(user.type);
          await StorageService.setUserData(user);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account created successfully 🎉")),
          );

          navigateAndClearStack(context, RouteNames.bottomNavigationScreen);
          controllerClear();
        } else {
          // ❌ API LEVEL FAILURE (like Already Registered)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(resData['message'] ?? "Something went wrong")),
          );
          controllerClear();
        }

      } else {
        // ❌ NETWORK / SERVER ERROR
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.error ?? "Server error")),
        );
        controllerClear();
      }
    } catch (error, stackTrace) {
      isLoad = false;
      notifyListeners();
      print("❌ Error: $error");
      print("📍 StackTrace: $stackTrace");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong: $error")));
    }
  }

  void controllerClear() {
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    emailController.clear();
    numberController.clear();
  }
}
