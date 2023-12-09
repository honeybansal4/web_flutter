import 'package:get/get.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';

class GetAllFormViewModel extends GetxController {
  List? getAllForm = [];
  Future<dynamic> getAllFormRepo() async {
    var response = await APIService().getResponse(
      url: baseUrl,
      apitype: APIType.aGet,
    );
    print('------BASE URL getAllForm-------$baseUrl');

    return response;
  }

  ApiResponse _getAllFormApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getAllFormApiResponse => _getAllFormApiResponse;

  Future<void> getAllFormViewModel({bool loading = true}) async {
    if (loading) {
      _getAllFormApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      getAllForm = await getAllFormRepo();
      print("getAllForm=response==>$getAllForm");

      _getAllFormApiResponse = ApiResponse.complete(getAllForm);
    } catch (e) {
      print("getAllForm=e==>$e");

      _getAllFormApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
