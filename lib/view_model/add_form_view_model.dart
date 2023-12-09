import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class AddFormViewModel extends GetxController {
  dynamic addForm;
  Future<int?> addFormRepo({required Map<String, dynamic> body}) async {
    var request = http.Request('POST', Uri.parse('$baseUrl'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log('ADD FORM RESPONSE CODE :- ${response.statusCode}');
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      LoggerUtils.logException("ERROR addFormRepo ${response.reasonPhrase}");
    }
    return null;
  }
}
