import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled/model/code_data_model.dart';
import 'package:untitled/model/form_data_model.dart';
import 'package:untitled/model/invoice_list_model.dart';
import 'package:untitled/model/service_form_model.dart';
import 'package:untitled/model/service_form_result_model.dart';
import 'package:untitled/model/user_model.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/utils/api_path.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dio_client.dart';
import 'package:get/get.dart' as getx;

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
        LocalStorage.SetString(LocalStorage.name, userModel.data!.fullName!);
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
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json"}));
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
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json"}));
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
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json"}));
      if (response.statusCode == 200) {

        FormDataModel formDataModel=FormDataModel.fromJson(response.data);
        return formDataModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  Future<InvoiceListModel?> invoiceList() async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";
      Response response = await _dio.get(ApiPath.invoiceListPath,
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json",}));
      if (response.statusCode == 200) {

        InvoiceListModel invoiceListModel=InvoiceListModel.fromJson(response.data);
        print("data --- "+invoiceListModel.data!.length.toString());
        return invoiceListModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  Future<ServiceFormResultModel?> saveForm(ServiceFormModel data) async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";
      print("Data --- "+data.toJson().toString());
      Response response = await _dio.post(ApiPath.saveInvoicePath,
          data: FormData.fromMap(data.toJson()),
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json"}));
      print("res"+response.toString());
      if (response.statusCode == 200) {

        ServiceFormResultModel serviceFormResultModel=ServiceFormResultModel.fromJson(response.data);
        return serviceFormResultModel;
      }
    } catch (e) {
      print("response--"+e.toString());
      return null;
    }
    return null;
  }
  Future<ServiceFormResultModel?> invoice(String id) async {
    try {
      String auth = await LocalStorage.getString(LocalStorage.auth) ?? "";
      Response response = await _dio.get(ApiPath.invoiceListPath+"/"+id,
          options: Options(headers: {"Authorization": "Bearer " + auth,"Accept":"application/json"}));
      if (response.statusCode == 200) {

        ServiceFormResultModel invoiceModel=ServiceFormResultModel.fromJson(response.data);
        return invoiceModel;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed ${e.toString()}");
      return null;
    }
    Fluttertoast.showToast(msg: "Failed");
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
