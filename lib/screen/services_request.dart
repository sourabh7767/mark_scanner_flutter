import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/service_form_model.dart';
import 'package:untitled/screen/home_screen.dart';
import 'package:untitled/screen/image_view.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/customCheckBox.dart';
import 'package:untitled/widgets/custom_edit_text.dart';
import 'package:get/get.dart';
import 'package:untitled/widgets/custom_text.dart';
import 'package:untitled/widgets/loader.dart';
import 'package:dio/dio.dart' as dio;
import '../model/ServicesListModel.dart';
import '../model/code_data_model.dart';
import '../model/form_data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../model/service_form_result_model.dart';
import 'dart:math' as math;

import '../utils/api_path.dart';

class ServicesRequest extends StatefulWidget {
  String? id;
  String? code;

  ServicesRequest({Key? key, this.id, this.code}) : super(key: key);

  @override
  State<ServicesRequest> createState() => _ServicesRequestState();
}

class _ServicesRequestState extends State<ServicesRequest> {
  var shopName = TextEditingController().obs;
  var yourName = TextEditingController().obs;
  var email = TextEditingController().obs;
  var phoneNO = TextEditingController().obs;
  var modelYear = TextEditingController().obs;
  var model = TextEditingController().obs;
  var color = TextEditingController().obs;
  var Make = TextEditingController().obs;
  var VIN = TextEditingController().obs;
  var licNo = TextEditingController().obs;
  var ro_po = TextEditingController().obs;
  var address = TextEditingController().obs;
  var Mileage = TextEditingController().obs;
  var amount = TextEditingController().obs;
  RxBool save=false.obs;
  RxList<String> years = <String>[].obs;
  RxString selectYear="".obs;
  RxList<XFile>? images = <XFile>[].obs;
  RxList<XFile>? cImages = <XFile>[].obs;
  RxList<String>? oldImages = <String>[].obs;
  List<bool> checkList=[];
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


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if ((widget.code ?? "") != "") {
        await serviceRequestController.LoadFormData(widget.code);
        Make.value.text = getdata("Make")!.value ?? "";
        modelYear.value.text = getdata("Model Year")!.value ?? "";
        model.value.text = getdata("Model")!.value ?? "";
        VIN.value.text = widget.code ?? "";
      }
      await serviceRequestController.LoadData();
      if ((widget.id ?? "") != "") {
        ApiClient apiClient = ApiClient();
        serviceRequestController.invoice.value = (await apiClient.invoice(widget.id!))!;
        print("data-=" + serviceRequestController.invoice.value.data!.toJson().toString());
        serviceRequestController.formDataModel.value.data!.shopDetails!
            .forEach((element) {
          print("data ---------" +
              element.id.toString() +
              "/" +
              serviceRequestController.invoice.value.data!.shopId.toString());
          if (element.id.toString() == serviceRequestController.invoice.value.data!.shopId.toString()) {
            serviceRequestController.shopDetails.value = element;
            email.value.text = serviceRequestController.shopDetails.value.email!;
            phoneNO.value.text = serviceRequestController.shopDetails.value.number!;
          }
          selectYear.value = serviceRequestController.invoice.value.data!.vYear!;
        });
  serviceRequestController.invoice.value.data!.images!.forEach((element) {
    oldImages!.add(element!.image!);
  });

        print("Data=" + serviceRequestController.invoice.value.data!.toJson().toString());
        yourName.value.text = serviceRequestController.invoice.value.data!.cName ?? "";
        modelYear.value.text = serviceRequestController.invoice.value.data!.vYear ?? "";
        model.value.text = serviceRequestController.invoice.value.data!.vModal ?? "";
        color.value.text = serviceRequestController.invoice.value.data!.vColor ?? "";
        address.value.text = serviceRequestController.invoice.value.data!.cAddress ?? "";
        Make.value.text = serviceRequestController.invoice.value.data!.vMake ?? "";
        VIN.value.text = serviceRequestController.invoice.value.data!.vVin ?? "";
        licNo.value.text = serviceRequestController.invoice.value.data!.vLicno ?? "";
        ro_po.value.text = serviceRequestController.invoice.value.data!.roNum ?? "";
        // Engine.value.text = serviceRequestController.invoice.value.data!.vEngine ?? "";
        Mileage.value.text = serviceRequestController.invoice.value.data!.vMilege ?? "";
    
      }
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy');
      String formatted = formatter.format(now);
      // years.add("Select Year");

      int count = 0;
      for(int i=0;i<serviceRequestController
          .formDataModel.value.data!.services!.length;i++){
        checkList.add(check(i) ?? false);
      }
      for (int i = 1950; i <= int.parse(formatted); i++) {
        years.add(i.toString());
        count++;
        if ((widget.id ?? "") != "") {
          if (serviceRequestController.invoice.value.data!.vYear == i.toString()) {
            selectYear..value = i.toString();
          }
        }
        if ((widget.code ?? "") != "") {
          if (i.toString() == (getdata("Model Year")!.value ?? "").toString()) {
            selectYear.value = i.toString();
          }
        }
      }
      if ((selectYear.value ?? "") == "") {
        selectYear.value = years[years.length - 1];
      }

    });


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
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    for (String xfile in oldImages!)
                    InkWell(
                      onTap: () {
                        Get.to(ImageView(url: ApiPath.ImageBasePath+xfile!,));
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.black12),
                        child: CachedNetworkImage(
                          imageUrl: ApiPath.ImageBasePath+xfile!,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    for (XFile xfile in images!)
                      InkWell(
                        onTap: () {
                          Get.to(ImageView(XFile: File(xfile.path)));
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.black12),
                          child: Image.file(
                            File(xfile.path),
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () async {
                        imagePicker();
                        //    final ImagePicker _picker = ImagePicker();
                        //
                        // List<XFile>? imagecopy = await _picker.pickMultiImage();
                        //  imagecopy?.forEach((element) {
                        //    images!.add(element);
                        //  });
                       
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.black26),
                        child: Icon(Icons.add),
                      ),
                    )
                  ],
                ),
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
                      email.value.text =
                          serviceRequestController.shopDetails.value.email!;
                      phoneNO.value.text =
                          serviceRequestController.shopDetails.value.number!;
                      address.value.text =
                          serviceRequestController.shopDetails.value.address!;
                    },
                  ),
                ),
              ),
              CustomTextField(
                  textEditingController: yourName.value , hint: AppText.writersName),
              CustomTextField(
                  textEditingController: email.value , hint: AppText.email),
              CustomTextField(
                  textEditingController: phoneNO.value,
                  hint: AppText.phoneNO,
                  textType: TextInputType.number),
              CustomTextField(
                textEditingController: address.value,
                hint: "Address",
              ),
              CustomTextField(
                textEditingController: VIN.value,
                hint: AppText.VIN,
                Capital: true,
                suffixIcon: InkWell(
                  onTap: () async {
                    ProgressDialog.show(context);
                    widget.code = VIN.value.text;
                    if ((widget.code ?? "") != "") {
                      await serviceRequestController.LoadFormData(widget.code);
                      Make.value.text = getdata("Make")!.value ?? "";
                      modelYear.value.text = getdata("Model Year")!.value ?? "";
                      if ((getdata("Model Year")!.value ?? "") != "") {
                        selectYear.value = getdata("Model Year")!.value ?? "";
                      } else {
                        Fluttertoast.showToast(msg: "VIN No is Wrong");
                      }
                      model.value.text = getdata("Model")!.value ?? "";
                      // Engine.value.text =
                      //     getdata("Engine Number of Cylinders")!.value ?? "";
                      VIN.value.text = widget.code ?? "";
                    }
                    ProgressDialog.hide();
                  },
                  child: Transform.rotate(
                    angle: 270 * math.pi / 180,
                    child: Icon(
                      Icons.get_app_outlined,
                      color: AppColors.appColors,
                    ),
                  ),
                ),
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
                    items: years.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Container(
                              width: Get.width * 0.7,
                              height: 20,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(e)));
                    }).toList(),
                    value: selectYear.value,
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? v1) {
                      selectYear.value = v1!;
                    },
                  ),
                ),
              ),
              CustomTextField(textEditingController: Make.value , hint: "Make"),
              CustomTextField(textEditingController: model.value , hint: "Model"),
              CustomTextField(textEditingController: color.value , hint: "Color"),
              // CustomTextField(textEditingController: Engine.value , hint: "Engine"),
              CustomTextField(textEditingController: licNo.value , hint: "Lic No"),
              CustomTextField(textEditingController: Mileage.value , hint: "Mileage"),
              CustomTextField(
                  textEditingController: ro_po.value , hint: AppText.ro_po),
              // CustomTextField(
              //     textEditingController: amount.value , hint: AppText.amount),
              // CustomTextField(
              //     textEditingController: other.value , hint: AppText.other),
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
                        value: checkList[index],
                        editData: gatdata(index));
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
                          send("2");
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
                            send("1");
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

  gatdata(index) {
    if ((serviceRequestController.invoice.value.data ?? "") != "") {
      var value;
      serviceRequestController.invoice.value.data!.services!.forEach((element) {
        if (element.serviceId.toString() ==
            serviceRequestController
                .formDataModel.value.data!.services![index].id
                .toString()) {
          value = element;
        }
      });
      return value;
    }
    return null;
  }

  bool? check(index) {
    if ((serviceRequestController.invoice.value.data ?? "") != "") {
      bool? value;
      serviceRequestController.invoice.value.data!.services!.forEach((element) {
        print("check --" +
            element.serviceId.toString() +
            "  -  " +
            serviceRequestController
                .formDataModel.value.data!.services![index].id
                .toString());
        if (element.serviceId.toString() ==
            serviceRequestController
                .formDataModel.value.data!.services![index].id
                .toString()) {
          for (int i = 0;
          i < serviceRequestController.servicesListModel.value.services!.length;
          i++) {
            if (serviceRequestController.servicesListModel.value.services![i].id
                .toString() ==
               element.id.toString()) {

            }
          }
          serviceRequestController.servicesListModel.value.services!.add(
              ServicesData(
                  quantity: element.quantity.toString() ?? "",
                  amount: element.amount.toString() ?? "",
                  id: element.serviceId.toString())

          );
        }
      });
      return value ?? false;
    }
    return false;
  }

  send(status) async {
    if (serviceRequestController.shopDetails.value.id == "") {
      Fluttertoast.showToast(msg: "Select shopName");
    } else if (email.value.text == "") {
      Fluttertoast.showToast(msg: "Enter email ");
    } else if (phoneNO.value.text == "") {
      Fluttertoast.showToast(msg: "Enter phoneNO ");
    } else if (model.value.text == "") {
      Fluttertoast.showToast(msg: "Enter model ");
    } else if (color.value.text == "") {
      Fluttertoast.showToast(msg: "Enter color ");
    } else if (Make.value.text == "") {
      Fluttertoast.showToast(msg: "Enter Make ");
    } else if (VIN.value.text == "") {
      Fluttertoast.showToast(msg: "Enter VIN ");
    } else if (licNo.value.text == "") {
      Fluttertoast.showToast(msg: "Enter licNo ");
    } else if (ro_po.value.text == "") {
      Fluttertoast.showToast(msg: "Enter ro_po ");
    } else if (Mileage.value.text == "") {
      Fluttertoast.showToast(msg: "Enter Mileage");
    } else if (yourName.value.text == "") {
      Fluttertoast.showToast(msg: "Enter yourName");
    } else if (selectYear.value!.length > 4) {
      Fluttertoast.showToast(msg: "Enter yourName");
    } else {
      ProgressDialog.show(context);
      List<dio.MultipartFile>? mul=[];
      for(XFile file in images! ){
        print("file name"+ file.name);
        dio.MultipartFile   multipartFile=await dio.MultipartFile.fromFile(file.path,filename: "images.jpg");
      mul!.add(multipartFile);
      }
      ServiceFormModel serviceFormModel = ServiceFormModel(
          id: widget.id ?? "",
          cName: yourName.value.text,
          cAddress: address.value.text,
          cEmail: email.value.text,
          cPhone: phoneNO.value.text,
          services: json
              .encode(serviceRequestController.servicesListModel.value.services!
                  .map((v) => v.toJson())
                  .toList())
              .toString(),
          Ro_num: ro_po.value.text,
          v_modal: model.value.text,
          shopId: serviceRequestController.shopDetails.value.id.toString(),
          status: status,
          vColor: color.value.text,
          vEngine: "abc",
          vLicno: licNo.value.text,
          vMake: Make.value.text,
          vMilege: Mileage.value.text,
          vVin: VIN.value.text,
          images: mul!,
          vYear: selectYear.value);
      ApiClient apiClient = ApiClient();
      apiClient.saveForm(serviceFormModel).then((value) {
        ProgressDialog.hide();
        Get.off(HomeScreen());
        Future.delayed(Duration(milliseconds: 1100))
            .then((value) => Fluttertoast.showToast(msg: "Success"));
      });
    }
  }

  imagePicker() {
    Get.bottomSheet(Container(
      height: Get.height * 0.3,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              Get.back();
              final ImagePicker _picker = ImagePicker();

              XFile? imagecopy = await _picker.pickImage(source: ImageSource.camera,imageQuality: 25);

                images!.add(imagecopy!);

            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width,
              child: Text(
                "Camera",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black26,
          ),
          InkWell(
              onTap: () async {
                Get.back();
                   final ImagePicker _picker = ImagePicker();

                List<XFile>? imagecopy = await _picker.pickMultiImage();
                 imagecopy?.forEach((element) {
                   images!.add(element);
                 });
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.black),
                  ))),
          Container(
            width: Get.width,
            height: 1,
            color: Colors.black26,
          ),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ))
        ],
      ),
    ));
  }
}
