import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:get/get.dart';
class CustomCheckBox extends StatefulWidget {
  String? text;
  bool? value;
  CustomCheckBox({Key? key,required this.text,required this.value,}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: Get.width*0.7,
              child: Text(widget.text!)),
          InkWell(
            onTap: (){

            },
            child: Checkbox(value: widget.value!,
                fillColor: MaterialStateProperty.all(AppColors.appColors),
                onChanged: (v){
              widget.value=!widget.value!;
              setState((){});
            }),
          )
        ],
      ),
    );
  }
}
