import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/view/edit_form_screen.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

ViewCodeDialogBox(BuildContext context, String labelType, double width,
    ShowSelectFormViewModel controller, int index, inputLabel) {
  var code =
      jsonEncode(controller.getSelectForm['entries'][index]['edit_code']);
  final TextEditingController previewCodeController =
      TextEditingController(text: code);

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Container(
              height: 400,
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 10,
                      controller: previewCodeController,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DynamicWidgetBuilder.build(
                            previewCodeController.text.trim(),
                            context,
                            DefaultClickListener()) ??
                        Text("Error occured in widget rendering"),

                    // Row(
                    //   children: [

                    //     Expanded(
                    //       child: DynamicWidgetBuilder.build(
                    //               previewCodeController.text.trim(),
                    //               context,
                    //               DefaultClickListener()) ??
                    //           Text("Error occured in widget rendering"),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              controller.getSelectForm['entries'][index]
                                      ['edit_code'] =
                                  jsonDecode(previewCodeController.text.trim());
                              controller.update();
                              Get.back();
                            },
                            child: Text(
                              'Save',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
