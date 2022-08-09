import 'package:flutter/material.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/password_change.dart';
import 'package:untitled/screen/scanner.dart';
import 'package:untitled/screen/service_details_Screen.dart';
import 'package:untitled/screen/services_request.dart';
import 'package:untitled/splash_screen.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:get/get.dart';

import '../api/dio.dart';
import '../model/invoice_list_model.dart';
import '../utils/local_storage.dart';
import '../widgets/loader.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiClient apiClient=ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColors,
        title: Text(AppText.scannerApp),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
           UserAccountsDrawerHeader(
                  accountName: Text(''),
                  accountEmail: Text(email ?? ""),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 50,
                      )
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
                ),
            ListTile(
              onTap: () {
                Get.back();
                Get.to(Scanner());
              },
              leading: Icon(Icons.qr_code_scanner),
              title: Text(AppText.scanner),
            ), ListTile(
              onTap: () {
                Get.to(ServicesRequest());
              },
              leading: Icon(Icons.format_align_justify_outlined),
              title: Text(AppText.createServicesPerformed),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PasswordChange()));
                Get.off(PasswordChange());
              },
              leading: Icon(Icons.password),
              title: Text(AppText.passwordChange),
            ),
            ListTile(
              onTap: () {
                ProgressDialog.show(context);
                ApiClient apiClient = ApiClient();
                apiClient
                    .logOut().then((value) {
                      if(value){
                        Get.offAll(SplashScreen());

                      }else{
                        Fluttertoast.showToast(msg: "Somethink is Wrong");
                      }
                      ProgressDialog.hide();
                });
              },
              leading: Icon(Icons.exit_to_app),
              title: Text(AppText.logOut),

            ),
          ],
        ),
      ),
      body:  Material(
        color: AppColors.white,
        child: RefreshIndicator(
       onRefresh: () async {
         setState((){});
       },
          child: FutureBuilder(
              future:  apiClient.invoiceList(),
              builder: (context,AsyncSnapshot<InvoiceListModel?> data)  {
                if(data.connectionState==ConnectionState.waiting){
                return  Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(data.connectionState==ConnectionState.done && (data.data ?? "")==""){
                 return Center(
                    child: Text("Something is Wrong"),
                  );
                }
              return ListView.builder(
                  itemCount: data.data!.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Get.to(ServiceDetailScreen(id:data.data!.data![index].id.toString()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.appColors.withOpacity(0.1),
                                  blurRadius: 8)
                            ]),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Row(
                          children: [
                            // Expanded(
                            //     flex: 3,
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            //       child: Image.network(
                            //           "https://media.istockphoto.com/photos/red-generic-sedan-car-isolated-on-white-background-3d-illustration-picture-id1189903200?k=20&m=1189903200&s=612x612&w=0&h=L2bus_XVwK5_yXI08X6RaprdFKF1U9YjpN_pVYPgS0o="
                            //       ,width: 120,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     )),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(data.data!.data![index].shopName!,
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5,),
                                    Wrap(
                                      children: [
                                        Text("Model:",style: TextStyle(
                                          fontWeight: FontWeight.w600
                                        ),),
                                  Text(data.data!.data![index].v_modal!),
                                      ],
                                    ),SizedBox(height: 5,),
                                    Wrap(
                                      children: [
                                        Text("Year:",style: TextStyle(
                                            fontWeight: FontWeight.w600
                                        ),),
                                        Text(data.data!.data![index].vYear!),
                                      ],
                                    ),                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Text(
                                    data.data!.data![index].status==1 ? "Progress" : "Success",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: data.data!.data![index].status==1
                                            ? Colors.orangeAccent
                                            : Colors.green),
                                  ),
                                  height: 30,
                                  padding: EdgeInsets.only(right: 10, top: 2),
                                  alignment: Alignment.topCenter,
                                ),
                                data.data!.data![index].status==1
                                    ? InkWell(
                                  onTap: (){
                                    Get.to(ServicesRequest(id: data.data!.data![index].id.toString(),));
                                  },
                                      child: Container(
                                          height: 30,
                                          child: Icon(
                                            Icons.edit_sharp,
                                            color: AppColors.appColors,
                                          )),
                                    )
                                    : Container(
                                        height: 30,
                                      )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {

          Get.to(Scanner());
        },
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.appColors),
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.qr_code_scanner,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
  String? email;
  @override
  void initState() {
WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
   email=await LocalStorage.getString(LocalStorage.email) ?? "";
setState((){});
});
  }

}
