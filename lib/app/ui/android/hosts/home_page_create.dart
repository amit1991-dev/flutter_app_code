import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/controller/networking/networking.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/hosts/create_event.dart';
import 'package:getx/app/ui/android/hosts/event_page.dart';
import 'package:getx/app/ui/android/hosts/profile_page.dart';
import 'package:getx/app/ui/android/widgets/loading_widget.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:simple_s3/simple_s3.dart';

import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import 'events.dart';
import 'host_bookings.dart';



class HostHomeCreateEvent extends StatefulWidget {
  HostHomeCreateEvent({super.key});

  @override
  State<HostHomeCreateEvent> createState() => _HostHomeCreateEventState();
}

class _HostHomeCreateEventState extends State<HostHomeCreateEvent> {
  // Widget fp=HostEventsPage(),sp=CreateEventPage(),tp=HostBooking();
  File? selectedFile;
  bool isLoading = false;
  bool uploaded = false;
  int i=0;
  int page=1;
  // int page=0;
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
            backgroundColor: appColors["background"]!,
            color: appColors["primary"]!,
            index: page,
            // index: Get.find<HostController>().page.value,
            height: 75,
            animationDuration: const Duration(milliseconds: 200),
            items:  <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

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

                    Icon(Icons.add, size: 30,color: appColors["background"]!,),
                    Text("New",style: TextStyle(color: appColors["background"]!),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.document_scanner_outlined, size: 30,color: appColors["background"]!,),
                    Text("Bookings",style: TextStyle(color: appColors["background"]!),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(Icons.person, size: 30,color: appColors["background"]!,),
                    Text("Profile",style: TextStyle(color: appColors["background"]!),)
                  ],
                ),
              ),
              // Icon(Icons.search, size: 30),
              // Icon(Icons.airplane_ticket, size: 30),
            ],
            onTap: (index) {
              openPage(page,index);
            },
          ),


          body: SafeArea(
            child: Builder(builder: (context){
              return CreateEventPage();
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
