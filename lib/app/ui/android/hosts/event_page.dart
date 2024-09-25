// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:getx/app/data/model/event.dart';
// import 'package:getx/app/data/provider/host_api.dart';
// import 'package:getx/app/ui/android/widgets/event_phases.dart';

// import '../../../routes/app_pages.dart';
// import '../widgets/host_event_media_list.dart';
// import '../widgets/host_event_picture_main.dart';
// import '../widgets/miscellaneous.dart';

// class HostEventPage extends StatefulWidget {
//   HostEventPage({Key? key}):super(key: key){
//     // Get.put<HostController>(HostController());
//   }
//   @override
//   State<HostEventPage> createState() => _State();
// }

// class _State extends State<HostEventPage> {
//   bool createWait = false;
//   late String eventId;
//   _State(){
//     eventId = Get.arguments as String;
//     // eventId = "asdsad";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColors["background"]!,
//       body: AsyncBuilder<APIResponse>(
//         future: Get.find<HostController>().getMyEvent(eventId,test: false),
//         waiting: (context) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//         builder: (context,apiResponse){
//           if(apiResponse!.status == TextMessages.SUCCESS)
//             {
//               Event event = apiResponse.data as Event;
//               print("phase");
//               print(event.currentPhaseId);
//               return SafeArea(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 50,
//                       ),
//                       headerBar("Event Details"),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           MaterialButton(
//                             onPressed: () {
//                               Get.toNamed(Routes.HOST_SCANNER);
//                             },
//                             color: appColors["primary"]!,
//                             textColor: appColors["background"]!,
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   Icons.document_scanner_outlined,
//                                   size: 24,
//                                 ),
//                                 clumsyTextLabel("QR Scan",fontsize: 10,color: appColors["background"]!)
//                               ],
//                             ),
//                             padding: EdgeInsets.all(16),
//                             shape: CircleBorder(),
//                           ),
//                           MaterialButton(
//                             onPressed: () {
//                               Get.toNamed(Routes.HOST_HELPERS,arguments: eventId);
//                             },
//                             color: appColors["primary"]!,
//                             textColor: appColors["background"]!,
//                             child: Column(
//                               children: [

//                                 Icon(
//                                   Icons.medical_services_outlined,
//                                   size: 24,
//                                 ),
//                                 clumsyTextLabel("Helpers",fontsize: 10,color: appColors["background"]!)
//                               ],
//                             ),
//                             padding: EdgeInsets.all(16),
//                             shape: CircleBorder(),
//                           ),
//                           MaterialButton(
//                             onPressed: () {
//                               Get.toNamed(Routes.HOST_BOOKINGS,arguments: eventId);
//                             },
//                             color: appColors["primary"]!,
//                             textColor: appColors["background"]!,
//                             child: Column(
//                               children: [

//                                 Icon(
//                                   Icons.airplane_ticket,
//                                   size: 24,
//                                 ),
//                                 clumsyTextLabel("Bookings",fontsize: 10,color: appColors["background"]!)
//                               ],
//                             ),
//                             padding: EdgeInsets.all(16),
//                             shape: CircleBorder(),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       clumsyText("Main Picture"),
//                       HostEventPictureMain(event: event,),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       clumsyText("Gallary"),
//                       HostEventMediaListWidget(eventId: event.id,medias: event.medias),
//                       // ClumsyMediaList(event!.medias,host: true),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Divider(color: appColors["primary"]!,),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           clumsyText("Details"),
//                           MaterialButton(
//                             onPressed: () async {
//                               await Get.toNamed(Routes.HOST_EVENT_DETAILS,arguments: event.id);
//                               setState(() {

//                               });
//                             },

//                             color: appColors["background"]!,
//                             textColor: appColors["grey"]!,
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   Icons.edit,
//                                   size: 34,
//                                 ),
//                                 clumsyTextLabel("Edit",fontsize: 10,color: appColors["white"]!)
//                               ],
//                             ),
//                             padding: EdgeInsets.all(16),
//                             shape: CircleBorder(),
//                           ),
//                         ],
//                       ),
//                       EventInfoWidget(event: event),

//                       SizedBox(
//                         height: 50,
//                       ),
//                       // EventPhasesWidget(eventId: event.id, phases: event.phases),
//                       // SizedBox(
//                       //   height: 100,
//                       // ),

//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             if(event.eventStatus!="finished" && !event.published)
//                               InkWell(
//                                   onTap:() async {
//                                     await callDialog("Are you sure?", Row(
//                                       children: [
//                                         ClumsyFinalButton("No", Get.width*0.3, () {
//                                           Get.back();
//                                         }, false),
//                                         ClumsyFinalButton("Yes", Get.width*0.3, () async {
//                                           Get.back();
//                                           bool t=await attemptTogglePublishEvent(true,event);
//                                           if(t)
//                                           {
//                                             print(t);
//                                             setState(() {

//                                             });
//                                           }

//                                         }, false)
//                                       ],
//                                     )
//                                     );

//                                   },
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.publish,color: appColors["primary"]!,size: 30),
//                                       clumsyTextLabel("Publish",color:appColors["primary"]!)
//                                     ],
//                                   )
//                               ),
//                             // Container(
//                             //   margin: EdgeInsets.only(bottom: 20),
//                             //   child: Center(
//                             //     child: ClumsyFinalButton("Publish", Get.width*0.8, () async {
//                             //       HapticFeedback.lightImpact();
//                             //       await attemptTogglePublishEvent(true,event);
//                             //     }, createWait
//                             //     ),
//                             //   ),
//                             // ),
//                             if(event.eventStatus!="finished" && event.published)
//                               InkWell(
//                                   onTap:() async {
//                                     await callDialog("Are you sure?", Row(
//                                       children: [
//                                         ClumsyFinalButton("No", Get.width*0.3, () {
//                                           Get.back();
//                                         }, false),
//                                         ClumsyFinalButton("Yes", Get.width*0.3, () async {
//                                           Get.back();
//                                           bool t=await attemptTogglePublishEvent(false,event);

//                                           if(t)
//                                           {
//                                             setState(() {

//                                             });
//                                           }

//                                         }, false)
//                                       ],
//                                     )
//                                     );

//                                   },
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.unpublished,color: appColors["red"]!,size: 30,),
//                                       clumsyTextLabel("Unpublish",color:appColors["red"]!)
//                                     ],
//                                   )
//                               ),
//                             // Container(
//                             //   margin: EdgeInsets.only(bottom: 20),
//                             //   child: Center(
//                             //     child: ClumsyFinalButton("Unpublish", Get.width*0.8, () async {
//                             //       HapticFeedback.lightImpact();
//                             //       await attemptTogglePublishEvent(false,event);
//                             //     }, createWait
//                             //     ),
//                             //   ),
//                             // ),
//                             if(event.eventStatus!="finished" && event.published)
//                               InkWell(
//                                   onTap:() async {
//                                     await callDialog("Are you sure?", Row(
//                                       children: [
//                                         ClumsyFinalButton("No", Get.width*0.3, () {
//                                           Get.back();
//                                         }, false),
//                                         ClumsyFinalButton("Yes", Get.width*0.3, () async {
//                                           Get.back();
//                                           bool t=await attemptFinishEvent();
//                                           if(t)
//                                           {
//                                             setState(() {

//                                             });
//                                           }

//                                         }, false)
//                                       ],
//                                     )
//                                     );

//                                   },
//                                   child: Column(
//                                     children: [
//                                       Icon(Icons.done,color: appColors["green"]!,size: 30,),
//                                       clumsyTextLabel("Finish Event",color:appColors["green"]!)
//                                     ],
//                                   )
//                               ),
//                             // Container(
//                             //   margin: EdgeInsets.only(bottom: 200),
//                             //   child: Center(
//                             //     child: ClumsyFinalButton("Finish Event", Get.width*0.8, () async {
//                             //       HapticFeedback.lightImpact();
//                             //       await attemptFinishEvent();
//                             //     }, createWait
//                             //     ),
//                             //   ),
//                             // ),
//                             if(event.eventStatus=="finished") clumsyTextLabel("This Event is Already Finished",color: Colors.red),
//                             // SizedBox(
//                             //   height: 50,
//                             // )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }
//           else
//             {
//               return Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset("assets/images/favicon.png"),
//                       Text("Some error Occured"),
//                       // Text(error.toString()),
//                       ClumsyRealButton("Retry", Get.width, () {
//                         setState(() {

//                         });
//                       }, false),
//                     ],
//                   )
//               );
//             }
//         },
//         error: (context, error, stackTrace) {
//           print(error);
//           return Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset("assets/images/favicon.png"),
//                   Text("Some error Occured"),
//                   // Text(error.toString()),
//                   ClumsyRealButton("Retry", Get.width, () {
//                     setState(() {

//                     });
//                   }, false),
//                 ],
//               )
//           );
//         },
//       ),
//     );

//   }
//   Future<bool> attemptTogglePublishEvent(bool publish,Event event) async {
//     if (kDebugMode) {
//       print("attempting to save the event");
//     }
//     Map<String,dynamic> eventJson = {};

//     if(publish)
//     {
//       if(getTicketCount(event.currentPhase)==0)
//       {
//         showSnackbar("Please", "Your Current Active phase does not contain any tickets!");
//         return false;
//       }
//     }

//     eventJson['_id'] = eventId;
//     eventJson['published'] = publish;

//     APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
//     if(res.status == TextMessages.SUCCESS)
//     {
//       showSnackbar(TextMessages.SUCCESS,"Successfully Altered Published state");
//       return true;
//     }
//     else
//     {
//       showSnackbar("Error", res.info!);
//       return false;
//     }
//   }

//   Future<bool> attemptFinishEvent() async {
//     if (kDebugMode) {
//       print("attempting to finish the event");
//     }
//     Map<String,dynamic> eventJson = {};

//     eventJson['_id'] = eventId;
//     eventJson['event_status'] = "finished";

//     APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
//     if(res.status == TextMessages.SUCCESS)
//     {
//       showSnackbar(TextMessages.SUCCESS,"Successfully finished event");
//       return true;
//     }
//     else
//     {

//       showSnackbar("Error", res.info!);
//       return false;
//     }
//   }
// }

