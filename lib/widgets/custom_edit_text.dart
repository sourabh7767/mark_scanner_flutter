import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final textEditingController;
  String? hint;
  bool? inputLine;
  bool? Capital;
  var textType;

  CustomTextField(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      this.inputLine,
        this.textType,
      this.Capital})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
          fontSize: 15,
        ),
        keyboardType: textType ?? TextInputType.text,
        textCapitalization: (Capital ?? false)
            ? TextCapitalization.characters
            : TextCapitalization.none,
        decoration: InputDecoration(
          focusColor: AppColors.appColors,
          fillColor: AppColors.appColors,
          focusedBorder: (inputLine ?? false)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1)),
          enabledBorder: (inputLine ?? false)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1)),
          disabledBorder: (inputLine ?? false)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1)),
          labelText: hint,
          hintText: hint,
          contentPadding: EdgeInsets.only(left: 10),
          hintStyle: TextStyle(color: Colors.black),
          labelStyle: TextStyle(
            color: AppColors.appColors,
          ),
          border: (inputLine ?? false)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1))
              : OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColors, width: 1)),
        ),
      ),
    );
  }
}
