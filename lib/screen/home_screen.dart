import 'package:flutter/material.dart';
import 'package:untitled/screen/login/login_screen.dart';
import 'package:untitled/screen/password_change.dart';
import 'package:untitled/screen/scanner.dart';
import 'package:untitled/screen/services_request.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_text.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> check = [
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
  ];
  List<String> cars = [
    "Hyundai i20",
    "Hyundai Venue",
    "Kia Seltos",
    "Hyundai Creta",
    "Mahindra Scorpio",
    "Mahindra Thar",
    "Toyota Fortuner",
    "Lamborghini Urus",
    "Hyundai Creta",
    "Mahindra Scorpio",
    "Mahindra Thar",
    "Toyota Fortuner",
    "Lamborghini Urus",
  ];
  List<String> modelNo = [
    "Manual, Automatic",
    " Petrol, Diesel ",
    " Mid-Size SUV ",
    "Manual, Automatic",
    " Petrol, Diesel ",
    " Mid-Size SUV ",
    "Manual, Automatic",
    " Petrol, Diesel ",
    " Mid-Size SUV ",
    "Manual, Automatic",
    " Petrol, Diesel ",
    " Mid-Size SUV ",
  ];
  List<String> Code = [
    "32334",
    "6334",
    "34334",
    "76334",
    "23334",
    "13334",
    "97334",
    "34334",
    "3545334",
    "0984",
    "34434",
    "23434",
    "234534",
    "3456644",
    "32334",
    "32334",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColors,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Oflutter.com'),
              accountEmail: Text('example@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
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
                Get.to(Scanner());
              },
              leading: Icon(Icons.qr_code_scanner),
              title: Text(AppText.scanner),
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
                Get.off(LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: Text(AppText.logOut),

            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
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
                          Text(cars[index],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(modelNo[index]),
                          Text(Code[index]),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          check[index] ? "Progress" : "Success",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              color: check[index]
                                  ? Colors.orangeAccent
                                  : Colors.green),
                        ),
                        height: 30,
                        padding: EdgeInsets.only(right: 10, top: 2),
                        alignment: Alignment.topCenter,
                      ),
                      check[index]
                          ? InkWell(
                        onTap: (){
                          Get.to(ServicesRequest(newForm: true,));
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
            );
          }),
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
}
