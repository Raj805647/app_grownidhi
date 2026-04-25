class AppConfig {
  static const String apiTestUrl = "http://192.168.1.27:8000/api";
  static const String apiProdUrl = "http://192.168.1.27:8000/api";
  static const String apiTestKey = "";
  static const String apiProdKey = "";
  static const reverseAddressApi = "";
  static const String mapApiKey = "";
  static const bool isProduction = true;

  static String get baseUrl => isProduction ? apiProdUrl : apiTestUrl;

  static String get apiKey => isProduction ? apiProdKey : apiTestKey;

  //auth api call
  static const String actionSendOtp = '/sendOtp';
  static const String actionVerifyOtp = '/verifyOtp';
  static const String actionSignUp = '/register';
  static const String actionProfile = '/profile';
  static const String actionUpdateProfile = '/profile/update';
  static const String actionCoursesDetails = '/courses';
  static const String actionCoursesLanguage = '/courses/course_languages';
  static const String actionCoursesCategory = '/courses/course_categories';
  static const String actionCoursesLevel = '/courses/course_levels';
}
