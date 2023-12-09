import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class SaveFormRepo {
  static Future saveFormRepo({
    required List body,
    required String formId,
  }) async {
    var request =
        http.Request('POST', Uri.parse(baseUrl + 'payload/' + formId));
    request.body = json.encode(body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    log('API URL :- ${baseUrl + 'payload/' + formId}');
    if (response.statusCode == 200) {
      var saveFormData = jsonDecode(await response.stream.bytesToString());

      return saveFormData;
    } else {
      print("POST ERROR v====>>${response.reasonPhrase}");

      return null;
    }
  }
}
