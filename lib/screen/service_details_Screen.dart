import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/api/dio.dart';
import 'package:untitled/model/invoice_list_model.dart';
import 'package:untitled/utils/api_path.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_images.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/custom_text.dart';

import '../model/form_data_model.dart';
import '../model/service_form_result_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'image_view.dart';

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
String? name;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      formDataModel = await apiClient.shopDetail();
     name= await LocalStorage.getString(LocalStorage.name) ;
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
              if (snapshot.connectionState == ConnectionState.done) {


                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          for (Images xfile in snapshot.data!.data!.images!)
                            InkWell(
                              onTap: () {
                                 Get.to(ImageView(url: ApiPath.ImageBasePath+xfile.image!,));
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.black12),
                                child: CachedNetworkImage(
                                  imageUrl: ApiPath.ImageBasePath+xfile.image!,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),]),),
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
                                  title: "Invoice No: ",
                                  text: snapshot.data!.data!.invoiceId ?? "",
                                ),
                                CustomText(
                                  title: "Date : ",
                                  text:  DateFormat("MM/dd/yyyy").format(DateTime.parse(snapshot.data!.data!.createdAt!)),
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
                              title: "Email: ",
                              text: snapshot.data!.data!.shopEmail ?? "",

                            ),
                            CustomText(
                              title: "Phone No : ",
                              text: snapshot.data!.data!.shopNumber ?? "",
                            ),
                            // CustomText(
                            //   title: "Engine : ",
                            //   text: snapshot.data!.data!.vEngine ?? "'",
                            // ),
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
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: AppColors.appColors,
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
                        // ListView.builder(
                        //     itemCount: servicesData.length,
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 20),
                        //           child: Text(
                        //             (index + 1).toString() +
                        //                 "." +
                        //                 (servicesData.elementAt(index) ?? ""),
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w400),
                        //           ));
                        //     }),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(

                            TextSpan(
                     children: [
                                TextSpan(
                                  text: 'SERVICE COMMENTS:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                TextSpan(text: ' MOBILE SERVICE REQUESTED BY ${snapshot.data!.data!.cName ?? ""}',),
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
                                (name ?? ""),
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
                                  "Part",
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
                            physics: NeverScrollableScrollPhysics(),
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
                                      (snapshot.data!.data!.services![index].type==1)? (String.fromCharCodes(new Runes('\u0024'))+snapshot.data!.data!.services![index].amount.toString()):"",
                                    textAlign: TextAlign.center,

                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                  ),
                                ), Expanded(
                                  flex: 1,
                                  child:   Text(snapshot.data!.data!.services![index].type==2?(String.fromCharCodes(new Runes('\u0024'))+(snapshot.data!.data!.services![index].amount.toString())):"",
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
                                    (String.fromCharCodes(new Runes('\u0024'))+snapshot.data!.data!.services![index].amount.toString()),
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
                            text: (String.fromCharCodes(Runes('\u0024'))+total(snapshot.data!)),
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
    double totalAmount=0.00;
    data!.data!.services!.forEach((element) {
      totalAmount= double.parse(element!.amount!)+totalAmount;
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
