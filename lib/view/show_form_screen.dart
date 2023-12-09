import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/check_box.dart';
import 'package:web_demo_satish/common_widget/collaps.dart';
import 'package:web_demo_satish/common_widget/date_time_picker.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/image.dart';
import 'package:web_demo_satish/common_widget/multi_search_field.dart';
import 'package:web_demo_satish/common_widget/scroll_list.dart';
import 'package:web_demo_satish/common_widget/seprator.dart';
import 'package:web_demo_satish/common_widget/table_widget.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/view_model/get_all_form_view_model.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

class ShowFormScreen extends StatefulWidget {
  final GetAllFormViewModel? getAllFormViewModel;
  final SetFormViewModel? setFormViewModel;
  const ShowFormScreen(
      {Key? key, this.getAllFormViewModel, this.setFormViewModel})
      : super(key: key);

  @override
  State<ShowFormScreen> createState() => _ShowFormScreenState();
}

class _ShowFormScreenState extends State<ShowFormScreen> {
  ShowSelectFormViewModel showSelectFormViewModel =
      Get.put(ShowSelectFormViewModel());
  @override
  void initState() {
    super.initState();
  }

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
            if (controller.getFormDataApiResponse.status == Status.LOADING) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.getFormDataApiResponse.status == Status.COMPLETE) {
              try {
                if (controller.save == true) {
                  controller.updatePayloadId(
                      controller.getSelectSaveForm[controller.selectedSaveForm]
                              ['_id'] ??
                          '');
                }
              } catch (e) {
                log('PAYLOAD ERROR---$e');
                log('PAYLOAD ERROR---${controller.selectedSaveForm}');
              }
              try {
                return controller.isLoader == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: width * 0.02,
                            left: width * 0.02,
                          ),
                          child: AnimationLimiter(
                            child: Wrap(
                              runSpacing: width * 0.02,
                              children: List.generate(
                                controller.getSelectForm['entries'].length,
                                (index) {
                                  var labelType = controller
                                      .getSelectForm['entries'][index]
                                          ['entry_type']
                                      .keys
                                      .toString()
                                      .replaceAll('(', '')
                                      .replaceAll(')', '');

                                  var selectFormLabelName = controller
                                      .getSelectForm['entries'][index]['label'];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: buildForm(
                                          controller,
                                          index,
                                          labelType,
                                          width,
                                          selectFormLabelName,
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
                print('-----ERROR----');

                return SizedBox();
              }
            } else {
              return Center(
                child: Text(''),
              );
            }
          } else {
            return Center(
              child: Text('Something Went Wrong...'),
            );
          }
        },
      ),
    );
  }

  buildForm(ShowSelectFormViewModel controller, int index, String labelType,
      double width, selectFormLabelName) {
    return Column(
      children: [
        Container(
          width: controller.getSelectForm['entries'][index]['new_line'] == true
              ? width / 2
              : labelType == "Table"
                  ? width
                  : labelType == "Separator"
                      ? width
                      : labelType == "Collapse Area"
                          ? width
                          : controller.getSelectForm['entries'][index]
                                      ['fullWidth'] ==
                                  true
                              ? width
                              : width / 2.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelType == "DropDown"
                  ? BuildDropDownMenu(
                      index: index,
                      name: '${selectFormLabelName}',
                      controller: controller,
                    )
                  : labelType == "Check Box"
                      ? CheckBoxTicker(
                          index: index,
                          name: '${selectFormLabelName}',
                          controller: controller,
                        )
                      : labelType == "Datefield"
                          ? DatePicker(
                              index: index,
                              name: '${selectFormLabelName}',
                              controller: controller,
                            )
                          : labelType == "TimeField"
                              ? TimePicker(
                                  index: index,
                                  name: '${selectFormLabelName}',
                                  controller: controller,
                                )
                              : labelType == "Long box"
                                  ? LongBoxField(
                                      index: index,
                                      name: '${selectFormLabelName}',
                                      controller: controller,
                                    )
                                  : labelType == "Hyperlink"
                                      ? HyperLinkButton(
                                          index: index,
                                          name: '${selectFormLabelName}',
                                          controller: controller,
                                        )
                                      : labelType == "Image"
                                          ? ShowImageData(
                                              index: index,
                                              controller: controller,
                                              name: '${selectFormLabelName}',
                                            )
                                          : labelType == "Scrollable list"
                                              ? ScrollListData(
                                                  controller: controller,
                                                  name:
                                                      '${selectFormLabelName}',
                                                  index: index,
                                                )
                                              : labelType == "Field grouping"
                                                  ? FieldGroupField(
                                                      name:
                                                          '${selectFormLabelName}',
                                                      index: index,
                                                    )
                                                  : labelType == "Table"
                                                      ? RowTable(
                                                          title:
                                                              '${selectFormLabelName}',
                                                          index: index,
                                                          controller:
                                                              controller,
                                                        )
                                                      : labelType == "Separator"
                                                          ? BuildSeparator(
                                                              selectFormLabelName:
                                                                  selectFormLabelName,
                                                              width: width,
                                                              index: index,
                                                              controller:
                                                                  controller,
                                                            )
                                                          : labelType ==
                                                                  "Collapse Area"
                                                              ? buildCollapse(
                                                                  labelType:
                                                                      labelType,
                                                                  width: width,
                                                                  index: index,
                                                                  controller:
                                                                      controller,
                                                                )
                                                              : labelType ==
                                                                      "Search Box"
                                                                  ? BuildSearchTextField(
                                                                      index:
                                                                          index,
                                                                      name:
                                                                          '${selectFormLabelName}',
                                                                      controller:
                                                                          controller,
                                                                    )
                                                                  : labelType ==
                                                                          "Multi Search"
                                                                      ? BuildMultiSearchTextField(
                                                                          index:
                                                                              index,
                                                                          name:
                                                                              '${selectFormLabelName}',
                                                                          controller:
                                                                              controller,
                                                                        )
                                                                      : BuildTextField(
                                                                          index:
                                                                              index,
                                                                          name:
                                                                              '${selectFormLabelName}',
                                                                          controller:
                                                                              controller,
                                                                        )
            ],
          ),
        ),
      ],
    );
  }
}
