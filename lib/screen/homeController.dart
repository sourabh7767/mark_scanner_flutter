import 'package:get/get.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/invoice_list_model.dart';
class HomeController extends GetxController{

  Rx<InvoiceListModel> invoiceListModel=InvoiceListModel().obs;

  Future<void> GetData() async {
   ApiClient apiClient=ApiClient();
 invoiceListModel.value= (await apiClient.invoiceList())!;


 }




}