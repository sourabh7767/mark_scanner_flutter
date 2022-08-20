import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/service_form_model.dart';
import 'package:untitled/screen/home_screen.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/customCheckBox.dart';
import 'package:untitled/widgets/custom_edit_text.dart';
import 'package:get/get.dart';
import 'package:untitled/widgets/loader.dart';

import '../model/code_data_model.dart';
import '../model/form_data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../model/invoice_list_model.dart';
import '../model/service_form_result_model.dart';

class ServicesRequest extends StatefulWidget {
  String? id;
  String? code;

  ServicesRequest({Key? key, this.id, this.code}) : super(key: key);

  @override
  State<ServicesRequest> createState() => _ServicesRequestState();
}

class _ServicesRequestState extends State<ServicesRequest> {
  TextEditingController shopName = TextEditingController();
  TextEditingController yourName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNO = TextEditingController();
  TextEditingController modelYear = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController Make = TextEditingController();
  TextEditingController VIN = TextEditingController();
  TextEditingController licNo = TextEditingController();
  TextEditingController ro_po = TextEditingController();
  TextEditingController Engine = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController Mileage = TextEditingController();
  TextEditingController amount = TextEditingController();
  bool? save;
  List<String> years=[];
  String? selectYear;
  ServiceRequestController serviceRequestController =
      Get.put(ServiceRequestController());

  Results? getdata(variable) {
    for (Results data in serviceRequestController.codeData.value.results!) {
      if (data.variable == variable) {
        print("Match===");
        return data;
      }
    }
    return null;
  }
  ServiceFormResultModel? invoice;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      if ((widget.code ?? "") != "") {
        await serviceRequestController.LoadFormData(widget.code);
        Make.text = getdata("Make")!.value ?? "";
        modelYear.text = getdata("Model Year")!.value ?? "";
        model.text = getdata("Model")!.value ?? "";
        Engine.text = getdata("Engine Number of Cylinders")!.value ?? "";
        VIN.text = widget.code ?? "";
      }
      await serviceRequestController.LoadData();
      if ((widget.id ?? "") != "") {
        ApiClient apiClient = ApiClient();
         invoice = await apiClient.invoice(widget.id!);
         print("data-="+invoice!.data!.toJson().toString());
        serviceRequestController.formDataModel.value.data!.shopDetails!
            .forEach((element) {
          print("data ---------" +
              element.id.toString() +
              "/" +
              invoice!.data!.shopId.toString());
          if (element.id.toString() == invoice!.data!.shopId.toString()) {
            serviceRequestController.shopDetails.value = element;
            email.text = serviceRequestController.shopDetails.value.email!;
            phoneNO.text = serviceRequestController.shopDetails.value.number!;

          }
          selectYear=invoice!.data!.vYear;


        });

        print("Data=" + invoice!.data!.toJson().toString());
        yourName.text = invoice!.data!.cName ?? "";
        modelYear.text = invoice!.data!.vYear ?? "";
        model.text = invoice!.data!.vModal ?? "";
        color.text = invoice!.data!.vColor ?? "";
        address.text = invoice!.data!.cAddress ?? "";
        Make.text = invoice!.data!.vMake ?? "";
        VIN.text = invoice!.data!.vVin ?? "";
        licNo.text = invoice!.data!.vLicno ?? "";
        ro_po.text = invoice!.data!.roNum ?? "";
        Engine.text = invoice!.data!.vEngine ?? "";
        Mileage.text = invoice!.data!.vMilege ?? "";
        setState(() {});


      }
      DateTime now = DateTime. now();
      DateFormat formatter = DateFormat('yyyy');
      String formatted = formatter. format(now);
      // years.add("Select Year");

int count=0;
      for(int i=1950;i<=int.parse(formatted);i++){

        years.add(i.toString());
        count++;
        if ((widget.id ?? "") != "") {


          if(invoice!.data!.vYear==i.toString()){
        selectYear=i.toString();
          }
        }
        if ((widget.code ?? "") != "") {
          if(i.toString()==(getdata("Model Year")!.value ?? "").toString()){
            selectYear=i.toString();
          }

        }
      }
      if((selectYear ?? "") =="") {
        selectYear = years[years.length - 1];
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!serviceRequestController.check.value) {
        return Material(
          color: AppColors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(AppText.servicesPerformed),
          backgroundColor: AppColors.appColors,
        ),
        body: Container(
          child: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.appColors, width: 1)),
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButton(
                    items: serviceRequestController
                        .formDataModel.value.data!.shopDetails
                        ?.map<DropdownMenuItem<ShopDetails>>((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Container(
                              width: Get.width * 0.7,
                              height: 20,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(e.name!)));
                    }).toList(),
                    value: serviceRequestController.shopDetails.value.obs(),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (ShopDetails? v1) {
                      print("Change" + v1!.toJson().toString());

                      serviceRequestController.shopDetails.value = v1;
                      print("Change" +
                          serviceRequestController.shopDetails.value
                              .toJson()
                              .toString());
                      email.text =
                          serviceRequestController.shopDetails.value.email!;
                      phoneNO.text =
                          serviceRequestController.shopDetails.value.number!;address.text =
                          serviceRequestController.shopDetails.value.address!;
                    },
                  ),
                ),
              ),
              CustomTextField(
                  textEditingController: yourName, hint: AppText.writersName),
              CustomTextField(
                  textEditingController: email, hint: AppText.email),
              CustomTextField(
                  textEditingController: phoneNO,
                  hint: AppText.phoneNO,
                  textType: TextInputType.number),
              CustomTextField(
                textEditingController: address,
                hint: "Address",
              ),
              CustomTextField(
                textEditingController: VIN,
                hint: AppText.VIN,
                Capital: true,
              ),
              CustomTextField(textEditingController: model, hint: "Model"),
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.appColors, width: 1)),
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: DropdownButton(
                    items: years.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Container(
                              width: Get.width * 0.7,
                              height: 20,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(e)));
                    }).toList(),
                    value: selectYear,
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? v1) {
                      selectYear=v1!;
                      setState((){});
                    },
                  ),
                ),
              ),
              CustomTextField(textEditingController: Make, hint: "Make"),
              CustomTextField(textEditingController: color, hint: "Color"),
              CustomTextField(textEditingController: licNo, hint: "Lic No"),
              CustomTextField(textEditingController: Engine, hint: "Engine"),
              CustomTextField(textEditingController: Mileage, hint: "Mileage"),
              CustomTextField(
                  textEditingController: ro_po, hint: AppText.ro_po),
              CustomTextField(
                  textEditingController: amount, hint: AppText.amount),
              // CustomTextField(
              //     textEditingController: other, hint: AppText.other),
              // CustomTextField(
              //     textEditingController: anyOtherInformation,
              //     hint: AppText.anyOtherInformation),
              // CustomTextField(
              //     textEditingController: anyOtherInformation,
              //     hint: AppText.pleaseEnterAnyTwoDigits),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    AppText.servicesperformed,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: serviceRequestController
                      .formDataModel.value.data!.services!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CustomCheckBox(
                        data: serviceRequestController
                            .formDataModel.value.data!.services![index],
                        value:check(index),
                        editData:gatdata(index)



                    );
                  }),

              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          send("1");
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.appColors),
                            fixedSize:
                                MaterialStateProperty.all(Size(100, 40))),
                        child: Text(
                          "Save",
                          style: TextStyle(color: AppColors.white),
                        )),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            send("2");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.appColors),
                              fixedSize:
                                  MaterialStateProperty.all(Size(100, 40))),
                          child: Text(
                            "Send",
                            style: TextStyle(color: AppColors.white),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    });
  }

   gatdata(index){
    if((invoice?? "")!="") {

      var value;
      invoice!.data!.services!.forEach((element) {
        if (element.id.toString() == serviceRequestController
            .formDataModel.value.data!.services![index].id.toString()) {
          value=element;
        }
      });
      return value;
    }
    return null;
  }
bool? check(index){
    if((invoice?? "")!="") {

      bool? value;
     invoice!.data!.services!.forEach((element) {
       print("check --"+element.id.toString()+"  -  "+serviceRequestController
           .formDataModel.value.data!.services![index].id.toString());
        if (element.id.toString() == serviceRequestController
            .formDataModel.value.data!.services![index].id.toString()) {
          value = true;
        }
      });
      return value ?? false;
    }
    return false;
}
  send(status) {

    if (serviceRequestController.shopDetails.value.id == "") {
      Fluttertoast.showToast(msg: "Select shopName");
    } else if (email.text == "") {
      Fluttertoast.showToast(msg: "Enter email ");
    } else if (phoneNO.text == "") {
      Fluttertoast.showToast(msg: "Enter phoneNO ");
    } else if (model.text == "") {
      Fluttertoast.showToast(msg: "Enter model ");
    } else if (color.text == "") {
      Fluttertoast.showToast(msg: "Enter color ");
    } else if (Make.text == "") {
      Fluttertoast.showToast(msg: "Enter Make ");
    } else if (VIN.text == "") {
      Fluttertoast.showToast(msg: "Enter VIN ");
    } else if (licNo.text == "") {
      Fluttertoast.showToast(msg: "Enter licNo ");
    } else if (ro_po.text == "") {
      Fluttertoast.showToast(msg: "Enter ro_po ");
    } else if (Engine.text == "") {
      Fluttertoast.showToast(msg: "Enter Engine ");
    } else if (Mileage.text == "") {
      Fluttertoast.showToast(msg: "Enter Mileage");
    } else if (yourName.text == "") {
      Fluttertoast.showToast(msg: "Enter yourName");
    } else if (selectYear!.length > 4) {
      Fluttertoast.showToast(msg: "Enter yourName");
    } else {    ProgressDialog.show(context);
    ServiceFormModel serviceFormModel = ServiceFormModel(
      id: widget.id ?? "",
          cName: yourName.text,
          cAddress: address.text,
          cEmail: email.text,
          cPhone: phoneNO.text,
          services:json.encode(serviceRequestController.servicesListModel.value.services!.map((v) => v.toJson()).toList()).toString(),
          Ro_num: ro_po.text,
          v_modal: model.text,
          shopId: serviceRequestController.shopDetails.value.id.toString(),
          status: status,
          vColor: color.text,
          vEngine: Engine.text,
          vLicno: licNo.text,
          vMake: Make.text,
          vMilege: Mileage.text,
          vVin: VIN.text,

          vYear: selectYear);
      ApiClient apiClient = ApiClient();
      apiClient.saveForm(serviceFormModel).then((value) {
        ProgressDialog.hide();
        Get.off(HomeScreen());
        Future.delayed(Duration(milliseconds: 1100)).then((value) =>      Fluttertoast.showToast(msg: "Success"));
      });
    }
  }
}
