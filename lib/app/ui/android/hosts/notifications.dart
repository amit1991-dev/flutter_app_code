import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:getx/app/ui/android/widgets/host_notificaations.dart';

import '../../../routes/app_pages.dart';
import '../widgets/host_event_media_list.dart';
import '../widgets/host_event_picture_main.dart';
import '../widgets/miscellaneous.dart';

class HostNotificationsPage extends StatefulWidget {
  HostNotificationsPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<HostNotificationsPage> createState() => _State();
}

class _State extends State<HostNotificationsPage> {
  late String hostId;
  _State(){
    print("building");
    hostId = Get.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColors["background"]!,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              headerBar("Notifications",parent: true),
              HostNotifications(hostId: hostId,),
            ],
          ),
        )
      ),
    );

  }
}

