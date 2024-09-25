import 'package:async_builder/async_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/helper_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';

import '../../../routes/app_pages.dart';
import '../widgets/host_event_media_list.dart';
import '../widgets/host_event_picture_main.dart';
import '../widgets/miscellaneous.dart';

class HelperEventPage extends StatefulWidget {
  HelperEventPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<HelperEventPage> createState() => _State();
}

class _State extends State<HelperEventPage> {
  bool createWait = false;
  late String eventId;
  _State(){
    eventId = Get.arguments as String;
    // eventId = "asdsad";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: AsyncBuilder<APIResponse>(
        future: Get.find<HelperController>().getMyEvent(eventId,test: false),
        waiting: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        builder: (context,apiResponse){
          if(apiResponse!.status == TextMessages.SUCCESS)
            {
              Event event = apiResponse.data as Event;
              print("phase");
              print(event.currentPhaseId);
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      headerBar("Event Details"),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.HOST_SCANNER);
                            },
                            color: appColors["primary"]!,
                            textColor: appColors["background"]!,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.document_scanner_outlined,
                                  size: 24,
                                ),
                                clumsyTextLabel("QR Scan",fontsize: 10,color: appColors["background"]!)
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      helperEventListTile(event,clickDisabled: true),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          clumsyText("Details"),
                        ],
                      ),
                      EventInfoWidget(event: event),

                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 100,
                      ),

                      // if(!event.published)
                      //   Container(
                      //     margin: EdgeInsets.only(bottom: 20),
                      //     child: Center(
                      //       child: ClumsyFinalButton("Publish", Get.width*0.8, () async {
                      //         HapticFeedback.lightImpact();
                      //         await attemptTogglePublishEvent(true,event);
                      //       }, createWait
                      //       ),
                      //     ),
                      //   ),
                      // if(event.published)
                      //   Container(
                      //     margin: EdgeInsets.only(bottom: 20),
                      //     child: Center(
                      //       child: ClumsyFinalButton("Unpublish", Get.width*0.8, () async {
                      //         HapticFeedback.lightImpact();
                      //         await attemptTogglePublishEvent(false,event);
                      //       }, createWait
                      //       ),
                      //     ),
                      //   ),
                      // if(event.eventStatus!="finished" && event.published)
                      //   Container(
                      //     margin: EdgeInsets.only(bottom: 200),
                      //     child: Center(
                      //       child: ClumsyFinalButton("Finish Event", Get.width*0.8, () async {
                      //         HapticFeedback.lightImpact();
                      //         await attemptFinishEvent();
                      //       }, createWait
                      //       ),
                      //     ),
                      //   ),
                      if(event.eventStatus=="finished") clumsyTextLabel("This Event is Already Finished",color: Colors.red),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              );
            }
          else
            {
              return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/favicon.png"),
                      Text("Some error Occured"),
                      // Text(error.toString()),
                      ClumsyRealButton("Retry", Get.width, () {
                        setState(() {

                        });
                      }, false),
                    ],
                  )
              );
            }
        },
        error: (context, error, stackTrace) {
          print(error);
          return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/favicon.png"),
                  Text("Some error Occured"),
                  // Text(error.toString()),
                  ClumsyRealButton("Retry", Get.width, () {
                    setState(() {

                    });
                  }, false),
                ],
              )
          );
        },
      ),
    );

  }
  dynamic attemptTogglePublishEvent(bool publish,Event event) async {
    if (kDebugMode) {
      print("attempting to save the event");
    }
    Map<String,dynamic> eventJson = {};

    if(publish)
    {
      if(getTicketCount(event.currentPhase)==0)
      {
        showSnackbar("Please", "Cannot publish without a Ticket");
        return;
      }
    }

    eventJson['_id'] = eventId;
    eventJson['published'] = publish;

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      // Event event= res.data as Event;
      showSnackbar(TextMessages.SUCCESS,"Successfully Altered Published state");
      setState(() {
      });
    }
    else
    {
      showSnackbar("Error", res.info!);
    }
    if (kDebugMode) {
      print("finished toggling published variable");
    }
  }

  dynamic attemptFinishEvent() async {
    if (kDebugMode) {
      print("attempting to finish the event");
    }
    Map<String,dynamic> eventJson = {};

    eventJson['_id'] = eventId;
    eventJson['event_status'] = "finished";

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully finished event");
      setState(() {

      });
    }
    else
    {
      showSnackbar("Error", res.info!);
    }
    if (kDebugMode) {
      print("finished toggling published variable");
    }
  }
}

