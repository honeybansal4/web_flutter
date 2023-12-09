import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class DeleteFormRepo {
  static Future<int> deleteFormRepo({required String formId}) async {
    var request = http.Request('DELETE', Uri.parse('$baseUrl$formId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('--response.statusCode-------${response.statusCode}');
    print('------BASE URL Delete Form-------$baseUrl$formId');
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      print('---------ERROR-------${response.reasonPhrase}');

      return 400;
    }
  }
}
