import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class FieldArticle extends StatelessWidget {
  final Icon icon;
  final TextEditingController field_controller;
  final String text;
  final int min;
  final int max;
  final TextInputType keyboard;
  const FieldArticle({
    this.min=1,
    this.max=1,
    required this.keyboard,
    required this.icon,
    required this.text,
    required this.field_controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: min,
      maxLines: max,
      style: kCaptionTextStyle,
      controller: field_controller,
      keyboardType: keyboard,
      onChanged: ((value) {
        print(value);
      }),
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(
            borderRadius:
            const BorderRadius.all(Radius.circular(50.0))),
        prefixIcon: icon,
      ),
    );
  }
}