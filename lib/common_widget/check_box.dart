import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

Checkbox buildCheckbox({bool? value, void Function(bool?)? onPress}) {
  return Checkbox(value: value, onChanged: onPress);
}

class CheckBoxTicker extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;
  CheckBoxTicker({
    Key? key,
    required this.index,
    this.name,
    this.controller,
  }) : super(key: key);

  @override
  State<CheckBoxTicker> createState() => _CheckBoxTickerState();
}

class _CheckBoxTickerState extends State<CheckBoxTicker> {
  bool isNewLine = false;
  @override
  void initState() {
    try {
      if (widget.controller?.selectedSaveForm == -1) {
        isNewLine = false;
      } else {
        isNewLine = widget.controller
                        ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                    ['payload'][widget.index]['value'] ==
                'true'
            ? true
            : false;
        widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
            ['Check Box'] = isNewLine;
      }
    } catch (e) {
      print('---ERROR CHECK BOX---$e');
      isNewLine = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 2.8,
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.03),
        child: Row(
          children: [
            buildCheckbox(
                value: isNewLine,
                onPress: (val) {
                  setState(() {
                    isNewLine = val!;
                    widget.controller?.getSelectForm['entries'][widget.index]
                        ['entry_type']['Check Box'] = val;
                  });
                }),
            commonSizedBox(width),
            label(
              width,
              widget.index,
              context,
              widget.name,
            ),
          ],
        ),
      ),
    );
  }
}

/// FORM CHECK BOX
class formCheckBox extends StatefulWidget {
  const formCheckBox({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
    this.fullWidth,
  }) : super(key: key);

  final double width;
  final String name;
  final int index;
  final bool? fullWidth;

  @override
  State<formCheckBox> createState() => _formCheckBoxState();
}

class _formCheckBoxState extends State<formCheckBox> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width / 3,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.03),
        child: Row(
          children: [
            buildCheckbox(
                value: isCheck,
                onPress: (val) {
                  setState(() {
                    isCheck = val!;
                  });
                }),
            SizedBox(
              width: widget.width * 0.02,
            ),
            label(widget.width, widget.index, context, '${widget.name}'),
          ],
        ),
      ),
    );
  }
}
