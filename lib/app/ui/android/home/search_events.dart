import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/controller/networking/networking.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/loading_widget.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:simple_s3/simple_s3.dart';

import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/booking.dart';
import '../../../data/model/event.dart';

class UserSearchEvents extends StatefulWidget {
  // late Function openPage;
  // String eventType;
  UserSearchEvents({super.key});

  @override
  State<UserSearchEvents> createState() => _UserSearchEventsState();
}

class _UserSearchEventsState extends State<UserSearchEvents> {


  TextEditingController searchController = TextEditingController(text: "");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        color: appColors["background"]!,
        child: SafeArea(
          child: Column(
            children: [
              headerBar("Search",parent: false),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Color(0xff36363D),
                  border: Border.all(color:appColors["primary"]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: searchController,
                    autofocus: false,
                    onChanged: (text){
                      setState(() {

                      });
                    },
                    cursorColor: appColors["primary"]!,
                    cursorRadius: Radius.circular(10),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Search Topics,Tests or Classes",
                      labelStyle: TextStyle(color: appColors["primary"]!),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    if(searchController.text.isNotEmpty) AsyncBuilder<APIResponse>(
                      // future: Get.find<HomeController>().searchEvents(searchController.text),
                      future: Get.find<HomeController>().searchEvents(searchController.text),
                      waiting: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      builder: (context,apiResponse){
                        if(apiResponse!.status == TextMessages.SUCCESS)
                        {
                          List<Event> events = apiResponse.data as List<Event>;
                          return ScrollConfiguration(
                            behavior: ScrollBehavior(),
                            child: GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: appColors["primary"]!,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    if(events.length>0)
                                      ...List.generate(events.length, (index){
                                        return clientEventListTile(events[index]);
                                      })
                                    else
                                      Center(
                                        child: Column(
                                          children: [
                                            Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                                            Text(" 0 Events for this Event Type"),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else
                        {
                          // showSnackbar("Error", apiResponse!.info!);
                          print(apiResponse.info!);
                          return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // headerBar("All Events",parent: false),
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
                                ClumsyFinalButton("Retry", Get.width*0.6, () {
                                  setState(() {
                                  });
                                }, false)
                              ],
                            )
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      );
  }
}

// Widget eventListTile(Event event){
//     return InkWell(
//       splashColor: appColors["primary"]!,
//       onTap: ()async{
//         await Get.toNamed(Routes.EVENT,arguments: event.id);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Container(
//           // width: 225,
//           // height: 200,
//           decoration: BoxDecoration(
//               border: Border.all(color:appColors["grey"]!.shade800,style: BorderStyle.solid,width: 1),
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(image:  NetworkImage(event.thumbnail!,scale: 10), fit: BoxFit.contain)
//               // image: DecorationImage(image:  AssetImage("assets/images/pager.jpg"), fit: BoxFit.cover)
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: clumsyTextLabel(event.name,fontsize: 25,color:appColors["white"]!),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.location_on_outlined,color: appColors["primary"]!,),
//                     Text(event.venue!)
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.calendar_month_rounded,color: appColors["primary"]!,),
//                     Text(event.eventTimestamp!)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
// }


//
// Widget bookingListTile(Booking booking){
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: ListTile(
//           tileColor: appColors["background"]!,
//           splashColor: appColors["primary"]!,
//           leading: CircleAvatar(
//             radius: 40,
//             backgroundColor: appColors["primary"]!,
//             // backgroundImage: AssetImage("assets/images/c_logo.png"),
//             backgroundImage: NetworkImage("https://clumsyapp.com"+booking!.event.thumbnail!,scale: 10),
//           ),
//           title: clumsyText(booking.id,),
//           subtitle: Row(
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.calendar_month_rounded),
//                   Text(booking.id!)
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.location_on_outlined),
//                   Text(booking.id!)
//                 ],
//               ),
//             ],
//           ),
//           onTap: (){
//             Get.to(Routes.EVENT,arguments: booking.id);
//           },
//         ),
//       ),
//       Divider()
//     ],
//   );
// }
