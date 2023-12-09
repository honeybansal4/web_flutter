import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class ExpandedWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener,
      {ValueChanged<String>? onChanged,
        VoidCallback? onEditingComplete,
        ValueChanged<String>? onSubmitted,
        String? errorText}) {
    return Expanded(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener)!,
      flex: map.containsKey("flex") ? map["flex"] : 1,
    );
  }

  @override
  String get widgetName => "Expanded";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Expanded;
    return <String, dynamic>{
      "type": widgetName,
      "flex": realWidget.flex,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Expanded;
}
