import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/helper_controller.dart';
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

class HelperEventsPage extends StatefulWidget {
  // late Function openPage;
  HelperEventsPage({super.key});

  @override
  State<HelperEventsPage> createState() => _HelperEventsPageState();
}

class _HelperEventsPageState extends State<HelperEventsPage> {

  @override
  Widget build(BuildContext context) {
    return Material(
        color: appColors["background"]!,
        child: Column(
          children: [
            headerBar("Events you helping",parent: false),
            Expanded(
              child: AsyncBuilder<APIResponse>(
                future: Get.find<HelperController>().getMyEvents(),
                waiting: (context) {
                  return Center(
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
                                  return helperEventListTile(events[index]);
                                })
                              else
                                Center(
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                                      Text("No Events for you..."),
                                      // ClumsyFinalButton("Create +", Get.width*0.3, () {
                                      //   print(Get.find<HostController>().page.value);
                                      //   if(Get.find<HostController>().page.value!=1){
                                      //     print("setting");
                                      //     Get.find<HostController>().page.value=1;
                                      //   }
                                      //   // widget.openPage(1);
                                      //   // Get.toNamed(Routes.HOST_CREATE_EVENT);
                                      // }, false)
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
                            headerBar("All Events",parent: false),
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
            ),
          ],
        )

      );
  }
}

Widget eventListTile(Event event){

    return InkWell(
      splashColor: appColors["primary"]!,
      
      onTap: ()async{
        await Get.toNamed(Routes.HOST_EVENT,arguments: event.id);
      },
      child: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: Container(
              // width: 225,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color:appColors["primary"]!,style: BorderStyle.solid,width: 2),
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(image:  NetworkImage(event.thumbnail!,scale: 10), fit: BoxFit.cover)
                  // image: DecorationImage(image:  AssetImage("assets/images/pager.jpg"), fit: BoxFit.cover)
              ),
              child:Row(
                children: [
                  Flexible(child: Image.network(event.thumbnail!,),flex: 1,),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["primary"]!,
                        borderRadius: BorderRadius.circular(20),
                        
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(event.name,fontsize: 22,color:appColors["white"]!),
                          ),
                          
                        ],
                      ),
                    ) ,
                  )
                ],
              ),
        )
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     // width: 225,
      //     height: 200,
      //     decoration: BoxDecoration(
      //         border: Border.all(color:appColors["primary"]!,style: BorderStyle.solid,width: 2),
      //         borderRadius: BorderRadius.circular(10),
      //         image: DecorationImage(image:  NetworkImage(event.thumbnail!,scale: 10), fit: BoxFit.cover)
      //         // image: DecorationImage(image:  AssetImage("assets/images/pager.jpg"), fit: BoxFit.cover)
      //     ),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Icon(Icons.location_on_outlined,color: appColors["primary"]!,),
      //               Text(event.venue!)
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: clumsyTextLabel(event.name,fontsize: 22,color:appColors["white"]!),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Icon(Icons.calendar_month_rounded,color: appColors["primary"]!,),
      //               Text(event.eventTimestamp!)
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListTile(
          tileColor: appColors["background"]!,
          splashColor: appColors["primary"]!,
          leading: CircleAvatar(
            radius: 40,
            backgroundColor: appColors["primary"]!,
            // backgroundImage: NetworkImage("https://clumsyapp.com/images/c_logo.png",scale: 10),
            // backgroundImage: NetworkImage("https://clumsyapp.com"+event.thumbnail!,scale: 10),
            backgroundImage: NetworkImage(event.thumbnail!,scale: 10),
          ),
          title: clumsyText(event.name,),
          subtitle: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  Text(event.eventTimestamp!)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(event.venue!)
                ],
              ),
            ],
          ),
          onTap: () async{
            await Get.toNamed(Routes.HOST_EVENT,arguments: event.id);

          },
        ),
      ),
      Divider()
    ],
  );
}

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
//             backgroundImage: NetworkImage("https://clumsyapp.com"+booking.event.thumbnail!,scale: 10),
//           ),
//           title: clumsyText(booking.id,),
//           subtitle: Row(
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.calendar_month_rounded),
//                   Text(booking.id)
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.location_on_outlined),
//                   Text(booking.id)
//                 ],
//               ),
//             ],
//           ),
//           onTap: (){
//             Get.to(Routes.HOST_EVENT,arguments: booking.id);
//           },
//         ),
//       ),
//       Divider()
//     ],
//   );
// }
