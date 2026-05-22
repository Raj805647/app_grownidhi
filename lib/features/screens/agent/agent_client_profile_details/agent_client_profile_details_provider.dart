import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/client_complete_profile_response.dart';

class AgentClientProfileDetailsProvider extends BaseProvider {
  bool isLoading = false;
  ClientCompleteData completeData = ClientCompleteData();

  Future<void> getClientCompleteProfile(int clientId) async {
    print(clientId);
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.agentClientProfile();
      print('Response Data => ${response.data}');
      print('Response Success => ${response.isSuccess}');
      print('Response Error => ${response.error}');

      if (response.isSuccess == true) {
        print('dafkjdsnfjadsf');
        final List dataList = response.data['data'] ?? [];

        final matchedData = dataList.firstWhere(

              (e) => e['user_id'] == clientId,

          orElse: () => null,
        );

        if (matchedData != null) {

          completeData =
              ClientCompleteData.fromJson(matchedData);
        }
        notifyListeners();

        print('adkfjdsjf=> $completeData');
        print('adkfjdsjf=> ${completeData.userId}');
        print('adkfjdsjf=> ${completeData.id}');
      } else {
        print('asdfkkjdsbf=> ${response.data}');
      }
    } catch (error) {
      print('Submit Error => $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
