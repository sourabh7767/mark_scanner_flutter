import 'package:flutter/material.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/invoice_list_model.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/custom_text.dart';

import '../model/form_data_model.dart';
import '../model/service_form_result_model.dart';
class ServiceDetailScreen extends StatefulWidget {
  String? id;
   ServiceDetailScreen({Key? key,this.id}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {

  ApiClient apiClient=ApiClient();
 List<String> servicesData=[];
  FormDataModel? formDataModel;
  String? services;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    formDataModel=await  apiClient.shopDetail();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appColors,
          title: Text(AppText.servicesPerformedDetails),
        ),
        body: FutureBuilder(

          future: apiClient.invoice(widget.id!),
          builder: (context, AsyncSnapshot<ServiceFormResultModel?> snapshot) {

            if(snapshot.connectionState==ConnectionState.done){
             services= snapshot.data!.data!.services ?? "";
             services!.split(',').forEach((element) {
               textGet(element.toString());
             });

            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
CustomText(title: "Shop Name: ",text: snapshot.data!.data!.shopName ?? "",),
CustomText(title: "Writer's Name: ",text: snapshot.data!.data!.cName ?? "",),
CustomText(title: "Email: ",text: snapshot.data!.data!.shopEmail ?? "",),
CustomText(title: "Phone No : ",text: snapshot.data!.data!.shopNumber ?? "",),
CustomText(title: "Engine : ",text: snapshot.data!.data!.vEngine ?? "'",),
CustomText(title: "Milege : ",text: snapshot.data!.data!.vMilege ?? "",),
CustomText(title: "VIN : ",text: snapshot.data!.data!.vVin ?? "",),
CustomText(title: "Model: ",text: snapshot.data!.data!.v_modal?? "",),
CustomText(title: "Model Year: ",text: snapshot.data!.data!.vYear ?? "",),
CustomText(title: "Make: ",text: snapshot.data!.data!.vMake ?? ""),
CustomText(title: "Color: ",text: snapshot.data!.data!.vColor ?? "",),
CustomText(title: "Ro/PO#: ",text: snapshot.data!.data!.Ro_num ?? "",),
                  Center(
                    child: Text(AppText.servicesperformed,style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.appColors,
                    fontSize: 30
                    ),),
                  ),
                  SizedBox(height: 8,),
                  ListView.builder(
                      itemCount: servicesData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text((index+1).toString()+"."+(servicesData.elementAt(index) ?? ""),style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                            ),));
                      }),
                ],
              ),
            );}
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),

    );
  }
  void textGet(String data){
    String? dataCopy;
    formDataModel!.data!.services!.forEach((element) {
      if(element.id.toString()==data.toString()){
        servicesData.add(element.name ?? "");
      }
    });

  }
}
