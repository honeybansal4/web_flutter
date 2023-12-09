import 'package:get/get.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Repo/log_in_repo.dart';
import 'package:web_demo_satish/model/Services/get_storage_service.dart';

class LogInViewModel extends GetxController {
  Map<String, dynamic> logInResponse = {};
  bool isLoading = false;
  updateLoading(bool val) {
    isLoading = val;
    update();
  }

  ApiResponse _logInApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get logInApiResponse => _logInApiResponse;

  Future<void> logInViewModel(
      {Map<String, dynamic>? body, bool isLoading = true}) async {
    if (isLoading) {
      _logInApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      logInResponse = await LogInRepo.logInRepo(body: body!);
      print("LOGIN RESPONSE=response==>${logInResponse['token']}");
      GetStorageServices.setToken(logInResponse['token'].toString().trim());

      print("LOGIN RESPONSE=response==>${GetStorageServices.getToken()}");

      _logInApiResponse = ApiResponse.complete(logInResponse);
    } catch (e) {
      print("LOGIN RESPONSE=e==>$e");
      _logInApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
