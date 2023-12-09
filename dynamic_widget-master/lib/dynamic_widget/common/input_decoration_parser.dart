import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../other_utils.dart';

class InputDecorationParser {
  /*static Map<String, dynamic>? export(RoundedRectangleBorder rectangleBorder) {
    if (rectangleBorder.side == BorderSide.none &&
        rectangleBorder.borderRadius == BorderRadius.zero) {
      return null;
    }
    final BorderRadius borderRadius =
    rectangleBorder.borderRadius as BorderRadius;
    final Map<String, dynamic> map = {
      "side": exportBorderSide(rectangleBorder.side),
      "borderRadius": "${exportBorderRadius(borderRadius)}"
    };
    return map;
  }*/
  static Map<String, dynamic>? export(InputDecoration decoration) {
    final inputBorder = decoration.border as OutlineInputBorder;

    final Map<String, dynamic> map = {
      "side": exportBorderSide(inputBorder.borderSide),
      "borderRadius": exportCircularBorderRadius(inputBorder.borderRadius),
      "hint_text": decoration.hintText,
      "label_text": decoration.labelText,
      "enabled": decoration.enabled,
      "hint_style": exportTextStyle(decoration.hintStyle),
      // "label_style": exportTextStyle(decoration.labelStyle),
    };
    print('export decoration:- $map');
    return map;
  }

  static InputDecoration? parse(Map<String, dynamic>? map,
      {String? errorText}) {
    print('parse decoration $map');
    try {
      if (map == null) return null;

      return InputDecoration(
        border: OutlineInputBorder(
          borderSide: parseBorderSide(map['side']),
          borderRadius: parseCircularBorderRadius(
            map['borderRadius'],
          ),
        ),
        hintText: map['hint_text'],
        hintStyle: map.containsKey('hint_style')
            ? parseTextStyle(map['hint_style'])
            : null,
        labelText: map['label_text'],
        labelStyle: map.containsKey('label_style')
            ? parseTextStyle(map['label_style'])
            : null,
        enabled: map.containsKey('enabled') ? map['enabled'] : true,
        errorText: errorText,
      );
    } catch (e) {
      print('error ${e.toString()}');
      return InputDecoration();
    }
  }
}
