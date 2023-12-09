import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Services/api_service.dart';

import '../Apis/base_url.dart';

class AddFormRepo {
  static Future<int?> addFormRepo({required Map<String, dynamic> body}) async {
    var request = http.Request('POST', Uri.parse('$baseUrl'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log('ADD FORM BODY :- $body');
    log('ADD FORM RESPONSE CODE :- ${response.statusCode}');
    if (response.statusCode == 200) {
      log('API RESPONSE :- ${await response.stream.bytesToString()}');
      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }
}
