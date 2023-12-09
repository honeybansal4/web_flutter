import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class EditFormRepo {
  static Future editFormRepo({
    required List body,
    required String urlId,
    List? group,
    List? organization,
    List? roles,
    String? status,
    String? name,
    String? menuType,
    String? description,
  }) async {
    var request = http.Request('PATCH', Uri.parse(baseUrl + urlId));
    request.body = json.encode({
      "roles": roles,
      "name": name,
      "menuType": menuType,
      "description": description,
      "organization": organization,
      "status": status,
      "group": group,
      "entries": body
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    log('DATA BODY :- ${request.body}');
    LoggerUtils.logI('-----DATA_--${body}');
    log('RESPONSE STATUS CODE :- ${response.statusCode}');
    log('API URL :- ${baseUrl + urlId}');
    if (response.statusCode == 200) {
      print("POST RESPONSE===>>>${await response.stream.bytesToString()}");
      return response.statusCode;
    } else {
      print("POST ERROR B====>>${response.reasonPhrase}");

      return response.statusCode;
    }
  }
}
