import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/view_model/get_all_form_view_model.dart';

class GetAllFormNameScreen extends StatefulWidget {
  const GetAllFormNameScreen({Key? key}) : super(key: key);

  @override
  State<GetAllFormNameScreen> createState() => _GetAllFormNameScreenState();
}

class _GetAllFormNameScreenState extends State<GetAllFormNameScreen> {
  GetAllFormViewModel getAllFormViewModel = Get.put(GetAllFormViewModel());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GetBuilder<GetAllFormViewModel>(
        builder: (controller) {
          if (controller.getAllFormApiResponse.status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.getAllFormApiResponse.status == Status.COMPLETE) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: width * 0.02,
                  left: width * 0.02,
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: List.generate(
                    controller.getAllForm!.length,
                    (index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          height: width * 0.035,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${controller.getAllForm![index]['name']}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Something Went Wrong...'),
            );
          }
        },
      ),
    );
  }
}
