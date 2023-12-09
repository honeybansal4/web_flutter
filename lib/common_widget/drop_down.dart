import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

buildDropdownButton(
    {List? dropDownValueList,
    String? dropDownValue,
    void Function(String?)? changeData}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500)),
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
          style: const TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          hint: dropDownValue == null ||
                  dropDownValue == 'null' ||
                  dropDownValue.isEmpty
              ? Text('Select Option')
              : Text(
                  dropDownValue,
                  style: TextStyle(color: AppColor.mainColor),
                ),

          items: dropDownValueList!.map((e) {
            return DropdownMenuItem<String>(
              child: OnHover(
                builder: (isHovered) {
                  final color = isHovered ? AppColor.mainColor : Colors.black;
                  return Text(
                    '$e',
                    style: TextStyle(color: color),
                  );
                },
              ),
              value: e,
            );
          }).toList(),
          // value: dropDownValue,
          onChanged: changeData,
        ),
      ),
    ),
  );
}

class BuildDropDownMenu extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  BuildDropDownMenu({
    Key? key,
    required this.index,
    this.name,
    this.controller,
  }) : super(key: key);

  @override
  State<BuildDropDownMenu> createState() => _BuildDropDownMenuState();
}

class _BuildDropDownMenuState extends State<BuildDropDownMenu> {
  String? dropDownValue = '';

  List dropDownValueList = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
    "Option 5",
  ];

  @override
  void initState() {
    try {
      dropDownValueList = widget.controller?.getSelectForm['entries']
          [widget.index]['entry_type']['DropDown'];
      try {
        dropDownValue = widget.controller
                    ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                ['payload'][widget.index]['value'] ??
            '';
        widget.controller?.dummyGetSelectForm['entries'][widget.index]
            ['entry_type']['DropDown'] = dropDownValue;
      } catch (e) {
        print('---DDROP DOWN ERROR123---');
      }
    } catch (e) {
      print('---DDROP DOWN ERROR---');
      dropDownValueList = [
        "Option 1",
        "Option 2",
        "Option 3",
        "Option 4",
        "Option 5",
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 2.8,
      child: Row(
        children: [
          label(
            width,
            widget.index,
            context,
            widget.name,
          ),
          commonSizedBox(width),
          buildDropdownButton(
            changeData: (val) {
              setState(() {
                dropDownValue = val!;
                widget.controller?.dummyGetSelectForm['entries'][widget.index]
                    ['entry_type']['DropDown'] = dropDownValue;
              });
            },
            dropDownValue: dropDownValue,
            dropDownValueList: dropDownValueList,
          )
        ],
      ),
    );
  }
}

/// FOR FORM DROPDOWN
class formDropDown extends StatefulWidget {
  const formDropDown({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
    this.controller,
    this.selectFormViewModel,
    this.fullWidth,
  }) : super(key: key);

  final double? width;
  final String name;
  final int index;
  final bool? fullWidth;
  final SetFormViewModel? controller;
  final ShowSelectFormViewModel? selectFormViewModel;

  @override
  State<formDropDown> createState() => _formDropDownState();
}

class _formDropDownState extends State<formDropDown> {
  List<String> dropDownValueList = [
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4",
    "Option 5",
  ];

  String? dropDownValue;

  @override
  void initState() {
    try {
      if (widget.controller?.pageSelected == 1) {
        dropDownValueList = List.from(widget.controller?.dataOfMap['entries']
            [widget.index]['entry_type']['DropDown']);
        widget.controller?.dataOfMap['entries'][widget.index]['entry_type']
            ['DropDown'] = dropDownValueList;
      } else {
        dropDownValueList = List.from(widget.selectFormViewModel
            ?.getSelectForm['entries'][widget.index]['entry_type']['DropDown']);
        widget.selectFormViewModel?.getSelectForm['entries'][widget.index]
                ['entry_type']['DropDown'] ==
            dropDownValueList;
      }
    } catch (e) {
      dropDownValueList = [
        "Option 1",
        "Option 2",
        "Option 3",
        "Option 4",
        "Option 5",
      ];
      print('----ERROR------$e');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width! / 3,
      child: Row(
        children: [
          label(widget.width!, widget.index, context, '${widget.name}'),
          SizedBox(
            width: widget.width! * 0.02,
          ),
          buildDropdownButton(
            dropDownValue: dropDownValue,
            dropDownValueList: dropDownValueList,
            changeData: (value) {
              setState(() {
                dropDownValue = value;
              });
            },
          )
        ],
      ),
    );
  }
}

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHover({Key? key, required this.builder}) : super(key: key);

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    // on hover animation movement matrix translation
    final hovered = Matrix4.identity()..translate(10, 0, 0);
    final transform = isHovered ? hovered : Matrix4.identity();

    // when user enter the mouse pointer onEnter method will work
    // when user exit the mouse pointer from MouseRegion onExit method will work
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: transform, // animation transformation hovered.
        child:
            widget.builder(isHovered), // build the widget passed from main.dart
      ),
    );
  }

  //used to set bool isHovered to true/false
  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
