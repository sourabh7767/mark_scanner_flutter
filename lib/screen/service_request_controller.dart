import 'package:untitled/api/dio.dart';
import 'package:untitled/model/code_data_model.dart';
import 'package:untitled/model/form_data_model.dart';
import 'package:get/get.dart';

class ServiceRequestController {
  Rx<FormDataModel> formDataModel = FormDataModel().obs;
  var check = false.obs;
  Rx<ShopDetails> shopDetails = ShopDetails().obs;
  Rx<CodeDataModel> codeData = CodeDataModel().obs;
  var servicesperformed = [].obs;
  var servicesperformedString = "".obs;

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
