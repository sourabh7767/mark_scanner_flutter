import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:untitled/screen/services_request.dart';
import 'package:untitled/utils/app_color.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool? check;
  @override
  void initState() {
    controller?.resumeCamera();
  } // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }

  }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),

        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
                      await this.controller?.pauseCamera();
    setState(() {
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      if((check ?? true)) {
        Get.off(ServicesRequest(code: result!.code!,));

        print("result---" + result!.code.toString());
      }else{
      // Get.dialog(
      //     barrierDismissible: false,
      //     useSafeArea: false,

//           WillPopScope(
//             onWillPop: ()async{
//               check=true;
//               return check!;
//             },
//             child: AlertDialog(
//         title: Text("Service Code"),
//         content: Text(result!.code!),
//         actions: [
//             TextButton(
//                 onPressed: () {
//                   Get.back();
//                   Get.off(ServicesRequest(code: result!.code!,));
//                 },
//                 child: Text(
//                   "Next",
//                   style: TextStyle(color: AppColors.appColors),
//                 )),
//             TextButton(
//                 onPressed: () {
// Get.back();
//
// check=true;
//                 },
//                 child: Text(
//                   "cancel",
//                   style: TextStyle(color: AppColors.appColors),
//                 )),
//         ],
//
//       ),
//           ));
check=false;
      }

    });

    });
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
