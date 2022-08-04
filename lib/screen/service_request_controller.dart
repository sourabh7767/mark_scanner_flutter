import 'package:untitled/api/dio.dart';
import 'package:untitled/model/form_data_model.dart';
import 'package:get/get.dart';
class ServiceRequestController{
Rx<FormDataModel> formDataModel=FormDataModel().obs;
var check=false.obs;
Rx<ShopDetails> shopDetails=ShopDetails().obs;
  LoadData()  async {
    ApiClient apiClient=ApiClient();
    formDataModel.value=await  apiClient.shopDetail() ?? FormDataModel();
    shopDetails.value=formDataModel.value.data!.shopDetails![0];
    check.value=true;
  }





}