import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/common/input_decoration_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/rounded_rectangle_border_parser.dart';

class TextFieldWidgetParser implements WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener, {
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? errorText,
  }) {
    /* final Color? color = parseHexColor(map['color']);
    final bool borderOnForeground = map['borderOnForeground'];
    final EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry(map['margin']);
    final Clip clipBehavior = parseClipBehavior(map['clipBehavior']);
    */

    String? data = map['data'];
    String? textAlignString = map['textAlign'];
    int? maxLines = map['maxLines'];
    String? textDirectionString = map['textDirection'];
    TextEditingController controller = TextEditingController(text: data);
    String? keyboardType = map['keyboard_type'];

    final InputDecoration? decoration =
        InputDecorationParser.parse(map['decoration'], errorText: errorText);

    return Row(
      children: [
        if (map.containsKey('label_text'))
          Text(
            map['label_text'] + ": ",
            style:
                map.containsKey('style') ? parseTextStyle(map['style']) : null,
          ),
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: parseTextAlign(textAlignString),
            keyboardType: parseTextInputType(keyboardType),
            // overflow: parseTextOverflow(overflow),
            maxLines: maxLines,
            // semanticsLabel: semanticsLabel,
            // softWrap: softWrap,
            textDirection: parseTextDirection(textDirectionString),
            style:
                map.containsKey('style') ? parseTextStyle(map['style']) : null,
            // textScaleFactor: textScaleFactor,
            decoration: decoration,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }

  @override
  String get widgetName => "TextField";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as TextField;

    final Map<String, dynamic>? decoration;
    if (realWidget.decoration != null) {
      decoration = InputDecorationParser.export(realWidget.decoration!);
    } else
      decoration = null;

    return <String, dynamic>{
      "type": "TextField",
      "data": realWidget.controller?.text,
      "keyboard_type": exportTextInputType(realWidget.keyboardType),
      "textAlign": realWidget.textAlign != null
          ? exportTextAlign(realWidget.textAlign)
          : "start",
      // "overflow": exportTextOverflow(realWidget.overflow),
      "maxLines": realWidget.maxLines,
      // "semanticsLabel": realWidget.semanticsLabel,
      // "softWrap": realWidget.softWrap,
      "textDirection": exportTextDirection(realWidget.textDirection),
      "style": exportTextStyle(realWidget.style),
      // "textScaleFactor": realWidget.textScaleFactor
      'decoration': decoration,
    };
  }

  @override
  Type get widgetType => TextField;

  @override
  bool matchWidgetForExport(Widget? widget) => widget is TextField;
}
