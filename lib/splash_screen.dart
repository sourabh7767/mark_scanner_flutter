
import 'package:flutter/material.dart';
import 'package:untitled/screen/home_screen.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/local_storage.dart';

import 'api/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      alignment: Alignment.center,
      child:  Image.asset(AppImages.AppLogo,
          width: MediaQuery.of(context).size.width * 0.5),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    String? auth=await LocalStorage.getString(LocalStorage.auth) ?? "";

      Future.delayed(Duration(seconds: 2)).then((value) {
          if(auth==""){
            Get.off(LoginScreen());

      }else{
                Get.off(HomeScreen());


          }
      });

    });

}
}
