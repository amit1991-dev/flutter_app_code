import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'profile_page.dart';
import 'package:getx/app/ui/android/hosts/create_event.dart';
import 'package:getx/app/ui/android/hosts/profile_page.dart';
import '../widgets/miscellaneous.dart';
import '../../../data/model/event.dart';
import 'events.dart';
import '../../../data/constants/miscellaneous.dart';


class HelperHomePage extends StatefulWidget {
  HelperHomePage({super.key});

  @override
  State<HelperHomePage> createState() => _HelperHomePageState();
}

class _HelperHomePageState extends State<HelperHomePage> {
  // Widget fp=HostEventsPage(),sp=CreateEventPage(),tp=HostBooking();
  int pageIndex=0;
  List<Widget> pages=[HelperEventsPage(),HelperProfilePage()];
  File? selectedFile;
  bool isLoading = false;
  bool uploaded = false;
  int i=0;
  int page=0;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: appColors["background"]!,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: appColors["primary"]!,
        index: pageIndex,
        // index: Get.find<HostController>().page.value,
        height: 75,
        animationDuration: const Duration(milliseconds: 200),
        items:  <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //
          //       // Icon(Icons.search, size: 30,color:  appColors["white"]!),
          //       // Text("Search",style: TextStyle(color:  appColors["white"]!),)
          //       Icon(Icons.add, size: 30,color:  appColors["background"]!),
          //       Text("New",style: TextStyle(color:  appColors["background"]!),)
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.home, size: 30,color:  appColors["white"]!),
                // Text("Home",style: TextStyle(color:  appColors["white"]!),),
                Icon(Icons.home, size: 30,color: appColors["background"]!,),
                Text("Home",style: TextStyle(color: appColors["background"]!),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.home, size: 30,color:  appColors["white"]!),
                // Text("Home",style: TextStyle(color:  appColors["white"]!),),
                Icon(Icons.home, size: 30,color: appColors["background"]!,),
                Text("Profile",style: TextStyle(color: appColors["background"]!),)
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top:10.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //
          //       Icon(Icons.document_scanner_outlined, size: 30,color: appColors["grey"]!,),
          //       Text("Bookings",style: TextStyle(color: appColors["grey"]!),)
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Icon(Icons.person, size: 30,color:  appColors["white"]!),
          //       // Text("Profile",style: TextStyle(color:  appColors["white"]!),),
          //       Icon(Icons.person, size: 30,color: appColors["background"]!),
          //       Text("Profile",style: TextStyle(color: appColors["background"]!),)
          //     ],
          //   ),
          // ),
          // Icon(Icons.search, size: 30),
          // Icon(Icons.airplane_ticket, size: 30),
        ],
        onTap: (index) {
          pageIndex=index;
          setState(() {

          });
          // openPage(page,index);
        },
      ),


      body: SafeArea(
        child: Builder(builder: (context){
          return pages[pageIndex];
          // return HostEventsPage();
          // var page=Get.find<HostController>().page.value;
          // int page=0;
          // if(page==0)
          // {
          //   return fp;
          // }
          // else if(page==1)
          // {
          //   return sp;
          // }
          // else if(page==2)
          // {
          //   return tp;
          // }
          // else
          // {
          //   return ProfilePage();
          // }
        },
        ),
      ),
    );
  }

}
//
// void openPage(page,index)
// {
//   // var page = Get.find<HostController>().page.value;
//   switch(index){
//     case 0:
//       if(page!=0){
//         Get.toNamed(Routes.HOST_HOME);
//       }
//       // Get.toNamed(Routes.HOME);
//       break;
//     case 1:
//       if(page!=1){
//         Get.toNamed(Routes.HOST_CREATE_EVENT);
//       }
//       // Get.toNamed(Routes.SEARCH);
//       break;
//     case 2:
//       if(page!=2){
//         Get.toNamed(Routes.HOST_BOOKINGS);
//       }
//       // Get.toNamed(Routes.BOOKINGS);
//       break;
//     case 3:
//       if(page!=3){
//         Get.toNamed(Routes.HOST_PROFILE);
//       }
//       // Get.toNamed(Routes.BOOKINGS);
//       break;
//   }
// }

Widget eventListTile(Event event){
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
            backgroundImage: NetworkImage("https://clumsyapp.com"+event.thumbnail!,scale: 10),
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
          onTap: (){
            Get.to(Routes.HOST_EVENT as Widget Function(),arguments: event.id);
          },
        ),
      ),
      Divider()
    ],
  );
}
