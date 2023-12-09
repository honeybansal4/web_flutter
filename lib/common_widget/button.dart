import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

import 'label.dart';

Widget commonButton({onPress, String? name, double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      onPressed: onPress,
      child: Text(name!),
    ),
  );
}

class HyperLinkButton extends StatefulWidget {
  final int index;
  final String? name;
  final ShowSelectFormViewModel? controller;

  const HyperLinkButton(
      {Key? key, required this.index, this.name, this.controller})
      : super(key: key);

  @override
  State<HyperLinkButton> createState() => _HyperLinkButtonState();
}

class _HyperLinkButtonState extends State<HyperLinkButton> {
  String url = '';
  @override
  void initState() {
    try {
      url = (widget.controller
          ?.getSelectForm['entries'][widget.index]['entry_type']['Hyperlink']
          .toString())!;
      widget.controller?.getSelectForm['entries'][widget.index]['entry_type']
          ['Hyperlink'] = url;
    } catch (e) {
      print('----HYPER LINK ERROR-----');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        label(
          width,
          widget.index,
          context,
          widget.name,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        commonButton(
            width: 100,
            height: 40,
            onPress: () async {
              final Uri _url = Uri.parse('${url}');
              if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
              }
              log('DATA ADDED $_url');
            },
            name: widget.name),
      ],
    );
  }
}

/// FOR HYPRER LINK

class FormHyperLink extends StatelessWidget {
  const FormHyperLink({
    Key? key,
    required this.width,
    required this.name,
    required this.index,
  }) : super(key: key);

  final double width;
  final String name;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.03),
      child: Row(
        children: [
          label(width, index, context, '${name}'),
          SizedBox(
            width: width * 0.02,
          ),
          commonButton(
              width: 100,
              height: 40,
              onPress: () {
                log('DATA ADDED');
              },
              name: '${name}'),
        ],
      ),
    );
  }
}
