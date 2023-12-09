import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';

class FormGroupField extends StatefulWidget {
  const FormGroupField({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
  }) : super(key: key);

  final double width;
  final String name;
  final int index;

  @override
  State<FormGroupField> createState() => _FormGroupFieldState();
}

class _FormGroupFieldState extends State<FormGroupField> {
  int fieldLength = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: widget.width * 0.03),
      child: Row(
        children: [
          label(widget.width, widget.index, context, '${widget.name}'),
          SizedBox(
            width: widget.width * 0.02,
          ),
          Column(
            children: [
              commonButton(
                  width: 100,
                  height: 40,
                  onPress: () {
                    setState(() {
                      fieldLength++;
                    });
                    log('DATA ADDED');
                  },
                  name: '${widget.name}'),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 300,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: fieldLength,
                  itemBuilder: (context, index) {
                    return buildTextFormField(
                        index: index,
                        label: 'Enter Data',
                        textEditingController: TextEditingController());
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
