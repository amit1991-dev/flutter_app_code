// import 'dart:io';

// import 'package:async_builder/async_builder.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/controller/networking/networking.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/hosts/create_event.dart';
// import 'package:getx/app/ui/android/hosts/event_page.dart';
// import 'package:getx/app/ui/android/hosts/profile_page.dart';
// import 'package:getx/app/ui/android/widgets/loading_widget.dart';
// import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:simple_s3/simple_s3.dart';

// import '../../../data/constants/errors.dart';
// import '../../../data/constants/miscellaneous.dart';
// import '../../../data/model/api_response.dart';
// import '../../../data/model/event.dart';
// import 'events.dart';
// import 'host_bookings.dart';


// class HostHomeBookings extends StatefulWidget {
//   HostHomeBookings({super.key});

//   @override
//   State<HostHomeBookings> createState() => _HostHomeBookingsState();
// }

// class _HostHomeBookingsState extends State<HostHomeBookings> {
//   SimpleS3 _simpleS3 = SimpleS3();
//   // Widget fp=HostEventsPage(),sp=CreateEventPage(),tp=HostBooking();
//   File? selectedFile;
//   bool isLoading = false;
//   bool uploaded = false;
//   int i=0;
//   int page=2;
//   // int page=0;
//   @override
//   void initState() {


//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//           extendBody: true,
//           backgroundColor: appColors["background"]!,
//           body: SafeArea(
//             child: Builder(builder: (context){
//               return const HostBookings();
//             },
//             ),
//           ),
//         );
//   }
// }


// //
// // Widget eventListTile(Event event){
// //   return Column(
// //     children: [
// //       Padding(
// //         padding: const EdgeInsets.all(18.0),
// //         child: ListTile(
// //           tileColor: appColors["background"]!,
// //           splashColor: appColors["primary"]!,
// //           leading: CircleAvatar(
// //             radius: 40,
// //             backgroundColor: appColors["primary"]!,
// //             backgroundImage: NetworkImage("https://clumsyapp.com"+event.thumbnail!,scale: 10),
// //           ),
// //           title: clumsyText(event.name,),
// //           subtitle: Row(
// //             children: [
// //               Row(
// //                 children: [
// //                   Icon(Icons.calendar_month_rounded),
// //                   Text(event.eventTimestamp!)
// //                 ],
// //               ),
// //               Row(
// //                 children: [
// //                   Icon(Icons.location_on_outlined),
// //                   Text(event.venue!)
// //                 ],
// //               ),
// //             ],
// //           ),
// //           onTap: (){
// //             Get.to(Routes.HOST_EVENT,arguments: event.id);
// //           },
// //         ),
// //       ),
// //       Divider()
// //     ],
// //   );
// // }
