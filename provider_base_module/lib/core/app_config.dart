class AppConfig {
  static const String apiTestUrl = "http://10.11.135.156:8000/api";
  static const String apiProdUrl = "https://app.grownidhi.com/api";
  static const String imageUrl = "https://app.grownidhi.com";
  static const String apiTestKey = "";
  static const String apiProdKey = "";
  static const reverseAddressApi = "";
  static const String mapApiKey = "";
  static const bool isProduction = true;

  static String get baseUrl => isProduction ? apiProdUrl : apiTestUrl;

  static String get apiKey => isProduction ? apiProdKey : apiTestKey;

  //auth api call
  static const String actionSignIn = '/login';
  static const String actionSignUp = '/register';

  //individual api endpoints
  static const String actionProfile = '/individualProfessionalDetails';
  static const String actionServiceCategory = '/categories';
  static const String actionServiceSubsCategory = '/subcategories';
  static const String actionServiceProductDetails = '/products';
  static const String actionFormStateDetails = '/individual/products/apply-form';
  static const String actionPolicyDetails = '/individual/policies';
  static const String actionUpdateProfile = '/profile/update';
  static const String actionSubmitFormDetails = '/individualKycAddOrUpdate';
  static const String actionAddUpdateMembers = '/storeOrUpdateFamilyMember';
  static const String actionIndividualKYC = '/storeOrUpdateIndividualKyc';
  static const String actionIndividualKYCData = '/individualKyc';
  static const String actionIndividuaFamilyMember = '/familyMembers';
  static const String actionIndividualDeleteFamilyMember = '/deleteFamilyMember';
  static const String actionIndividualCompany = '/companies';
  static const String actionIndividualDashboard = '/individual-dashboard';
  static const String actionIndividualAgent = '/company_id';
  static const String actionIndividualSubmitProduct = '/individual/submit-product-application';
  static const String actionIndividualNotification = '/individual/notifications';

  // agents api endpoints
  static const String actionAgentDashboard = '/agent/dashboard_count';
  static const String actionAgentProfile = '/getAagentDetails';
  static const String actionUpdateAgentProfile = '/storeOrUpdateAagentDetails';
  static const String actionCompanyList = '/company-list';
  static const String actionProductList = '/products-by-company';
  static const String actionClientList = '/agent/clients';
  static const String actionClientApplication = '/agent/clientApplications';
  static const String actionClientMemberList = '/agent/clientFamilyMembers';
  static const String actionAgentKycAddOrUpdate = '/agentKycAddOrUpdate';
  static const String actionClientAddOrUpdate = '/agent/clientAddOrUpdate';
  static const String actionClientFamilyMemberAddOrUpdate = '/agent/clientFamilyMemberAddOrUpdate';
  static const String actionClientFamilyMemberDelete = '/agent/clientFamilyMemberDelete';
  static const String actionPortfolioCategory = '/agent/categories';
  static const String actionPortfolioSubCategory = '/agent/subcategories';
  static const String actionPortfolioProducts = '/agent/products';
  static const String actionAgentProductApplyForm = '/agent/apply-form';
  static const String actionAgentProductFormSubmit = '/agent/product/form-submit';
  static const String actionAgentCompanyData = '/agent/companies';
  static const String actionAgentClientAddUpdateProfile = '/client-professional-details';
  static const String actionAgentNotification = '/agent/notifications';
}
