import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/user_notifications.dart';
import '../widgets/miscellaneous.dart';
import '../../../data/constants/miscellaneous.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<NotificationsPage> createState() => _State();
}

class _State extends State<NotificationsPage> {
  late String UserId;
  _State(){
    print("building");
    UserId = Get.arguments as String;
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
              UserNotifications(userId: UserId,),
            ],
          ),
        )
      ),
    );

  }
}

