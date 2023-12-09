import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/app_bar.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/common_widget/check_box.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/common_widget/side_bar.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Repo/edit_saved_form_repo.dart';
import 'package:web_demo_satish/model/Repo/save_form_repo.dart';
import 'package:web_demo_satish/view/add_form_page.dart';
import 'package:web_demo_satish/view/blanck_page.dart';
import 'package:web_demo_satish/view/edit_form_screen.dart';
import 'package:web_demo_satish/view/get_all_form_screen.dart';
import 'package:web_demo_satish/view/show_form_screen.dart';
import 'package:web_demo_satish/view_model/add_form_view_model.dart';
import 'package:web_demo_satish/view_model/get_all_form_view_model.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  SetFormViewModel setFormViewModel = Get.put(SetFormViewModel());
  GetAllFormViewModel getAllFormViewModel = Get.put(GetAllFormViewModel());
  AddFormViewModel addFormViewModel = Get.put(AddFormViewModel());
  ShowSelectFormViewModel showSelectFormViewModel =
      Get.put(ShowSelectFormViewModel());
  TabController? tabController;
  @override
  void initState() {
    getAllFormViewModel.getAllFormViewModel();
    setFormViewModel.getNavigationDataViewModel();

    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(
        scaffoldKey: scaffoldKey,
        context: context,
        width: width,
        showSelectFormViewModel: showSelectFormViewModel,
        setFormViewModel: setFormViewModel,
        addFormViewModel: addFormViewModel,
        getAllFormViewModel: getAllFormViewModel,
      ),
      body: GetBuilder<GetAllFormViewModel>(
        builder: (allFormController) {
          if (allFormController.getAllFormApiResponse.status ==
              Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (allFormController.getAllFormApiResponse.status ==
              Status.COMPLETE) {
            return GetBuilder<SetFormViewModel>(
              builder: (controller) {
                if (controller.getNavigationDataApiResponse.status ==
                    Status.LOADING) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.getNavigationDataApiResponse.status ==
                    Status.COMPLETE) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sideBar(
                          showSelectFormViewModel: showSelectFormViewModel,
                          width: width,
                          formController: controller,
                          getAllFormController: allFormController),
                      controller.pageSelected == 0
                          ? HomeScreen()
                          : controller.pageSelected == 1
                              ? AddFormPage(
                                  setFormViewModel: controller,
                                )
                              : controller.pageSelected == 2
                                  ? EditFormScreen(
                                      setFormViewModel: controller,
                                    )
                                  : controller.selectAllPage == 0
                                      ? GetAllFormNameScreen()
                                      : ShowFormScreen(
                                          getAllFormViewModel:
                                              allFormController,
                                          setFormViewModel: controller,
                                        )
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Try Again'),
                  );
                }
              },
            );
          } else {
            return Center(
              child: Text('Try Again'),
            );
          }
        },
      ),
      floatingActionButton: GetBuilder<SetFormViewModel>(
        builder: (controller) {
          return controller.pageSelected == 0
              ? SizedBox()
              : controller.pageSelected == 2 || controller.pageSelected == 1
                  ? FormFieldAddBox(controller, context, width)
                  : controller.selectAllPage == 0
                      ? SizedBox()
                      : SaveFormData(controller, context);
        },
      ),
    );
  }

  /// FORM FIELD ADD
  FormFieldAddBox(
      SetFormViewModel controller, BuildContext context, double width) {
    return FloatingActionButton(
      onPressed: () {
        controller.searchBoxData.clear();
        controller.expandList.clear();
        controller.dropdownList.clear();

        if (controller.titleController.text.isNotEmpty &&
                controller.desController.text.isNotEmpty ||
            controller.pageSelected == 2) {
          FormAddDialog(context, width, controller).whenComplete(
            () {
              print('--------');
              controller.clearData();
              setState(() {});
            },
          );
        } else {
          if (controller.titleController.text.isEmpty) {
            CommonSnackBar.getWarningSnackBar(context, 'Enter Form Name fist!');
          } else if (controller.desController.text.isEmpty) {
            CommonSnackBar.getWarningSnackBar(
                context, 'Enter Form Description fist!');
          }
        }
      },
      tooltip: 'Add',
      child: const Icon(Icons.add),
    );
  }

  /// FORM ADD DIALOG
  FormAddDialog(
      BuildContext context, double width, SetFormViewModel controller) {
    int? sequence;

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStat) {
          return Dialog(
            child: SizedBox(
              width: width / 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: width * 0.025),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Label',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Expanded(
                            child: buildTextFormField(
                              textEditingController: controller.labelController,
                              label: 'label',
                              enable: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Type of field :',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Expanded(
                            child: DropdownSearch<dynamic>(
                              selectedItem: controller.optionSelected,
                              onChanged: (value) {
                                controller.updateShowTypeDropDownValue(
                                    value: value);

                                setStat(() {});
                                if (controller.optionSelected == 'Hyperlink') {
                                  controller.updateHyperLinkTrue();
                                  controller.updateDropDownFalse();
                                  controller.updateExpandFalse();
                                  controller.updateSearchBoxFalse();
                                } else {
                                  controller.updateHyperLinkFalse();
                                }
                                if (controller.optionSelected == 'DropDown') {
                                  controller.updateDropDownTrue();
                                  controller.updateExpandFalse();
                                  controller.updateHyperLinkFalse();
                                  controller.updateSearchBoxFalse();
                                } else {
                                  controller.updateDropDownFalse();
                                }
                                if (controller.optionSelected ==
                                    'Collapse Area') {
                                  controller.updateExpandTrue();
                                  controller.updateHyperLinkFalse();
                                  controller.updateDropDownFalse();
                                  controller.updateSearchBoxFalse();
                                } else {
                                  controller.updateExpandFalse();
                                }
                                if (controller.optionSelected == 'Search Box' ||
                                    controller.optionSelected ==
                                        'Multi Search') {
                                  controller.updateSearchBoxTrue();
                                  controller.updateExpandFalse();
                                  controller.updateHyperLinkFalse();
                                  controller.updateDropDownFalse();
                                } else {
                                  controller.updateSearchBoxFalse();
                                }
                              },
                              items: List.generate(controller.options.length,
                                  (index) {
                                return controller.options[index];
                              }),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                constraints: BoxConstraints.tightFor(
                                  height: 250,
                                  width: 400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      /// FOR HYPER LINK

                      if (controller.hyperLink == true)
                        Row(
                          children: [
                            Text(
                              'Link',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: buildTextFormField(
                                textEditingController:
                                    controller.hyperlinkController,
                                label: 'Enter Link',
                                enable: true,
                              ),
                            ),
                          ],
                        ),

                      if (controller.hyperLink == true)
                        const SizedBox(
                          height: 30,
                        ),

                      /// FOR DROP DOWN LINK

                      if (controller.dropDownValue == true)
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
                                    controller.dropDownTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  if (controller
                                      .dropDownTextController.text.isNotEmpty) {
                                    if (controller.dropDownValue == true) {
                                      controller.addDropDownValue(controller
                                          .dropDownTextController.text
                                          .toString());
                                      controller.dropDownTextController.clear();
                                    }
                                  } else {
                                    CommonSnackBar.getWarningSnackBar(
                                        context, 'Enter Value');
                                  }
                                  setStat(() {});
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      if (controller.dropDownValue == true)
                        const SizedBox(
                          height: 15,
                        ),
                      if (controller.dropDownValue == true)
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
                                '${controller.dropdownList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
                              ),
                            ),
                          ],
                        ),

                      /// FOR EXPANDED VALUE

                      if (controller.expandValue == true)
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
                                    controller.expandTextController,
                                label: 'Enter Data',
                                enable: true,
                              ),
                            ),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  if (controller
                                      .expandTextController.text.isNotEmpty) {
                                    if (controller.expandValue == true) {
                                      controller.addCollapsValue(controller
                                          .expandTextController.text
                                          .toString());
                                      controller.expandTextController.clear();
                                    }
                                  } else {
                                    CommonSnackBar.getWarningSnackBar(
                                        context, 'Enter Value');
                                  }
                                  setStat(() {});
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      if (controller.expandValue == true)
                        const SizedBox(
                          height: 15,
                        ),
                      if (controller.expandValue == true)
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
                                '${controller.expandList.toString().replaceAll('[', '').replaceAll(']', '').toString()}',
                              ),
                            ),
                          ],
                        ),

                      /// FOR SEARCH BOX VALUE

                      if (controller.searchBoxValue == true)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Page',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500)),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Theme(
                                    data: ThemeData(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        dropdownColor: Colors.white,
                                        hint: controller.selectPageName ==
                                                    'null' ||
                                                controller
                                                    .selectPageName.isEmpty
                                            ? Text('Select Option')
                                            : Text(
                                                controller.selectPageName
                                                    .split(':')
                                                    .first
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColor.mainColor),
                                              ),

                                        items: getAllFormViewModel.getAllForm!
                                            .map((e) {
                                          return DropdownMenuItem(
                                            child: OnHover(
                                              builder: (isHovered) {
                                                final color = isHovered
                                                    ? AppColor.mainColor
                                                    : Colors.black;
                                                return Text(
                                                  '${e['name']}',
                                                  style:
                                                      TextStyle(color: color),
                                                );
                                              },
                                            ),
                                            value: '${e['name']}:${e['_id']}',
                                          );
                                        }).toList(),
                                        // value: dropDownValue,
                                        onChanged: (val) async {
                                          controller
                                              .updateSelectPageName('${val}');

                                          setStat(() {});
                                          await showSelectFormViewModel
                                              .isIdFormViewModel(
                                                  id: val
                                                      .toString()
                                                      .split(':')
                                                      .last
                                                      .toString());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (controller.selectPageName.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    'Field',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  GetBuilder<ShowSelectFormViewModel>(
                                    builder: (showFormController) {
                                      if (showFormController
                                              .searchIdFormApiResponse.status ==
                                          Status.LOADING) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (showFormController
                                              .searchIdFormApiResponse.status ==
                                          Status.COMPLETE) {
                                        return Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade500)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.center,
                                          child: Theme(
                                            data: ThemeData(
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                hint: controller.selectPageFieldName ==
                                                            'null' ||
                                                        controller
                                                            .selectPageFieldName
                                                            .isEmpty
                                                    ? Text('Select Field')
                                                    : Text(
                                                        controller
                                                            .selectPageFieldName
                                                            .split(':')
                                                            .first,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .mainColor),
                                                      ),
                                                items: showFormController
                                                    .isIdFormData
                                                    .map(
                                                  (e) {
                                                    return DropdownMenuItem(
                                                      child: OnHover(
                                                        builder: (isHovered) {
                                                          final color =
                                                              isHovered
                                                                  ? AppColor
                                                                      .mainColor
                                                                  : Colors
                                                                      .black;
                                                          return Text(
                                                            '${e['label']}',
                                                            style: TextStyle(
                                                                color: color),
                                                          );
                                                        },
                                                      ),
                                                      value:
                                                          '${e['label']}:${e['label_id']}',
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (val) async {
                                                  controller
                                                      .updateSelectPageFieldName(
                                                          val!);
                                                  controller.addSearchValue(
                                                      formName: controller
                                                          .selectPageName
                                                          .toString()
                                                          .split(':')
                                                          .first
                                                          .trim()
                                                          .toString(),
                                                      labelId: controller
                                                          .selectPageFieldName
                                                          .toString()
                                                          .split(':')
                                                          .last
                                                          .trim()
                                                          .toString());

                                                  setStat(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: Text(''),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      if (controller.dropDownValue == true ||
                          controller.expandValue == true ||
                          controller.hyperLink == true ||
                          controller.searchBoxValue == true)
                        const SizedBox(
                          height: 15,
                        ),
                      selectFieldType(
                        context: context,
                        width: width,
                        titleLeft: 'Display only',
                        valueLeft: controller.isDisplayOnly,
                        onPressLeft: (p0) {
                          controller.updateIsDisplayOnly();
                          setStat(() {});
                        },
                        titleRight: 'Control',
                        valueRight: controller.isControl,
                        onPressRight: (p0) {
                          controller.updateIsControl();
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
                        valueLeft: controller.isRelated,
                        onPressLeft: (p0) {
                          controller.updateIsRelated();
                          setStat(() {});
                        },
                        titleRight: 'NewLine',
                        valueRight: controller.isNewLine,
                        onPressRight: (p0) {
                          controller.updateIsNewLine();
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
                        valueLeft: controller.isMasked,
                        onPressLeft: (p0) {
                          controller.updateIsMasked();
                          setStat(() {});
                        },
                        titleRight: 'Full Width',
                        valueRight: controller.isFullWidth,
                        onPressRight: (p0) {
                          controller.updateIsFullWidth();
                          setStat(() {});
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          buildCheckbox(
                              value: controller.isId,
                              onPress: (val) {
                                controller.updateIsId(val);
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
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              dynamic x;
                              if (controller.labelController.text.isNotEmpty) {
                                if (controller.pageSelected == 2) {
                                  /// ADD EDIT FORM FIELD
                                  if ((showSelectFormViewModel
                                          .getSelectForm['entries'] as List)
                                      .isEmpty) {
                                    sequence = 10;
                                  } else {
                                    int lastSequence = (showSelectFormViewModel
                                                    .getSelectForm['entries']
                                                as List)
                                            .last['sequence'] ??
                                        10;
                                    print('-----HELLO----$lastSequence');
                                    sequence = 10 + lastSequence;
                                  }
                                  print('-------SEQUENCE---$sequence');
                                  showSelectFormViewModel.setEditFields(
                                      sequence: sequence,
                                      optionSelected: controller.optionSelected,
                                      dropdownList: controller.dropdownList,
                                      expandList: controller.expandList,
                                      isControl: controller.isControl,
                                      isId: controller.isId,
                                      isDisplayOnly: controller.isDisplayOnly,
                                      isFullWidth: controller.isFullWidth,
                                      isMasked: controller.isMasked,
                                      isNewLine: controller.isNewLine,
                                      isRelated: controller.isRelated,
                                      searchList: controller.searchBoxData,
                                      labelController: controller
                                          .labelController.text
                                          .toString());
                                } else if (controller.pageSelected == 1) {
                                  /// ADD NEW FORM FIELD
                                  if ((controller.dataOfMap['entries'] as List)
                                      .isEmpty) {
                                    sequence = 10;
                                  } else {
                                    int lastSequence = (controller
                                                .dataOfMap['entries'] as List)
                                            .last['sequence'] ??
                                        10;
                                    print('-----HELLO----$lastSequence');
                                    sequence = 10 + lastSequence;
                                  }
                                  print('-------SEQUENCE---$sequence');

                                  controller.addNewFormField(
                                      context, sequence!);

                                  setStat(() {});
                                }
                              } else {
                                CommonSnackBar.getWarningSnackBar(
                                    context, 'Please enter the label');
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                  vertical: width * 0.008),
                              child: const Text("OK"),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                  vertical: width * 0.008),
                              child: const Text("CANCEL"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// SAVE OR SAVED ACTION
  SaveFormData(SetFormViewModel controller, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            onPressed: () {
              controller.updateSaveSelectedPage(-1);
              controller.updateSelectedPage(0);
              controller.updateSelectTab(0);
            },
            tooltip: 'close',
            child: const Icon(Icons.close),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          onPressed: () async {
            showSelectFormViewModel.updateLoaderValue(true);

            List<Map<String, dynamic>> data = [];
            try {
              for (int i = 0;
                  i <
                      (showSelectFormViewModel.getSelectForm['entries'] as List)
                          .length;
                  i++) {
                var labelType = showSelectFormViewModel
                    .getSelectForm['entries'][i]['entry_type'].keys
                    .toString()
                    .replaceAll('(', '')
                    .replaceAll(')', '');

                var dummyGetSelectFormData =
                    showSelectFormViewModel.dummyGetSelectForm['entries'][i]
                        ['entry_type']['${labelType}'];
                data.insert(i, {
                  'label_id':
                      '${showSelectFormViewModel.getSelectForm['entries'][i]['label_id']}',
                  'label':
                      '${showSelectFormViewModel.getSelectForm['entries'][i]['label']}',
                  'value': labelType == "Table"
                      ? showSelectFormViewModel.getSelectForm['entries'][i]
                          ['entry_type']['${labelType}']
                      : labelType == 'Collapse Area'
                          ? dummyGetSelectFormData
                          : labelType == 'DropDown'
                              ? dummyGetSelectFormData
                              : labelType == 'Search Box' ||
                                      labelType == 'Multi Search'
                                  ? dummyGetSelectFormData
                                  : '${showSelectFormViewModel.getSelectForm['entries'][i]['entry_type']['${labelType}']}',
                });
              }

              if (data.isNotEmpty) {
                ///  SAVE FORM DATA
                if (showSelectFormViewModel.save == false) {
                  LoggerUtils.logI('------SAVE DATA---$data');

                  var statusCode = await SaveFormRepo.saveFormRepo(
                      body: data,
                      formId: showSelectFormViewModel.getSelectForm['_id']);
                  if (statusCode != null) {
                    showSelectFormViewModel.updateLoaderValue(false);

                    print('-----FORM SAVED SUCCESSFULLY--');

                    CommonSnackBar.getSuccessSnackBar(
                        scaffoldKey.currentContext!, "Form Saved Successfully");
                    await showSelectFormViewModel.showSelectFormViewModel(
                      loading: true,
                      formId: '${showSelectFormViewModel.getSelectForm['_id']}',
                    );

                    setState(() {});
                  } else {
                    showSelectFormViewModel.updateLoaderValue(false);

                    CommonSnackBar.getFailedSnackBar(context, "Failed !");
                    setState(() {});
                  }
                }

                ///  UPDATE FORM DATA

                else if (showSelectFormViewModel.save == true) {
                  LoggerUtils.logI('------SAVED DATA---$data');

                  int statusCode = await EditSavedFormRepo.editSavedFormRepo(
                      body: {
                        'id':
                            '${showSelectFormViewModel.getSelectSaveForm[showSelectFormViewModel.selectedSaveForm]['_id']}',
                        'payload': data
                      },
                      formId:
                          '${showSelectFormViewModel.getSelectSaveForm[showSelectFormViewModel.selectedSaveForm]['table_id']}');

                  if (statusCode == 200) {
                    await showSelectFormViewModel
                        .showSelectFormViewModel(
                          loading: true,
                          formId:
                              '${showSelectFormViewModel.getSelectForm['_id']}',
                        )
                        .then(
                          (value) => showSelectFormViewModel
                              .getFormSaveDataViewModel(
                                  labelId: showSelectFormViewModel
                                      .isIdDropDownValue['label_id'],
                                  id: showSelectFormViewModel
                                      .getSelectForm['_id'],
                                  labelValue:
                                      showSelectFormViewModel.searchLabel),
                        );
                    showSelectFormViewModel.updateLoaderValue(false);

                    CommonSnackBar.getSuccessSnackBar(
                        scaffoldKey.currentContext!, "Form Updated");
                    setState(() {});
                  } else {
                    print('FAILED');

                    showSelectFormViewModel.updateLoaderValue(false);
                    CommonSnackBar.getFailedSnackBar(context, "Failed !");
                    setState(() {});
                  }
                }
              } else {
                CommonSnackBar.getWarningSnackBar(context, 'No Entries Found');
              }
            } catch (e) {
              controller.updateSaveCall(false);
              CommonSnackBar.getWarningSnackBar(
                  context, 'Something went wrong');
              print('------EROR---$e');
            }
            controller.updateSaveCall(false);
          },
          tooltip: 'Save',
          child: const Icon(Icons.save),
        ),
      ],
    );
  }
}

/// SELECT TYPE LIKE ISID ISMASKED
Row selectFieldType(
    {double? width,
    required BuildContext context,
    bool? valueLeft,
    bool? valueRight,
    String? titleRight,
    String? titleLeft,
    void Function(bool?)? onPressLeft,
    void Function(bool?)? onPressRight}) {
  return Row(
    children: [
      Expanded(
        child: Row(
          children: [
            buildCheckbox(value: valueLeft, onPress: onPressLeft),
            SizedBox(
              width: width! * 0.02,
            ),
            Text(
              titleLeft!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: Row(
          children: [
            buildCheckbox(value: valueRight, onPress: onPressRight),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              titleRight!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      )
    ],
  );
}
