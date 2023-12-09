import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

//
// class buildSeparator extends StatefulWidget {
//   const buildSeparator({
//     Key? key,
//     required this.width,
//     required this.index,
//     required this.formController,
//     required this.snapshot,
//   }) : super(key: key);
//
//   final double width;
//   final int index;
//   final GetAllFormController formController;
//   final AsyncSnapshot snapshot;
//
//   @override
//   State<buildSeparator> createState() => _buildSeparatorState();
// }
//
// class _buildSeparatorState extends State<buildSeparator> {
//   bool x = false;
//   UpdateController updateController = Get.put(UpdateController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     try {
//       x = widget.formController.allFormData[widget.formController.selectedPage]
//           ['entries'][widget.index + 1]['expand'] as bool;
//     } catch (e) {
//       x = false;
//     }
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           try {
//             x = !x;
//
//             widget.formController
//                     .allFormData[widget.formController.selectedPage]['entries']
//                 [widget.index + 1]['expand'] = x;
//             setState(() {});
//             updateController.updateState();
//           } catch (e) {
//             print('------DATA111---${x}');
//           }
//         },
//         child: Container(
//           margin: EdgeInsets.only(bottom: 15),
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.teal,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       try {
//                         x = !x;
//
//                         widget.formController
//                                 .allFormData[widget.formController.selectedPage]
//                             ['entries'][widget.index + 1]['expand'] = x;
//                         setState(() {});
//                         updateController.updateState();
//                       } catch (e) {
//                         print('------DATA111---${x}');
//                       }
//                     },
//                     child: Image.asset(
//                       'asset/link.png',
//                       color: Colors.white,
//                       height: 15,
//                       width: 15,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                       '${widget.snapshot.data['entries'][widget.index]['label']}',
//                       style: TextStyle(
//                           fontSize: widget.width * 0.014, color: Colors.white)),
//                 ],
//               ),
//               Icon(
//                 Icons.remove,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class BuildSeparator extends StatelessWidget {
  const BuildSeparator({
    super.key,
    required this.selectFormLabelName,
    required this.width,
    required this.index,
    required this.controller,
  });

  final String selectFormLabelName;
  final double width;
  final int index;
  final ShowSelectFormViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('----RTA');

          try {
            bool x = controller.getSelectForm['entries'][index + 1]['expand']
                as bool;
            print('--------VALUE OF X00 :- $x');

            x = !x;
            controller.getSelectForm['entries'][index + 1]['expand'] = x;
            controller.updateData();
            print('--------VALUE OF X :- $x');
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
                    '${selectFormLabelName}',
                    style:
                        TextStyle(fontSize: width * 0.014, color: Colors.white),
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
    );
  }
}
