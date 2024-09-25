import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import '../../../data/constants/miscellaneous.dart';
import 'package:photo_view/photo_view.dart';

import 'miscellaneous.dart';
class PaymentStatus extends StatefulWidget {
  // final String path;
  const PaymentStatus({Key? key}) : super(key: key);

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  late String status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = Get.arguments as String;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerBar("Payment Transaction status",parent: true),
            Spacer(),
            Image.asset("assets/images/logo_title.png",width: Get.width/2.5,),
            clumsyTextLabel("Payment Status",fontsize: 20,color: appColors["white"]!),
            clumsyTextLabel("Success",fontsize: 30,color: appColors["primary"]!),
            clumsyTextLabel(status,fontsize:16),
            clumsyTextLabel("Please view Tickets in Profile Page",fontsize: 15),
            ClumsyFinalButton("HOME", Get.width*0.4, () {
              Get.toNamed(Routes.HOME);
              // Get.offUntil(Routes.HOME,(Routes.HOME){
              //   return false;
              // });
            }, false),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
