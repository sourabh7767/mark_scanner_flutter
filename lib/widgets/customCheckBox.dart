
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/model/ServicesListModel.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:untitled/widgets/custom_edit_text.dart';

import '../model/form_data_model.dart';
import '../model/service_form_result_model.dart' as dataModel;

class CustomCheckBox extends StatefulWidget {
  bool? value;
  Services? data;
  dataModel.Services? editData;

  CustomCheckBox({Key? key, required this.value, required this.data,this.editData})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  ServiceRequestController serviceRequestController =
      Get.put(ServiceRequestController());
  TextEditingController textEditingController = TextEditingController();
  int count = 1;

  @override
  void initState() {
    textEditingController.text = widget.data!.amount.toString();
    if (widget.value == true) {
     serviceRequestController.servicesListModel.value.services!.add(ServicesData(

       quantity: widget.editData!.quantity.toString() ?? "",
       amount: widget.editData!.amount.toString() ?? "",
       id: widget.editData!.serviceId.toString()
     ));
     textEditingController.text= widget.editData!.amount.toString();
     count=widget.editData!.quantity ?? 1;
     setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: Get.width * 0.7,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(widget.data!.description ?? "",style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),),),
              InkWell(
                onTap: () {


                },
                child: Checkbox(
                    value: widget.value!,
                    fillColor: MaterialStateProperty.all(AppColors.appColors),

                    onChanged: (v) {
                      widget.value = !widget.value!;
                      print("serviceRequestController "+widget.value!.toString());
                      if(!widget.value!){
                        for(int i=0;i<serviceRequestController.servicesListModel.value.services!.length;i++){
                          if(serviceRequestController.servicesListModel.value.services![i].id.toString()==widget.data!.id.toString())
                          {
                            print("serviceRequestController "+serviceRequestController.servicesListModel.value.services![i].toString());

                            serviceRequestController.servicesListModel.value.services!.removeAt(i);
                          }
                        }
                      }else{

                        serviceRequestController.servicesListModel.value.services?.add(ServicesData(
                            id: widget.data!.id!.toString(),
                            amount: textEditingController.text,
                            quantity: count.toString()
                        ));
                        print("serviceRequestController "+json.encode(serviceRequestController.servicesListModel.value.services!.map((v) => v.toJson()).toList()).toString());
                        print("serviceRequestController "+serviceRequestController.servicesListModel.value.toJson()["services"].toString());

                      } setState((){});
                    }),
              )
            ],
          ),
          // Container(
          //   color: AppColors.white,
          //   width: double.infinity,
          //   height: 1,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text("Cost",style: TextStyle(
                      fontSize: 12,fontWeight: FontWeight.w300
                    ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                    height: 30,
                    width: 100,
                    child: Theme(
                      data: ThemeData(
                          textSelectionHandleColor: Colors.transparent,
                        textSelectionTheme: TextSelectionThemeData(
                          selectionHandleColor: Colors.transparent
                        ),

                        ),
                      child: TextField(
                        controller: textEditingController, enableInteractiveSelection: true,

                        onChanged: (v){
                          for(int i=0;i<serviceRequestController.servicesListModel.value.services!.length;i++){
                            if(serviceRequestController.servicesListModel.value.services![i].id.toString()==widget.data!.id.toString())
                            {
                              serviceRequestController.servicesListModel.value.services![i].amount=textEditingController.text.toString();
                              print("serviceRequestController "+serviceRequestController.servicesListModel.value.services!.map((v) => v.toJson().toString()).toList().toString());
                            }
                          }
                         setState((){});
                        },
                        maxLength: 7,
autofocus: false,
                        cursorRadius: Radius.circular(20),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(border: UnderlineInputBorder(),

                        counterText: ""),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   color: AppColors.white,
              //   width: 1,
              //   height: 20,
              // ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text("Quantity",style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w300
                    ),),
                  ), Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(1),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (count > 0) {
                              count--;
                            }
                            for(int i=0;i<serviceRequestController.servicesListModel.value.services!.length;i++){
                              if(serviceRequestController.servicesListModel.value.services![i].id.toString()==widget.data!.id.toString())
                              {
                                serviceRequestController.servicesListModel.value.services![i].quantity=count.toString();
                              }
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            child: Icon(Icons.remove),
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(count.toString()),
                          height: 30,
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (count < 99) {
                              count++;
                            }for(int i=0;i<serviceRequestController.servicesListModel.value.services!.length;i++){
                              if(serviceRequestController.servicesListModel.value.services![i].id.toString()==widget.data!.id.toString())
                              {
                                serviceRequestController.servicesListModel.value.services![i].quantity=count.toString();
                              }
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            child: Icon(Icons.add),
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox()
            ],
          ),
          SizedBox(
            height: 13,
          )
        ],
      ),
    );
  }
}
