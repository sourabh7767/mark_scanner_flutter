import 'package:flutter/material.dart';
import 'package:untitled/widgets/custom_text.dart';
class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
CustomText(title: "Shop Name: ",text: "test",),
CustomText(title: "Writer's Name: ",text: "test",),
CustomText(title: "Email: ",text: "test",),
CustomText(title: "Phone No : ",text: "test",),
CustomText(title: "VIN : ",text: "test",),
CustomText(title: "Model: ",text: "test",),
CustomText(title: "Model Year: ",text: "test",),
CustomText(title: "Make: ",text: "test",),
CustomText(title: "Color: ",text: "test",),
CustomText(title: "Ro/PO#: ",text: "test",),
            ],
          ),
        ),
      ),

    );
  }
}
