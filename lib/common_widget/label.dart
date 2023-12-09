import 'package:flutter/material.dart';

label(double width, int index, BuildContext context, label) {
  double size = width * 0.014;
  return SizedBox(
    width: width * 0.090,
    child: Text('${label}', style: TextStyle(fontSize: width * 0.010)),
  );
}

SizedBox commonSizedBox(double width) {
  return SizedBox(
    width: width * 0.00,
  );
}
