import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class LogInRepo {
  static Future logInRepo({required Map<String, dynamic> body}) async {
    var logInResponse = await APIService().getResponse(
      url: '${baseUrl}auth/login',
      body: body,
      apitype: APIType.aPost,
    );
    print('------BASE LOGIN FormRepo-------${baseUrl}auth/login');

    return logInResponse;
  }
}
