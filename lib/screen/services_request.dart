import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/customCheckBox.dart';
import 'package:untitled/widgets/custom_edit_text.dart';

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


  @override
  void initState() {
    if((widget.newForm ?? false)){
    shopName.text="My Shop,in";
    yourName.text="sonu";
    email.text="sonu4567@gdnd.com";
    phoneNO.text="56873460934";
    VIN.text="nfkj876348jd";
    ro_po.text="fhfuius";
    other.text="ertyuiohgfd";
    anyOtherInformation.text="dfghjw higcbsc";
    verification.text="456788";   }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.servicesRequest),
        backgroundColor: AppColors.appColors,
      ),
      body: Container(
        child: ListView(
                            shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            CustomTextField(
                textEditingController: shopName, hint: AppText.shopName),
            CustomTextField(
                textEditingController: yourName, hint: AppText.yourName),
            CustomTextField(
                textEditingController: email, hint: AppText.email),
            CustomTextField(
                textEditingController: phoneNO, hint: AppText.phoneNO),
            CustomTextField(textEditingController: VIN, hint: AppText.VIN),
            CustomTextField(
                textEditingController: ro_po, hint: AppText.ro_po),
            CustomTextField(
                textEditingController: other, hint: AppText.other),
            CustomTextField(
                textEditingController: anyOtherInformation,
                hint: AppText.anyOtherInformation),
            CustomTextField(
                textEditingController: anyOtherInformation,
                hint: AppText.pleaseEnterAnyTwoDigits),
            Center(
              child: Text(
                AppText.servicesRequested,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            CustomCheckBox(text: AppText.Pre_Scan, value: false),
            CustomCheckBox(text: AppText.DiagnosticScan, value: false),
            CustomCheckBox(text: AppText.Post_Scan, value: false),
            CustomCheckBox(text: AppText.SRSModuleProgramming, value: false),
            CustomCheckBox(
                text: AppText.occupancySensorCalibration, value: false),
            CustomCheckBox(
                text: AppText.RadarLaserCruiseCalibration, value: false),
            CustomCheckBox(
                text: AppText.RadarLaserCruiseCalibrationSameModule,
                value: false),
            Center(
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.appColors),
                      fixedSize: MaterialStateProperty.all(Size(100, 40))),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: AppColors.white),
                  )),
            )
            , SizedBox(height: 10,)
          ],
        ),
      ),
    );


  }

}
