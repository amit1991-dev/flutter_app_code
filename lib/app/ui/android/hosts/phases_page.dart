import 'package:async_builder/async_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

class HostEventPhasesPage extends StatefulWidget {
  HostEventPhasesPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<HostEventPhasesPage> createState() => _State();
}

class _State extends State<HostEventPhasesPage> {
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
        future: Get.find<HostController>().getMyEvent(eventId,test: false),
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
                      headerBar("Event Phases"),
                      if(event.published) clumsyTextLabel("Event is LIVE!",color: appColors["green"]!),
                      if(event.published) Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: clumsyTextLabel("* Please un-publish the event to make any changes here....",fontsize: 10,color: appColors["grey"]!),
                        ),
                      SizedBox(
                        height: 50,
                      ),
                      EventPhasesWidget(eventId: event.id, phases: event.phases),
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
  Future<bool> attemptTogglePublishEvent(bool publish,Event event) async {
    if (kDebugMode) {
      print("attempting to save the event");
    }
    Map<String,dynamic> eventJson = {};

    if(publish)
    {
      if(getTicketCount(event.currentPhase)==0)
      {
        showSnackbar("Please", "Your Current Active phase does not contain any tickets!");
        return false;
      }
    }

    eventJson['_id'] = eventId;
    eventJson['published'] = publish;

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully Altered Published state");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }
  }

  Future<bool> attemptFinishEvent() async {
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
      return true;
    }
    else
    {

      showSnackbar("Error", res.info!);
      return false;
    }
  }
}

