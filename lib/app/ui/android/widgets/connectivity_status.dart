
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/ui/android/widgets/internet_checker.dart';

class ConnectivityStatusWidget extends StatelessWidget {
  const ConnectivityStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<InternetChecker>().isConnected.value) {
        return const Text('Connected', style: TextStyle(color: Colors.green));
      } else {
        return const Text('Disconnected', style: TextStyle(color: Colors.red));
      }
    });
  }
}
