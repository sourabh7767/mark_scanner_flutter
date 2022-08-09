
import 'package:flutter/material.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:get/get.dart';

import '../model/form_data_model.dart';
class CustomCheckBox extends StatefulWidget {
  bool? value;
  Services? data;
  CustomCheckBox({Key? key,required this.value,required this.data}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  ServiceRequestController serviceRequestController=Get.put(ServiceRequestController());

  @override
  void initState() {
if(widget.value==true){
  serviceRequestController.servicesperformed.value.add(widget.data!.id);
  serviceRequestController.servicesperformedString.value=widget.data!.id.toString();

}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: Get.width*0.7,
              child: Text(widget.data!.name!)),
          InkWell(
            onTap: (){
         serviceRequestController.servicesperformed.value.add(widget.data!.id);
            },
            child: Checkbox(value: widget.value!,
                fillColor: MaterialStateProperty.all(AppColors.appColors),
                onChanged: (v){
                  widget.value=!widget.value!;

             if(!widget.value!){ for(int i=0; i<serviceRequestController.servicesperformed.value.length;i++){
                if(serviceRequestController.servicesperformed.value[i]==widget.data!.id)
                {
                                    serviceRequestController.servicesperformed.value.removeAt(i);
                }
              }}else{
               serviceRequestController.servicesperformed.value.add(widget.data!.id);
             }
             String listData="";
             for(int data in serviceRequestController.servicesperformed.value){
              if(listData==""){
                listData=data.toString();
                serviceRequestController.servicesperformedString.value=listData;
              }else{ listData=listData+","+data.toString();
              serviceRequestController.servicesperformedString.value=listData;
              }}
             print("servicesperformed = "+listData);
              setState((){});
            }),
          )
        ],
      ),
    );
  }
}
