import 'package:flutter/material.dart';

/// BorderRadius
String exportCircularBorderRadius(BorderRadius radius) {
  try {
  return "${radius.topLeft.x}";
  } catch (e) {
    return "0.0";
  }
}

BorderRadius parseCircularBorderRadius(String? radius) {
  if (radius != null && radius.isNotEmpty) {
    try {
      return BorderRadius.circular(
            double.parse(radius),
          );
    } catch (e) {
      return BorderRadius.zero;
    }
  } else {
    return BorderRadius.zero;
  }
}