import 'package:app_grownidhi/routes/app_routes.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:base_module/core/models/base_model.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:base_module/core/storage/storage_service.dart';
import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

class SignInProvider extends BaseProvider {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoad = false;

  Future<void> loginWithEmail(BuildContext context) async {
    try {
      isLoad = true;
      notifyListeners();

      final body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final response = await authRepository.signIn(body);
      print('akbdkfbjdsafbdsabf=> ${response.isSuccess}');
      print('akbdkfbjdsafbdsabf=> ${response.data}');

      isLoad = false;
      notifyListeners();
      if (response.isSuccess) {
        final userDataMap = response.data['data'];
        UserData user = UserData.fromJson(userDataMap);

        await StorageService.setToken(user.token ?? '');
        await StorageService.setUserId(user.id ?? 0);
        await StorageService.setUserType(user.type);
        await StorageService.setUserData(user);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful ✅")),
        );
        navigateAndClearStack(context, RouteNames.bottomNavigationScreen);
        controllerClear();
        // Navigate
      }
    } catch (e) {
      isLoad = false;
      notifyListeners();
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }
  void controllerClear() {
    emailController.dispose();
    passwordController.dispose();
  }
}
