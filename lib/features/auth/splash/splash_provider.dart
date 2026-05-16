import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import '../../../../routes/route_names.dart';

class SplashProvider extends BaseProvider {
  late AnimationController progressController;
  late Animation<double> progressAnimation;

  void init(BuildContext context, TickerProvider vsync) {
    progressController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    );

    progressAnimation = CurvedAnimation(
      parent: progressController,
      curve: Curves.easeInOut,
    );
    progressController.forward();

    Future.delayed(const Duration(seconds: 4), () async {
      final userToken = await StorageService.getUserToken();
      final userType = await StorageService.getUserType();
      print('mbhvdvjvfhdkhdb=> ${userToken}');
      if (userToken != null &&
          userToken.isNotEmpty &&
          userType != null &&
          userType.isNotEmpty) {
        if (userType == 'individual') {
          navigateAndClearStack(context, RouteNames.bottomNavigationScreen);
        } else if(userType == 'agent') {
          navigateAndClearStack(
            context,
            RouteNames.agentBottomNavigationScreen,
          );
        }
      } else {
        navigateAndClearStack(context, RouteNames.onBoardingScreen);
      }
    });
    notifyListeners();
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }
}
