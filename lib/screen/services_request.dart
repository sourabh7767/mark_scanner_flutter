import 'package:flutter/material.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/customCheckBox.dart';
import 'package:untitled/widgets/custom_edit_text.dart';
import 'package:get/get.dart';

import '../model/form_data_model.dart';
class ServicesRequest extends StatefulWidget {
  bool? newForm;
   ServicesRequest({Key? key, this.newForm}) : super(key: key);

  @override
  State<ServicesRequest> createState() => _ServicesRequestState();
}

class _ServicesRequestState extends State<ServicesRequest> {
  TextEditingController shopName = TextEditingController();
  TextEditingController yourName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNO = TextEditingController();
  TextEditingController VIN = TextEditingController();
  TextEditingController ro_po = TextEditingController();
  TextEditingController other = TextEditingController();
  TextEditingController anyOtherInformation = TextEditingController();
  TextEditingController verification = TextEditingController();
 bool? save;
 ServiceRequestController serviceRequestController=Get.put(ServiceRequestController());

  @override
  void initState() {

serviceRequestController.LoadData();
    if((widget.newForm ?? false)){
    shopName.text="My Shop,in";
    yourName.text="sonu";
    email.text="sonu4567@gdnd.com";
    phoneNO.text="56873460934";
    VIN.text="DFGJKDFH";
    ro_po.text="fhfuius";
    other.text="ertyuiohgfd";
    anyOtherInformation.text="dfghjw higcbsc";
    verification.text="456788";   }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
         if(!serviceRequestController.check.value)
         {
           return Center(
             child: CircularProgressIndicator(),
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
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.appColors,
                        width: 1
                      )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                    child: DropdownButton(
                      items:  serviceRequestController.formDataModel.value.data!.shopDetails?.map<
                          DropdownMenuItem<ShopDetails>>((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: SizedBox(
                                width: Get.width * 0.75,
                                child: Text(e.name!)));
                      }).toList()
                          ,
                       value:serviceRequestController.shopDetails.value.obs(),
                      borderRadius: BorderRadius.circular(10),

                      onChanged: (ShopDetails? v1) {
                        print("Change" + v1!.toJson().toString());

                        serviceRequestController.shopDetails.value=v1;
                        print("Change" +  serviceRequestController.shopDetails.value.toJson().toString());
                        email.text=serviceRequestController.shopDetails.value.email!;
                      },
                    ),
                  ),
                ),
                CustomTextField(
                    textEditingController: yourName, hint: AppText.writersName),
                CustomTextField(
                    textEditingController: email, hint: AppText.email),
                CustomTextField(
                    textEditingController: phoneNO, hint: AppText.phoneNO,textType: TextInputType.number),
                CustomTextField(textEditingController: VIN, hint: AppText.VIN,Capital: true,),
                CustomTextField(
                    textEditingController: ro_po, hint: AppText.ro_po),
                // CustomTextField(
                //     textEditingController: other, hint: AppText.other),
                // CustomTextField(
                //     textEditingController: anyOtherInformation,
                //     hint: AppText.anyOtherInformation),
                // CustomTextField(
                //     textEditingController: anyOtherInformation,
                //     hint: AppText.pleaseEnterAnyTwoDigits),
                Center(
                  child: Text(
                    AppText.servicesRequested,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
               ListView.builder(
                   itemCount: serviceRequestController.formDataModel.value.data!.services!.length,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                 return CustomCheckBox(text:serviceRequestController.formDataModel.value.data!.services![index].name, value: false);

               }),

                SizedBox(height: 10,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      TextButton(
                          onPressed: () {
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(AppColors.appColors),
                              fixedSize: MaterialStateProperty.all(Size(100, 40))),
                          child: Text(
                            "Save" ,
                            style: TextStyle(color: AppColors.white),
                          )),
                      Center(
                        child: TextButton(
                            onPressed: () {
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(AppColors.appColors),
                                fixedSize: MaterialStateProperty.all(Size(100, 40))),
                            child: Text(
                              "Send" ,
                              style: TextStyle(color: AppColors.white),
                            )),
                      )                    ],
                  ),
                )
                , SizedBox(height: 10,)
              ],
            ),
          ),
        );
      }
    );


  }

}
