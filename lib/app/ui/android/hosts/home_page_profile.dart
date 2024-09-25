import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/hosts/profile_page.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import '../../../data/model/event.dart';
import '../../../data/constants/miscellaneous.dart';

class HostHomeProfile extends StatefulWidget {
  HostHomeProfile({super.key});
  @override
  State<HostHomeProfile> createState() => _HostHomeProfileState();
}

class _HostHomeProfileState extends State<HostHomeProfile> {
  File? selectedFile;
  bool isLoading = false;
  bool uploaded = false;
  int i=0;
  int page=3;

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          extendBody: true,
          backgroundColor: appColors["background"]!,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: appColors["background"]!,
            color: appColors["primary"]!,
            index: page,
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
            ],
            onTap: (index) {
              openPage(page,index);
            },
          ),

          body: SafeArea(
            child: Builder(builder: (context){
              return ProfilePage();
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
  // void openPage(page,index)
  // {
  //   // var page = Get.find<HostController>().page.value;
  //   switch(index){
  //     case 0:
  //       if(page!=0){
  //         setState(() {
  //           Get.find<HostController>().page.value=0;
  //         });
  //       }
  //       // Get.toNamed(Routes.HOME);
  //       break;
  //     case 1:
  //       if(page!=1){
  //         setState(() {
  //           Get.find<HostController>().page.value=1;
  //         });
  //       }
  //       // Get.toNamed(Routes.SEARCH);
  //       break;
  //     case 2:
  //       if(page!=2){
  //         setState(() {
  //           Get.find<HostController>().page.value=2;
  //         });
  //       }
  //       // Get.toNamed(Routes.BOOKINGS);
  //       break;
  //     case 3:
  //       if(page!=3){
  //         setState(() {
  //           Get.find<HostController>().page.value=3;
  //         });
  //       }
  //       // Get.toNamed(Routes.BOOKINGS);
  //       break;
  //   }
  // }

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
