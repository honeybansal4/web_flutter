import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';
//
// class buildCollapse extends StatefulWidget {
//   const buildCollapse({
//     Key? key,
//     required this.lableTypeName,
//     required this.index,
//     required this.formController,
//     required this.snapshot,
//     required this.saveSnapshot,
//   }) : super(key: key);
//
//   final String lableTypeName;
//
//   final int index;
//   final GetAllFormController formController;
//   final AsyncSnapshot snapshot, saveSnapshot;
//
//   @override
//   State<buildCollapse> createState() => _buildCollapseState();
// }
//
// class _buildCollapseState extends State<buildCollapse> {
//   List dataValue = [];
//   @override
//   void initState() {
//     try {
//       dataValue =
//           widget.saveSnapshot.data[widget.formController.selectedSaveForm]
//               ['payload'][widget.index]['value'];
//       widget.formController.allFormData[widget.formController.selectedPage]
//           ['entries'][widget.index]['entry_type']['Collapse Area'] = dataValue;
//     } catch (e) {
//       print('---');
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.only(bottom: 15),
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: GetBuilder<UpdateController>(
//           builder: (controllers) {
//             return widget.formController
//                             .allFormData[widget.formController.selectedPage]
//                         ['entries'][widget.index]['expand'] ==
//                     true
//                 ? SizedBox()
//                 : Column(
//                     children: [
//                       ...List.generate(
//                         (widget.snapshot.data['entries'][widget.index]
//                                     ['entry_type']['${widget.lableTypeName}']
//                                 as List)
//                             .length,
//                         (index1) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 label(width, index1, context,
//                                     '${widget.snapshot.data['entries'][widget.index]['entry_type']['${widget.lableTypeName}'][index1]}'),
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: TextEditingController(
//                                         text: widget.formController
//                                                     .selectedSaveForm ==
//                                                 -1
//                                             ? ''
//                                             : dataValue[index1] ?? ''),
//                                     onChanged: (val) async {
//                                       widget.formController.allFormData[widget
//                                                       .formController
//                                                       .selectedPage]['entries']
//                                                   [widget.index]['entry_type']
//                                               ['Collapse Area'][index1] =
//                                           val.toString();
//
//                                       print(
//                                           '----HELLO----${widget.formController.allFormData[widget.formController.selectedPage]['entries'][widget.index]['entry_type']['Collapse Area'][index1]}');
//                                     },
//                                     decoration: InputDecoration(
//                                       hintText: 'Value',
//                                       enabledBorder: OutlineInputBorder(),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.blue,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }

class buildCollapse extends StatefulWidget {
  const buildCollapse({
    super.key,
    required this.labelType,
    required this.width,
    required this.index,
    required this.controller,
  });

  final String labelType;
  final double width;
  final int index;
  final ShowSelectFormViewModel controller;

  @override
  State<buildCollapse> createState() => _buildCollapseState();
}

class _buildCollapseState extends State<buildCollapse> {
  List dataValue = [];

  @override
  void initState() {
    try {
      try {
        dataValue = widget.controller
                .getSelectSaveForm[widget.controller.selectedSaveForm]
            ['payload'][widget.index]['value'];
        widget.controller.dummyGetSelectForm['entries'][widget.index]
            ['entry_type']['Collapse Area'] = dataValue;
      } catch (e) {
        print('---EROROR');
      }
      if (dataValue.isEmpty) {
        (widget.controller.getSelectForm['entries'][widget.index]['entry_type']
                ['${widget.labelType}'] as List)
            .forEach((element) {
          dataValue.add('');
        });
      }
    } catch (e) {
      print('-------NOMKOj');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.controller.getSelectForm['entries'][widget.index]
                    ['expand'] ==
                true
            ? SizedBox()
            : Column(
                children: [
                  ...List.generate(
                    (widget.controller.getSelectForm['entries'][widget.index]
                            ['entry_type']['${widget.labelType}'] as List)
                        .length,
                    (index1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            label(
                              widget.width,
                              index1,
                              context,
                              '${widget.controller.getSelectForm['entries'][widget.index]['entry_type']['${widget.labelType}'][index1]}',
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: dataValue[index1] ?? ''),
                                onChanged: (val) async {
                                  widget.controller
                                                  .dummyGetSelectForm['entries']
                                              [widget.index]['entry_type']
                                          ['Collapse Area'][index1] =
                                      val.toString();
                                },
                                decoration: InputDecoration(
                                  hintText: 'Value',
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
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

/// FROM COLLAPS
class FromCollaps extends StatefulWidget {
  const FromCollaps({
    super.key,
    required this.labelType,
    required this.width,
    this.setFormViewModel,
    this.index,
  });

  final SetFormViewModel? setFormViewModel;

  final String labelType;
  final double width;
  final int? index;

  @override
  State<FromCollaps> createState() => _FromCollapsState();
}

class _FromCollapsState extends State<FromCollaps> {
  List<String> collapsData = [];
  @override
  void initState() {
    try {
      if (widget.setFormViewModel?.pageSelected == 1) {
        collapsData = List.from(widget.setFormViewModel?.dataOfMap['entries']
            [widget.index]['entry_type']['Collapse Area']);
        widget.setFormViewModel?.dataOfMap['entries'][widget.index]
            ['entry_type']['Collapse Area'] = collapsData;
      } else {}
    } catch (e) {
      print('-----ERROR----$e');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            ...List.generate(
              widget.setFormViewModel?.dataOfMap['entries'][widget.index]
                          ['expand'] ==
                      true
                  ? 0
                  : collapsData.length,
              (index1) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      label(
                        widget.width,
                        index1,
                        context,
                        '${collapsData[index1]}',
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
    );
  }
}
