import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

class ScrollListData extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  ScrollListData({
    Key? key,
    required this.index,
    this.name,
    this.controller,
  }) : super(key: key);

  @override
  State<ScrollListData> createState() => _ScrollListDataState();
}

class _ScrollListDataState extends State<ScrollListData> {
  ScrollController scrollController = ScrollController();

  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: widget.controller?.getSelectForm['entries'][widget.index]
                  ['fullWidth'] ==
              true
          ? width - 300
          : width / 3,
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label(
              width,
              widget.index,
              context,
              widget.name,
            ),
            commonSizedBox(width),
            SizedBox(
              height: 200,
              width: 200,
              child: Scrollbar(
                controller: scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                thickness: 10,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = index;
                        });
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: selectedValue == index
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        height: 40,
                        child: Text(
                          'ITEM :- ${index + 1}',
                          style: TextStyle(height: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// FOR SCROLL LIST
class FormScollListField extends StatefulWidget {
  const FormScollListField({
    Key? key,
    required this.width,
    required this.scrollController,
    required this.name,
    required this.index,
    this.fullWidth,
  }) : super(key: key);

  final double width;
  final ScrollController scrollController;
  final String name;
  final int index;
  final bool? fullWidth;

  @override
  State<FormScollListField> createState() => _FormScollListFieldState();
}

class _FormScollListFieldState extends State<FormScollListField> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width / 3,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label(widget.width, widget.index, context, '${widget.name}'),
            SizedBox(
              width: widget.width * 0.02,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Scrollbar(
                controller: widget.scrollController,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                thickness: 10,
                child: ListView.builder(
                  controller: widget.scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = index;
                        });
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: selectedValue == index
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        height: 40,
                        child: Text(
                          'ITEM :- ${index + 1}',
                          style: TextStyle(height: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
