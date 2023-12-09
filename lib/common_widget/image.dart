import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_demo_satish/common_widget/label.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

class ShowImageData extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  ShowImageData({Key? key, required this.index, this.name, this.controller})
      : super(key: key);

  @override
  State<ShowImageData> createState() => _ShowImageDataState();
}

class _ShowImageDataState extends State<ShowImageData> {
  String? fileName;

  Uint8List? pickedFileBytes;

  ImagePicker imagePicker = ImagePicker();

  pickVideo() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    pickedFileBytes = await pickedFile!.readAsBytes();
    print('----UINT*LIST----${pickedFileBytes}');
    setState(() {
      // webImage = pickedFileBytes!;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 3,
      child: Padding(
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
            GestureDetector(
              onTap: () {
                pickVideo();
              },
              child: pickedFileBytes == null || pickedFileBytes!.isEmpty
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        pickedFileBytes!,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

/// FOR IMAGE DATA
class FormImageField extends StatefulWidget {
  FormImageField({
    Key? key,
    this.width,
    required this.name,
    required this.index,
    this.fullWidth,
  }) : super(key: key);
  final double? width;
  final String name;
  final int index;
  final bool? fullWidth;

  @override
  State<FormImageField> createState() => _FormImageFieldState();
}

class _FormImageFieldState extends State<FormImageField> {
  var pickedFile;

  String? fileName;

  File _file = File("zz");

  Uint8List? pickedFileBytes;

  Uint8List webImage = Uint8List(10);

  ImagePicker imagePicker = ImagePicker();

  pickVideo() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedFileBytes = await pickedFile!.readAsBytes();
      setState(() {
        _file = File("a");
        webImage = pickedFileBytes!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width! / 3,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width! * 0.03),
        child: Row(
          children: [
            label(widget.width!, widget.index, context, '${widget.name}'),
            SizedBox(
              width: widget.width! * 0.02,
            ),
            InkWell(
              onTap: () {
                pickVideo();
              },
              child: (_file.path == "zz")
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        webImage,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

/// FOR DOCUMENT DATA
class ForDocumentData extends StatefulWidget {
  final double? width;
  final String name;
  final int index;
  final bool? fullWidth;
  const ForDocumentData(
      {Key? key,
      this.width,
      required this.name,
      required this.index,
      this.fullWidth})
      : super(key: key);

  @override
  State<ForDocumentData> createState() => _ForDocumentDataState();
}

class _ForDocumentDataState extends State<ForDocumentData> {
  String? fileName;

  Uint8List? pickedFileBytes;

  ImagePicker imagePicker = ImagePicker();

  pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print('---result.files.single.bytes---${result.files.single.extension}');
      pickedFileBytes = await result.files.single.bytes;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width! / 3,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width! * 0.03),
        child: Row(
          children: [
            label(widget.width!, widget.index, context, '${widget.name}'),
            SizedBox(
              width: widget.width! * 0.02,
            ),
            InkWell(
              onTap: () {
                pickVideo();
              },
              child: pickedFileBytes == null
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        pickedFileBytes!,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
