import 'dart:convert';
import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/model/city_state.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../routes/app_pages.dart';
import '../widgets/google_places.dart';
import 'package:http/http.dart' as http;

class AddHelperPage extends StatefulWidget {
  const AddHelperPage({super.key});
  @override
  State<AddHelperPage> createState() => _AddHelperPageState();
}

class _AddHelperPageState extends State<AddHelperPage> {
  bool createWait=false,cityLoading = false;
  late String eventId;
  TextEditingController phoneController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  _AddHelperPageState(){
    eventId = Get.arguments as String;
  }

  dynamic attemptAddHelper() async {
    if (kDebugMode) {
      print("attempting to");
    }
    Map<String,dynamic> eventJson = {};
    if(phoneController.text.isEmpty)
      {
        showSnackbar("Error", "Please provide helpers phone number");
        return;
      }
    print("adding helper with the phone number:${phoneController.text}");
    eventJson['phone'] = phoneController.text;
    // setState(() {
    //   createWait = true;
    // });
    // print(eventJson);
    APIResponse res = await Get.find<HostController>().addHelper(eventJson,eventId);
    if(res.status == TextMessages.SUCCESS)
      {
        showSnackbar(TextMessages.SUCCESS,"Successfully added the helper!");
        Get.back();
        print("get did not work!");
      }
    else
      {
        showSnackbar("Error", res.info!);
      }
    if (kDebugMode) {
      print("finished adding the helper to the event");
    }
    // setState(() {
    //   createWait = false;
    // });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          color: appColors["background"]!,
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(

            child: Container(
                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: appColors["background"]!
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height*0.05,
                  ),
                  headerBar("Add Helper",parent: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IntlPhoneField(
                      cursorColor: appColors["white"]!,
                      controller: phoneController,
                      decoration: InputDecoration(
                          counter: const Offstage(),
                          labelText: 'Phone Number',
                          labelStyle: GoogleFonts.ubuntu(color: appColors["white"]!,fontSize: 14),
                          border: InputBorder.none
                      ),
                      initialCountryCode: 'IN',
                      // countries: ["IN"],
                      cursorWidth: 2,
                      showDropdownIcon: true,
                      style: GoogleFonts.ubuntu(fontSize: 20,color: appColors["white"]!),
                      dropdownIconPosition:IconPosition.trailing,
                      onChanged: (phone) {
                        print("hello");
                        print(phone.number);
                        // phoneNumber = phone.number;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 200),
                    child: Center(
                        child: ClumsyRealButton("Add helper", Get.width*0.8, () async {
                          HapticFeedback.lightImpact();
                          await attemptAddHelper();
                        }, false),
                      ),
                    ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  // Map<String, dynamic>? eventFromForm() {
  //   // pending
  //   return {};
  // }
}
