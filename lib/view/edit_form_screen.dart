import 'dart:convert';
import 'dart:io';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/check_box.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/date_time_picker.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/field_group.dart';
import 'package:web_demo_satish/common_widget/image.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/common_widget/multi_search_field.dart';
import 'package:web_demo_satish/common_widget/scroll_list.dart';
import 'package:web_demo_satish/common_widget/table_widget.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/view/dynamic_addition_widgets.dart';
import 'package:web_demo_satish/view/edit_preview_page.dart';
import 'package:web_demo_satish/view/main_screen.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class EditFormScreen extends StatefulWidget {
  final SetFormViewModel? setFormViewModel;
  const EditFormScreen({Key? key, this.setFormViewModel}) : super(key: key);

  @override
  State<EditFormScreen> createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  // Color borderColor = Color(0xff${});
  ScrollController scrollController = ScrollController();

  TextEditingController titles = TextEditingController();
  final TextEditingController labelName = TextEditingController();
  final TextEditingController sequenceData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GetBuilder<ShowSelectFormViewModel>(
        builder: (controller) {
          if (controller.showFormApiResponse.status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.showFormApiResponse.status == Status.COMPLETE) {
            try {
              return controller.isLoader == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.02,
                          top: width * 0.02,
                        ),
                        child: AnimationLimiter(
                          child: Wrap(
                            runSpacing: width * 0.02,
                            children: List.generate(
                              controller.getSelectForm['entries'].length,
                              (index) {
                                try {
                                  print(
                                      '-----${controller.getSelectForm['entries'][index]['fullWidth']}');
                                } catch (e) {
                                  print('----- FULL ERROR$e');
                                }
                                var labelType = controller
                                    .getSelectForm['entries'][index]
                                        ['entry_type']
                                    .keys
                                    .toString()
                                    .replaceAll('(', '')
                                    .replaceAll(')', '');

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        width: controller.getSelectForm[
                                                        'entries'][index]
                                                    ['new_line'] ==
                                                true
                                            ? width / 2
                                            : labelType == "Table"
                                                ? width
                                                : labelType == "Separator"
                                                    ? width
                                                    : labelType ==
                                                            "Collapse Area"
                                                        ? width
                                                        : controller.getSelectForm[
                                                                            'entries']
                                                                        [index][
                                                                    'fullWidth'] ==
                                                                true
                                                            ? width
                                                            : width / 2.4,
                                        child: Stack(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                labelType == "Multi Search"
                                                    ? FormMultiSearchBoxField(
                                                        data: controller.getSelectForm[
                                                                        'entries']
                                                                    [index]
                                                                ['entry_type']
                                                            ['Multi Search'],
                                                        setFormViewModel: widget
                                                            .setFormViewModel,
                                                        width: width,
                                                        index: index,
                                                        name:
                                                            '${controller.getSelectForm['entries'][index]['label']}',
                                                      )
                                                    : labelType == "Search Box"
                                                        ? FormSearchBoxField(
                                                            controller:
                                                                controller,
                                                            data: controller.getSelectForm[
                                                                            'entries']
                                                                        [index][
                                                                    'entry_type']
                                                                ['Search Box'],
                                                            index: index,
                                                            name:
                                                                '${controller.getSelectForm['entries'][index]['label']}',
                                                            setFormViewModel: widget
                                                                .setFormViewModel,
                                                            width: width,
                                                          )
                                                        : labelType ==
                                                                "DropDown"
                                                            ? formDropDown(
                                                                controller: widget
                                                                    .setFormViewModel,
                                                                selectFormViewModel:
                                                                    controller,
                                                                width: width,
                                                                fullWidth: controller
                                                                            .getSelectForm[
                                                                        'entries'][index]
                                                                    [
                                                                    'fullWidth'],
                                                                index: index,
                                                                name:
                                                                    '${controller.getSelectForm['entries'][index]['label']}',
                                                              )
                                                            : labelType ==
                                                                    "Check Box"
                                                                ? formCheckBox(
                                                                    width:
                                                                        width,
                                                                    index:
                                                                        index,
                                                                    fullWidth: controller.getSelectForm['entries']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'fullWidth'],
                                                                    name:
                                                                        '${controller.getSelectForm['entries'][index]['label']}',
                                                                  )
                                                                : labelType ==
                                                                        "Datefield"
                                                                    ? FormDateField(
                                                                        width:
                                                                            width,
                                                                        index:
                                                                            index,
                                                                        fullWidth:
                                                                            controller.getSelectForm['entries'][index]['fullWidth'],
                                                                        name:
                                                                            '${controller.getSelectForm['entries'][index]['label']}',
                                                                      )
                                                                    : labelType ==
                                                                            "TimeField"
                                                                        ? FormTimeField(
                                                                            width:
                                                                                width,
                                                                            index:
                                                                                index,
                                                                            name:
                                                                                '${controller.getSelectForm['entries'][index]['label']}',
                                                                          )
                                                                        : labelType ==
                                                                                "Long box"
                                                                            ? FormLongField(
                                                                                onTap: () {
                                                                                  getFieldInfo(controller, index, context);
                                                                                },
                                                                                width: width,
                                                                                index: index,
                                                                                name: '${controller.getSelectForm['entries'][index]['label']}',
                                                                                fullWidth: controller.getSelectForm['entries'][index]['fullWidth'],
                                                                              )
                                                                            : labelType == "Hyperlink"
                                                                                ? FormHyperLink(
                                                                                    width: width,
                                                                                    name: '${controller.getSelectForm['entries'][index]['label']}',
                                                                                    index: index,
                                                                                  )
                                                                                : labelType == "Image"
                                                                                    ? FormImageField(
                                                                                        fullWidth: controller.getSelectForm['entries'][index]['fullWidth'],
                                                                                        width: width,
                                                                                        index: index,
                                                                                        name: '${controller.getSelectForm['entries'][index]['label']}',
                                                                                      )
                                                                                    : labelType == "Scrollable list"
                                                                                        ? FormScollListField(
                                                                                            index: index,
                                                                                            name: '${controller.getSelectForm['entries'][index]['label']}',
                                                                                            width: width,
                                                                                            scrollController: scrollController,
                                                                                            fullWidth: controller.getSelectForm['entries'][index]['fullWidth'],
                                                                                          )
                                                                                        : labelType == "Field grouping"
                                                                                            ? FormGroupField(
                                                                                                width: width,
                                                                                                index: index,
                                                                                                name: '${controller.getSelectForm['entries'][index]['label']}',
                                                                                              )
                                                                                            : labelType == "Table"
                                                                                                ? EditTableWidget(
                                                                                                    index: index,
                                                                                                    title: controller.getSelectForm['entries'][index]['label'],
                                                                                                    controller: controller,
                                                                                                    setFormViewModel: widget.setFormViewModel,
                                                                                                  )
                                                                                                : labelType == "Separator"
                                                                                                    ? Expanded(
                                                                                                        child: GestureDetector(
                                                                                                          onTap: () {
                                                                                                            print('----RTA');

                                                                                                            try {
                                                                                                              bool x = controller.getSelectForm['entries'][index + 1]['expand'] as bool;
                                                                                                              print('--------VALUE OF X00 :- $x');

                                                                                                              x = !x;
                                                                                                              controller.getSelectForm['entries'][index + 1]['expand'] = x;
                                                                                                              print('--------VALUE OF X :- $x');
                                                                                                              controller.updateData();
                                                                                                            } catch (e) {
                                                                                                              print('------$e');
                                                                                                            }
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.mainColor),
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: [
                                                                                                                Row(
                                                                                                                  children: [
                                                                                                                    Image.asset(
                                                                                                                      'asset/link.png',
                                                                                                                      color: Colors.white,
                                                                                                                      height: 15,
                                                                                                                      width: 15,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      width: 10,
                                                                                                                    ),
                                                                                                                    Text(
                                                                                                                      '${controller.getSelectForm['entries'][index]['label']}',
                                                                                                                      style: TextStyle(fontSize: width * 0.014, color: Colors.white),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                                Icon(
                                                                                                                  Icons.remove,
                                                                                                                  color: Colors.white,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : labelType == "Collapse Area"
                                                                                                        ? Expanded(
                                                                                                            child: Container(
                                                                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                              ),
                                                                                                              child: Column(
                                                                                                                children: [
                                                                                                                  ...List.generate(
                                                                                                                    controller.getSelectForm['entries'][index]['expand'] == true ? 0 : (controller.getSelectForm['entries'][index]['entry_type']['$labelType'] as List).length,
                                                                                                                    (index1) {
                                                                                                                      return Padding(
                                                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                                                        child: Row(
                                                                                                                          children: [
                                                                                                                            label(
                                                                                                                              width,
                                                                                                                              index1,
                                                                                                                              context,
                                                                                                                              '${controller.getSelectForm['entries'][index]['entry_type']['$labelType'][index1]}',
                                                                                                                            ),
                                                                                                                            Expanded(
                                                                                                                              child: buildTextFormField(
                                                                                                                                index: 0,
                                                                                                                                label: 'value',
                                                                                                                                obSecure: false,
                                                                                                                                textEditingController: TextEditingController(),
                                                                                                                                enable: true,
                                                                                                                                maxLine: 1,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    },
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                        : controller.getSelectForm['entries'][index]['edit_code'] != null
                                                                                                            ? SizedBox(
                                                                                                                  width: 200,
                                                                                                                  child: DynamicWidgetBuilder.build(jsonEncode(controller.getSelectForm['entries'][index]['edit_code']), context, new DefaultClickListener()),
                                                                                                                ) ??
                                                                                                                Text("Error")
                                                                                                            : FromTextField(
                                                                                                                onTap: () {
                                                                                                                  getFieldInfo(controller, index, context);
                                                                                                                },
                                                                                                                labelType: labelType,
                                                                                                                width: width,
                                                                                                                index: index,
                                                                                                                name: controller.getSelectForm['entries'][index]['label'].toString(),
                                                                                                                fullWidth: controller.getSelectForm['entries'][index]['fullWidth'] as bool,
                                                                                                              ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      /// View code BUTTON
                                                      InkResponse(
                                                        radius: 20,
                                                        onTap: () {
                                                          ViewCodeDialogBox(
                                                            context,
                                                            labelType,
                                                            width,
                                                            controller,
                                                            index,
                                                            controller
                                                                .getSelectForm[
                                                                    'entries']
                                                                    [index]
                                                                    ['label']
                                                                .toString(),
                                                          );
                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                          Icons.preview_rounded,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkResponse(
                                                        radius: 20,
                                                        onTap: () {
                                                          controller.removeData(
                                                              index);
                                                        },
                                                        child: const Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),

                                                      /// EDIT BUTTON
                                                      InkResponse(
                                                        radius: 20,
                                                        onTap: () {
                                                          labelName
                                                              .text = controller
                                                                      .getSelectForm[
                                                                  'entries']
                                                              [index]['label'];
                                                          try {
                                                            sequenceData.text =
                                                                controller
                                                                    .getSelectForm[
                                                                        'entries']
                                                                        [index][
                                                                        'sequence']
                                                                    .toString();
                                                          } catch (e) {
                                                            print('---$e');
                                                          }

                                                          try {
                                                            widget
                                                                .setFormViewModel
                                                                ?.dropdownList = controller
                                                                            .getSelectForm[
                                                                        'entries'][index]
                                                                    [
                                                                    'entry_type']
                                                                ['$labelType'];
                                                          } catch (e) {
                                                            print(
                                                                '----ERORORORO___$e');
                                                          }

                                                          try {
                                                            widget
                                                                .setFormViewModel
                                                                ?.expandList = controller
                                                                            .getSelectForm[
                                                                        'entries'][index]
                                                                    [
                                                                    'entry_type']
                                                                ['$labelType'];
                                                          } catch (e) {
                                                            print(
                                                                'EXPAND ERROR---$e');
                                                          }

                                                          try {
                                                            widget
                                                                .setFormViewModel
                                                                ?.isDisplayOnly = controller
                                                                        .getSelectForm[
                                                                    'entries'][index]
                                                                [
                                                                'display_only'];

                                                            widget
                                                                .setFormViewModel
                                                                ?.isMasked = controller
                                                                        .getSelectForm[
                                                                    'entries'][
                                                                index]['masked'];
                                                            widget.setFormViewModel
                                                                    ?.isNewLine =
                                                                controller.getSelectForm[
                                                                            'entries']
                                                                        [index][
                                                                    'new_line'];
                                                            widget
                                                                .setFormViewModel
                                                                ?.isRelated = controller
                                                                        .getSelectForm[
                                                                    'entries'][
                                                                index]['related'];
                                                            widget
                                                                .setFormViewModel
                                                                ?.isControl = controller
                                                                        .getSelectForm[
                                                                    'entries'][
                                                                index]['control'];
                                                            widget.setFormViewModel
                                                                    ?.isFullWidth =
                                                                controller.getSelectForm[
                                                                            'entries']
                                                                        [index][
                                                                    'fullWidth'];
                                                            widget
                                                                .setFormViewModel
                                                                ?.expandValue = controller
                                                                        .getSelectForm[
                                                                    'entries'][
                                                                index]['expand'];
                                                            widget
                                                                .setFormViewModel
                                                                ?.isId = controller
                                                                        .getSelectForm[
                                                                    'entries'][
                                                                index]['is_id'];
                                                          } catch (e) {
                                                            print(
                                                                '----VALUE ERROR---$e');
                                                          }

                                                          EditDialogBox(
                                                              context,
                                                              labelType,
                                                              width,
                                                              controller,
                                                              index);
                                                        },
                                                        child: const Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      InkResponse(
                                                        radius: 20,
                                                        onTap: () {
                                                          DynamicWidgetAddition(
                                                            context,
                                                            controller
                                                                    .getSelectForm[
                                                                'entries'],
                                                          );
                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .access_alarm_outlined,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            // InkWell(
                                            //   onTap: () {
                                            //     List<String> data = [];
                                            //
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['new_line']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('new_line');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['is_id']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('is_id');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['display_only']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('display_only');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['control']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('control');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['fullWidth']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('fullWidth');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['related']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('related');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['expand']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('expand');
                                            //     }
                                            //     if (controller.getSelectForm[
                                            //                 'entries'][index]
                                            //                 ['masked']
                                            //             .toString() ==
                                            //         'true') {
                                            //       data.add('masked');
                                            //     }
                                            //
                                            //     print('-----DATA---${data}');
                                            //
                                            //     showDialog(
                                            //       context: context,
                                            //       builder: (context) {
                                            //         return SimpleDialog(
                                            //           contentPadding:
                                            //               EdgeInsets.symmetric(
                                            //                   horizontal: 40,
                                            //                   vertical: 40),
                                            //           children: [
                                            //             Container(
                                            //               width: 350,
                                            //               child: Column(
                                            //                 children: [
                                            //                   Row(
                                            //                     children: [
                                            //                       Expanded(
                                            //                         child: Text(
                                            //                           'Name',
                                            //                           style: TextStyle(
                                            //                               fontWeight: FontWeight
                                            //                                   .w500,
                                            //                               fontSize:
                                            //                                   18),
                                            //                         ),
                                            //                       ),
                                            //                       Expanded(
                                            //                           child:
                                            //                               Text(
                                            //                         '${controller.getSelectForm['entries'][index]['label']}',
                                            //                         style: TextStyle(
                                            //                             fontWeight:
                                            //                                 FontWeight
                                            //                                     .w600,
                                            //                             fontSize:
                                            //                                 18),
                                            //                       )),
                                            //                     ],
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: 20,
                                            //                   ),
                                            //                   Row(
                                            //                     children: [
                                            //                       Expanded(
                                            //                         child: Text(
                                            //                           'Sequence',
                                            //                           style: TextStyle(
                                            //                               fontWeight: FontWeight
                                            //                                   .w500,
                                            //                               fontSize:
                                            //                                   18),
                                            //                         ),
                                            //                       ),
                                            //                       Expanded(
                                            //                           child:
                                            //                               Text(
                                            //                         '${controller.getSelectForm['entries'][index]['sequence']}',
                                            //                         style: TextStyle(
                                            //                             fontWeight:
                                            //                                 FontWeight
                                            //                                     .w600,
                                            //                             fontSize:
                                            //                                 18),
                                            //                       )),
                                            //                     ],
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: 20,
                                            //                   ),
                                            //                   Align(
                                            //                     alignment:
                                            //                         Alignment
                                            //                             .topLeft,
                                            //                     child: Wrap(
                                            //                       runSpacing:
                                            //                           20,
                                            //                       spacing: 20,
                                            //                       children: [
                                            //                         ...List.generate(
                                            //                             data.length,
                                            //                             (index) {
                                            //                           return Row(
                                            //                             mainAxisSize:
                                            //                                 MainAxisSize.min,
                                            //                             children: [
                                            //                               Text(
                                            //                                 '${data[index]}',
                                            //                                 style:
                                            //                                     TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                            //                               ),
                                            //                               SizedBox(
                                            //                                 width:
                                            //                                     5,
                                            //                               ),
                                            //                               Checkbox(
                                            //                                 value:
                                            //                                     true,
                                            //                                 activeColor:
                                            //                                     Colors.teal,
                                            //                                 onChanged:
                                            //                                     (value) {},
                                            //                               )
                                            //                             ],
                                            //                           );
                                            //                         })
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: 20,
                                            //                   ),
                                            //                   Align(
                                            //                     alignment:
                                            //                         Alignment
                                            //                             .center,
                                            //                     child:
                                            //                         ElevatedButton(
                                            //                       onPressed:
                                            //                           () async {
                                            //                         Get.back();
                                            //                       },
                                            //                       child: Text(
                                            //                         'Ok',
                                            //                       ),
                                            //                     ),
                                            //                   )
                                            //                 ],
                                            //               ),
                                            //             )
                                            //           ],
                                            //         );
                                            //       },
                                            //     );
                                            //   },
                                            //   child: Container(
                                            //     width: width * 0.090,
                                            //     height: 50,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
            } catch (e) {
              return Center(
                child: Text('$e'),
              );
            }
          } else {
            return Center(
              child: Text('Try Again'),
            );
          }
        },
      ),
    );
  }

  void getFieldInfo(
      ShowSelectFormViewModel controller, int index, BuildContext context) {
    List<String> data = [];

    if (controller.getSelectForm['entries'][index]['new_line'].toString() ==
        'true') {
      data.add('new_line');
    }
    if (controller.getSelectForm['entries'][index]['is_id'].toString() ==
        'true') {
      data.add('is_id');
    }
    if (controller.getSelectForm['entries'][index]['display_only'].toString() ==
        'true') {
      data.add('display_only');
    }
    if (controller.getSelectForm['entries'][index]['control'].toString() ==
        'true') {
      data.add('control');
    }
    if (controller.getSelectForm['entries'][index]['fullWidth'].toString() ==
        'true') {
      data.add('fullWidth');
    }
    if (controller.getSelectForm['entries'][index]['related'].toString() ==
        'true') {
      data.add('related');
    }
    if (controller.getSelectForm['entries'][index]['expand'].toString() ==
        'true') {
      data.add('expand');
    }
    if (controller.getSelectForm['entries'][index]['masked'].toString() ==
        'true') {
      data.add('masked');
    }

    print('-----DATA---${data}');

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          children: [
            Container(
              width: 350,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        '${controller.getSelectForm['entries'][index]['label']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Sequence',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        '${controller.getSelectForm['entries'][index]['sequence']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        ...List.generate(data.length, (index) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${data[index]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Checkbox(
                                value: true,
                                activeColor: Colors.teal,
                                onChanged: (value) {},
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text(
                        'Ok',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  /// EDIT DIALOG BOX

  EditDialogBox(BuildContext context, String labelType, double width,
      ShowSelectFormViewModel controller, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return AlertDialog(
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: labelName,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Sequence : ',
                      ),
                      Expanded(
                        child: TextField(
                          controller: sequenceData,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (labelType == "DropDown")
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Value',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: buildTextFormField(
                                textEditingController: widget
                                    .setFormViewModel?.dropDownTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                if (widget.setFormViewModel!
                                    .dropDownTextController.text.isNotEmpty) {
                                  widget.setFormViewModel?.addDropDownValue(
                                      widget.setFormViewModel!
                                          .dropDownTextController.text);
                                  widget
                                      .setFormViewModel!.dropDownTextController
                                      .clear();
                                } else {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Enter Value');
                                }
                                setStat(() {});
                              },
                              icon: Icon(
                                Icons.add,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Select Value :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: Text(
                                '${widget.setFormViewModel?.dropdownList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (labelType == "Hyperlink")
                    Row(
                      children: [
                        Text(
                          'Value',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: buildTextFormField(
                            textEditingController:
                                widget.setFormViewModel?.hyperlinkController,
                            label: 'Enter Link value',
                            enable: true,
                          ),
                        ),
                      ],
                    ),
                  if (labelType == "Collapse Area")
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Value',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: buildTextFormField(
                                textEditingController: widget
                                    .setFormViewModel?.expandTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                if (widget.setFormViewModel!
                                    .expandTextController.text.isNotEmpty) {
                                  widget.setFormViewModel?.addCollapsValue(
                                      widget.setFormViewModel!
                                          .expandTextController.text);
                                  widget.setFormViewModel!.expandTextController
                                      .clear();
                                } else {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Enter Value');
                                }
                                setStat(() {});
                              },
                              icon: Icon(
                                Icons.add,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Select Value :',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: Text(
                                '${widget.setFormViewModel?.expandList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  selectFieldType(
                    context: context,
                    width: width,
                    titleLeft: 'Display only',
                    valueLeft: widget.setFormViewModel?.isDisplayOnly,
                    onPressLeft: (p0) {
                      widget.setFormViewModel?.updateIsDisplayOnly();
                      setStat(() {});
                    },
                    titleRight: 'Control',
                    valueRight: widget.setFormViewModel?.isControl,
                    onPressRight: (p0) {
                      widget.setFormViewModel?.updateIsControl();

                      setStat(() {});
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  selectFieldType(
                    context: context,
                    width: width,
                    titleLeft: 'Related',
                    valueLeft: widget.setFormViewModel?.isRelated,
                    onPressLeft: (p0) {
                      widget.setFormViewModel?.updateIsRelated();
                      setStat(() {});
                    },
                    titleRight: 'NewLine',
                    valueRight: widget.setFormViewModel?.isNewLine,
                    onPressRight: (p0) {
                      widget.setFormViewModel?.updateIsNewLine();
                      setStat(() {});
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  selectFieldType(
                    context: context,
                    width: width,
                    titleLeft: 'Masked',
                    valueLeft: widget.setFormViewModel?.isMasked,
                    onPressLeft: (p0) {
                      widget.setFormViewModel?.updateIsMasked();
                      setStat(() {});
                    },
                    titleRight: 'Full Width',
                    valueRight: widget.setFormViewModel?.isFullWidth,
                    onPressRight: (p0) {
                      widget.setFormViewModel?.updateIsFullWidth();
                      setStat(() {});
                    },
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          buildCheckbox(
                              value: widget.setFormViewModel?.isId,
                              onPress: (val) {
                                widget.setFormViewModel?.updateIsId(val);
                                setStat(() {});
                              }),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            'isId',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                            if (labelName.text.isNotEmpty) {
                              await controller.editData(
                                  sequence: sequenceData.text,
                                  labelNameType: labelType,
                                  index: index,
                                  title: labelName.text.trim().toString(),
                                  newLine: widget.setFormViewModel!.isNewLine,
                                  isId: widget.setFormViewModel!.isId,
                                  display_only:
                                      widget.setFormViewModel!.isDisplayOnly,
                                  control: widget.setFormViewModel!.isControl,
                                  fullWidth:
                                      widget.setFormViewModel!.isFullWidth,
                                  related: widget.setFormViewModel!.isRelated,
                                  masked: widget.setFormViewModel!.isMasked,
                                  dropDownList:
                                      widget.setFormViewModel?.dropdownList,
                                  expandList:
                                      widget.setFormViewModel?.expandList,
                                  hyperLink: widget.setFormViewModel
                                      ?.hyperlinkController.text);
                              labelName.clear();
                              sequenceData.clear();
                            }
                            Get.back();
                          },
                          child: Text(
                            'Edit',
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
            );
          },
        );
      },
    );
  }
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    print("Receive click event: " + (event == null ? "" : event));
  }
}
