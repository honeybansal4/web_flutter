import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Services/api_service.dart';

import '../Apis/base_url.dart';

class GetFormRepo {
  var jsonString;

  Future getSaveData({id, label}) async {
    http.Response response = await http
        .get(Uri.parse('${baseUrl}payload/$id/$label'), headers: headers);
    print('------GET SAVE URL-----${baseUrl}payload/$id/$label');
    if (response.statusCode == 200) {
      jsonString = jsonDecode(response.body);
      // dataController.dataOfMap1 = jsonString;

      print("GET SAVE DATA===>>  ${jsonString}");
      return jsonString;
    } else {
      return null;
    }
  }
}
