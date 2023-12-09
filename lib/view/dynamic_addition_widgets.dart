import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:web_demo_satish/view/edit_form_screen.dart';

DynamicWidgetAddition(BuildContext context, List<dynamic> entries) {
  // var code =
  //     jsonEncode(controller.getSelectForm['entries'][index]['edit_code']);
  String price = '';
  String quantity = '';
  String result = '';

  String? errorPrice = null;
  String? errorQuantity = null;
  String? errorResult = null;

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
                    ...entries.asMap().keys.toList().map((e) => Column(
                      children: [
                        DynamicWidgetBuilder.build(
                            jsonEncode(entries[e]['edit_code']),
                            context,
                            DefaultClickListener(),
                            onEditingComplete: () {},
                            onSubmitted: (val) {
                              // print("On submitting complete is called");
                              setState(() {
                                // if (e == 2) {

                                // }
                                try {
                                  entries[2]['edit_code']['data'] = result;
                                } catch (e) {
                                  print(e);
                                }
                              });
                            }, onChanged: (val) async {
                          print("On change value is: $val");
                          if (e == 0) {
                            price = val;
                            entries[e]['edit_code']['data'] = price;
                          }
                          if (e == 1) {
                            quantity = val;
                            entries[e]['edit_code']['data'] = quantity;
                          }
                          result =
                              (await calculateResult(price, quantity))
                                  .toString();

                          print(result);

                          if (price.length < 2) {
                            errorPrice =
                            "Unit Price should be of atleast 2 charachter";
                          } else {
                            errorPrice = null;
                          }

                          if (quantity.length < 2) {
                            errorQuantity =
                            "Quantity should be of atleast 2 charachter";
                          } else {
                            errorQuantity = null;
                          }
                        },
                            errorText: e == 0
                                ? errorPrice
                                : e == 1
                                ? errorQuantity
                                : null) ??
                            Container(),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
                    Text(result),
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

Future<int> calculateResult(String price, String quantity) async {
  int result = 0;
  try {
    var mPrice = int.tryParse(price) ?? 0;
    var mQuantity = int.tryParse(quantity) ?? 0;
    result = mPrice * mQuantity;
  } catch (e) {
    print(e);
  }
  return result;
}
