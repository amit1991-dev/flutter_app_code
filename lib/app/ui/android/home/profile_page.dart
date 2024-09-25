// import 'dart:ui';

// import 'package:async_builder/async_builder.dart';
// // import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/gravity/student_controller.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:getx/app/data/model/event.dart';
// import 'package:getx/app/data/provider/host_api.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/widgets/dnd.dart';
// import 'package:getx/app/ui/android/widgets/event_phases.dart';
// import 'package:getx/app/ui/android/widgets/user_booking_list.dart';

// import '../widgets/miscellaneous.dart';
// import 'mydrawer.dart';
// import '../widgets/battery_do.dart';


// class UserProfilePage extends StatefulWidget {
//   UserProfilePage({Key? key}) : super(key: key) {}
//   @override
//   State<UserProfilePage> createState() => _State();
// }

// class _State extends State<UserProfilePage> {
//   List<String> genderLabels = ['male', 'female', 'non-binary'];
//   TextEditingController phoneController =
//       TextEditingController(text: Get.find<Authentication>().user!.phone);
//   TextEditingController emailController = TextEditingController(
//       text: Get.find<Authentication>().user!.email ?? "---");
//   TextEditingController nameController = TextEditingController(
//       text: Get.find<Authentication>().user!.name ?? "---");
//   // List<String> selectedGenres= Get.find<Authentication>().user!.genreTags;

//   int genderSelectionIndex = 0;
//   // final TextfieldTagsController _controller = TextfieldTagsController();
//   final double _distanceToField = Get.width;

//   // TextEditingController phoneController = TextEditingController(text: Get.find<Authentication>().user!.phone);
//   // TextEditingController emailController = TextEditingController(text: Get.find<Authentication>().user!.email??"Email Not Set!");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: appColors["background"]!,
//         // backgroundColor: appColors["golu"]!,

//         body: SafeArea(
//           child: scrollWidget(
//             Column(
//               children: [
//           //  headerBar("Student Profile",parent:true),
//  Container(
//     margin: EdgeInsets.all(20),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20), color: appColors['primary']),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
        
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(
//                         Icons.arrow_circle_left_rounded,
//                         size: 30,
//                         color: appColors["white"]!,
//                       )),
//                   Container(
//                       margin: const EdgeInsets.all(20),
//                       // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
//                       child: clumsyTextLabel("Student Profile",
//                           color: appColors['white']!, fontsize: 25)),
//                 ],
//               )),
      
//       ],
//     ),
//   ),

//                 // Padding(
//                 //   padding: const EdgeInsets.all(18.0),
//                 //   child: clumsyTextLabel("Student Profile",
//                 //       fontsize: 20, color: appColors['primary']),
//                 // ),

//                 Container(
//                   margin: EdgeInsets.all(20),
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: appColors['primary'],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.person,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Name",
//                             color: appColors['white'], fontsize: 14),
//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(nameController.text,
//                             color: appColors['white'], fontsize: 20),
//                       ),

//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.email_outlined,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Email",
//                             color: appColors['white'], fontsize: 14),

//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(emailController.text,
//                             color: appColors['white'], fontsize: 17),
//                       ),

//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.phone_android,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Phone",
//                             color: appColors['white'], fontsize: 14),
//                         // trailing: InkWell(
//                         //   child: Icon(Icons.edit,color: Colors.grey,),
//                         //   onTap: () async { },
//                         // ),
//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(phoneController.text,
//                             color: appColors['white'], fontsize: 20),
//                       ),

//                       // Padding(
//                       //   padding: const EdgeInsets.only(left:28.0),
//                       //   child: clumsyTextLabel("Gender",color: appColors[2]),
//                       // ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                         child: FlutterToggleTab(
//                           width: 70,

//                           // isScroll: false,
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           // borderRadius: 15,
//                           marginSelected: EdgeInsets.all(0),
//                           selectedBackgroundColors: [Colors.lightGreenAccent],
//                           selectedTextStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600),
//                           unSelectedTextStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400),
//                           labels:
//                               genderLabels.map((e) => e.toUpperCase()).toList(),
//                           // icons: [Icons.add,Icons.mic,Icons.abc],
//                           selectedIndex: genderSelectionIndex,
//                           selectedLabelIndex: (index) {
//                             // setState(() {
//                             //   genderSelectionIndex = index;
//                             // });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // ClumsyRealButton("Save", Get.width*0.6, () async {
//                 //   // print(selectedGenres);
//                 //   print(genderLabels[genderSelectionIndex].toLowerCase());
//                 //
//                 //   Map<String,dynamic> data = {"gender":genderLabels[genderSelectionIndex].toLowerCase()};
//                 //   if(await attemptSaveUserData(data)){
//                 //     Get.back();
//                 //     Get.find<Authentication>().user!.gender = genderLabels[genderSelectionIndex].toLowerCase();
//                 //     // Get.find<Authentication>().user!.genreTags =selectedGenres;
//                 //     Get.find<Authentication>().login(Get.find<Authentication>().user!);
//                 //     setState(() {
//                 //       Get.snackbar("Successful", "Updated Details");
//                 //     });
//                 //   }
//                 // }, false),

//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ListTile(
//                     onTap: () {
//                       Get.find<Authentication>().logout();
//                       Get.offAllNamed(Routes.INITIAL);
//                     },
//                     tileColor: Colors.redAccent,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     leading: Icon(
//                       Icons.logout,
//                       color: appColors['white'],
//                     ),
//                     title: clumsyTextLabel("LOGOUT",
//                         color: appColors["white"], fontsize: 14),
//                     trailing: InkWell(
//                       child: Icon(
//                         Icons.arrow_circle_right,
//                         color: Colors.white,
//                       ),
//                       onTap: () async {},
//                     ),
//                     // subtitle: clumsyTextLabel("Email"),
//                     // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//                   ),
//                 ),

//                 //golu
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ListTile(
//                     onTap: () {
                    
//                       print("disable battery optimization");
//                       Get.to(

//                       const DisableBO(),
//                       );
//                     },
//                     tileColor: Colors.redAccent,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     leading: Icon(
//                       Icons.battery_full,
//                       color: appColors['white'],
//                     ),
//                     title: clumsyTextLabel("Disable Battery Optimization",
//                         color: appColors["white"], fontsize: 14),
//                     trailing: InkWell(
//                       child: Icon(
//                         Icons.arrow_circle_right,
//                         color: Colors.white,
//                       ),
//                       onTap: () async {},
//                     ),
//                     // subtitle: clumsyTextLabel("Email"),
//                     // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//                   ),
//                 ),

//    Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ListTile(
//                     onTap: () {
                    
//                       print("DO not disturb mode");
//                       Get.to(

//                       const DND(),
//                       );
//                     },
//                     tileColor: Colors.redAccent,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     leading: Icon(
//                       Icons.do_disturb_on_rounded,
//                       color: appColors['white'],
//                     ),
//                     title: clumsyTextLabel("Do Not Disturb Mode",
//                         color: appColors["white"], fontsize: 14),
//                     trailing: InkWell(
//                       child: Icon(
//                         Icons.arrow_circle_right,
//                         color: Colors.white,
//                       ),
//                       onTap: () async {},
//                     ),
//                     // subtitle: clumsyTextLabel("Email"),
//                     // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//                   ),
//                 ),

//                 //golu

//                 // headerBar("Profile",parent: false),
//                 // Container(
//                 //   margin: EdgeInsets.all(10),
//                 //   decoration: BoxDecoration(
//                 //     // border: Border.all(color:appColors["grey"]!),
//                 //     borderRadius: BorderRadius.circular(20),
//                 //   ),
//                 //   child: GestureDetector(
//                 //     onTap: (){
//                 //       showSnackbar("Disabled", "Contact Number cannot be edited from here");
//                 //     },
//                 //     child: BackdropFilter(
//                 //       filter:  ImageFilter.blur(
//                 //         sigmaY: 0,
//                 //         sigmaX: 0,
//                 //       ),
//                 //       child: Container(
//                 //         padding: EdgeInsets.all(20),
//                 //         decoration: BoxDecoration(
//                 //           // border:  Border.all(color: appColors["grey"]!),
//                 //             color: appColors["grey"]!.withOpacity(1.0),
//                 //             borderRadius: BorderRadius.circular(15),
//                 //             boxShadow: [
//                 //               // BoxShadow(color: appColors['grey']!,blurRadius: 5,offset: Offset(5,5)),
//                 //             ]
//                 //         ),
//                 //         child: TextFormField(
//                 //           controller: phoneController,
//                 //           autofocus: false,
//                 //           keyboardType: TextInputType.number,
//                 //           enabled: false,
//                 //           // onTap: (){
//                 //           //   print("no");
//                 //           // },
//                 //           onChanged: (text){
//                 //             setState(() {
//                 //
//                 //             });
//                 //           },
//                 //           cursorColor: appColors["primary"]!,
//                 //           cursorRadius: Radius.circular(10),
//                 //           decoration: InputDecoration(
//                 //             border: InputBorder.none,
//                 //             labelText: "Phone Number",
//                 //             labelStyle: TextStyle(color: appColors["white"]!),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),

//                 // Container(
//                 //   margin: EdgeInsets.all(20),
//                 //   padding: EdgeInsets.all(20),
//                 //   decoration: BoxDecoration(
//                 //       color: appColors["primary"]!,
//                 //       borderRadius: BorderRadius.circular(20)
//                 //   ),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //     children: [
//                 //       // clumsyTextLabel("Email"),
//                 //       clumsyTextLabel(emailController.text,color: appColors["background"]!),
//                 //       // if(hi.account=="-")
//                 //       InkWell(
//                 //         child: Icon(Icons.edit,color: appColors["background"]!,),
//                 //         onTap: () async {
//                 //           var ret = await callDialog("Email Address",
//                 //               Column(
//                 //                 mainAxisAlignment: MainAxisAlignment.start,
//                 //                 children: [
//                 //                   Container(
//                 //                     margin: EdgeInsets.all(10),
//                 //                     decoration: BoxDecoration(
//                 //                       color: appColors["background"]!,
//                 //                       border: Border.all(color:appColors["grey"]!),
//                 //                       borderRadius: BorderRadius.circular(20),
//                 //                     ),
//                 //                     child: Padding(
//                 //                       padding: const EdgeInsets.all(18.0),
//                 //                       child: TextFormField(
//                 //                         controller:emailController,
//                 //                         autofocus: false,
//                 //                         style: TextStyle(color: appColors['grey']!),
//                 //                         cursorColor: appColors["primary"]!,
//                 //                         cursorRadius: Radius.circular(10),
//                 //                         decoration: InputDecoration(
//                 //                           border: InputBorder.none,
//                 //                           labelText: "User Email Address",
//                 //                           labelStyle: TextStyle(color: appColors["primary"]!),
//                 //                         ),
//                 //                       ),
//                 //                     ),
//                 //                   ),
//                 //
//                 //                   ClumsyRealButton("Save", Get.width*0.7, () async {
//                 //
//                 //                     if(await attemptSaveEmail(emailController.text)){
//                 //                       // Get.back();
//                 //                       setState(() {
//                 //                         showSnackbar("Successful", "Updated Email Address");
//                 //                       });
//                 //
//                 //                     }
//                 //
//                 //                   }, false),
//                 //                   ClumsyRealButton("Close", Get.width*0.7, () async {
//                 //                     Get.back();
//                 //                   }, false)
//                 //                 ],
//                 //               )
//                 //           );
//                 //         },
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 // MaterialButton(
//                 //   onPressed: () {
//                 //     Get.find<Authentication>().logout();
//                 //     Get.offAllNamed(Routes.INITIAL);
//                 //   },
//                 //   color: appColors["background"]!,
//                 //   textColor: Colors.red.shade900,
//                 //   child: Column(
//                 //     children: [
//                 //
//                 //       Icon(
//                 //         Icons.logout,
//                 //         size: 34,
//                 //       ),
//                 //       clumsyTextLabel("logout",fontsize: 10,color: Colors.red.shade900)
//                 //     ],
//                 //   ),
//                 //   padding: EdgeInsets.all(16),
//                 //   shape: CircleBorder(),
//                 // )

//                 // Container(
//                 //   margin: EdgeInsets.all(10),
//                 //   decoration: BoxDecoration(
//                 //     // color: Color(0xff36363D),
//                 //     border: Border.all(color:appColors["grey"]!),
//                 //     borderRadius: BorderRadius.circular(20),
//                 //   ),
//                 //   child: GestureDetector(
//                 //     onTap: (){
//                 //       showSnackbar("Disabled", "Contact Number cannot be edited from here");
//                 //
//                 //     },
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.all(18.0),
//                 //       child: TextFormField(
//                 //         controller: emailController,
//                 //         autofocus: false,
//                 //         keyboardType: TextInputType.text,
//                 //         enabled: true,
//                 //         // onTap: (){
//                 //         //   print("no");
//                 //         // },
//                 //         onChanged: (text){
//                 //           setState(() {
//                 //             // emailController.text=text;
//                 //           });
//                 //         },
//                 //         cursorColor: appColors["primary"]!,
//                 //         cursorRadius: Radius.circular(10),
//                 //         decoration: InputDecoration(
//                 //           border: InputBorder.none,
//                 //           labelText: "Email Address",
//                 //           labelStyle: TextStyle(color: appColors["primary"]!),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),

//                 // ClumsyFinalButton("Save", Get.width*0.4, () {
//                 //   // Get.find<Authentication>().logout();
//                 //   // Get.offAllNamed(Routes.INITIAL);
//                 //   showSnackbar("Info", "Email Updated");
//                 // }, false,color: appColors["blue"]!),
//                 // Divider(),
//                 // Expanded(child: UserBookingList()),
//                 // Spacer(),
//                 // ClumsyFinalButton("logout", Get.width*0.8, () {
//                 //   Get.find<Authentication>().logout();
//                 //   Get.offAllNamed(Routes.INITIAL);
//                 // }, false,color: Colors.red),
//               ],
//             ),
//           ),
//         ));
//   }

//   Future<bool> attemptSaveEmail(String text) async {
//     print("attempting to save email");
//     Map<String, dynamic> eventJson = {};
//     if (text.isEmpty) {
//       showSnackbar("Error", "Please enter a NAME for the event");
//       return false;
//     }
//     eventJson['name'] = text;
//     // eventJson['event_id'] = widget.eventId;

//     APIResponse res = await Get.find<HomeController>().setEmail(text);
//     if (res.status == TextMessages.SUCCESS) {
//       showSnackbar(TextMessages.SUCCESS, "Successfully saved Email Address");
//       Get.find<Authentication>().user!.email = text;
//       Get.find<Authentication>().login(Get.find<Authentication>().user!);
//       print("returning true");
//       return true;
//     } else {
//       showSnackbar("Error", res.info!);
//       return false;
//     }
//   }

//   Future<bool> attemptSaveUserData(Map<String, dynamic> data) async {
//     print("attempting to save data");
//     APIResponse res = await Get.find<StudentsController>().updateUser(data);
//     if (res.status == TextMessages.SUCCESS) {
//       // Get.find<Authentication>().login(Get.find<Authentication>().user!);
//       // print("returning true");
//       return true;
//     } else {
//       Get.snackbar("Error", res.info!);
//       return false;
//     }
//   }
// }


// import 'dart:ui';

// import 'package:async_builder/async_builder.dart';
// // import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/gravity/student_controller.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:getx/app/data/model/event.dart';
// import 'package:getx/app/data/provider/host_api.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/widgets/dnd.dart';
// import 'package:getx/app/ui/android/widgets/event_phases.dart';
// import 'package:getx/app/ui/android/widgets/user_booking_list.dart';

// import '../widgets/miscellaneous.dart';
// import 'mydrawer.dart';
// import '../widgets/battery_do.dart';


// class UserProfilePage extends StatefulWidget {
//   UserProfilePage({Key? key}) : super(key: key) {}
//   @override
//   State<UserProfilePage> createState() => _State();
// }

// class _State extends State<UserProfilePage> {
//   List<String> genderLabels = ['male', 'female', 'non-binary'];
//   TextEditingController phoneController =
//       TextEditingController(text: Get.find<Authentication>().user!.phone);
//   TextEditingController emailController = TextEditingController(
//       text: Get.find<Authentication>().user!.email ?? "---");
//   TextEditingController nameController = TextEditingController(
//       text: Get.find<Authentication>().user!.name ?? "---");
//   // List<String> selectedGenres= Get.find<Authentication>().user!.genreTags;

//   int genderSelectionIndex = 0;
//   // final TextfieldTagsController _controller = TextfieldTagsController();
//   final double _distanceToField = Get.width;

//   // TextEditingController phoneController = TextEditingController(text: Get.find<Authentication>().user!.phone);
//   // TextEditingController emailController = TextEditingController(text: Get.find<Authentication>().user!.email??"Email Not Set!");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: appColors["background"]!,
//         // backgroundColor: appColors["golu"]!,

//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//           //  headerBar("Student Profile",parent:true),
//  Container(
//     margin: EdgeInsets.all(20),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20), color: appColors['primary']),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
        
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         // Get.toNamed(Routes.HOME_PAGE);
//                         Get.back();
//                       },
//                       icon: Icon(
//                         Icons.arrow_circle_left_rounded,
//                         size: 25,
//                         color: appColors["white"]!,
//                       )),
//                   Container(
//                       margin: const EdgeInsets.all(20),
//                       // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
//                       child: clumsyTextLabel("Student Profile",
//                           color: appColors['white']!, fontsize: 20)),
//                 ],
//               )),
      
//       ],
//     ),
//   ),

//                 // Padding(
//                 //   padding: const EdgeInsets.all(18.0),
//                 //   child: clumsyTextLabel("Student Profile",
//                 //       fontsize: 20, color: appColors['primary']),
//                 // ),

//                 Container(
//                   margin: EdgeInsets.all(20),
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: appColors['primary'],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.person,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Name",
//                             color: appColors['white'], fontsize: 14),
//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(nameController.text,
//                             color: appColors['white'], fontsize: 20),
//                       ),

//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.email_outlined,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Email",
//                             color: appColors['white'], fontsize: 14),

//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(emailController.text,
//                             color: appColors['white'], fontsize: 17),
//                       ),

//                       ListTile(
//                         tileColor: Colors.white,
//                         leading: Icon(
//                           Icons.phone_android,
//                           color: appColors['white'],
//                         ),
//                         title: clumsyTextLabel("Phone",
//                             color: appColors['white'], fontsize: 14),
//                         // trailing: InkWell(
//                         //   child: Icon(Icons.edit,color: Colors.grey,),
//                         //   onTap: () async { },
//                         // ),
//                         // subtitle: clumsyTextLabel("Email"),
//                         subtitle: clumsyTextLabel(phoneController.text,
//                             color: appColors['white'], fontsize: 20),
//                       ),

//                       // Padding(
//                       //   padding: const EdgeInsets.only(left:28.0),
//                       //   child: clumsyTextLabel("Gender",color: appColors[2]),
//                       // ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                         child: FlutterToggleTab(
//                           width: 70,

//                           // isScroll: false,
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           // borderRadius: 15,
//                           marginSelected: EdgeInsets.all(0),
//                           selectedBackgroundColors: [Colors.lightGreenAccent],
//                           selectedTextStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600),
//                           unSelectedTextStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400),
//                           labels:
//                               genderLabels.map((e) => e.toUpperCase()).toList(),
//                           // icons: [Icons.add,Icons.mic,Icons.abc],
//                           selectedIndex: genderSelectionIndex,
//                           selectedLabelIndex: (index) {
//                             // setState(() {
//                             //   genderSelectionIndex = index;
//                             // });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // ClumsyRealButton("Save", Get.width*0.6, () async {
//                 //   // print(selectedGenres);
//                 //   print(genderLabels[genderSelectionIndex].toLowerCase());
//                 //
//                 //   Map<String,dynamic> data = {"gender":genderLabels[genderSelectionIndex].toLowerCase()};
//                 //   if(await attemptSaveUserData(data)){
//                 //     Get.back();
//                 //     Get.find<Authentication>().user!.gender = genderLabels[genderSelectionIndex].toLowerCase();
//                 //     // Get.find<Authentication>().user!.genreTags =selectedGenres;
//                 //     Get.find<Authentication>().login(Get.find<Authentication>().user!);
//                 //     setState(() {
//                 //       Get.snackbar("Successful", "Updated Details");
//                 //     });
//                 //   }
//                 // }, false),

//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ListTile(
//                     onTap: () {
//                       Get.find<Authentication>().logout();
//                       Get.offAllNamed(Routes.INITIAL);
//                     },
//                     tileColor: Colors.redAccent,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     leading: Icon(
//                       Icons.logout,
//                       color: appColors['white'],
//                     ),
//                     title: clumsyTextLabel("Logout",
//                         color: appColors["white"], fontsize: 14),
//                     trailing: InkWell(
//                       child: Icon(
//                         Icons.arrow_circle_right,
//                         color: Colors.white,
//                       ),
//                       onTap: () async {},
//                     ),
//                     // subtitle: clumsyTextLabel("Email"),
//                     // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//                   ),
//                 ),

//                 //golu
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ListTile(
//                     onTap: () {
                    
//                       print("disable battery optimization");
//                       Get.to(

//                       const DisableBO() as Widget Function(),
//                       );
//                     },
//                     tileColor: Colors.redAccent,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     leading: Icon(
//                       Icons.battery_full,
//                       color: appColors['white'],
//                     ),
//                     title: clumsyTextLabel("Disable Battery Optimization",
//                         color: appColors["white"], fontsize: 14),
//                     trailing: InkWell(
//                       child: Icon(
//                         Icons.arrow_circle_right,
//                         color: Colors.white,
//                       ),
//                       onTap: () async {},
//                     ),
//                     // subtitle: clumsyTextLabel("Email"),
//                     // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//                   ),
//                 ),

//   //  Padding(
//   //                 padding: const EdgeInsets.all(18.0),
//   //                 child: ListTile(
//   //                   onTap: () {
                    
//   //                     print("DO not disturb mode");
//   //                     Get.to(

//   //                     const DND(),
//   //                     );
//   //                   },
//   //                   tileColor: Colors.redAccent,
//   //                   shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(20)),
//   //                   leading: Icon(
//   //                     Icons.do_disturb_on_rounded,
//   //                     color: appColors['white'],
//   //                   ),
//   //                   title: clumsyTextLabel("Do Not Disturb Mode",
//   //                       color: appColors["white"], fontsize: 14),
//   //                   trailing: InkWell(
//   //                     child: Icon(
//   //                       Icons.arrow_circle_right,
//   //                       color: Colors.white,
//   //                     ),
//   //                     onTap: () async {},
//   //                   ),
//   //                   // subtitle: clumsyTextLabel("Email"),
//   //                   // subtitle: clumsyTextLabel(phoneController.text,color: appColors[2],fontsize: 20),
//   //                 ),
//   //               ),
             
//               ],
//             ),
//           ),
//         ));
//   }

//   Future<bool> attemptSaveEmail(String text) async {
//     print("attempting to save email");
//     Map<String, dynamic> eventJson = {};
//     if (text.isEmpty) {
//       showSnackbar("Error", "Please enter a NAME for the event");
//       return false;
//     }
//     eventJson['name'] = text;
//     // eventJson['event_id'] = widget.eventId;

//     APIResponse res = await Get.find<HomeController>().setEmail(text);
//     if (res.status == TextMessages.SUCCESS) {
//       showSnackbar(TextMessages.SUCCESS, "Successfully saved Email Address");
//       Get.find<Authentication>().user!.email = text;
//       Get.find<Authentication>().login(Get.find<Authentication>().user!);
//       print("returning true");
//       return true;
//     } else {
//       showSnackbar("Error", res.info!);
//       return false;
//     }
//   }

//   Future<bool> attemptSaveUserData(Map<String, dynamic> data) async {
//     print("attempting to save data");
//     APIResponse res = await Get.find<StudentsController>().updateUser(data);
//     if (res.status == TextMessages.SUCCESS) {
//       // Get.find<Authentication>().login(Get.find<Authentication>().user!);
//       // print("returning true");
//       return true;
//     } else {
//       Get.snackbar("Error", res.info!);
//       return false;
//     }
//   }
// }


// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/authentication/authentication.dart';
// import 'package:getx/app/controller/gravity/student_controller.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/widgets/dnd.dart';

// import '../widgets/miscellaneous.dart';
// import '../widgets/battery_do.dart';

// class UserProfilePage extends StatefulWidget {
//   UserProfilePage({Key? key}) : super(key: key);

//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage> {
//   List<String> genderLabels = ['male', 'female', 'non-binary'];
//   late TextEditingController phoneController;
//   late TextEditingController emailController;
//   late TextEditingController nameController;

//   int genderSelectionIndex = 0;
//   final double _distanceToField = Get.width;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers after authentication.user is available
//     phoneController = TextEditingController(
//         text: Get.find<Authentication>().user?.phone ?? '');
//     emailController = TextEditingController(
//         text: Get.find<Authentication>().user?.email ?? '---');
//     nameController = TextEditingController(
//         text: Get.find<Authentication>().user?.name ?? '---');
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to prevent memory leaks
//     phoneController.dispose();
//     emailController.dispose();
//     nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColors["background"]!,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: appColors['primary'],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Get.back();
//                             },
//                             icon: Icon(
//                               Icons.arrow_circle_left_rounded,
//                               size: 25,
//                               color: appColors["white"]!,
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(20),
//                             child: clumsyTextLabel("Student Profile",
//                                 color: appColors['white']!, fontsize: 20),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: appColors['primary'],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       tileColor: Colors.white,
//                       leading: Icon(
//                         Icons.person,
//                         color: appColors['white'],
//                       ),
//                       title: clumsyTextLabel("Name",
//                           color: appColors['white'], fontsize: 14),
//                       subtitle: clumsyTextLabel(nameController.text,
//                           color: appColors['white'], fontsize: 20),
//                     ),
//                     ListTile(
//                       tileColor: Colors.white,
//                       leading: Icon(
//                         Icons.email_outlined,
//                         color: appColors['white'],
//                       ),
//                       title: clumsyTextLabel("Email",
//                           color: appColors['white'], fontsize: 14),
//                       subtitle: clumsyTextLabel(emailController.text,
//                           color: appColors['white'], fontsize: 17),
//                     ),
//                     ListTile(
//                       tileColor: Colors.white,
//                       leading: Icon(
//                         Icons.phone_android,
//                         color: appColors['white'],
//                       ),
//                       title: clumsyTextLabel("Phone",
//                           color: appColors['white'], fontsize: 14),
//                       subtitle: clumsyTextLabel(phoneController.text,
//                           color: appColors['white'], fontsize: 20),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                       child: FlutterToggleTab(
//                         width: 70,
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         marginSelected: EdgeInsets.all(0),
//                         selectedBackgroundColors: [Colors.lightGreenAccent],
//                         selectedTextStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         unSelectedTextStyle: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         labels: genderLabels.map((e) => e.toUpperCase()).toList(),
//                         selectedIndex: genderSelectionIndex,
//                         selectedLabelIndex: (index) {
//                           // Handle gender selection change
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: ListTile(
//                   onTap: () {
//                     Get.find<Authentication>().logout();
//                     Get.offAllNamed(Routes.INITIAL);
//                   },
//                   tileColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   leading: Icon(
//                     Icons.logout,
//                     color: appColors['white'],
//                   ),
//                   title: clumsyTextLabel("Logout",
//                       color: appColors["white"], fontsize: 14),
//                   trailing: InkWell(
//                     child: Icon(
//                       Icons.arrow_circle_right,
//                       color: Colors.white,
//                     ),
//                     onTap: () async {},
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: ListTile(
//                   onTap: () {
//                     print("disable battery optimization");
//                     Get.to(
//                       () => const DisableBO(),
//                     );
//                   },
//                   tileColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   leading: Icon(
//                     Icons.battery_full,
//                     color: appColors['white'],
//                   ),
//                   title: clumsyTextLabel("Disable Battery Optimization",
//                       color: appColors["white"], fontsize: 14),
//                   trailing: InkWell(
//                     child: Icon(
//                       Icons.arrow_circle_right,
//                       color: Colors.white,
//                     ),
//                     onTap: () async {},
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> attemptSaveEmail(String text) async {
//     print("attempting to save email");
//     Map<String, dynamic> eventJson = {};
//     if (text.isEmpty) {
//       showSnackbar("Error", "Please enter a NAME for the event");
//       return false;
//     }
//     eventJson['name'] = text;

//     APIResponse res = await Get.find<HomeController>().setEmail(text);
//     if (res.status == TextMessages.SUCCESS) {
//       showSnackbar(TextMessages.SUCCESS, "Successfully saved Email Address");
//       Get.find<Authentication>().user?.email = text;
//       Get.find<Authentication>().login(Get.find<Authentication>().user!);
//       print("returning true");
//       return true;
//     } else {
//       showSnackbar("Error", res.info!);
//       return false;
//     }
//   }

//   Future<bool> attemptSaveUserData(Map<String, dynamic> data) async {
//     print("attempting to save data");
//     APIResponse res = await Get.find<StudentsController>().updateUser(data);
//     if (res.status == TextMessages.SUCCESS) {
//       return true;
//     } else {
//       Get.snackbar("Error", res.info!);
//       return false;
//     }
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/dnd.dart';

import '../widgets/miscellaneous.dart';
import '../widgets/battery_do.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<String> genderLabels = ['male', 'female', 'non-binary'];
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController nameController;

  int genderSelectionIndex = 0;
  final double _distanceToField = Get.width;

  @override
  void initState() {
    super.initState();
    // Initialize controllers after authentication.user is available
    phoneController = TextEditingController(
        text: Get.find<Authentication>().user?.phone ?? '');
    emailController = TextEditingController(
        text: Get.find<Authentication>().user?.email ?? '---');
    nameController = TextEditingController(
        text: Get.find<Authentication>().user?.name ?? '---');
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: appColors['primary'],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_circle_left_rounded,
                              size: 25,
                              color: appColors["white"]!,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: clumsyTextLabel("Student Profile",
                                color: appColors['white']!, fontsize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appColors['primary'],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.person,
                        color: appColors['white'],
                      ),
                      title: clumsyTextLabel("Name",
                          color: appColors['white'], fontsize: 14),
                      subtitle: clumsyTextLabel(nameController.text,
                          color: appColors['white'], fontsize: 20),
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.email_outlined,
                        color: appColors['white'],
                      ),
                      title: clumsyTextLabel("Email",
                          color: appColors['white'], fontsize: 14),
                      subtitle: clumsyTextLabel(emailController.text,
                          color: appColors['white'], fontsize: 17),
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: Icon(
                        Icons.phone_android,
                        color: appColors['white'],
                      ),
                      title: clumsyTextLabel("Phone",
                          color: appColors['white'], fontsize: 14),
                      subtitle: clumsyTextLabel(phoneController.text,
                          color: appColors['white'], fontsize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FlutterToggleTab(
                        width: 70,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        marginSelected: EdgeInsets.all(0),
                        selectedBackgroundColors: [Colors.lightGreenAccent],
                        selectedTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        unSelectedTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        labels: genderLabels.map((e) => e.toUpperCase()).toList(),
                        selectedIndex: genderSelectionIndex,
                        selectedLabelIndex: (index) {
                          // Handle gender selection change
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListTile(
                  onTap: () {
                    Get.find<Authentication>().logout();
                    Get.offAllNamed(Routes.INITIAL);
                  },
                  tileColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: appColors['white'],
                  ),
                  title: clumsyTextLabel("Logout",
                      color: appColors["white"], fontsize: 14),
                  trailing: InkWell(
                    child: Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                    ),
                    onTap: () async {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListTile(
                  onTap: () {
                    print("disable battery optimization");
                    Get.to(
                      () => const DisableBO(),
                    );
                  },
                  tileColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(
                    Icons.battery_full,
                    color: appColors['white'],
                  ),
                  title: clumsyTextLabel("Disable Battery Optimization",
                      color: appColors["white"], fontsize: 14),
                  trailing: InkWell(
                    child: Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                    ),
                    onTap: () async {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> attemptSaveEmail(String text) async {
    print("attempting to save email");
    Map<String, dynamic> eventJson = {};
    if (text.isEmpty) {
      showSnackbar("Error", "Please enter a NAME for the event");
      return false;
    }
    eventJson['name'] = text;

    APIResponse res = await Get.find<HomeController>().setEmail(text);
    if (res.status == TextMessages.SUCCESS) {
      showSnackbar(TextMessages.SUCCESS, "Successfully saved Email Address");
      Get.find<Authentication>().user?.email = text;
      Get.find<Authentication>().login(Get.find<Authentication>().user!);
      print("returning true");
      return true;
    } else {
      showSnackbar("Error", res.info!);
      return false;
    }
  }

  Future<bool> attemptSaveUserData(Map<String, dynamic> data) async {
    print("attempting to save data");
    APIResponse res = await Get.find<StudentsController>().updateUser(data);
    if (res.status == TextMessages.SUCCESS) {
      return true;
    } else {
      Get.snackbar("Error", res.info!);
      return false;
    }
  }
}
