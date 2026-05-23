import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/individual_prifile_details_response.dart';

class IndividualProfileDetailsProvider extends BaseProvider{
  bool isLoading = false;

  IndividalProfileData? userProfileData;

  /// ERROR MESSAGE

  /// FETCH PROFILE
  Future<void> fetchAgentDashboard() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.userProfile();
      print('adbfhbdsaf=> ${response.data}');

      if (response.isSuccess == true) {
        userProfileData = IndividalProfileData.fromJson(response.data['data']);
        // agentClientDataProvider.fetchAgentClientData();
        print('adfbdsakjbf=> $userProfileData');
      } else {
        print(response.data);
      }
    } catch (error) {
      print("Dashboard Error: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  }
