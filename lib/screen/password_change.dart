import 'package:flutter/material.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/screen/home_screen.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/widgets/custom_edit_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/loader.dart';
import 'package:get/get.dart';

class PasswordChange extends StatelessWidget {
  PasswordChange({Key? key}) : super(key: key);

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.appColors),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Reset Password",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appColors),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  textEditingController: oldPassword,
                  hint: "Current Password",
                  inputLine: true,
                ),
                CustomTextField(
                    textEditingController: newPassword,
                    hint: "New Password",
                    inputLine: true),
                CustomTextField(
                    textEditingController: confirmPassword,
                    hint: "Confirm New Password",
                    inputLine: true),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      ProgressDialog.show(context);
                      if(newPassword.text.length>8){
                        Fluttertoast.showToast(msg: "enter at least 8 characters password");
                      }else if(confirmPassword.text.length>8){
                        Fluttertoast.showToast(msg: "enter at least 8 characters password");

                      }else{
                      ApiClient apiClient = ApiClient();
                      apiClient
                          .passwordChange(oldPassword.text, newPassword.text,
                              confirmPassword.text)
                          .then((value) {
                        if (value) {
                          Get.off(HomeScreen());
                          Fluttertoast.showToast(
                              msg: "Password updated successfully");
                        } else {
                          Fluttertoast.showToast(msg: "Something is wrong");
                        }
                        ProgressDialog.hide();
                      });}
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.appColors),
                        fixedSize: MaterialStateProperty.all(Size(180, 40))),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: AppColors.white),
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
