import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/controller/networking/networking.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/loading_widget.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:simple_s3/simple_s3.dart';
import '../../../data/constants/miscellaneous.dart';

import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/booking.dart';
import '../../../data/model/event.dart';

class EventTypeEvents extends StatefulWidget {
  // late Function openPage;
  // String eventType;
  EventTypeEvents({super.key});

  @override
  State<EventTypeEvents> createState() => _EventTypeEventsState();
}

class _EventTypeEventsState extends State<EventTypeEvents> {

  late String eventType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventType = Get.arguments as String;
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        color: appColors["background"]!,
        child: SafeArea(
          child: Column(
            children: [
              headerBar(eventType,parent: true),
              Expanded(
                child: AsyncBuilder<APIResponse>(
                  future: Get.find<HomeController>().getEventsByTypes(eventType),
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
                                    return eventListTile(events[index]);
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
              ),
            ],
          ),
        )

      );
  }
}

Widget eventListTile(Event event){
    return InkWell(
      splashColor: appColors["primary"]!,
      onTap: ()async{
        await Get.toNamed(Routes.EVENT,arguments: event.id);
      },
      child: Padding(
        padding:  EdgeInsets.all(18.0),
        child: Container(
          // width: 225,
          // height: 200,
          decoration: BoxDecoration(
              border: Border.all(color:appColors["grey"]!,style: BorderStyle.solid,width: 1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image:  NetworkImage(event.thumbnail!,scale: 10), fit: BoxFit.contain)
              // image: DecorationImage(image:  AssetImage("assets/images/pager.jpg"), fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel(event.name,fontsize: 25,color:appColors["white"]!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Icon(Icons.location_on_outlined,color: appColors["primary"]!,),
                    Text(event.venue!)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Icon(Icons.calendar_month_rounded,color: appColors["primary"]!,),
                    Text(event.eventTimestamp!)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
