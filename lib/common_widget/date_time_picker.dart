import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

class DatePicker extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  DatePicker({Key? key, required this.index, this.name, this.controller})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? dateTime = 'dd/mm/yyyy';
  @override
  void initState() {
    try {
      dateTime = widget.controller
                      ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                  ['payload'][widget.index]['value'] ==
              'null'
          ? 'dd/mm/yyyy'
          : widget
              .controller
              ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                  ['payload'][widget.index]['value']
              .toString();
      widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
          ['Datefield'] = dateTime.toString().split(' ').first;
    } catch (e) {
      print('-----DATE PICKER ERROR----');
      dateTime = 'dd/mm/yyyy';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(
            width,
            widget.index,
            context,
            widget.name,
          ),
          commonSizedBox(width),
          InkWell(
            onTap: () async {
              DateTime? newData = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1800),
                lastDate: DateTime(2050),
              );

              if (newData != null) {
                setState(() {
                  dateTime = newData.toString();
                  widget.controller?.getSelectForm['entries'][widget.index]
                          ['entry_type']['Datefield'] =
                      dateTime.toString().split(' ').first;
                });
              }
            },
            child: Container(
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTime == null
                          ? 'dd/mm/yyyy'
                          : dateTime.toString().split(" ")[0],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  TimePicker({
    Key? key,
    required this.index,
    this.name,
    this.controller,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String? formattedTime = 'Time';

  @override
  void initState() {
    try {
      formattedTime = widget.controller
                      ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                  ['payload'][widget.index]['value'] ==
              'null'
          ? 'Time'
          : widget
              .controller
              ?.getSelectSaveForm[widget.controller!.selectedSaveForm]
                  ['payload'][widget.index]['value']
              .toString();

      widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
          ['TimeField'] = formattedTime;
    } catch (e) {
      print('-----TIME PICKER ERROR---');
      formattedTime = 'Time';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(
            width,
            widget.index,
            context,
            widget.name,
          ),
          commonSizedBox(width),
          InkWell(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context, //context of current state
              );

              if (pickedTime != null) {
                print(pickedTime.format(context)); //output 10:51 PM
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());

                formattedTime = DateFormat('HH:mm:ss').format(parsedTime);

                setState(() {
                  widget.controller?.getSelectForm['entries'][widget.index]
                      ['entry_type']['TimeField'] = formattedTime;
                });
              } else {
                print("Time is not selected");
              }
            },
            child: Container(
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedTime == null ? 'Time' : formattedTime!,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.timer,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// FOR FORM DATE
class FormDateField extends StatefulWidget {
  const FormDateField({
    Key? key,
    this.width,
    required this.name,
    required this.index,
    this.fullWidth,
  }) : super(key: key);
  final double? width;
  final String name;
  final bool? fullWidth;

  final int index;

  @override
  State<FormDateField> createState() => _FormDateFieldState();
}

class _FormDateFieldState extends State<FormDateField> {
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: widget.width! * 0.03),
      child: Row(
        children: [
          label(widget.width!, widget.index, context, '${widget.name}'),
          SizedBox(
            width: widget.width! * 0.02,
          ),
          InkWell(
            onTap: () async {
              DateTime? newData = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2031),
              );

              if (newData != null) {
                setState(() {
                  dateTime = newData;
                });
              }
            },
            child: Container(
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTime == null
                          ? 'dd/mm/yyyy'
                          : dateTime.toString().split(" ")[0],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.calendar_today,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// FOR FORM TIME
class FormTimeField extends StatefulWidget {
  FormTimeField({
    Key? key,
    this.width,
    required this.name,
    required this.index,
  }) : super(key: key);
  final double? width;
  final String name;
  final int index;

  @override
  State<FormTimeField> createState() => _FormTimeFieldState();
}

class _FormTimeFieldState extends State<FormTimeField> {
  String? formattedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: widget.width! * 0.03),
      child: Row(
        children: [
          label(widget.width!, widget.index, context, '${widget.name}'),
          SizedBox(
            width: widget.width! * 0.02,
          ),
          InkWell(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context, //context of current state
              );

              if (pickedTime != null) {
                print(pickedTime.format(context)); //output 10:51 PM
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());
                formattedTime = DateFormat('HH:mm:ss').format(parsedTime);

                setState(() {});
              } else {
                print("Time is not selected");
              }
            },
            child: Container(
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedTime == null ? 'Time' : formattedTime!,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.timer,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
