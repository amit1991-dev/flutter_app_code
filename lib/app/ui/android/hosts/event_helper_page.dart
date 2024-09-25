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

class HostEventHelpersPage extends StatefulWidget {
  HostEventHelpersPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<HostEventHelpersPage> createState() => _State();
}

class _State extends State<HostEventHelpersPage> {
  bool createWait = false;
  late String eventId;
  _State(){
    eventId = Get.arguments as String;
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
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      headerBar("Event Helpers",parent: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 3,
                              child: clumsyTextLabel("Helpers help with scanning and marking entry of the tickets. Thery are only allowed for ticket scanning purpose",fontsize: 10,color: appColors["primary"]!)),
                          Flexible(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: () async {
                                await Get.toNamed(Routes.HOST_ADD_HELPERS,arguments: eventId);
                                setState(() {});
                                // Get.toNamed();
                              },
                              color: appColors["primary"]!,
                              textColor: appColors["background"]!,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_reaction_sharp,
                                    size: 24,
                                  ),
                                  clumsyTextLabel("Add",fontsize: 10,color: appColors["background"]!)
                                ],
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      if(event.helpers.isNotEmpty)
                        ...List.generate(event.helpers.length, (index){
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: appColors["primary"]!),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  clumsyTextLabel(event.helpers[index],fontsize: 20,color: appColors["blue"]!),
                                  MaterialButton(
                                    onPressed: () async {
                                      APIResponse res = await Get.find<HostController>().removeHelper({"phone":event.helpers[index]}, eventId);
                                      if(res.status == TextMessages.SUCCESS)
                                      {
                                        showSnackbar("Success", "Removed helper");
                                        setState(() {

                                        });
                                      }
                                      else{
                                        showSnackbar("Error",res.info!);
                                      }
                                    },
                                    color: appColors["background"]!,
                                    textColor: appColors["primary"]!,
                                    child: Column(
                                      children: [
                                        Icon(
                                            Icons.delete_forever,
                                            size: 24,
                                            color:Colors.red
                                        ),
                                        clumsyTextLabel("Delete",fontsize: 10,color: Colors.red)
                                      ],
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                      if(event.helpers.isEmpty)
                        clumsyTextLabel("You have added no Helpers, start by adding a phone number",fontsize: 12),
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
}

