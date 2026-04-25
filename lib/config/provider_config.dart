import 'package:app_grownidhi/features/screens/calender/calender_provider.dart';
import 'package:app_grownidhi/features/screens/home/home_provider.dart';
import 'package:app_grownidhi/features/screens/profile/profile_provider.dart';
import 'package:provider/provider.dart';

import '../features/auth/onboarding/onboarding_provider.dart';
import '../features/auth/sign_in/sign_in_controller.dart';
import '../features/auth/splash/splash_provider.dart';
import '../features/screens/add_product/add_product_provider.dart';
import '../features/screens/add_product_details/add_product_details_provider.dart';
import '../features/screens/bottom_bar/bottom_bar_provider.dart';
import '../features/screens/portfolio/portfolio_provider.dart';
import '../features/screens/product_details/product_details_provider.dart';

class ProviderConfig {
  static List<ChangeNotifierProvider> providers = [
    // auth provider
    ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
    ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
    ChangeNotifierProvider<OnboardingProvider>(create: (_) => OnboardingProvider()),

    //others provider
    ChangeNotifierProvider<BottomBarProvider>(create: (_) => BottomBarProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<AddProductProvider>(create: (_) => AddProductProvider()),
    ChangeNotifierProvider<AddProductDetailsProvider>(create: (_) => AddProductDetailsProvider()),
    ChangeNotifierProvider<PortfolioProvider>(create: (_) => PortfolioProvider()),
    ChangeNotifierProvider<ProductDetailProvider>(create: (_) => ProductDetailProvider()),
    ChangeNotifierProvider<CalenderProvider>(create: (_) => CalenderProvider()),
    ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),

  ];
}
