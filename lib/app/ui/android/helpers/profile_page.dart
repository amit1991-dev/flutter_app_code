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

class HelperProfilePage extends StatefulWidget {
  HelperProfilePage({Key? key}):super(key: key){
  }
  @override
  State<HelperProfilePage> createState() => _State();
}

class _State extends State<HelperProfilePage> {
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
            ],
          ),
        ),
      )
    );

  }
}

