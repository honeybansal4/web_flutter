import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class LimitedBoxWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    LimitedBox realWidget = widget as LimitedBox;
    return <String, dynamic>{
      "type": widgetName,
      "maxWidth": realWidget.maxWidth == double.infinity
          ? infinity
          : realWidget.maxWidth,
      "maxHeight": realWidget.maxHeight == double.infinity
          ? infinity
          : realWidget.maxHeight,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener,
      {ValueChanged<String>? onChanged,
        VoidCallback? onEditingComplete,
        ValueChanged<String>? onSubmitted,
        String? errorText}) {
    return LimitedBox(
      maxWidth: map.containsKey("maxWidth") ? map['maxWidth'] : double.infinity,
      maxHeight:
          map.containsKey("maxHeight") ? map['maxHeight'] : double.infinity,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => "LimitedBox";

  @override
  Type get widgetType => LimitedBox;
}
