import 'package:async_builder/async_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:getx/app/ui/android/widgets/phase_item.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../routes/app_pages.dart';
import 'event_phase.dart';

class EventPhasesWidget extends StatefulWidget {
  late final String eventId;
  List<EventPhase> phases;
  EventPhasesWidget({super.key, required this.eventId,required this.phases });

  @override
  State<EventPhasesWidget> createState() => _EventPhasesWidgetState();
}

class _EventPhasesWidgetState extends State<EventPhasesWidget> {
  TextEditingController phaseController= TextEditingController();
  bool phaseWait = false;
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HostController>().getEventPhases(widget.eventId),
      waiting: (context) {
        return clumsyWaitingBar();
        // return Padding(
        //   padding: const EdgeInsets.all(18.0),
        //   child: Center(
        //     child: CircularProgressIndicator(color: appColors["primary"]!,),
        //
        //   ),
        // );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<EventPhase> phases = apiResponse.data as List<EventPhase>;
          print(phases);
          return ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: appColors["primary"]!,
              child: SingleChildScrollView(
                child: Container(

                  decoration: BoxDecoration(
                    // color: appColors["grey"]!
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: clumsyTextLabel("Tickets",fontsize: 30),
                                  ),
                                  //Text("Instructions to create Tickets"),
                                  clumsyTextLabel("Steps to Create Tickets",fontsize: 20,color: appColors["primary"]!),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: clumsyTextLabel("Create Phases > Categories > Tickets in that order.",fontsize: 15,color: appColors["white"]!),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.all(20),
                                    width: Get.width*0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: appColors["primary"]!),

                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        clumsyTextLabel("Phase-Name",color: appColors["primary"]!),
                                        clumsyTextLabel("(eg. Early Bird)",color: appColors["grey"]!),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          width: Get.width*0.8,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: appColors["primary"]!),

                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              clumsyTextLabel("Category-Name",color: appColors["primary"]!),
                                              clumsyTextLabel("(eg. Male stag)",color: appColors["grey"]!),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.all(10),
                                                width: Get.width*0.8,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  border: Border.all(color: appColors["primary"]!),

                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    clumsyTextLabel("Tickets",color: appColors["primary"]!),
                                                    clumsyTextLabel("(eg. VIP)",color: appColors["grey"]!),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: clumsyTextLabel("2. Select ACTIVE PHASE from EDIT Details Page",fontsize: 15,color: appColors["white"]!),
                                  // ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(width: 40,),
                                  Column(
                                    children: [
                                      clumsyTextLabel("Event Phases",color: appColors["primary"]!,fontsize: 22),
                                      // clumsyTextLabel(event.name,color: appColors["primary"]!,fontsize: 22),

                                    ],
                                  ),
                                  // SizedBox(width: 40,),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                             await callDialog("Phase Name",
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              // color: Color(0xff36363D),
                                                              border: Border.all(color:appColors["grey"]!),
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(18.0),
                                                              child: TextFormField(
                                                                controller: phaseController,
                                                                autofocus: false,
                                                                cursorColor: appColors["primary"]!,
                                                                cursorRadius: Radius.circular(10),
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  labelText: "Phase Name",
                                                                  labelStyle: TextStyle(color: appColors["primary"]!),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              ClumsyFinalButton("Create", Get.width*0.4, () async {
                                                                Get.back();
                                                                await attemptCreatePhase(phaseController.text);
                                                                setState(() {
                                                                  // phaseWait=false;
                                                                });
                                                              }, false),
                                                              ClumsyFinalButton("Cancel", Get.width*0.4, () async {
                                                                Get.back();
                                                              }, false)
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                      );
                                            },
                                              child: Icon(Icons.add,color: appColors["green"]!,size: 30,)),
                                          clumsyTextLabel("Add Phase",color: appColors["grey"]!,fontsize: 12),


                                        ],
                                      ),
                                      SizedBox(width: 40,),
                                      // Column(
                                      //   children: [
                                      //     Icon(Icons.delete,color: Colors.red,size: 30,),
                                      //     clumsyTextLabel("Delete",color: appColors["grey"]!,fontsize: 12),
                                      //
                                      //
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(18.0),
                                  //       child: Icon(Icons.add,color: appColors["background"]!,size: 40,),
                                  //     ),
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(18.0),
                                  //       child:,
                                  //     ),
                                  //
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            // Center(
                            //   child: ClumsyFinalButton("Phase +", Get.width*0.6, () async {
                            //     // setState(() {
                            //     //   phaseWait=true;
                            //     // });
                            //
                            //     var ret = await callDialog("Phase Name",
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       children: [
                            //         Container(
                            //           margin: EdgeInsets.all(10),
                            //           decoration: BoxDecoration(
                            //             // color: Color(0xff36363D),
                            //             border: Border.all(color:appColors["grey"]!),
                            //             borderRadius: BorderRadius.circular(20),
                            //           ),
                            //           child: Padding(
                            //             padding: const EdgeInsets.all(18.0),
                            //             child: TextFormField(
                            //               controller: phaseController,
                            //               autofocus: false,
                            //               cursorColor: appColors["primary"]!,
                            //               cursorRadius: Radius.circular(10),
                            //               decoration: InputDecoration(
                            //                 border: InputBorder.none,
                            //                 labelText: "Phase Name",
                            //                 labelStyle: TextStyle(color: appColors["primary"]!),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //         Row(
                            //           children: [
                            //             ClumsyFinalButton("Create", Get.width*0.4, () async {
                            //               Get.back();
                            //               await attemptCreatePhase(phaseController.text);
                            //               setState(() {
                            //                 // phaseWait=false;
                            //               });
                            //             }, false),
                            //             ClumsyFinalButton("Cancel", Get.width*0.4, () async {
                            //               Get.back();
                            //             }, false)
                            //           ],
                            //         )
                            //       ],
                            //     )
                            //     );
                            //
                            //     // setState(() {
                            //     //   phaseWait=false;
                            //     // });
                            //
                            //   }, phaseWait),
                            // )
                          ],
                        ),
                      if(phases.isNotEmpty)
                        ...List.generate(phases.length, (index){
                          return Container(
                              margin: EdgeInsets.only(top:20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 40,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap:() async {
                                            await callDialog("Are you sure?", Row(
                                              children: [
                                                ClumsyFinalButton("No", Get.width*0.3, () {
                                                  Get.back();
                                                }, false),
                                                ClumsyFinalButton("Yes", Get.width*0.3, () async {
                                                   Get.back();
                                                   await attemptDeletePhase(phases[index].id);

                                                  setState(() {

                                                  });

                                                }, false)
                                              ],
                                            )
                                            );

                                              },
                                            child: Icon(Icons.delete,color: appColors["white"]!,size: 30,)
                                        ),
                                        clumsyTextLabel("Delete Phase",color: appColors["grey"]!,fontsize: 10),


                                      ],
                                    ),
                                  ),
                                  PhaseItem(seqNum: index+1,phaseId: phases[index].id,eventId: widget.eventId,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(color: appColors["grey"]!),
                                  )
                                ],
                              ));
                        }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else
        {
          // showSnackbar("Error", apiResponse!.info!);
          print(apiResponse!.info!);
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // headerBar("All Phases",parent: false),
                  Text(ErrorMessages.SOMETHINGS_WRONG),

                  ClumsyFinalButton("Retry", Get.width*0.6, () {
                    setState(() {

                    });
                  }, false)
                  // Text(error.toString()),
                ],
              )
          );
        }

      },
      error: (context, error, stackTrace) {
        return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Some error Occured"),
                Text(error.toString()),
              ],
            )
        );
      },
    );
  }

  Future<bool> attemptCreatePhase(String text) async {
    Map<String,dynamic> eventJson = {};
    if(text.isEmpty)
    {
      showSnackbar("Error", "Please enter a NAME for the event");
      return false;
    }
    eventJson['name'] = text;
    eventJson['event_id'] = widget.eventId;

    APIResponse res = await Get.find<HostController>().createPhase(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully created the Phase!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }
    if (kDebugMode) {
      print("finished creating the the phase");
    }

  }

  Future<bool> attemptDeletePhase(String phaseId) async {
    print("deleting Phase");
    APIResponse res = await Get.find<HostController>(). deletePhase(phaseId);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully deleted the Phase!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }
}
