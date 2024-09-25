import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../data/constants/miscellaneous.dart';
import '../widgets/google_places.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({super.key});

  // String cityName = "a";

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool flashOn = false;
  MobileScannerController cameraController = MobileScannerController(torchEnabled: false);
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  _ScannerPageState(){


  }
  @override
  Widget build(BuildContext context) {

    void toggleFlash() {
        setState(() {
          flashOn = !flashOn;
          cameraController.toggleTorch();
        });
    }



    return Material(
      child: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            // fit: BoxFit.fill,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                showSnackbar("Successfully Scanned","Opening Booking Page");
                Get.toNamed(Routes.HOST_SCANNED,arguments: code);
                // debugPrint('Barcode found! $code');
              }
            }),
          Positioned(
              top: 100,
              left: 20,
              child: Image.asset("assets/images/logo_title.png",scale: 3,)
          ),
          Positioned(
              top: 100,
              right: 20,
              child: IconButton(
                onPressed: toggleFlash,
                icon: flashOn?Icon(Icons.flashlight_off_outlined):Icon(Icons.flashlight_on_outlined),
              )
          ),
          Positioned(
              top:Get.height*0.3,
              left:Get.width*0.2,

              child: Container(
                width: Get.width*0.6,
                height: Get.width*0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:Border.all(color: appColors["primary"]!)
                ),

              )
          )
        ],
      ),
    );
  }
}
