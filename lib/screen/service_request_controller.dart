import 'package:untitled/api/dio.dart';
import 'package:untitled/model/code_data_model.dart';
import 'package:untitled/model/form_data_model.dart';
import 'package:get/get.dart';

import '../model/ServicesListModel.dart';
import '../model/service_form_result_model.dart';

class ServiceRequestController extends GetxController{
  Rx<FormDataModel> formDataModel = FormDataModel().obs;
  var check = false.obs;
  Rx<ShopDetails> shopDetails = ShopDetails().obs;
  Rx<CodeDataModel> codeData = CodeDataModel().obs;
  Rx<ServicesListModel> servicesListModel=ServicesListModel(services: []).obs;
  Rx<ServiceFormResultModel> invoice=ServiceFormResultModel().obs;
RxInt count=1.obs;
  LoadData() async {
    ApiClient apiClient = ApiClient();
    var data = ShopDetails(
        iso: "",
        updatedAt: "",
        number: "",
        id: 0,
        dialCode: "",
        createdAt: "",
        name: "Select Shop Name",
        email: "");
    shopDetails.value = ShopDetails.fromJson(data.toJson());
    formDataModel.value = await apiClient.shopDetail() ?? FormDataModel();
    formDataModel.value.data!.shopDetails!.insert(0, data);
    shopDetails.value = formDataModel.value.data!.shopDetails![0];

    Future.delayed(Duration(seconds: 2)).then((value) => check.value = true);
  }

  LoadFormData(code) async {
    ApiClient apiClient = ApiClient();
    codeData.value = await apiClient.CodeData(code) ?? CodeDataModel();
  }
}
