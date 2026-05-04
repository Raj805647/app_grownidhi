import 'package:app_grownidhi/features/screens/home/home_screen.dart';
import 'package:app_grownidhi/features/screens/kyc_update/kyc_update_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/onboarding/onboarding_screen.dart';
import '../features/auth/sign_in/sign_in_screen.dart';
import '../features/auth/sign_up/sign_up_screen.dart';
import '../features/auth/splash/splash_screen.dart';
import '../features/screens/add_product/add_product_screen.dart';
import '../features/screens/add_product_details/add_product_details_screen.dart';
import '../features/screens/bottom_bar/bottom_bar_screen.dart';
import '../features/screens/calender/calender_screen.dart';
import '../features/screens/portfolio/portfolio_screen.dart';
import '../features/screens/product_details/product_details_screen.dart';
import '../features/screens/profile/profile_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    // Auth Screens
    RouteNames.splashScreen: (context) => SplashScreen(),
    RouteNames.onBoardingScreen: (context) => OnboardingScreen(),
    RouteNames.signInScreen: (context) => SignInScreen(),
    RouteNames.signUpScreen: (context) => SignUpScreen(),

    //others Screens
    RouteNames.bottomNavigationScreen: (context) => BottomBarScreen(),
    RouteNames.homeScreen: (context) => HomeScreen(),
    RouteNames.addProductScreen: (context) => AddProductScreen(),
    RouteNames.addProductDetailsScreen: (context) => AddProductDetailsScreen(),
    RouteNames.portfolioScreen: (context) => PortfolioScreen(),
    RouteNames.productDetailScreen: (context) => ProductDetailScreen(),
    RouteNames.calendarScreen: (context) => CalendarScreen(),
    RouteNames.profileScreen: (context) => ProfileScreen(),
    RouteNames.kycScreen: (context) => KycUpdateScreen(),
  };

}