import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:getx/app/ui/android/widgets/host_info_widget.dart';
import 'package:getx/app/ui/android/widgets/host_notificaations.dart';

import '../widgets/miscellaneous.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}):super(key: key){
  }
  @override
  State<ProfilePage> createState() => _State();
}

class _State extends State<ProfilePage> {
  TextEditingController phoneController = TextEditingController(text:Get.find<Authentication>().user!.phone);
  // TextEditingController phoneController = TextEditingController(text:Get.find<Authentication>().user!.phone);
  // TextEditingController phoneController = TextEditingController(text:Get.find<Authentication>().user!.phone);
  // TextEditingController phoneController = TextEditingController(text:Get.find<Authentication>().user!.phone);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerBar("Profile",parent: false),

              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // border: Border.all(color:appColors["grey"]!),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: GestureDetector(
                  onTap: (){
                    showSnackbar("Disabled", "Contact Number cannot be edited from here");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: phoneController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      enabled: false,
                      // onTap: (){
                      //   print("no");
                      // },
                      onChanged: (text){
                        setState(() {

                        });
                      },
                      cursorColor: appColors["primary"]!,
                      cursorRadius: Radius.circular(10),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: appColors["primary"]!),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Get.toNamed(Routes.HOST_WALLET);
                    },
                    color: appColors["background"]!,
                    textColor: appColors["green"]!,
                    child: Column(
                      children: [
                        Icon(
                          Icons.money,
                          size: 34,
                        ),
                        clumsyTextLabel("Wallet",fontsize: 10,color: appColors["green"]!)
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    onPressed: () {
                      print("asd");
                      print(Get.find<Authentication>().user!.id);
                      Get.toNamed(Routes.HOST_NOTIFICATIONS,arguments: Get.find<Authentication>().user!.id);
                    },
                    color: appColors["background"]!,
                    textColor: appColors["background"]!,
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications,
                          size: 34,
                          color: appColors["blue"]!,
                        ),
                        clumsyTextLabel("Notifications",fontsize: 10,color: appColors["blue"]!)
                      ],
                    ),
                    padding: EdgeInsets.all(26),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.find<Authentication>().logout();
                      Get.offAllNamed(Routes.INITIAL);
                    },
                    color: appColors["background"]!,
                    textColor: Colors.red.shade900,
                    child: Column(
                      children: [

                        Icon(
                          Icons.logout,
                          size: 34,
                        ),
                        clumsyTextLabel("logout",fontsize: 10,color: Colors.red.shade900)
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    shape: CircleBorder(),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    clumsyTextLabel("Switch to Client Side"),
                    MaterialButton(
                      onPressed: () async {
                        APIResponse res = await Get.find<HostController>().switchToClient();
                        if(res.status == TextMessages.SUCCESS)
                        {
                          Get.find<Authentication>().user!.token = res.data as String;
                          Get.find<Authentication>().user!.role = "user";
                          await Get.find<Authentication>().login(Get.find<Authentication>().user!);
                          showSnackbar( "Switching...","Host to client side");
                          Get.offAllNamed(Routes.INITIAL);
                        }
                        else
                        {
                          showSnackbar( "Switching Failed",res.info!);
                        }

                        // Get.offAllNamed(Routes.INITIAL);
                      },
                      color: appColors["background"]!,
                      textColor: appColors["grey"]!,
                      child: Column(
                        children: [

                          Icon(
                            Icons.swap_horiz,
                            size: 34,
                          ),
                          clumsyTextLabel("Switch",fontsize: 10,color: appColors["white"]!)
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ),

              HostInfoWidget(hostId: Get.find<Authentication>().user!.id),
              // HostNotifications(hostId: Get.find<Authentication>().user!.id),
              Divider(),
              // ClumsyFinalButton("Host Wallet", Get.width*0.8, () {
              //   Get.toNamed(Routes.HOST_WALLET);
              // }, false,color: appColors["primary"]!),
              // // Spacer(),
              // SizedBox(
              //   height: 200,
              // ),
              // ClumsyFinalButton("logout", Get.width*0.8, () {
              //   Get.find<Authentication>().logout();
              //   Get.offAllNamed(Routes.INITIAL);
              // }, false,color: Colors.red),
            ],
          ),
        ),
      )
    );

  }
}

