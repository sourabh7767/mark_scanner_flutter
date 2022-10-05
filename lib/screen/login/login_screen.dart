import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/screen/home_screen.dart';
import 'package:untitled/screen/privacyPolicy.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_images.dart';

import '../../../../main.dart';
import '../../utils/app_text.dart';
import '../../widgets/loader.dart';
import 'login_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  LoginController loginController = Get.put(LoginController());
FocusNode focusNode=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(() {
        return Scaffold(
          body: SingleChildScrollView(
keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(

              children: [  SizedBox(
                height: Get.height * 0.2,
              ),
                Image.asset(AppImages.AppLogo,
                    width: MediaQuery.of(context).size.width * 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Center(
                      child: Text(AppText.signin.toUpperCase(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appColors))),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.06,
                    vertical: Get.height * 0.01,
                  ),
                  child: TextField(
                    controller: emailController,
                    onEditingComplete: (){FocusScope.of(context).nextFocus();},
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (v) {
                      loginController.validatePassword(emailController.text);
                    },
                    decoration: InputDecoration(
                      errorText: !loginController.emailCheck.value
                          ? AppText.pleaseEnterCorrectEmail ?? "Enter Text"
                          : null,
                      contentPadding: EdgeInsets.only(left: 10),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.appColors, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.appColors, width: 1)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.appColors, width: 1)),
                      labelText: AppText.email,
                      hintText: AppText.email,
                      alignLabelWithHint: false,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                        color: AppColors.appColors,
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.appColors, width: 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.06,
                    vertical: Get.height * 0.01,
                  ),
                  child: TextField(
                    controller: passwordController,
                    autocorrect: true,
                    autofocus: true,
                    onEditingComplete: (){FocusScope.of(context).nextFocus();},

                    style: TextStyle(
                      fontSize: 20,
                    ),

                    onChanged: (v) {
                      loginController.validatePassword(passwordController.text);
                    },
                    obscureText:
                        loginController.visblePassword.value ? false : true,
                    decoration: InputDecoration(
                        errorText: !loginController.passwordCheck.value
                            ? AppText.pleaseEnterCorrectPassword ?? "Enter Text"
                            : null,
                        focusColor: AppColors.appColors,
                        fillColor: AppColors.appColors,

                        suffixIcon: InkWell(
                            onTap: () {
                              loginController.visblePassword.value =
                                  !loginController.visblePassword.value;
                            },
                            child: Icon(
                              loginController.visblePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.appColors,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.appColors, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.appColors, width: 1)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.appColors, width: 1)),
                        labelText: AppText.password,
                        hintText: AppText.password,
                        contentPadding: EdgeInsets.only(left: 10),
                        alignLabelWithHint: false,
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(
                          color: AppColors.appColors,
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.appColors, width: 1))),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                TextButton(
                    onPressed: () {
                      setState((){});
                      ProgressDialog.show(context);
                      ApiClient apiClient = ApiClient();

                      apiClient
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          Get.off(HomeScreen());
                        } else {
                          Fluttertoast.showToast(msg: "SomeThink Is Wrong");
                        }
                        ProgressDialog.hide();

                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.appColors)),
                    child: Text(
                      AppText.signin,
                      style: TextStyle(color: AppColors.white),
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                SizedBox(height: Get.height * 0.08),
                InkWell(
                    onTap: (){
                      Get.to(PrivacyPolicy());
                    },
                    child: Text("Privacy Policy",style: const TextStyle(
                      fontSize: 15,fontWeight: FontWeight.bold,
                      color: AppColors.appColors
                    ),)),
                SizedBox(
                  height: Get.height * 0.2,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
