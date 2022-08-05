import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/model/code_data_model.dart';
import 'package:untitled/model/form_data_model.dart';
import 'package:untitled/model/user_model.dart';
import 'package:untitled/utils/api_path.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dio_client.dart';

class ApiClient {
  Dio _dio = Dio();
  Dio? baseUrl;

  ApiClient() {
    _dio = Dio();

    baseUrl = initializeInterceptors(_dio);
  }

  static Dio initializeInterceptors(Dio dio) {
    return dio..interceptors.add(LoggingInterceptor());
  }

  Future<bool> login(String email, String password) async {
    try {
      print("login" + email + password);

      Response response = await _dio.post(ApiPath.loginPath,
          data: FormData.fromMap({"email": email, "password": password}));
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        print("login" + userModel.toJson().toString());
        LocalStorage.SetString(LocalStorage.auth, userModel.data!.authToken!);
        LocalStorage.SetString(LocalStorage.email, userModel.data!.email!);
        LocalStorage.SetString(LocalStorage.password, password);
        return true;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error-- " + e.toString());
      return false;
    }
    return false;
  }

  Future<bool> passwordChange(
      String oldPasseord, String newPassword, String confirmPassword) async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";

      Response response = await _dio.post(ApiPath.changePasswordPath,
          data: FormData.fromMap({
            "old_password": oldPasseord,
            "new_password": newPassword,
            "confirm_new_password": confirmPassword
          }),
          options: Options(headers: {"Authorization": "Bearer " + auth}));
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        print("login" + userModel.toJson().toString());
        LocalStorage.SetString(LocalStorage.auth, userModel.data!.authToken!);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> logOut() async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";
      Response response = await _dio.get(ApiPath.logoutPath,
          options: Options(headers: {"Authorization": "Bearer " + auth}));
      if (response.statusCode == 200) {
        bool result = await LocalStorage.delectAllData();

        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
  Future<FormDataModel?> shopDetail() async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";
      Response response = await _dio.get(ApiPath.shopDetailPath,
          options: Options(headers: {"Authorization": "Bearer " + auth}));
      if (response.statusCode == 200) {

        FormDataModel formDataModel=FormDataModel.fromJson(response.data);
        return formDataModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  Future<CodeDataModel?> CodeData(String code) async {
    try {
      Response response = await _dio.get(ApiPath.getCodeData(code));
      if (response.statusCode == 200) {

        CodeDataModel codeDataModel=CodeDataModel.fromJson(response.data);
        return codeDataModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
