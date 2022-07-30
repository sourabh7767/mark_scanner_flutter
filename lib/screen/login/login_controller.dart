import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailCheck = true.obs;
  var passwordCheck = true.obs;
  var visblePassword=false.obs;
  bool? checkEmail(email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    emailCheck.value = emailValid;

    return emailValid;
  }

  bool? validatePassword(String value) {
    // RegExp regex =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    // if (value.isEmpty) {
    //   passwordCheck.value = false;
    //
    //   return false;
    // } else {
    //   if (!regex.hasMatch(value)) {
    //     passwordCheck.value = false;
    //
    //     return false;
    //   } else {
    //     passwordCheck.value = true;
    //     return true;
    //   }
    // }
    return true;
  }


}
