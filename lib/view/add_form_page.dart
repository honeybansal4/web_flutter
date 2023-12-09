import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/check_box.dart';
import 'package:web_demo_satish/common_widget/collaps.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/date_time_picker.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/field_group.dart';
import 'package:web_demo_satish/common_widget/image.dart';
import 'package:web_demo_satish/common_widget/multi_search_field.dart';
import 'package:web_demo_satish/common_widget/scroll_list.dart';
import 'package:web_demo_satish/common_widget/table_widget.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/view/edit_form_screen.dart';
import 'package:web_demo_satish/view/main_screen.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';

class AddFormPage extends StatelessWidget {
  final SetFormViewModel setFormViewModel;
   AddFormPage({Key? key, required this.setFormViewModel})
      : super(key: key);

  ScrollController scrollController = ScrollController();

  TextEditingController titles = TextEditingController();

  final TextEditingController labelName = TextEditingController();

  final TextEditingController sequenceData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: setFormViewModel.dataOfMap.isEmpty
          ? SizedBox()
          : setFormViewModel.saveCall == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.02,
                      top: width * 0.02,
                    ),
                    child: Wrap(
                      runSpacing: width * 0.02,
                      children: List.generate(
                        setFormViewModel.dataOfMap['entries'].length,
                        (index) {
                          var labelType = setFormViewModel
                              .dataOfMap['entries'][index]['entry_type'].keys
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '');

                          return Column(
                            children: [
                              Container(
                                width: setFormViewModel
                                                .dataOfMap['entries'][index]
                                            ['new_line'] ==
                                        true
                                    ? width / 2
                                    : labelType == "Table"
                                        ? width
                                        : labelType == "Separator"
                                            ? width
                                            : labelType == "Collapse Area"
                                                ? width
                                                : setFormViewModel
                                                                    .dataOfMap[
                                                                'entries'][index]
                                                            ['fullWidth'] ==
                                                        true
                                                    ? width
                                                    : width / 2.4,
                                child: Row(
                                  children: [
                                    labelType == "Multi Search"
                                        ? FormMultiSearchBoxField(
                                            data: {},
                                            setFormViewModel:
                                                setFormViewModel,
                                            width: width,
                                            index: index,
                                            name:
                                                '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                          )
                                        : labelType == "DropDown"
                                            ? formDropDown(
                                                fullWidth: setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['fullWidth'],
                                                controller:
                                                    setFormViewModel,
                                                width: width,
                                                index: index,
                                                name:
                                                    '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                              )
                                            : labelType == "Check Box"
                                                ? formCheckBox(
                                                    fullWidth:
                                                        setFormViewModel
                                                                    .dataOfMap[
                                                                'entries'][
                                                            index]['fullWidth'],
                                                    width: width,
                                                    index: index,
                                                    name:
                                                        '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                  )
                                                : labelType == "Datefield"
                                                    ? FormDateField(
                                                        fullWidth: setFormViewModel
                                                                    .dataOfMap[
                                                                'entries'][
                                                            index]['fullWidth'],
                                                        width: width,
                                                        index: index,
                                                        name:
                                                            '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                      )
                                                    : labelType == "TimeField"
                                                        ? FormTimeField(
                                                            width: width,
                                                            index: index,
                                                            name:
                                                                '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                          )
                                                        : labelType ==
                                                                "File upload"
                                                            ? ForDocumentData(
                                                                width: width,
                                                                index: index,
                                                                fullWidth: setFormViewModel
                                                                        .dataOfMap['entries'][index]
                                                                    [
                                                                    'fullWidth'],
                                                                name:
                                                                    '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                              )
                                                            : labelType ==
                                                                    "Long box"
                                                                ? FormLongField(
                                                                    width:
                                                                        width,
                                                                    index:
                                                                        index,
                                                                    name:
                                                                        '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                                    fullWidth: setFormViewModel
                                                                            .dataOfMap['entries'][index]
                                                                        [
                                                                        'fullWidth'])
                                                                : labelType ==
                                                                        "Hyperlink"
                                                                    ? FormHyperLink(
                                                                        width:
                                                                            width,
                                                                        name:
                                                                            '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                                        index:
                                                                            index,
                                                                      )
                                                                    : labelType ==
                                                                            "Image"
                                                                        ? FormImageField(
                                                                            fullWidth:
                                                                                setFormViewModel.dataOfMap['entries'][index]['fullWidth'],
                                                                            width:
                                                                                width,
                                                                            index:
                                                                                index,
                                                                            name:
                                                                                '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                                          )
                                                                        : labelType ==
                                                                                "Scrollable list"
                                                                            ? FormScollListField(
                                                                                fullWidth: setFormViewModel.dataOfMap['entries'][index]['fullWidth'],
                                                                                index: index,
                                                                                name: '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                                                width: width,
                                                                                scrollController: scrollController,
                                                                              )
                                                                            : labelType == "Field grouping"
                                                                                ? FormGroupField(
                                                                                    width: width,
                                                                                    index: index,
                                                                                    name: '${setFormViewModel.dataOfMap['entries'][index]['label']}',
                                                                                  )
                                                                                : labelType == "Table"
                                                                                    ? TableWidget(
                                                                                        index: index,
                                                                                        title: setFormViewModel.dataOfMap['entries'][index]['label'],
                                                                                        titles: titles,
                                                                                        addDataController: setFormViewModel,
                                                                                      )
                                                                                    : labelType == "Search Box"
                                                                                        ? FormSearchBoxField(
                                                                                            index: index,
                                                                                            name: setFormViewModel.dataOfMap['entries'][index]['label'],
                                                                                            setFormViewModel: setFormViewModel,
                                                                                            width: width,
                                                                                          )
                                                                                        : labelType == "Separator"
                                                                                            ? Expanded(
                                                                                                child: GestureDetector(
                                                                                                  onTap: () {
                                                                                                    print('----RTA');

                                                                                                    try {
                                                                                                      bool x = setFormViewModel.dataOfMap['entries'][index + 1]['expand'] as bool;
                                                                                                      print('--------VALUE OF X00 :- $x');

                                                                                                      x = !x;
                                                                                                      setFormViewModel.dataOfMap['entries'][index + 1]['expand'] = x;
                                                                                                      print('--------VALUE OF X :- $x');
                                                                                                      setFormViewModel.updateState();
                                                                                                    } catch (e) {
                                                                                                      print('------$e');
                                                                                                    }
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                                                    decoration: BoxDecoration(
                                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                                      color: AppColor.mainColor,
                                                                                                    ),
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
                                                                                                              '${setFormViewModel.dataOfMap['entries'][index]['label']}',
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
                                                                                                ? FromCollaps(
                                                                                                    labelType: labelType,
                                                                                                    width: width,
                                                                                                    setFormViewModel: setFormViewModel,
                                                                                                    index: index,
                                                                                                  )
                                                                                                : setFormViewModel.dataOfMap['entries'][index]['edit_code'] != null
                                                                                                    ? SizedBox(
                                                                                                          width: 200,
                                                                                                          child: DynamicWidgetBuilder.build(jsonEncode(setFormViewModel.dataOfMap['entries'][index]['edit_code']), context, new DefaultClickListener()),
                                                                                                        ) ??
                                                                                                        Text("Error")
                                                                                                    : FromTextField(
                                                                                                        // onTap: () {
                                                                                                        //   getFieldInfo(controller, index, context);
                                                                                                        // },
                                                                                                        labelType: labelType,
                                                                                                        width: width,
                                                                                                        index: index,
                                                                                                        name: setFormViewModel.dataOfMap['entries'][index]['label'].toString(),
                                                                                                        fullWidth: setFormViewModel.dataOfMap['entries'][index]['fullWidth'] as bool,
                                                                                                      ),

                                    // FromTextField(
                                    //     labelType: labelType,
                                    //     width: width,
                                    //     index: index,
                                    //     name: widget.setFormViewModel.dataOfMap['entries'][index]['label'].toString(),
                                    //     fullWidth: widget.setFormViewModel.dataOfMap['entries'][index]['fullWidth'] as bool,
                                    //   ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          // Preview code
                                          // InkResponse(
                                          //               radius: 20,
                                          //               onTap: () {
                                          //                 ViewCodeDialogBox(
                                          //                   context,
                                          //                   labelType,
                                          //                   width,
                                          //                   widget.setFormViewModel,
                                          //                   index,
                                          //                   widget.setFormViewModel
                                          //                       .getSelectForm[
                                          //                           'entries']
                                          //                           [index]
                                          //                           ['label']
                                          //                       .toString(),
                                          //                 );
                                          //                 setState(() {});
                                          //               },
                                          //               child: const Icon(
                                          //                 Icons.preview_rounded,
                                          //                 size: 20,
                                          //                 color: Colors.grey,
                                          //               ),
                                          //             ),
                                          /// DELETE BUTTON
                                          InkResponse(
                                            radius: 20,
                                            onTap: () {
                                              setFormViewModel
                                                  .removeData(index);
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
                                              labelName.text = setFormViewModel
                                                      .dataOfMap['entries']
                                                  [index]['label'];

                                              try {
                                                sequenceData.text = setFormViewModel
                                                    .dataOfMap['entries'][index]
                                                        ['sequence']
                                                    .toString();
                                              } catch (e) {
                                                print('---$e');
                                              }

                                              try {
                                                setFormViewModel
                                                    ?.expandList = setFormViewModel
                                                            .dataOfMap[
                                                        'entries'][index][
                                                    'entry_type']['$labelType'];
                                              } catch (e) {
                                                print('EXPAND ERROR---$e');
                                              }

                                              try {
                                                setFormViewModel
                                                    ?.dropdownList = setFormViewModel
                                                            .dataOfMap[
                                                        'entries'][index][
                                                    'entry_type']['$labelType'];
                                              } catch (e) {
                                                print('----ERORORORO___$e');
                                              }

                                              try {
                                                setFormViewModel
                                                    ?.isDisplayOnly = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['display_only'];

                                                setFormViewModel
                                                    ?.isMasked = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['masked'];
                                                setFormViewModel
                                                    ?.isRelated = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['related'];
                                                setFormViewModel
                                                    ?.isControl = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['control'];

                                                setFormViewModel
                                                    ?.isNewLine = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['new_line'];
                                                setFormViewModel
                                                    ?.isFullWidth = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['fullWidth'];
                                                setFormViewModel
                                                    ?.expandValue = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['expand'];
                                                setFormViewModel
                                                    .isId = setFormViewModel
                                                        .dataOfMap['entries']
                                                    [index]['is_id'];
                                              } catch (e) {
                                                print('----VALUE ERROR---$e');
                                              }
                                              EditDialogBox(
                                                  context,
                                                  labelType,
                                                  width,
                                                  setFormViewModel,
                                                  index);
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
    );
  }

  /// EDIT DIALOG BOX
  EditDialogBox(BuildContext context, String labelType, double width,
      SetFormViewModel controller, int index) {
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
                                textEditingController: setFormViewModel.dropDownTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                if (setFormViewModel
                                    .dropDownTextController.text.isNotEmpty) {
                                  setFormViewModel.addDropDownValue(
                                      setFormViewModel
                                          .dropDownTextController.text);
                                  setFormViewModel.dropDownTextController
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
                                '${setFormViewModel.dropdownList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
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
                                setFormViewModel?.hyperlinkController,
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
                                textEditingController: setFormViewModel?.expandTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                if (setFormViewModel!
                                    .expandTextController.text.isNotEmpty) {
                                  setFormViewModel?.addCollapsValue(
                                      setFormViewModel!
                                          .expandTextController.text);
                                  setFormViewModel!.expandTextController
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
                                '${setFormViewModel?.expandList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
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
                    valueLeft: setFormViewModel?.isDisplayOnly,
                    onPressLeft: (p0) {
                      setFormViewModel?.updateIsDisplayOnly();
                      setStat(() {});
                    },
                    titleRight: 'Control',
                    valueRight: setFormViewModel?.isControl,
                    onPressRight: (p0) {
                      setFormViewModel?.updateIsControl();

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
                    valueLeft: setFormViewModel?.isRelated,
                    onPressLeft: (p0) {
                      setFormViewModel?.updateIsRelated();
                      setStat(() {});
                    },
                    titleRight: 'NewLine',
                    valueRight: setFormViewModel?.isNewLine,
                    onPressRight: (p0) {
                      setFormViewModel?.updateIsNewLine();
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
                    valueLeft: setFormViewModel?.isMasked,
                    onPressLeft: (p0) {
                      setFormViewModel?.updateIsMasked();
                      setStat(() {});
                    },
                    titleRight: 'Full Width',
                    valueRight: setFormViewModel?.isFullWidth,
                    onPressRight: (p0) {
                      setFormViewModel?.updateIsFullWidth();
                      setStat(() {});
                    },
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          buildCheckbox(
                              value: setFormViewModel?.isId,
                              onPress: (val) {
                                setFormViewModel?.updateIsId(val);
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
                                  newLine: setFormViewModel!.isNewLine,
                                  isId: setFormViewModel!.isId,
                                  display_only:
                                      setFormViewModel!.isDisplayOnly,
                                  control: setFormViewModel!.isControl,
                                  fullWidth:
                                      setFormViewModel!.isFullWidth,
                                  related: setFormViewModel!.isRelated,
                                  masked: setFormViewModel!.isMasked,
                                  dropDownList:
                                      setFormViewModel?.dropdownList,
                                  expandList:
                                      setFormViewModel?.expandList,
                                  hyperLink: setFormViewModel
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
    ).whenComplete(() => controller.clearData());
  }
}
