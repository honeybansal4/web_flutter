import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

import 'label.dart';

class TableWidget extends StatefulWidget {
  final int? index;
  final title;
  final titles;
  final SetFormViewModel? addDataController;
  final ShowSelectFormViewModel? showSelectFormViewModel;

  const TableWidget(
      {super.key,
      this.index,
      this.title,
      this.titles,
      this.addDataController,
      this.showSelectFormViewModel});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List data = [
    ['NO'],
    [''],
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(width, widget.index!, context, '${widget.title}'),
          commonSizedBox(width),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width - 650,
                child: Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      ...List.generate(data.length, (index) {
                        return buildTableRow(data: data[index]);
                      })
                    ]),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setStat) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                buildTextFormField(
                                  textEditingController: widget.titles,
                                  label: 'Enter label',
                                  enable: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (widget.titles.text.isNotEmpty) {
                                      for (int i = 0; i < data.length; i++) {
                                        data[i].add(i == 0
                                            ? '${widget.titles.text.trim().toString()}'
                                            : '');
                                      }
                                      if (widget.addDataController
                                              ?.pageSelected ==
                                          1) {
                                        widget.addDataController!
                                                    .dataOfMap['entries']
                                                [widget.index]['entry_type']
                                            ['Table'] = data;
                                      } else if (widget.addDataController
                                              ?.pageSelected ==
                                          2) {
                                        widget.showSelectFormViewModel!
                                                    .getSelectForm['entries']
                                                [widget.index]['entry_type']
                                            ['Table'] = data;
                                      }

                                      Navigator.pop(context);
                                      setState(() {});
                                    } else {}

                                    widget.titles.clear();
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}

class RowTable extends StatefulWidget {
  final int? index;
  final title;
  final ShowSelectFormViewModel controller;

  const RowTable({
    Key? key,
    this.index,
    this.title,
    required this.controller,
  }) : super(key: key);

  @override
  State<RowTable> createState() => _RowTableState();
}

class _RowTableState extends State<RowTable> {
  List data = [
    ['NO'],
    [''],
  ];

  @override
  void initState() {
    try {
      data = widget
              .controller.getSelectSaveForm[widget.controller.selectedSaveForm]
          ['payload'][widget.index]['value'];

      widget.controller.getSelectForm['entries'][widget.index]['entry_type']
          ['Table'] = data;
      log('ENTER MODE111 :- ${data}');
    } catch (e) {
      if (widget.controller.getSelectForm['entries'][widget.index]['entry_type']
                  ['Table'] ==
              null ||
          widget.controller
                  .getSelectForm['entries'][widget.index]['entry_type']['Table']
                  .toString() ==
              '') {
        data = [
          ['NO'],
          [''],
        ];
      } else {
        data = widget.controller.getSelectForm['entries'][widget.index]
            ['entry_type']['Table'];
        widget.controller.getSelectForm['entries'][widget.index]['entry_type']
            ['Table'] = data;
      }
      print('-----ERROR-----$e');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(width, widget.index!, context, widget.title),
              SizedBox(
                width: width * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width - 650,
                    child: Table(
                      border: TableBorder
                          .all(), // Allows to add a border decoration around your table
                      children: [
                        ...List.generate(
                          data.length,
                          (index) {
                            return TableRow(
                              children: List.generate(
                                data[index]!.length,
                                (index1) {
                                  return TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (val) {
                                      data[index][index1] = val;
                                      widget.controller.getSelectForm['entries']
                                              [widget.index]['entry_type']
                                          ['Table'] = data;
                                      log('ALL DATA :- ${data}');
                                    },
                                    controller: TextEditingController(
                                        text: data[index][index1]),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      log('GET DATA :- $data');
                      data.add(
                        [
                          ...List.generate(data[0].length, (index) => ''),
                        ],
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

TableRow buildTableRow({List? data, bool enable = true}) {
  return TableRow(
      children: data!.map((e) {
    return TextField(
      textAlign: TextAlign.center,
      controller: TextEditingController(text: e),
      enabled: enable == true ? true : false,
    );
  }).toList());
}

class EditTableWidget extends StatefulWidget {
  final int? index;
  final title;
  final ShowSelectFormViewModel? controller;
  final SetFormViewModel? setFormViewModel;

  const EditTableWidget({
    super.key,
    this.index,
    this.title,
    this.controller,
    this.setFormViewModel,
  });

  @override
  State<EditTableWidget> createState() => _EditTableWidgetState();
}

class _EditTableWidgetState extends State<EditTableWidget> {
  TextEditingController labelTitle = TextEditingController();
  List data = [
    ['NO'],
    [''],
  ];

  @override
  void initState() {
    try {
      log('ENTER MODE222 :- ${data}');
      data = widget.controller?.getSelectForm['entries'][widget.index]
          ['entry_type']['Table'];
    } catch (e) {
      data = [
        ['NO'],
        [''],
      ];
      log('ENTER MODE333 :- ${data}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.02, right: width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(width, widget.index!, context, '${widget.title}'),
          commonSizedBox(width),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width - 650,
                child: Table(
                  border: TableBorder
                      .all(), // Allows to add a border decoration around your table
                  children: [
                    ...List.generate(
                      data.length,
                      (index) {
                        return buildTableRow(data: data[index]);
                      },
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setStat) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                buildTextFormField(
                                  textEditingController: labelTitle,
                                  label: 'Enter label',
                                  enable: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (labelTitle.text.isNotEmpty) {
                                      for (int i = 0; i < data.length; i++) {
                                        data[i].add(i == 0
                                            ? '${labelTitle.text.trim().toString()}'
                                            : '');
                                      }

                                      log('TABEL DATA :- ${data}');
                                      if (widget
                                              .setFormViewModel?.pageSelected ==
                                          2) {
                                        print(
                                            '--widget.index---${widget.index}');
                                        print(
                                            '--widget.controller!.getSelectSaveForm.length---${widget.controller!.getSelectSaveForm.length}');
                                        widget.controller
                                                    ?.getSelectForm['entries']
                                                [widget.index]['entry_type']
                                            ['Table'] = data;

                                        try {
                                          if (widget.controller!
                                              .getSelectSaveForm.isNotEmpty) {
                                            for (int i = 0;
                                                i <
                                                    widget
                                                        .controller!
                                                        .getSelectSaveForm
                                                        .length;
                                                i++) {
                                              widget.controller!
                                                          .getSelectSaveForm[i]
                                                      ['payload'][widget.index]
                                                  ['value'] = data;
                                            }
                                          }
                                        } catch (e) {
                                          print(
                                              '-----ERROR __EDIT DATA TABEL---');
                                        }
                                      } else {
                                        log('ENTER FIRST');
                                      }
                                      Navigator.pop(context);
                                      setState(() {});
                                    } else {}

                                    labelTitle.clear();
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
