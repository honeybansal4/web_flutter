import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_demo_satish/model/Apis/app_exception.dart';
import 'package:web_demo_satish/model/Services/get_storage_service.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${GetStorageServices.getToken()}'
};

Map<String, String> logInHeaders = {
  'Content-Type': 'application/json',
};

enum APIType {
  aPost,
  aGet,
}

class APIService {
  var response;
  String contentTypeToken = "application/x-www-form-urlencoded";

  @override
  Future getResponse(
      {required String url,
      required APIType apitype,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    Map<String, String> headersMap = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorageServices.getToken()}'
    };
    try {
      if (apitype == APIType.aGet) {
        final result = await http.get(Uri.parse(url), headers: headersMap);
        response = returnResponse(result.statusCode, result.body);
        // log("res${result.body}");
        print("REQUEST url ======>>>>> $url");
        print("REQUEST PARAMETER ======>>>>> $body");
        print("REQUEST HEADER ======>>>>> $headersMap");
      } else if (fileUpload) {
      } else {
        print("REQUEST url ======>>>>> $url");
        print("REQUEST PARAMETER ======>>>>> $body");
        print("REQUEST HEADER ======>>>>> $headersMap");

        final result = await http.post(Uri.parse(url),
            body: jsonEncode(body), headers: headersMap);
        log("resp${result.body}");
        response = returnResponse(result.statusCode, result.body);
        print(result.statusCode);
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 400:
        return jsonDecode(result);
      // throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
