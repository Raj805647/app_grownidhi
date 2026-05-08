import 'package:app_grownidhi/features/screens/agent/agent_bottom_bar/agent_bottom_bar_screen.dart';
import 'package:app_grownidhi/features/screens/agent/agent_dashboard/agent_dashboard_screen.dart';
import 'package:app_grownidhi/features/screens/agent/agent_earning/agent_earning_screen.dart';
import 'package:app_grownidhi/features/screens/agent/agent_portfolio/agent_portfolio_screen.dart';
import 'package:app_grownidhi/features/screens/agent/agent_report/agent_report_screen.dart';
import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_screen.dart';
import 'package:app_grownidhi/features/screens/individual/home/home_screen.dart';
import 'package:app_grownidhi/features/screens/individual/kyc_update/kyc_update_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/onboarding/onboarding_screen.dart';
import '../features/auth/sign_in/sign_in_screen.dart';
import '../features/auth/sign_up/sign_up_screen.dart';
import '../features/auth/splash/splash_screen.dart';
import '../features/screens/agent/agent_my_profile/agent_my_profile_screen.dart';
import '../features/screens/individual/add_product/add_product_screen.dart';
import '../features/screens/individual/add_product_details/add_product_details_screen.dart';
import '../features/screens/individual/all_service/all_service_screen.dart';
import '../features/screens/individual/bottom_bar/bottom_bar_screen.dart';
import '../features/screens/individual/calender/calender_screen.dart';
import '../features/screens/individual/product/product_screen.dart';
import '../features/screens/individual/product_details/product_details_screen.dart';
import '../features/screens/individual/profile/profile_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    // Auth Screens
    RouteNames.splashScreen: (context) => SplashScreen(),
    RouteNames.onBoardingScreen: (context) => OnboardingScreen(),
    RouteNames.signInScreen: (context) => SignInScreen(),
    RouteNames.signUpScreen: (context) => SignUpScreen(),

    //individual Screens
    RouteNames.bottomNavigationScreen: (context) => BottomBarScreen(),
    RouteNames.homeScreen: (context) => HomeScreen(),
    RouteNames.addProductScreen: (context) => AddProductScreen(),
    RouteNames.addProductDetailsScreen: (context) => AddProductDetailsScreen(),
    RouteNames.portfolioScreen: (context) => AllServiceScreen(),
    RouteNames.productDetailScreen: (context) => ProductDetailScreen(),
    RouteNames.calendarScreen: (context) => CalendarScreen(),
    RouteNames.profileScreen: (context) => ProfileScreen(),
    RouteNames.kycScreen: (context) => KycUpdateScreen(),

    //agent scree
    RouteNames.agentBottomNavigationScreen: (context) => AgentBottomBarScreen(),
    RouteNames.agentDashBoardScreen: (context) => AgentDashboardScreen(),
    RouteNames.agentEarningScreen: (context) => AgentEarningScreen(),
    RouteNames.agentPortfolioScreen: (context) => AgentPortfolioScreen(),
    RouteNames.agentReportScreen: (context) => AgentReportScreen(),
    RouteNames.agentMyProfileScreen: (context) => AgentMyProfileScreen(),

  };

}