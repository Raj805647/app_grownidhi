import 'package:app_grownidhi/features/auth/sign_up/sign_up_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_bottom_bar/agent_bottom_bar_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_client_data/agent_client_data_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_dashboard/agent_dashboard_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_dashboard/agent_dashboard_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_earning/agent_earning_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_earning/agent_earning_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_my_profile_edit/agent_my_profile_edit_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_notification/agent_notification_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_portfolio/agent_portfolio_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_portfolio/agent_portfolio_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_report/agent_report_provider.dart';
import 'package:app_grownidhi/features/screens/agent/agent_report/agent_report_provider.dart';
import 'package:app_grownidhi/features/screens/individual/calender/calender_provider.dart';
import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_provider.dart';
import 'package:app_grownidhi/features/screens/individual/home/home_provider.dart';
import 'package:app_grownidhi/features/screens/individual/individivual_add_member/individivual_add_member_provider.dart';
import 'package:app_grownidhi/features/screens/individual/individual_members/individual_members_provider.dart';
import 'package:app_grownidhi/features/screens/individual/kyc_update/kyc_update_provider.dart';
import 'package:app_grownidhi/features/screens/individual/portfolio/portfolio_provider.dart';
import 'package:provider/provider.dart';

import '../features/auth/onboarding/onboarding_provider.dart';
import '../features/auth/sign_in/sign_in_controller.dart';
import '../features/auth/splash/splash_provider.dart';
import '../features/screens/agent/agent_add_client_data/agent_add_client_data_provider.dart';
import '../features/screens/agent/agent_client_add_update_profile/agent_client_add_update_profile_provider.dart';
import '../features/screens/agent/agent_client_apply_form/agent_client_apply_form_provider.dart';
import '../features/screens/agent/agent_client_details/agent_client_details_provider.dart';
import '../features/screens/agent/agent_client_member_update_create/agent_client_member_update_create_provider.dart';
import '../features/screens/agent/agent_client_profile_details/agent_client_profile_details_provider.dart';
import '../features/screens/agent/agent_kyc/agent_kyc_provider.dart';
import '../features/screens/agent/agent_my_profile/agent_my_profile_provider.dart';
import '../features/screens/agent/agent_portfolio_product/agent_portfolio_product_provider.dart';
import '../features/screens/individual/add_product/add_product_provider.dart';
import '../features/screens/individual/add_product_details/add_product_details_provider.dart';
import '../features/screens/individual/bottom_bar/bottom_bar_provider.dart';
import '../features/screens/individual/individual_profile_details/individual_profile_details_provider.dart';
import '../features/screens/individual/individual_setting/individual_setting_provider.dart';
import '../features/screens/individual/product/product_provider.dart';
import '../features/screens/individual/product_details/product_details_provider.dart';
import '../features/screens/individual/show_cate_subcate_data/show_cate_subcate_data_provider.dart';

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
    ChangeNotifierProvider<ShowCateSubcateDataProvider>(create: (_) => ShowCateSubcateDataProvider()),
    ChangeNotifierProvider<ProductDetailProvider>(create: (_) => ProductDetailProvider()),
    ChangeNotifierProvider<CalenderProvider>(create: (_) => CalenderProvider()),
    ChangeNotifierProvider<IndividualSettingProvider>(create: (_) => IndividualSettingProvider()),
    ChangeNotifierProvider<IndividualProfileDetailsProvider>(create: (_) => IndividualProfileDetailsProvider()),
    ChangeNotifierProvider<KycUpdateProvider>(create: (_) => KycUpdateProvider()),
    ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
    ChangeNotifierProvider<FormSubmitDetailsProvider>(create: (_) => FormSubmitDetailsProvider()),
    ChangeNotifierProvider<PortfolioProvider>(create: (_) => PortfolioProvider()),
    ChangeNotifierProvider<IndividualAddMemberProvider>(create: (_) => IndividualAddMemberProvider()),
    ChangeNotifierProvider<IndividualMembersProvider>(create: (_) => IndividualMembersProvider()),

    //individual provider
    ChangeNotifierProvider<AgentBottomBarProvider>(create: (_) => AgentBottomBarProvider()),
    ChangeNotifierProvider<AgentDashboardProvider>(create: (_) => AgentDashboardProvider()),
    ChangeNotifierProvider<AgentPortfolioProvider>(create: (_) => AgentPortfolioProvider()),
    ChangeNotifierProvider<AgentReportProvider>(create: (_) => AgentReportProvider()),
    ChangeNotifierProvider<AgentEarningProvider>(create: (_) => AgentEarningProvider()),
    ChangeNotifierProvider<AgentMyProfileProvider>(create: (_) => AgentMyProfileProvider()),
    ChangeNotifierProvider<AgentMyProfileEditProvider>(create: (_) => AgentMyProfileEditProvider()),
    ChangeNotifierProvider<AgentKycProvider>(create: (_) => AgentKycProvider()),
    ChangeNotifierProvider<AgentClientDataProvider>(create: (_) => AgentClientDataProvider()),
    ChangeNotifierProvider<AgentAddClientDataProvider>(create: (_) => AgentAddClientDataProvider()),
    ChangeNotifierProvider<AgentClientDetailsProvider>(create: (_) => AgentClientDetailsProvider()),
    ChangeNotifierProvider<AgentClientMemberUpdateCreateProvider>(create: (_) => AgentClientMemberUpdateCreateProvider()),
    ChangeNotifierProvider<AgentPortfolioProductProvider>(create: (_) => AgentPortfolioProductProvider()),
    ChangeNotifierProvider<AgentPortfolioProductProvider>(create: (_) => AgentPortfolioProductProvider()),
    ChangeNotifierProvider<AgentClientApplyFormProvider>(create: (_) => AgentClientApplyFormProvider()),
    ChangeNotifierProvider<AgentClientAddUpdateProfileProvider>(create: (_) => AgentClientAddUpdateProfileProvider()),
    ChangeNotifierProvider<AgentClientProfileDetailsProvider>(create: (_) => AgentClientProfileDetailsProvider()),
    ChangeNotifierProvider<AgentNotificationProvider>(create: (_) => AgentNotificationProvider()),
  ];
}
