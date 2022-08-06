import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  String? title;
  String? text;
   CustomText({Key? key,this.text,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),

      child: Row(
        children: [
          SizedBox(
// width: 100,
            child: Text(  (title ?? ""),
            style: TextStyle(
               fontWeight: FontWeight.w500,
              fontSize: 16
            ),
            ),
          ), Text((text ?? ""),
          style: TextStyle(
             fontWeight: FontWeight.w400,
            fontSize: 16
          ),
          ),
        ],
      ),
    );
  }
}
