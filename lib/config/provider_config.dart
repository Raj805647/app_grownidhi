import 'package:app_grownidhi/features/auth/sign_up/sign_up_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_bottom_bar/agent_bottom_bar_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_dashboard/agent_dashboard_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_dashboard/agent_dashboard_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_earning/agent_earning_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_earning/agent_earning_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_portfolio/agent_portfolio_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_portfolio/agent_portfolio_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_report/agent_report_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_report/agent_report_provider.dart';
import 'package:app_grownidhi/features/screens/individual/calender/calender_provider.dart';
import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_provider.dart';
import 'package:app_grownidhi/features/screens/individual/home/home_provider.dart';
import 'package:app_grownidhi/features/screens/individual/kyc_update/kyc_update_provider.dart';
import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_provider.dart';
import 'package:app_grownidhi/features/screens/individual/profile/profile_provider.dart';
import 'package:provider/provider.dart';

import '../features/auth/onboarding/onboarding_provider.dart';
import '../features/auth/sign_in/sign_in_controller.dart';
import '../features/auth/splash/splash_provider.dart';
import '../features/screens/agent/agent_my_profile/agent_my_profile_provider.dart';
import '../features/screens/individual/add_product/add_product_provider.dart';
import '../features/screens/individual/portfolio/portfolio_provider.dart';
import '../features/screens/individual/add_product_details/add_product_details_provider.dart';
import '../features/screens/individual/all_service/all_service_provider.dart';
import '../features/screens/individual/bottom_bar/bottom_bar_provider.dart';
import '../features/screens/individual/product/product_provider.dart';
import '../features/screens/individual/product_details/product_details_provider.dart';

class ProviderConfig {
  static List<ChangeNotifierProvider> providers = [
    // auth provider
    ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
    ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
    ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
    ChangeNotifierProvider<OnboardingProvider>(create: (_) => OnboardingProvider()),

    //individual provider
    ChangeNotifierProvider<BottomBarProvider>(create: (_) => BottomBarProvider()),
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ChangeNotifierProvider<AddProductProvider>(create: (_) => AddProductProvider()),
    ChangeNotifierProvider<AddProductDetailsProvider>(create: (_) => AddProductDetailsProvider()),
    ChangeNotifierProvider<AllServiceProvider>(create: (_) => AllServiceProvider()),
    ChangeNotifierProvider<ProductDetailProvider>(create: (_) => ProductDetailProvider()),
    ChangeNotifierProvider<CalenderProvider>(create: (_) => CalenderProvider()),
    ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
    ChangeNotifierProvider<KycUpdateProvider>(create: (_) => KycUpdateProvider()),
    ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
    ChangeNotifierProvider<FormSubmitDetailsProvider>(create: (_) => FormSubmitDetailsProvider()),
    ChangeNotifierProvider<PortfolioProvider>(create: (_) => PortfolioProvider()),

    //individual provider
    ChangeNotifierProvider<AgentBottomBarProvider>(create: (_) => AgentBottomBarProvider()),
    ChangeNotifierProvider<AgentDashboardProvider>(create: (_) => AgentDashboardProvider()),
    ChangeNotifierProvider<AgentPortfolioProvider>(create: (_) => AgentPortfolioProvider()),
    ChangeNotifierProvider<AgentReportProvider>(create: (_) => AgentReportProvider()),
    ChangeNotifierProvider<AgentEarningProvider>(create: (_) => AgentEarningProvider()),
    ChangeNotifierProvider<AgentMyProfileProvider>(create: (_) => AgentMyProfileProvider()),

  ];
}
