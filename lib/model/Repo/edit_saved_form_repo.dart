import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Services/api_service.dart';

import '../Apis/base_url.dart';

class EditSavedFormRepo {
  static Future editSavedFormRepo(
      {required Map<String, dynamic> body, String? formId}) async {
    var request = http.Request('PATCH', Uri.parse('${baseUrl}payload/$formId'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return response.statusCode;
    } else {
      print('EEEEEE${response.reasonPhrase}');

      return response.statusCode;
    }
  }
}
