// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:web_demo_satish/common_widget/button.dart';
// import 'package:web_demo_satish/common_widget/label.dart';
// import 'package:web_demo_satish/controllers/updateController.dart';
// import 'package:web_demo_satish/model/Repo/trnaslate_lang_repo.dart';
// import '../controllers/get_all_form_controller.dart';
//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/model/Apis/base_url.dart';
import 'package:web_demo_satish/model/Services/api_service.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

TextFormField buildTextFormField(
    {int? index,
    TextEditingController? textEditingController,
    bool? enable,
    final void Function()? onTap,
    obSecure = false,
    int? maxLine = 1,
    Widget suffixIcon = const SizedBox(),
    Color? borderColor,
    Color? focusedBorderColor,
    String? label}) {
  return TextFormField(
    controller: textEditingController,
    enabled: enable,
    onTap: onTap,
    maxLines: maxLine,
    obscureText: obSecure,
    decoration: InputDecoration(
        hintText: 'Enter ${label}',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: borderColor ?? Colors.black,
        )),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor ?? Colors.blue,
          ),
        ),
        suffixIcon: suffixIcon),
  );
}

/// FIELD GROUP

class FieldGroupField extends StatefulWidget {
  final int index;
  final String? name;

  FieldGroupField({Key? key, required this.index, this.name}) : super(key: key);

  @override
  State<FieldGroupField> createState() => _FieldGroupFieldState();
}

class _FieldGroupFieldState extends State<FieldGroupField> {
  int x = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(width, widget.index, context, '${widget.name}'),
          commonSizedBox(width),
          Column(
            children: [
              commonButton(
                  width: 100,
                  height: 40,
                  onPress: () {
                    setState(() {
                      x++;
                    });
                  },
                  name: '${widget.name}'),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: x,
                  itemBuilder: (context, index) {
                    return buildTextFormField(
                      index: index,
                      label: 'Enter Data',
                      textEditingController: TextEditingController(),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// FROM TEXT FIELD
class FromTextField extends StatelessWidget {
  final bool? fullWidth;
  final double? width;
  final int? index;
  final void Function()? onTap;
  final String? name, labelType;
  Color? borderColor;
  Color? focusedBorderColor;

  FromTextField({
    Key? key,
    this.fullWidth,
    this.width,
    this.index,
    this.name,
    this.labelType,
    this.onTap,
    this.borderColor,
    this.focusedBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fullWidth == true
        ? Expanded(
            child: buildPadding(context),
          )
        : SizedBox(
            width: width! / 3,
            child: buildPadding(context),
          );
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width! * 0.03),
      child: Row(
        children: [
          label(width!, index!, context, '${name}'),
          SizedBox(
            width: width! * 0.02,
          ),
          Expanded(
            child: buildTextFormField(
              onTap: onTap,
              index: index,
              enable: labelType == "Control Field" ||
                      labelType == "Related Field" ||
                      labelType == "Normal Field" ||
                      labelType == "Search Box"
                  ? true
                  : false,
              label: name,
              textEditingController: TextEditingController(),
              borderColor: borderColor,
              focusedBorderColor: focusedBorderColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// TEXT FIELD
class BuildTextField extends StatefulWidget {
  final int index;
  final String name;
  final ShowSelectFormViewModel? controller;
  BuildTextField(
      {Key? key, required this.index, required this.name, this.controller})
      : super(key: key);

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  TextEditingController data = TextEditingController();
  bool? isShow = false;

  @override
  void initState() {
    try {
      // if (widget.index == 0) {
      //   data.text = widget.controller?.getSele ctForm['entries'][widget.index]
      //       ['entry_type']['Normal Field'];
      // }
      try {
        isShow =
            widget.controller?.getSelectForm['entries'][widget.index]['masked'];
      } catch (e) {}
      if (widget
              .controller
              ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                  ['payload'][widget.index]['value']
              .toString() !=
          'null') {
        data.text = widget.controller
                ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
            ['payload'][widget.index]['value'];

        if (widget.controller?.getSelectForm['entries'][widget.index]
                ['masked'] ==
            true) {
          List<int> decodedint = base64.decode(data.text);
          data.text = utf8.decode(decodedint);
        }
      }
      widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
          ['Normal Field'] = data.text;
    } catch (e) {
      print('----TEXTFIELD ERROR----$e');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return widget.controller?.getSelectForm['entries'][widget.index]
                ['fullWidth'] ==
            true
        ? Expanded(
            child: buildPadding(
                width,
                context,
                widget.controller?.getSelectForm['entries'][widget.index]
                    ['fullWidth'] as bool),
          )
        : SizedBox(
            width: width / 2.8,
            child: buildPadding(
                width,
                context,
                widget.controller?.getSelectForm['entries'][widget.index]
                    ['fullWidth'] as bool),
          );
  }

  Padding buildPadding(double width, BuildContext context, bool fullWidth) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(width, widget.index, context, '${widget.name}'),
          commonSizedBox(width),
          Expanded(
            child: TextFormField(
              controller: data,
              obscuringCharacter: '*',
              obscureText: isShow == true ? true : false,
              onChanged: (val) async {
                if (widget.controller?.getSelectForm['entries'][widget.index]
                        ['masked'] ==
                    false) {
                  widget.controller?.getSelectForm['entries'][widget.index]
                      ['entry_type']['Normal Field'] = data.text;
                } else {
                  widget.controller?.getSelectForm['entries'][widget.index]
                          ['entry_type']['Normal Field'] =
                      base64.encode(data.text.codeUnits);
                }
              },
              enabled: widget
                              .controller
                              ?.getSelectForm['entries'][widget.index]
                                  ['entry_type']
                              .keys
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '') ==
                          'Control Field' ||
                      widget
                              .controller
                              ?.getSelectForm['entries'][widget.index]
                                  ['entry_type']
                              .keys
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '') ==
                          'Related Field' ||
                      widget
                              .controller
                              ?.getSelectForm['entries'][widget.index]
                                  ['entry_type']
                              .keys
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '') ==
                          'Normal Field'
                  ? true
                  : false,
              decoration: InputDecoration(
                hintText: 'Enter ${widget.name}',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: widget.controller?.getSelectForm['entries']
                            [widget.index]['masked'] ==
                        true
                    ? IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          isShow = !isShow!;
                          setState(() {});
                        },
                        icon: Icon(
                          isShow! ? Icons.visibility : Icons.visibility_off,
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// FOR FORM SEARCH FIELD
class FormSearchBoxField extends StatefulWidget {
  FormSearchBoxField({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
    this.setFormViewModel,
    this.data,
    this.controller,
  }) : super(key: key);

  final double? width;
  final String name;
  final int index;
  final ShowSelectFormViewModel? controller;
  final Map<String, dynamic>? data;

  final SetFormViewModel? setFormViewModel;

  @override
  State<FormSearchBoxField> createState() => _FormSearchBoxFieldState();
}

class _FormSearchBoxFieldState extends State<FormSearchBoxField> {
  TextEditingController data = TextEditingController();

  Map<String, dynamic> searchData = {};

  @override
  void initState() {
    try {
      if (widget.setFormViewModel?.pageSelected == 1) {
        Map<String, dynamic> data = widget.setFormViewModel
            ?.dataOfMap['entries'][widget.index]['entry_type']['Search Box'];
        searchData = {...data};

        widget.setFormViewModel?.dataOfMap['entries'][widget.index]
            ['entry_type']['Search Box'] = searchData;
      } else if (widget.setFormViewModel?.pageSelected == 2) {
        searchData = {...widget.data!};
        widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
            ['Search Box'] = searchData;
      } else {
        searchData = {};
      }
    } catch (e) {
      print('----ERROR---01$e');
    }
    super.initState();
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
            Expanded(
              child: TextFormField(
                controller: data,
                onChanged: (val) async {},
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashRadius: 15,
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  hintText: 'Enter ${widget.name}',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// SEARCH FIELD
class BuildSearchTextField extends StatefulWidget {
  final int index;
  final String name;
  final ShowSelectFormViewModel? controller;
  BuildSearchTextField(
      {Key? key, required this.index, required this.name, this.controller})
      : super(key: key);

  @override
  State<BuildSearchTextField> createState() => _BuildSearchTextFieldState();
}

class _BuildSearchTextFieldState extends State<BuildSearchTextField> {
  TextEditingController data = TextEditingController();

  List searchList = [];
  Map<String, dynamic> searchBoxData = {};

  bool isShow = false;
  @override
  void initState() {
    try {
      try {
        searchBoxData = widget.controller?.getSelectForm['entries']
            [widget.index]['entry_type']['Search Box'];
      } catch (e) {
        print('---PHASE 1 Error');
      }

      try {
        data.text = widget.controller
                    ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                ['payload'][widget.index]['value'] ??
            '';
        widget.controller?.dummyGetSelectForm['entries'][widget.index]
            ['entry_type']['Search Box'] = data.text;
      } catch (e) {
        print('---PHASE 2 Error');
      }
    } catch (e) {
      print('----TEXTFIELD ERROR----$e');
    }
    super.initState();
  }

  searchApiCall({String? formName, String? labelId, String? text = ''}) async {
    var response = await http.get(
        Uri.parse('${baseUrl}search/${formName}/${labelId}?text=$text'),
        headers: headers);
    print('---------${baseUrl}search/${formName}/${labelId}?text=$text');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      searchList.clear();
      (data as List).forEach((element) {
        searchList.add(element['value']);
      });
      print('-----data-----${data}');
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
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: data,
                    onChanged: (val) async {
                      if (data.text.isEmpty) {
                        isShow = false;
                        searchList.clear();
                        setState(() {});
                      } else {
                        isShow = true;
                      }
                      widget.controller?.dummyGetSelectForm['entries']
                              [widget.index]['entry_type']['Search Box'] =
                          data.text;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 15,
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          await searchApiCall(
                              labelId: searchBoxData['labelId'],
                              formName: searchBoxData['formName'],
                              text: data.text.trim().toString());
                          setState(() {});
                        },
                      ),
                      hintText: 'Enter ${widget.name}',
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  if (searchList.isNotEmpty)
                    SizedBox(
                      height: 5,
                    ),
                  if (searchList.isNotEmpty)
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade100,
                              offset: Offset(1, 1),
                              blurRadius: 2),
                          BoxShadow(
                              color: Colors.grey.shade100,
                              offset: Offset(-1, -1),
                              blurRadius: 2),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            searchList.length,
                            (index) {
                              if (isShow == true) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 15),
                                  child: InkWell(
                                    onTap: () {
                                      data.clear();
                                      data.text = '${searchList[index]}';

                                      isShow = false;
                                      widget.controller?.dummyGetSelectForm[
                                                  'entries'][widget.index]
                                              ['entry_type']['Search Box'] =
                                          data.text;
                                      searchList.clear();
                                      setState(() {});
                                    },
                                    child: Text(
                                      '${searchList[index]}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// FOR FORM LONG FIELD
class FormLongField extends StatelessWidget {
  const FormLongField({
    Key? key,
    required this.width,
    required this.name,
    this.onTap,
    required this.index,
    this.fullWidth,
  }) : super(key: key);

  final double? width;
  final String name;
  final void Function()? onTap;
  final int index;
  final bool? fullWidth;

  @override
  Widget build(BuildContext context) {
    return fullWidth == true
        ? Expanded(
            child: buildPadding(context, fullWidth!),
          )
        : SizedBox(
            width: width! / 3,
            child: buildPadding(context, fullWidth!),
          );
  }

  Padding buildPadding(BuildContext context, bool fullWidth) {
    return Padding(
      padding: EdgeInsets.only(right: width! * 0.03),
      child: Row(
        children: [
          label(width!, index, context, '${name}'),
          SizedBox(
            width: width! * 0.02,
          ),
          Expanded(
            child: buildTextFormField(
              onTap: onTap,
              maxLine: 5,
              enable: true,
              label: name,
              textEditingController: TextEditingController(),
            ),
          ),
        ],
      ),
    );
  }
}

/// LONG BOX
class LongBoxField extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  const LongBoxField(
      {Key? key, required this.index, this.name, this.controller})
      : super(key: key);

  @override
  State<LongBoxField> createState() => _LongBoxFieldState();
}

class _LongBoxFieldState extends State<LongBoxField> {
  TextEditingController data = TextEditingController();

  @override
  void initState() {
    try {
      if (widget.controller
                  ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
              ['payload'][widget.index]['value'] !=
          'null') {
        data.text = widget.controller
                ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
            ['payload'][widget.index]['value'];
      }
      widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
          ['Long box'] = data.text;
    } catch (e) {
      print('----LONG BOX ERROR----');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return widget.controller?.getSelectForm['entries'][widget.index]
                ['fullWidth'] ==
            true
        ? Expanded(
            child: buildPadding(
                width,
                context,
                widget.controller?.getSelectForm['entries'][widget.index]
                    ['fullWidth'] as bool),
          )
        : SizedBox(
            width: width / 2.8,
            child: buildPadding(
                width,
                context,
                widget.controller?.getSelectForm['entries'][widget.index]
                    ['fullWidth'] as bool),
          );
  }

  Padding buildPadding(double width, BuildContext context, bool fullWidth) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(
            width,
            widget.index,
            context,
            widget.name,
          ),
          commonSizedBox(width),
          Expanded(
            child: TextFormField(
              controller: data,
              onChanged: (val) async {
                widget.controller?.getSelectForm['entries'][widget.index]
                    ['entry_type']['Long box'] = data.text;
                setState(() {});
              },
              enabled: true,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter ${widget.name}',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
