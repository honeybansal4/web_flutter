import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

/// FOR FORM SEARCH FIELD
class FormMultiSearchBoxField extends StatefulWidget {
  FormMultiSearchBoxField({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
    this.setFormViewModel,
    this.data,
  }) : super(key: key);

  final double? width;
  final String name;
  final int index;
  final Map<String, dynamic>? data;
  final SetFormViewModel? setFormViewModel;

  @override
  State<FormMultiSearchBoxField> createState() =>
      _FormMultiSearchBoxFieldState();
}

class _FormMultiSearchBoxFieldState extends State<FormMultiSearchBoxField> {
  TextEditingController data = TextEditingController();

  List searchData = [];
  Map<String, dynamic> multiSearchData = {};
  @override
  void initState() {
    try {
      if (widget.setFormViewModel?.pageSelected == 1) {
        Map<String, dynamic> datas = widget.setFormViewModel
            ?.dataOfMap['entries'][widget.index]['entry_type']['Multi Search'];
        multiSearchData = {...datas};
        widget.setFormViewModel?.dataOfMap['entries'][widget.index]
            ['entry_type']['Multi Search'] = multiSearchData;

        searchApiCall(
            labelId: multiSearchData['labelId'],
            formName: multiSearchData['formName'],
            text: '');
      } else {
        multiSearchData = widget.data!;
      }
    } catch (e) {
      print('----ERROR---01$e');
    }
    super.initState();
  }

  searchApiCall({String? formName, String? labelId, String? text = ''}) async {
    var response = await http.get(
        Uri.parse('${baseUrl}search/${formName}/${labelId}?text='),
        headers: headers);
    print('---------${baseUrl}search/${formName}/${labelId}?text=');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      searchData.clear();
      (data as List).forEach((element) {
        searchData.add(element['value']);
      });
      print('-----data-----${data}');
    } else {
      print('-----ERROR-----${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width! / 3,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width! * 0.03),
        child: Row(
          children: [
            label(widget.width!, widget.index, context, '${widget.name}'),
            SizedBox(
              width: widget.width! * 0.02,
            ),
            Flexible(
              child: DropdownSearch<dynamic>.multiSelection(
                items: searchData,
                popupProps: PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    constraints:
                        BoxConstraints.tightFor(width: Get.width, height: 300)),
                dropdownButtonProps: DropdownButtonProps(
                    splashRadius: 10,
                    icon: Image.asset(
                      'asset/arrow.png',
                      height: 15,
                      width: 15,
                    )),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Search value'),
                ),
                onChanged: (List<dynamic> value) {},
                selectedItems: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// SEARCH FIELD
class BuildMultiSearchTextField extends StatefulWidget {
  final int index;
  final String name;
  final ShowSelectFormViewModel? controller;
  BuildMultiSearchTextField(
      {Key? key, required this.index, required this.name, this.controller})
      : super(key: key);

  @override
  State<BuildMultiSearchTextField> createState() =>
      _BuildMultiSearchTextFieldState();
}

class _BuildMultiSearchTextFieldState extends State<BuildMultiSearchTextField> {
  TextEditingController data = TextEditingController();
  TextEditingController selectData = TextEditingController();
  Map<String, dynamic> searchBoxData = {};
  List searchList = [];
  List commonList = [];
  List secondList = [];
  bool isShow = false;
  @override
  void initState() {
    try {
      try {
        searchBoxData = widget.controller?.getSelectForm['entries']
            [widget.index]['entry_type']['Multi Search'];
        print('--------SEARCHDATA----${searchBoxData}');
      } catch (e) {
        print('---PHASE 1 Error');
      }
      try {
        searchApiCall(
            labelId: searchBoxData['labelId'],
            formName: searchBoxData['formName'],
            text: '');
      } catch (e) {}
      try {
        data.text = widget.controller
                    ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                ['payload'][widget.index]['value'] ??
            '';
        widget.controller?.dummyGetSelectForm['entries'][widget.index]
            ['entry_type']['Multi Search'] = data.text;

        secondList =
            data.text.replaceAll(' ,', ',').replaceAll(', ', ',').split(',');
        print('----SECOND LIST--$secondList');
      } catch (e) {
        print('---PHASE 2 Error$e');
      }
    } catch (e) {
      print('----TEXTFIELD ERROR----$e');
    }
    super.initState();
  }

  searchApiCall({String? formName, String? labelId, String? text = ''}) async {
    var response = await http.get(
        Uri.parse('${baseUrl}search/${formName}/${labelId}?text='),
        headers: headers);
    print('---------${baseUrl}search/${formName}/${labelId}?text=');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      searchList.clear();
      (data as List).forEach((element) {
        searchList.add(element['value']);
      });
      commonList = [...searchList];
      print('-----SEARCHLIST---$searchList');
      print('-----SEARCHLIST1---$commonList');
    } else {
      print('-----ERROR-----${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: widget.controller?.getSelectForm['entries'][widget.index]
                  ['fullWidth'] ==
              true
          ? width - 300
          : width / 2.8,
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.03),
        child: Row(
          children: [
            label(width, widget.index, context, '${widget.name}'),
            commonSizedBox(width),

            Flexible(
              child: DropdownSearch<dynamic>.multiSelection(
                items: searchList,
                popupProps: PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    constraints:
                        BoxConstraints.tightFor(width: Get.width, height: 300)),
                dropdownButtonProps: DropdownButtonProps(
                    splashRadius: 10,
                    icon: Image.asset(
                      'asset/arrow.png',
                      height: 15,
                      width: 15,
                    )),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Search value'),
                ),
                onChanged: (List<dynamic> value) {
                  log('selectedGroup>>>>${secondList}');

                  secondList = value;
                  data.text = secondList
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .toString();
                  widget.controller?.dummyGetSelectForm['entries'][widget.index]
                      ['entry_type']['Multi Search'] = data.text;
                  log('SELECTED GROUP==${secondList}');

                  log('LIST ${value.toString()}');
                },
                selectedItems: secondList == [] ? [] : secondList,
              ),
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       if (isShow == false)
            //         Container(
            //           height: 45,
            //           width: Get.width,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(2),
            //             border: Border.all(
            //               color: Colors.grey.shade400,
            //             ),
            //           ),
            //           child: secondList.isEmpty
            //               ? Padding(
            //                   padding: EdgeInsets.symmetric(horizontal: 15),
            //                   child: Row(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Text('Select value'),
            //                       InkWell(
            //                         onTap: () {
            //                           isShow = true;
            //                           setState(() {});
            //                         },
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Image.asset(
            //                               'asset/arrow.png',
            //                               height: 15,
            //                               width: 15,
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               : Padding(
            //                   padding: EdgeInsets.only(right: 15, left: 10),
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Wrap(
            //                         spacing: 5,
            //                         children: [
            //                           ...List.generate(
            //                             secondList.length,
            //                             (index) {
            //                               return Center(
            //                                 child: Container(
            //                                   padding: EdgeInsets.symmetric(
            //                                       horizontal: 2, vertical: 3),
            //                                   decoration: BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(2),
            //                                       color: Colors.teal.shade50),
            //                                   child: Row(
            //                                     mainAxisSize: MainAxisSize.min,
            //                                     children: [
            //                                       Text(
            //                                         '${searchList[index]}',
            //                                         style: TextStyle(
            //                                             color: Colors.teal),
            //                                       ),
            //                                       SizedBox(
            //                                         width: 2,
            //                                       ),
            //                                       InkWell(
            //                                           onTap: () {
            //                                             secondList
            //                                                 .removeAt(index);
            //                                             setState(() {});
            //                                           },
            //                                           child: Icon(Icons.clear,
            //                                               size: 18,
            //                                               color: Colors.teal))
            //                                     ],
            //                                   ),
            //                                 ),
            //                               );
            //                             },
            //                           )
            //                         ],
            //                       ),
            //                       InkWell(
            //                         onTap: () {
            //                           isShow = true;
            //                           setState(() {});
            //                         },
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             Image.asset(
            //                               'asset/arrow.png',
            //                               height: 15,
            //                               width: 15,
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //         ),
            //       // TextFormField(
            //       //   controller: data,
            //       //   onChanged: (val) async {
            //       //     widget.controller?.dummyGetSelectForm['entries']
            //       //             [widget.index]['entry_type']['Multi Search'] =
            //       //         data.text;
            //       //   },
            //       //   onTap: () {
            //       //     isShow = true;
            //       //     setState(() {});
            //       //   },
            //       //   decoration: InputDecoration(
            //       //     suffixIcon: IconButton(
            //       //       splashRadius: 15,
            //       //       icon: Icon(Icons.search),
            //       //       onPressed: () {
            //       //         isShow = true;
            //       //         setState(() {});
            //       //       },
            //       //     ),
            //       //     hintText: 'Enter ${widget.name}',
            //       //     enabledBorder: OutlineInputBorder(),
            //       //     focusedBorder: OutlineInputBorder(),
            //       //   ),
            //       // ),
            //       if (isShow == true)
            //         Container(
            //           width: Get.width,
            //           // color: Colors.white,
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                 controller: selectData,
            //                 onChanged: (val) async {
            //                   tempSecondList.clear();
            //                   for (int i = 0; i < searchList.length; i++) {
            //                     if (searchList[i]
            //                         .toString()
            //                         .toLowerCase()
            //                         .contains(val
            //                             .toString()
            //                             .split(',')
            //                             .last
            //                             .toLowerCase())) {
            //                       if (searchList.contains(val.toString())) {
            //                       } else {
            //                         tempSecondList.add(searchList[i]);
            //                       }
            //                     }
            //                   }
            //                   setState(() {});
            //                 },
            //                 decoration: InputDecoration(
            //                   hintText: 'Search here',
            //                   enabledBorder: OutlineInputBorder(),
            //                   focusedBorder: OutlineInputBorder(),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               if (selectData.text.isNotEmpty)
            //                 ...List.generate(
            //                   tempSecondList.length,
            //                   (index) {
            //                     return Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           vertical: 5, horizontal: 20),
            //                       child: Column(
            //                         children: [
            //                           ListTile(
            //                             minLeadingWidth: 0,
            //                             visualDensity: VisualDensity(
            //                                 horizontal: 0, vertical: -4),
            //                             onTap: () {
            //                               if (secondList.contains(
            //                                   tempSecondList[index])) {
            //                                 // secondList.remove(
            //                                 //     tempSecondList[index]);
            //                               } else {
            //                                 selectData.text =
            //                                     '${tempSecondList[index]}';
            //                                 secondList
            //                                     .add(tempSecondList[index]);
            //                               }
            //                               setState(() {});
            //                             },
            //                             title: Text(
            //                               '${tempSecondList[index]}',
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               // if (selectData.text.isEmpty)
            //               //   ...List.generate(
            //               //     searchList.length,
            //               //     (index) {
            //               //       return Padding(
            //               //         padding: const EdgeInsets.symmetric(
            //               //             vertical: 5, horizontal: 20),
            //               //         child: Column(
            //               //           children: [
            //               //             ListTile(
            //               //               dense: true,
            //               //               contentPadding: EdgeInsets.symmetric(
            //               //                   horizontal: 0.0, vertical: 0.0),
            //               //               minLeadingWidth: 0,
            //               //               visualDensity: VisualDensity(
            //               //                   horizontal: 0, vertical: -4),
            //               //               onTap: () {
            //               //                 if (secondList
            //               //                     .contains(searchList[index])) {
            //               //                   // secondList
            //               //                   //     .remove(searchList[index]);
            //               //                 } else {
            //               //                   secondList.add(searchList[index]);
            //               //                 }
            //               //                 setState(() {});
            //               //               },
            //               //               title: Text(
            //               //                 '${searchList[index]}',
            //               //               ),
            //               //             )
            //               //           ],
            //               //         ),
            //               //       );
            //               //     },
            //               //   ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       data.text = secondList
            //                           .toString()
            //                           .replaceAll('[', '')
            //                           .replaceAll(']', '')
            //                           .toString();
            //
            //                       widget.controller
            //                                   ?.dummyGetSelectForm['entries']
            //                               [widget.index]['entry_type']
            //                           ['Multi Search'] = data.text;
            //                       setState(() {
            //                         selectData.clear();
            //                         isShow = false;
            //                       });
            //                     },
            //                     child: Text('Add'),
            //                   ),
            //                   SizedBox(
            //                     width: 20,
            //                   ),
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       setState(() {
            //                         selectData.clear();
            //                         isShow = false;
            //                       });
            //                     },
            //                     child: Text('Cancel'),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
