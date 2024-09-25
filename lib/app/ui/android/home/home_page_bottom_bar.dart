// import 'dart:io';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/ui/android/home/gravity/my_batch_page.dart';
// import '../../../routes/app_pages.dart';
// import 'gravity/my_batches.dart';
// import 'home_page.dart';
// import 'profile_page.dart';
// import 'search_events.dart';
// import '../widgets/miscellaneous.dart';
// import '../../../data/model/event.dart';
// import '../../../data/constants/miscellaneous.dart';

// class HomePageBottomBar extends StatefulWidget {
//   HomePageBottomBar({super.key});

//   @override
//   State<HomePageBottomBar> createState() => _HomePageBottomBarState();
// }

// class _HomePageBottomBarState extends State<HomePageBottomBar> {
//   List<Widget> pages=[MyBatches(),HomePage(),UserProfilePage(),];
//   File? selectedFile;
//   int pageIndex=1;
//   bool isLoading = false;
//   bool uploaded = false;
//   int i=0;
//   // int page=0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBody: true,
//         backgroundColor: appColors["background"]!,
//         bottomNavigationBar: CurvedNavigationBar(
//           // backgroundColor: appColors["primary"]!.shade700,
//           backgroundColor: appColors["background"]!,
//           color: appColors["primary"]!,
//           index: pageIndex,
//           // index: Get.find<HostController>().page.value,
//           height: 65,
//           animationDuration: const Duration(milliseconds: 400),
//           items:  <Widget>[

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Icon(Icons.home, size: 30,color:  appColors["white"]!),
//                   // Text("Home",style: TextStyle(color:  appColors["white"]!),),
//                   Icon(Icons.video_collection_outlined, size: 30,color: appColors["background"]!,),
//                   Text("Batches",style: TextStyle(color: appColors["background"]!),)
//                 ],
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Icon(Icons.home, size: 30,color:  appColors["white"]!),
//                   // Text("Home",style: TextStyle(color:  appColors["white"]!),),
//                   Icon(Icons.home, size: 30,color: appColors["background"]!,),
//                   Text("Home",style: TextStyle(color: appColors["background"]!),)
//                 ],
//               ),
//             ),

//             // Padding(
//             //   padding: const EdgeInsets.only(top:10.0),
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //
//             //       Icon(Icons.document_scanner_outlined, size: 30,color: appColors["grey"]!,),
//             //       Text("Bookings",style: TextStyle(color: appColors["grey"]!),)
//             //     ],
//             //   ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Icon(Icons.person, size: 30,color:  appColors["white"]!),
//                   // Text("Profile",style: TextStyle(color:  appColors["white"]!),),
//                   Icon(Icons.person, size: 30,color: appColors["background"]!),
//                   Text("Profile",style: TextStyle(color: appColors["background"]!),)
//                 ],
//               ),
//             ),

//             // Icon(Icons.search, size: 30),
//             // Icon(Icons.airplane_ticket, size: 30),
//           ],
//           onTap: (index) {
//             //openPage(page,index);
//             pageIndex=index;
//             setState(() {

//             });
//           },
//         ),

//         body: SafeArea(
//           child: Builder(builder: (context){
//             return pages.elementAt(pageIndex);

//           },
//           ),
//         ),
//       ),
//     );
//   }

// }
// //
// // void openPage(page,index)
// // {
// //   // var page = Get.find<HostController>().page.value;
// //   switch(index){
// //     case 0:
// //       if(page!=0){
// //         Get.toNamed(Routes.HOST_HOME);
// //       }
// //       // Get.toNamed(Routes.HOME);
// //       break;
// //     case 1:
// //       if(page!=1){
// //         Get.toNamed(Routes.HOST_CREATE_EVENT);
// //       }
// //       // Get.toNamed(Routes.SEARCH);
// //       break;
// //     case 2:
// //       if(page!=2){
// //         Get.toNamed(Routes.HOST_BOOKINGS);
// //       }
// //       // Get.toNamed(Routes.BOOKINGS);
// //       break;
// //     case 3:
// //       if(page!=3){
// //         Get.toNamed(Routes.HOST_PROFILE);
// //       }
// //       // Get.toNamed(Routes.BOOKINGS);
// //       break;
// //   }
// // }

// Widget eventListTile(Event event){
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
//             backgroundImage: NetworkImage("https://clumsyapp.com"+event.thumbnail!,scale: 10),
//           ),
//           title: clumsyText(event.name,),
//           subtitle: Row(
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.calendar_month_rounded),
//                   Text(event.eventTimestamp!)
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.location_on_outlined),
//                   Text(event.venue!)
//                 ],
//               ),
//             ],
//           ),
//           onTap: (){
//             Get.to(Routes.HOST_EVENT,arguments: event.id);
//           },
//         ),
//       ),
//       Divider()
//     ],
//   );
// }

// import 'dart:io';
// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:getx/app/ui/android/home/gravity/my_batch_page.dart';
// import '../../../routes/app_pages.dart';
// // import 'gravity/my_batches.dart';
// import 'home_page.dart';
// // import 'profile_page.dart';
// // import 'search_events.dart';
// // import '../widgets/miscellaneous.dart';
// // import '../../../data/model/event.dart';
// import '../../../data/constants/miscellaneous.dart';


// class HomePageBottomBar extends StatefulWidget {
//   const HomePageBottomBar({super.key});

//   @override
//   State<HomePageBottomBar> createState() => _HomePageBottomBarState();
// }

// class _HomePageBottomBarState extends State<HomePageBottomBar> {
//   List<Widget> pages = [
//     // MyBatches(),
//     MyBatches(),
//     const HomePage(),
//     UserProfilePage(),
//     // MenuPage(),
//   ];
//   File? selectedFile;
//   int pageIndex = 1;
//   bool isLoading = false;
//   bool uploaded = false;
//   int i = 0;
//   // int page=0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//     child: Scaffold(
//     // return Scaffold(
//       // extendBody: true,
//       backgroundColor: appColors["background"]!,
//       body: pages.elementAt(pageIndex), // Add this line
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: appColors["primary"]!,
//         // selectedItemColor: appColors["black"]!,
//         selectedItemColor: appColors["golu-grey"]!,
//         // unselectedItemColor: appColors["golu-grey"]!,
//         // unselectedItemColor: appColors["white"]!,
//         unselectedItemColor: appColors["golu"]!,
//         // elevation: 5,
//         currentIndex: pageIndex,
//         onTap: (index) {
//           setState(() {
//             pageIndex = index;
//           });
//         },
//         items: const [
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.book_online_outlined),
//           //   label: 'Study',
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.video_collection_outlined),
//             label: 'Batches',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.menu),
//           //   label: 'Menu',
//           // ),
//         ],
//       ),
//     ),
//     );
//   }

//   Widget eventListTile(Event event) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: ListTile(
//             tileColor: appColors["background"]!,
//             splashColor: appColors["primary"]!,
//             leading: CircleAvatar(
//               radius: 40,
//               backgroundColor: appColors["primary"]!,
//               backgroundImage: NetworkImage(
//                   "https://clumsyapp.com" + event.thumbnail!,
//                   scale: 10),
//             ),
//             title: clumsyText(
//               event.name,
//             ),
//             subtitle: Row(
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_month_rounded),
//                     Text(event.eventTimestamp!)
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined),
//                     Text(event.venue!)
//                   ],
//                 ),
//               ],
//             ),
//             onTap: () {
//               Get.to(Routes.HOST_EVENT, arguments: event.id);
//             },
//           ),
//         ),
//         const Divider()
//       ],
//     );
//   }
// }

// class HomePageBottomBar extends StatefulWidget {
//   const HomePageBottomBar({super.key});

//   @override
//   State<HomePageBottomBar> createState() => _HomePageBottomBarState();
// }

// class _HomePageBottomBarState extends State<HomePageBottomBar> {
//   List<Widget> pages = [
//     MyBatches(),
//     const HomePage(),
//     UserProfilePage(),
//   ];
//   File? selectedFile;
//   int pageIndex = 1;
//   bool isLoading = false;
//   bool uploaded = false;
//   int i = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: () async {
//           if (pageIndex != 1) { // Assuming the home page is at index 1
//             setState(() {
//               pageIndex = 1; // Navigate to the home page
//             });
//             return false; // Prevent the default back action
//           }
//           return true; // Allow back navigation if already at home page
//         },
//         child: Scaffold(
//           backgroundColor: appColors["background"]!,
//           body: pages.elementAt(pageIndex),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: appColors["primary"]!,
//             selectedItemColor: appColors["golu-grey"]!,
//             unselectedItemColor: appColors["golu"]!,
//             currentIndex: pageIndex,
//             onTap: (index) {
//               setState(() {
//                 pageIndex = index;
//               });
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.video_collection_outlined),
//                 label: 'Batches',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget eventListTile(Event event) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: ListTile(
//             tileColor: appColors["background"]!,
//             splashColor: appColors["primary"]!,
//             leading: CircleAvatar(
//               radius: 40,
//               backgroundColor: appColors["primary"]!,
//               backgroundImage: NetworkImage(
//                   "https://clumsyapp.com" + event.thumbnail!,
//                   scale: 10),
//             ),
//             title: clumsyText(
//               event.name,
//             ),
//             subtitle: Row(
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_month_rounded),
//                     Text(event.eventTimestamp!)
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined),
//                     Text(event.venue!)
//                   ],
//                 ),
//               ],
//             ),
//             onTap: () {
//               Get.to(Routes.HOST_EVENT, arguments: event.id);
//             },
//           ),
//         ),
//         const Divider()
//       ],
//     );
//   }
// }









import 'dart:io';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:getx/app/ui/android/home/gravity/my_batch_page.dart';
import '../../../routes/app_pages.dart';
// import 'gravity/my_batches.dart';
import 'home_page.dart';
// import 'profile_page.dart';
// import 'search_events.dart';
// import '../widgets/miscellaneous.dart';
// import '../../../data/model/event.dart';
import '../../../data/constants/miscellaneous.dart';




class HomePageBottomBar extends StatefulWidget {
  HomePageBottomBar({super.key}){}

  @override
  State<HomePageBottomBar> createState() => _HomePageBottomBarState();
}

class _HomePageBottomBarState extends State<HomePageBottomBar> {
  // List<Widget> pages = [
  //   // MyBatches(),
  //   MyBatches(),
  //   const HomePage(),
  //   UserProfilePage(),
  //   // MenuPage(),
  // ];
  File? selectedFile;
  // int pageIndex = 1; // Default to home page
  bool isLoading = false;
  bool uploaded = false;
  int i = 0;

  final _pageIndex = 1.obs; // Use an Obx to manage pageIndex with GetX

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: WillPopScope(
      //   onWillPop: () async {
      //     if (_pageIndex.value != 1) { // Assuming the home page is at index 1
      //       _pageIndex.value = 1; // Navigate to the home page
      //       return false; // Prevent the default back action
      //     }
      //     return true; // Allow back navigation if already at home page
      //   },
        child: Scaffold(
          backgroundColor: appColors["background"]!,
          // body: pages.elementAt(pageIndex),
          // body:  pageIndex == 0 ? MyBatches(): 
          //       pageIndex == 1 ? const HomePage() : 
          //       pageIndex == 2 ? UserProfilePage() : Container(), 
          body: Obx(() {
            if (_pageIndex.value == 0) {
              Get.toNamed(Routes.My_Batches); // Navigate to MyBatches
              return const HomePage(); 
            } else if (_pageIndex.value == 1) {
              return const HomePage();
            } else if (_pageIndex.value == 2) {
              Get.toNamed(Routes.PROFILE); // Navigate to Profile
              return const HomePage(); 
            } else {
              return const HomePage();
            }
          }),// Add this line
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: appColors["primary"]!,
            selectedItemColor: appColors["golu-grey"]!,
            unselectedItemColor: appColors["golu"]!,
            currentIndex: _pageIndex.value, // Use _pageIndex.value
            onTap: (index) {
              _pageIndex.value = index; // Update _pageIndex.value
              if (index == 0) {
                Get.toNamed(Routes.My_Batches);
              }else if (index == 2) {
                Get.toNamed(Routes.PROFILE);
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.video_collection_outlined),
                label: 'Batches',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      // ),
    );
  }

}
