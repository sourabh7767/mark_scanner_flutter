import 'package:flutter/material.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/invoice_list_model.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_images.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/widgets/custom_text.dart';

import '../model/form_data_model.dart';
import '../model/service_form_result_model.dart';

class ServiceDetailScreen extends StatefulWidget {
  String? id;

  ServiceDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ApiClient apiClient = ApiClient();
  List<String> servicesData = [];
  FormDataModel? formDataModel;
  String? services;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      formDataModel = await apiClient.shopDetail();
      setState(() {});
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
            builder:
                (context, AsyncSnapshot<ServiceFormResultModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  (formDataModel ?? "") != "") {


                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              AppImages.AppLogo,
                              height: 100,
                            ),
                            Column(
                              children: [
                                CustomText(
                                  title: "Email: ",
                                  text: snapshot.data!.data!.shopEmail ?? "",
                                ),
                                CustomText(
                                  title: "Phone No : ",
                                  text: snapshot.data!.data!.shopNumber ?? "",
                                ),
                              ],
                            )
                          ],
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 3),
                          children: [
                            CustomText(
                              title: "Shop Name: ",
                              text: snapshot.data!.data!.shopName ?? "",
                            ),
                            CustomText(
                              title: "Writer's Name: ",
                              text: snapshot.data!.data!.cName ?? "",
                            ),
                            CustomText(
                              title: "Email: ",
                              text: snapshot.data!.data!.shopEmail ?? "",
                            ),
                            CustomText(
                              title: "Phone No : ",
                              text: snapshot.data!.data!.shopNumber ?? "",
                            ),
                            CustomText(
                              title: "Engine : ",
                              text: snapshot.data!.data!.vEngine ?? "'",
                            ),
                            CustomText(
                              title: "Milege : ",
                              text: snapshot.data!.data!.vMilege ?? "",
                            ),
                            CustomText(
                              title: "VIN : ",
                              text: snapshot.data!.data!.vVin ?? "",
                            ),
                            CustomText(
                              title: "Model: ",
                              text: snapshot.data!.data!.vModal ?? "",
                            ),
                            CustomText(
                              title: "Model Year: ",
                              text: snapshot.data!.data!.vYear ?? "",
                            ),
                            CustomText(
                                title: "Make: ",
                                text: snapshot.data!.data!.vMake ?? ""),
                            CustomText(
                              title: "Color: ",
                              text: snapshot.data!.data!.vColor ?? "",
                            ),
                            CustomText(
                              title: "Ro/PO#: ",
                              text: snapshot.data!.data!.roNum ?? "",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            AppText.servicesperformed,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppColors.appColors,
                                fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                            itemCount: servicesData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    (index + 1).toString() +
                                        "." +
                                        (servicesData.elementAt(index) ?? ""),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ));
                            }),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: AppColors.appColors,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(

                            TextSpan(
                     children: [
                                TextSpan(
                                  text: 'SERVICE COMMENTS:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                TextSpan(text: ' MOBILE SERVICE REQUESTED BY (PERSON REQUESTING SERVICE)',),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Text(
                                "TECHNICIAN: ",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                              ), Text(
                                "JEFF GRAY",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: AppColors.appColors,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(

                                  bottom: BorderSide(
                                      color: Colors.black54,
                                      width: 0.1
                                  )
                              )
                          ),
                          padding: EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Code",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.042,fontWeight: FontWeight.w700),
                                ),
                              ),  Expanded(
                                flex: 2,
                                child: Text(
                                  "Description",
                                  style: TextStyle(fontSize:  MediaQuery.of(context).size.width*0.042,fontWeight: FontWeight.w700),
                                ),
                              ),Expanded(
                                flex: 1,
                                child: Text(
                                  "Labor",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(fontSize:  MediaQuery.of(context).size.width*0.042,fontWeight: FontWeight.w700),
                                ),
                              ),Expanded(
                                flex: 1,
                                child: Text(
                                  "QTY.",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(fontSize:  MediaQuery.of(context).size.width*0.042,fontWeight: FontWeight.w700),
                                ),
                              ),Expanded(
                                flex: 1,
                                child: Text(
                                  "Total",
                                  textAlign: TextAlign.center,

                                  style: TextStyle(fontSize:  MediaQuery.of(context).size.width*0.042,fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data!.data!.services!.length,
                            itemBuilder: (context,index){
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(

                                bottom: BorderSide(
                                  color: Colors.black45,
                                  width: 0.1
                                )
                              )
                            ),
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:  [
                                Expanded(
                                  flex: 1,

                                  child: Text(
                                    snapshot.data!.data!.services![index].code.toString(),
                                    textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  ),
                                ),    Expanded(
                                flex: 2,
                                  child: Text(
                                    snapshot.data!.data!.services![index].description.toString(),

                                    style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
                                  ),
                                ),  Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.data!.services![index].amount.toString(),
                                    textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  ),
                                ),   Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.data!.services![index].quantity.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  ),
                                ),  Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.data!.services![index].amount.toString(),
                                    textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 80,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomText(
                            title: "Amount",
                            text: total(snapshot.data!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              "ALL PARTS ARE SUPPLIED BY CUSTOMER UNLESS OTHERWISE SPECIFIED\n\nCUSTOMER COPY",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
String total(ServiceFormResultModel data){
    int totalAmount=0;
    data!.data!.services!.forEach((element) {
      totalAmount= int.parse(element!.amount!)+totalAmount;
    });
    return totalAmount.toString();
}
  void textGet(String data) {
    String? dataCopy;
    formDataModel!.data!.services!.forEach((element) {
      if (element.id.toString() == data.toString()) {
        servicesData.add(element.description ?? "");
      }
    });
  }
}
