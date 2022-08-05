import 'package:flutter/material.dart';
import 'package:untitled/screen/service_request_controller.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/customCheckBox.dart';
import 'package:untitled/widgets/custom_edit_text.dart';
import 'package:get/get.dart';

import '../model/code_data_model.dart';
import '../model/form_data_model.dart';
class ServicesRequest extends StatefulWidget {
  bool? newForm;
  String? code;
   ServicesRequest({Key? key, this.newForm,this.code}) : super(key: key);

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
  TextEditingController other = TextEditingController();
  TextEditingController anyOtherInformation = TextEditingController();
  TextEditingController verification = TextEditingController();
 bool? save;
 ServiceRequestController serviceRequestController=Get.put(ServiceRequestController());

 Results? getdata(variable){
  for(Results data in serviceRequestController.codeData.value.results!){

    if(data.variable==variable){
      print("Match===");
      return data;
    }

  }
  return null;


 }



  @override
  void initState() {
WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
if((widget.code ?? "")!="") {
  await serviceRequestController.LoadFormData(widget.code);
  Make.text = getdata("Make")!.value ?? "";
  modelYear.text = getdata("Model Year")!.value ?? "";
  model.text = getdata("Model")!.value ?? "";
  VIN.text = serviceRequestController.codeData.value.searchCriteria!;
} await serviceRequestController.LoadData();
 email.text=serviceRequestController.shopDetails.value.email!;

});

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
                SizedBox(height: 40,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.appColors,
                        width: 1
                      )
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25,vertical: 1),
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: DropdownButton(
                      items:  serviceRequestController.formDataModel.value.data!.shopDetails?.map<
                          DropdownMenuItem<ShopDetails>>((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: Container(
                                width: Get.width * 0.7,
                                height: 20,
                                margin: EdgeInsets.symmetric(horizontal: 5),
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
                    textEditingController: model, hint: "Model"), CustomTextField(
                    textEditingController: modelYear, hint: "Model Year"),
                CustomTextField(
                    textEditingController: Make, hint: "Make"),
                CustomTextField(
                    textEditingController: color, hint: "Color"),
                CustomTextField(
                    textEditingController: licNo, hint: "Lic No"),
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
                    AppText.servicesperformed,
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
