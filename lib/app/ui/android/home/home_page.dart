// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// // import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// // import 'package:getx/app/controller/authentication/authentication.dart';
// // import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// // import 'package:getx/app/data/constants/request_paths.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/home/mydrawer.dart';
// // import 'package:getx/app/ui/android/home/gravity/batch_page.dart';
// // import 'package:getx/app/ui/android/home/gravity/my_batches.dart';
// // import 'package:getx/app/ui/android/widgets/all_events_grid.dart';
// import 'package:getx/app/ui/android/widgets/home_carousal.dart';
// // import 'package:getx/app/ui/android/widgets/location_bar.dart';
// import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
// // import 'package:getx/app/ui/android/widgets/todays_events_list.dart';

// // import '../../../data/model/city_state.dart';
// // import '../widgets/gravity/batches_list_widget.dart';
// import '../widgets/gravity/previous_year_exam_list.dart';
// // import 'booking_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String? city = "-", state = "-";
//   SingleValueDropDownController cityController = SingleValueDropDownController(
//       data: const DropDownValueModel(name: "-", value: "-"));
//   final TextEditingController? searchController = TextEditingController();
//   void detectLocation() async {
//     print(":location");
//     String cityState = await getUserCityState();
//     // city = cityState.substring(0,cityState.indexOf(":"));
//     // state = cityState.substring(cityState.indexOf(":")+1);
//     // setState(() {
//     //   cityController.dropDownValue = DropDownValueModel(name: city!, value: city);
//     // });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // detectLocation();
//     // await Get.put<HomeController>(HomeController());
//     // Get.find<HomeController>().cityState.listen((p0) {
//     //   setState(() {
//     //
//     //   });
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(color: appColors["background"]!, child: getBody());
//   }
//   //
//   // void detectLocation() async {
//   //   print(":location");
//   //   await getUserCityState();
//   // }

// //golu

//   Widget getBody() {
//     // var ncategories = categories.sublist(1);
//     return SafeArea(
//       child: Scaffold(
//           drawer: const MyDrawer(),
//           extendBodyBehindAppBar: true,
//           backgroundColor: appColors["background"]!,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//           ),
//           body: Container(
//             color: appColors["background"]!,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: clumsyTextLabel("Welcome",
//                               fontsize: 20, color: appColors['grey']),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     // child: HomeCarousal(),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                         Divider(),
// SizedBox(
//                   height: 10,
//                 ),
//                   Container(
//                     margin: EdgeInsets.all(0),
//                     padding: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               clumsyTextLabel("Previous Year Questions",
//                                   fontsize: 16, color: appColors['golu-grey']),
//                               Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   // Get.toNamed(Routes.My_Batches);

//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                             child: clumsyTextLabel("View All",fontsize: 12,color: appColors['golu-grey']),

//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: clumsyTextLabel("Session: 2023-2024",
//                               fontsize: 14, color: appColors['grey']),
//                         ),
//                         SizedBox(
//                           height: 150,
//                           child:
//                            ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: 1, // Since there's only one item
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.PREVIOUS_YEAR_QUESTIONS_PAGE);
//                                 },
//                                 customBorder: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20)),
//                                 splashColor: appColors["white"],
//                                 child: Expanded(
//                                   child: 
//                                      Card(
//                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
//                         elevation: .27,
//                         color: appColors['background'],
//                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
//                         side: BorderSide(color: appColors['golu-grey']!,
//                         width: .57,
//                         style: BorderStyle.solid)
//                         ),

//                         child: ListTile(
//                           // tileColor: appColors['background'],
//                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
//    leading: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 0),
                                
//  child:   Icon(
//                       Icons.padding_outlined,
//                       color: appColors['primary'],
//                     ),),
//                           title: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0.0, vertical: 0),
                                
//                             child: clumsyTextLabel(
//                                           ("previous year questions").toUpperCase(),
                            
                
//                                 fontsize: 12, color: appColors['primary']),
//                           ),
                         
//                           trailing: 
//                           Padding(
                                
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 8),
//                          child: Icon(
//                                         Icons.arrow_circle_right,
//                                         color: appColors['primary'],
//                                         size: 20,
                            
//                                 ),
//                           ),
//                         ),
//                                      ),

//                                     // ListTile(
//                                     //  contentPadding: EdgeInsets.all(0), // to remove default padding of ListTile
                                  
//                                     //   leading: Column(
//                                     //     mainAxisAlignment:
//                                     //         MainAxisAlignment.center,
//                                     //         // crossAxisAlignment: CrossAxisAlignment.start,
//                                     //     children: [
//                                     //       // SizedBox(
//                                     //         // height: 20,
                                            
//                                     //         //  Image.asset(
//                                     //         //     'assets/images/glogoB.png', height: 14),
//                                     //       // ),
//                                     //     ],
//                                     //   ),
                                    

//                                     //   title: clumsyTextLabel(
//                                     //       "IIT-JEE MAIN/ADVANCE/\nNEET",
//                                     //       color: appColors['primary'], fontsize: 10
//                                     //       ),
//                                     //   subtitle: Icon(
//                                     //     Icons.arrow_circle_right,
//                                     //     color: appColors['primary'],
//                                     //     size: 20,
//                                       // ),
//                                     // ),
                               
//                                   // ),
//                                 ),
//                               );
//                             },
//                           ),
                       
//                         ),
// //                          SizedBox(
// //                           height: 150,
// //                           child:
// //                            ListView.builder(
// //                             scrollDirection: Axis.vertical,
// //                             itemCount: 1, // Since there's only one item
// //                             itemBuilder: (context, index) {
// //                               return InkWell(
// //                                 onTap: () {
// //                                   Get.toNamed(Routes.My_Batches);
// //                                 },
// //                                 customBorder: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(20)),
// //                                 splashColor: appColors["white"],
// //                                 child: Expanded(
// //                                   child: 
// //                                      Card(
// //                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
// //                         elevation: .27,
// //                         color: appColors['background'],
// //                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
// //                         side: BorderSide(color: appColors['golu-grey']!,
// //                         width: .57,
// //                         style: BorderStyle.solid)
// //                         ),

// //                         child: ListTile(
// //                           // tileColor: appColors['background'],
// //                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //    leading: Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 8.0, vertical: 0),
                                
// //  child:   Icon(
// //                       Icons.video_collection_outlined,
// //                       color: appColors['primary'],
// //                     ),),
// //                           title: Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 0.0, vertical: 0),
                                
// //                             child: clumsyTextLabel(
// //                                           "IIT-JEE MAIN/ADVANCE/\nNEET",
                            
                
// //                                 fontsize: 12, color: appColors['primary']),
// //                           ),
                         
// //                           trailing: 
// //                           Padding(
                                
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 8.0, vertical: 8),
// //                          child: Icon(
// //                                         Icons.arrow_circle_right,
// //                                         color: appColors['primary'],
// //                                         size: 20,
                            
// //                                 ),
// //                           ),
// //                         ),
// //                                      ),

// //                                     // ListTile(
// //                                     //  contentPadding: EdgeInsets.all(0), // to remove default padding of ListTile
                                  
// //                                     //   leading: Column(
// //                                     //     mainAxisAlignment:
// //                                     //         MainAxisAlignment.center,
// //                                     //         // crossAxisAlignment: CrossAxisAlignment.start,
// //                                     //     children: [
// //                                     //       // SizedBox(
// //                                     //         // height: 20,
                                            
// //                                     //         //  Image.asset(
// //                                     //         //     'assets/images/glogoB.png', height: 14),
// //                                     //       // ),
// //                                     //     ],
// //                                     //   ),
                                    

// //                                     //   title: clumsyTextLabel(
// //                                     //       "IIT-JEE MAIN/ADVANCE/\nNEET",
// //                                     //       color: appColors['primary'], fontsize: 10
// //                                     //       ),
// //                                     //   subtitle: Icon(
// //                                     //     Icons.arrow_circle_right,
// //                                     //     color: appColors['primary'],
// //                                     //     size: 20,
// //                                       // ),
// //                                     // ),
                               
// //                                   // ),
// //                                 ),
// //                               );
// //                             },
// //                           ),
                       
// //                         ),
                     
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 80,
//                   ),
//                         Divider(),

//               Container(
//                     margin: EdgeInsets.all(0),
//                     padding: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               clumsyTextLabel("Batches",
//                                   fontsize: 16, color: appColors['golu-grey']),
//                               Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.My_Batches);

//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                             child: clumsyTextLabel("View All",fontsize: 12,color: appColors['golu-grey']),

//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: clumsyTextLabel("Session: 2023-2024",
//                               fontsize: 14, color: appColors['grey']),
//                         ),
// //                         SizedBox(
// //                           height: 150,
// //                           child:
// //                            ListView.builder(
// //                             scrollDirection: Axis.vertical,
// //                             itemCount: 1, // Since there's only one item
// //                             itemBuilder: (context, index) {
// //                               return InkWell(
// //                                 onTap: () {
// //                                   // Get.toNamed(Routes.My_Batches);
// //                                 },
// //                                 customBorder: RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(20)),
// //                                 splashColor: appColors["white"],
// //                                 child: Expanded(
// //                                   child:  Card(
// //                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
// //                         elevation: .27,
// //                         color: appColors['background'],
// //                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
// //                         side: BorderSide(color: appColors['golu-grey']!,
// //                         width: .57,
// //                         style: BorderStyle.solid)
// //                         ),

// //                         child: ListTile(
// //                           // tileColor: appColors['background'],
// //                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //    leading: Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 8.0, vertical: 0),
                                
// //  child:   Icon(
// //                       Icons.padding_outlined,
// //                       color: appColors['primary'],
// //                     ),),
// //                           title: Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 0.0, vertical: 0),
                                
// //                             child: clumsyTextLabel(
// //                                           ("previous year questions").toUpperCase(),
                            
                
// //                                 fontsize: 12, color: appColors['primary']),
// //                           ),
                         
// //                           trailing: 
// //                           Padding(
                                
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 8.0, vertical: 8),
// //                          child: Icon(
// //                                         Icons.arrow_circle_right,
// //                                         color: appColors['primary'],
// //                                         size: 20,
                            
// //                                 ),
// //                           ),
// //                         ),
// //                                      ),

// //                                     // ListTile(
// //                                     //  contentPadding: EdgeInsets.all(0), // to remove default padding of ListTile
                                  
// //                                     //   leading: Column(
// //                                     //     mainAxisAlignment:
// //                                     //         MainAxisAlignment.center,
// //                                     //         // crossAxisAlignment: CrossAxisAlignment.start,
// //                                     //     children: [
// //                                     //       // SizedBox(
// //                                     //         // height: 20,
                                            
// //                                     //         //  Image.asset(
// //                                     //         //     'assets/images/glogoB.png', height: 14),
// //                                     //       // ),
// //                                     //     ],
// //                                     //   ),
                                    

// //                                     //   title: clumsyTextLabel(
// //                                     //       "IIT-JEE MAIN/ADVANCE/\nNEET",
// //                                     //       color: appColors['primary'], fontsize: 10
// //                                     //       ),
// //                                     //   subtitle: Icon(
// //                                     //     Icons.arrow_circle_right,
// //                                     //     color: appColors['primary'],
// //                                     //     size: 20,
// //                                       // ),
// //                                     // ),
                               
// //                                   // ),
// //                                 ),
                             
// //                               );
// //                             },
// //                           ),
                       
// //                         ),
//                          SizedBox(
//                           height: 150,
//                           child:
//                            ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: 1, // Since there's only one item
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.My_Batches);
//                                 },
//                                 customBorder: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20)),
//                                 splashColor: appColors["white"],
//                                 child: Expanded(
//                                   child: 
//                                      Card(
//                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
//                         elevation: .27,
//                         color: appColors['background'],
//                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
//                         side: BorderSide(color: appColors['golu-grey']!,
//                         width: .57,
//                         style: BorderStyle.solid)
//                         ),

//                         child: ListTile(
//                           // tileColor: appColors['background'],
//                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
//    leading: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 0),
                                
//  child:   Icon(
//                       Icons.video_collection_outlined,
//                       color: appColors['primary'],
//                     ),),
//                           title: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0.0, vertical: 0),
                                
//                             child: clumsyTextLabel(
//                                           "IIT-JEE MAIN/ADVANCE/\nNEET",
                            
                
//                                 fontsize: 12, color: appColors['primary']),
//                           ),
                         
//                           trailing: 
//                           Padding(
                                
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 8),
//                          child: Icon(
//                                         Icons.arrow_circle_right,
//                                         color: appColors['primary'],
//                                         size: 20,
                            
//                                 ),
//                           ),
//                         ),
//                                      ),

//                                     // ListTile(
//                                     //  contentPadding: EdgeInsets.all(0), // to remove default padding of ListTile
                                  
//                                     //   leading: Column(
//                                     //     mainAxisAlignment:
//                                     //         MainAxisAlignment.center,
//                                     //         // crossAxisAlignment: CrossAxisAlignment.start,
//                                     //     children: [
//                                     //       // SizedBox(
//                                     //         // height: 20,
                                            
//                                     //         //  Image.asset(
//                                     //         //     'assets/images/glogoB.png', height: 14),
//                                     //       // ),
//                                     //     ],
//                                     //   ),
                                    

//                                     //   title: clumsyTextLabel(
//                                     //       "IIT-JEE MAIN/ADVANCE/\nNEET",
//                                     //       color: appColors['primary'], fontsize: 10
//                                     //       ),
//                                     //   subtitle: Icon(
//                                     //     Icons.arrow_circle_right,
//                                     //     color: appColors['primary'],
//                                     //     size: 20,
//                                       // ),
//                                     // ),
                               
//                                   // ),
//                                 ),
//                               );
//                             },
//                           ),
                       
//                         ),
                     
//                       ],
//                     ),
//                   ),
              
//                 const  SizedBox(
//                     height: 100,
//                   ),
//                   // Divider(color: appColors['primary']),
//                    // golu previous year exams
                  
//                   // PreviousYearExamListWidget(),
//                   // Divider(color: appColors['primary']),
//                  const SizedBox(
//                     height: 100,
//                   ),
//                    // golu ai
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Card(
//                   //     shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(20)),
//                   //     elevation: 5,
//                   //     child: ListTile(
//                   //       onTap: () {
//                           // Get.toNamed(Routes.GRAVITY_AI_PAGE);
//                   //       },
//                   //       leading: Column(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           Image.asset('assets/images/glogoB.png', width: 50),
//                   //         ],
//                   //       ),
//                   //       shape: RoundedRectangleBorder(
//                   //           borderRadius: BorderRadius.circular(20)),
//                   //       trailing: Icon(Icons.arrow_circle_right,
//                   //           color: appColors['primary']),
//                   //       title: clumsyTextLabel("Introducing AI",
//                   //           fontsize: 22, color: appColors['primary']),
//                   //       subtitle: clumsyTextLabel("Q/A Intelligence",
//                   //           color: appColors['primary']),
//                   //       tileColor: Colors.white,
//                   //     ),
//                   //   ),
//                   // ),
                
//                   SizedBox(
//                     height: 100,
//                   ),
//                 ],
//               ),
//             ),
//           )

//           ),
//     );
//   }
// }
// //         body: Container(
// //           color: appColors["background"]!,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: clumsyTextLabel("Welcome",
// //                           fontsize: 30, color: appColors['grey']),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10.0),
// //               ),
// //               Container(
// //                 margin: EdgeInsets.all(0),
// //                 padding: EdgeInsets.all(0),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Row(
// //                         children: [
// //                           clumsyTextLabel("Batches",
// //                               fontsize: 20, color: appColors['golu-grey']),
// //                           Spacer(),
// //                           InkWell(
// //                             onTap: () {},
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                       child: clumsyTextLabel("Session: 2023-2024",
// //                           fontsize: 14, color: appColors['grey']),
// //                     ),
// //                     SizedBox(
// //                       height: 180,
// //                       child: ListView.builder(
// //                         // scrollDirection: Axis.horizontal,
// //                         scrollDirection: Axis.vertical,

// //                         itemCount: 1, // Since there's only one item
// //                         itemBuilder: (context, index) {
// //                           return InkWell(
// //                             onTap: () {
// //                               Get.toNamed(Routes.My_Batches);
// //                             },
// //                             customBorder: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(20)),
// //                             splashColor: appColors["white"],
// //                             child: Container(
// //                               width: Get.width * 0.41,
// //                               height: 100,
// //                               margin: EdgeInsets.all(5),
// //                               padding: EdgeInsets.all(20),
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(22),
// //                                 color: appColors['white'],
// //                                 boxShadow: const [
// //                                   BoxShadow(
// //                                       color: Colors.grey,
// //                                       spreadRadius: 0,
// //                                       blurRadius: 5,
// //                                       offset: Offset(2, 2))
// //                                 ],
// //                               ),
// //                               child: Center(
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Center(
// //                                       child: SizedBox(
// //                                         height: 20,
// //                                         child: Image.asset(
// //                                             'assets/images/glogoB.png'),
// //                                       ),
// //                                     ),
// //                                     Expanded(
// //                                       child: clumsyTextLabel(
// //                                           "IIT, IIT ADVANCE, NEET",
// //                                           color: appColors['primary']),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Divider(color: appColors['primary']),
// //               PreviousYearExamListWidget(),
// //               Divider(color: appColors['primary']),

// // // SizedBox(
// //   // height: 100,
// //           //  child:
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child:

// //                 Card(
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20)),
// //                   elevation: 5,
// //                   child:
// //                   ListTile(
// //                     onTap: () {
// //                       Get.toNamed(Routes.GRAVITY_AI_PAGE);
// //                     },
// //                     leading: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Image.asset('assets/images/glogoB.png', width: 50),
// //                       ],
// //                     ),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(20)),
// //                     trailing: Icon(Icons.arrow_circle_right,
// //                         color: appColors['primary']),
// //                     title: clumsyTextLabel("Introducing AI",
// //                         fontsize: 22, color: appColors['primary']),
// //                     subtitle: clumsyTextLabel("Q/A Intelligence",
// //                         color: appColors['primary']),
// //                     tileColor: Colors.white,
// //                   ),

// //                 ),

// //               ),

// // // ),
// //             ],
// //           ),
// //         ),

//   //         ),
//   //   );
//   // }

// //golu

// //   Widget getBody()
// //   {
// //     var ncategories = categories.sublist(1);
// //     return SafeArea(
// //       child: Scaffold(
// //         drawer: const MyDrawer(),

// //         // backgroundColor: appColors["background"]!,
// //         extendBodyBehindAppBar: true,
// //         appBar: AppBar(

// //           // title: Text(
// //           //   " welcome"
// //           // ),
// //         //   automaticallyImplyLeading: false,
// //         //   elevation: 0.0,
// //           backgroundColor: Colors.transparent,
// //         //   actions: [
// //         //     Expanded(
// //         //       child: Row(
// //         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         //         children: [
// //         //         ],
// //         //       ),
// //         //     ),
// //         //   ],
// //         ),

// //         body:
// //         //  ScrollConfiguration(
// //           // behavior: const ScrollBehavior(),

// //           // child:
// //           //  Container(
// //             // color: appColors["primary"]!,
// //              Container(
// //               color: appColors["background"]!,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // headerBar("Home",parent: false),

// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Row(

// //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                       children: [
// //                   // Divider(color:appColors['primary']),

// //                          Padding(

// //                           padding: const EdgeInsets.all(8.0),
// //                           child: clumsyTextLabel("Welcome",fontsize: 30,color: appColors['grey']),
// //                         ),
// //                         // IconButton(onPressed: (){}, icon: Icon(Icons.menu_sharp,color: appColors['primary']!,)),
// //                       ],
// //                     ),
// //                   ),

// //                   // Padding(
// //                   //   padding: const EdgeInsets.all(28.0),
// //                   //   child: Container(
// //                   //     decoration: BoxDecoration(
// //                   //         // color: appColors['grey'],
// //                   //         borderRadius: BorderRadius.circular(10),border:Border.all(color: Colors.green)),
// //                   //     width: Get.width,
// //                   //
// //                   //     child: Row(
// //                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   //       children: [
// //                   //         Padding(
// //                   //           padding: const EdgeInsets.all(8.0),
// //                   //           child: clumsyTextLabel("Search",fontsize: 20,color: appColors['primary']),
// //                   //         ),
// //                   //         IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,color: appColors['primary']!,)),
// //                   //       ],
// //                   //     ),
// //                   //   ),
// //                   // ),

// //                   // BookingPage(),
// //                   // MyBatches(),

// //                   // Center(child: clumsyTextLabel("Our Past Performance",color: appColors['primary'],fontsize: 20)),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(vertical: 10.0),
// //                     // child: HomeCarousal(),
// //                   ),
// //  Container(
// //             margin: EdgeInsets.all(0),
// //             padding: EdgeInsets.all(0),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(20),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Row(
// //                     children: [
// //                       clumsyTextLabel("Batches",fontsize: 20,color: appColors['golu-grey']),
// //                       Spacer(),
// //                       InkWell(
// //                           onTap: (){},
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             // child: clumsyTextLabel("View All",fontsize: 14,color: appColors['green']),
// //                           )),
// //                     ],
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                   child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
// //                 ),
// // SizedBox(
// //   // height: 100,
// //   // width: 259,
// //   child:
// // // ListView.builder(
// // //   scrollDirection: Axis.vertical,
// // //   itemCount: 1,  // Since there's only one item
// // //   itemBuilder: (context, index) {
// // //     return InkWell(
// // //       onTap: () {
// // //         Get.toNamed(Routes.My_Batches);
// // //       },
// // //       customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // //       splashColor: appColors["white"],
// // //       child: Container(
// // //         width: Get.width * 0.41,
// // //         height: 100,
// // //         margin: EdgeInsets.all(5),
// // //         padding: EdgeInsets.all(20),
// // //         decoration: BoxDecoration(
// // //           borderRadius: BorderRadius.circular(22),
// // //           color: appColors['white'],
// // //           boxShadow: const [BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 5, offset: Offset(2, 2))]
// // //         ),
// // //         child: Center(
// // //           child: Column(
// // //             mainAxisAlignment: MainAxisAlignment.center,
// // //             children: [
// // //               Center(
// // //                 child: SizedBox(
// // //                   height: 20,
// // //                   child: Image.asset('assets/images/glogoB.png')
// // //                 ),
// // //               ),
// // //               Expanded(
// // //                 child: clumsyTextLabel("IIT, IIT ADVANCE, NEET", color: appColors['primary']),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   },
// // // )

// //             // ),
// //                 SingleChildScrollView(
// //                   scrollDirection: Axis.vertical,
// //                   child:Row(

// //                     children: [

// //                      InkWell(
// //                           onTap: (){
// //                             Get.toNamed(Routes.My_Batches);
// //                           },
// //                           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //                           splashColor: appColors["white"],
// //                           child: Container(
// //                             width: Get.width*0.41,
// //                             height: 100,
// //                             margin: EdgeInsets.all(5),
// //                             padding: EdgeInsets.all(20),
// //                             decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(22),
// //                                 color: appColors['white'],
// //                                 // border: Border.all(color: appColors['primary']!),
// //                                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
// //                             ),
// //                             child: Center(
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 // crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Center(
// //                                     child: SizedBox(
// //                                         height:20,
// //                                         child: Image.asset('assets/images/glogoB.png')
// //                                         ),
// //                                   ),
// //                                   Expanded(
// //                                     child: clumsyTextLabel("IIT, IIT ADVANCE,\nNEET",color: appColors['primary'],),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                     ],
// //                       // }
// //                       )
// //                     // ],
// //                   ),

// //                 ),
// //               ],
// //             )
// //           ),

// //                   // Padding(
// //                   //   padding: const EdgeInsets.only(right: 170,top: 50),
// //                   //   child: Card(
// //                   //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //                   //     elevation: 5,
// //                   //     child: ListTile(
// //                   //       onTap: (){
// //                   //         Get.toNamed(Routes.My_Batches);
// //                   //       },
// //                   //       leading: Column(
// //                   //         mainAxisAlignment: MainAxisAlignment.center,
// //                   //         children: [
// //                   //           // Image.asset('assets/images/glogoB.png',width: 50,),
// //                   //         ],
// //                   //       ),
// //                   //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //                   //       trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
// //                   //       title:clumsyTextLabel("BATCHES",fontsize:22,color: appColors['primary']),
// //                   //       subtitle: clumsyTextLabel("IIT, IIT ADVANCE, NEET",color: appColors['primary']),
// //                   //       tileColor: Colors.white,

// //                   //     ),
// //                   //   ),
// //                   // ),

// //                   // Divider(color:appColors['primary']),
// //                    Divider(color:appColors['primary']),
// //                   PreviousYearExamListWidget(),
// //                    Divider(color:appColors['primary']),

// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Card(
// //                       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //                       elevation: 5,
// //                       child: ListTile(
// //                         onTap: (){
// //                           Get.toNamed(Routes.GRAVITY_AI_PAGE);
// //                         },
// //                         leading: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Image.asset('assets/images/glogoB.png',width: 50,),
// //                           ],
// //                         ),
// //                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
// //                         trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
// //                         title:clumsyTextLabel("Introducing AI",fontsize:22,color: appColors['primary']),
// //                         subtitle: clumsyTextLabel("Q/A Intelligence",color: appColors['primary']),
// //                         tileColor: Colors.white,

// //                       ),
// //                     ),
// //                   ),
// //                   // Divider(color:appColors['primary']),
// //                   // PreviousYearExamListWidget(),
// //                   // BatchListWidget(),

// //                   // Padding(
// //                   //   padding: const EdgeInsets.all(8.0),
// //                   //   child: clumsyTextLabel("Online Tests",fontsize: 20,color: appColors['primary']),
// //                   // ),
// //                   // Padding(
// //                   //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
// //                   //   child: clumsyTextLabel("All Streams",fontsize: 14,color: appColors['grey']),
// //                   // ),
// //                   // Padding(
// //                   //   padding: const EdgeInsets.all(8.0),
// //                   //   child: AllEventsGrid(),
// //                   // ),
// //                 ],
// //               ),
// //             // ),
// //           ),
// //         // ),
// //       ),
// //     );
// //   }
// // }
  


// Widget _trendingList(String name) {
//   return Container(
//     decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10))),
//     child: InkWell(
//       splashColor: appColors["primary"]!,
//       onTap: () {
//         Get.toNamed(Routes.EVENT_TYPE_EVENTS, arguments: name);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: 225,
//           height: 100,
//           decoration: BoxDecoration(
//               border: Border.all(
//                   color: appColors["primary"]!,
//                   style: BorderStyle.solid,
//                   width: 2),
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(
//                   image: AssetImage("assets/images/pager.jpg"),
//                   colorFilter:
//                       ColorFilter.mode(appColors["grey"]!, BlendMode.modulate),
//                   fit: BoxFit.cover)),
//           child: Center(
//             child: Text(name,
//                 style: TextStyle(
//                     color: appColors["white"]!,
//                     fontFamily: "Barokah",
//                     fontSize: 12)),
//           ),
//           // child: Image.network("https://picsum.photos/125/100"),
//         ),
//       ),
//     ),
//   );
// }
























// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// // import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// // import 'package:getx/app/controller/authentication/authentication.dart';
// // import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// // import 'package:getx/app/data/constants/request_paths.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/home/mydrawer.dart';
// // import 'package:getx/app/ui/android/home/gravity/batch_page.dart';
// // import 'package:getx/app/ui/android/home/gravity/my_batches.dart';
// // import 'package:getx/app/ui/android/widgets/all_events_grid.dart';
// import 'package:getx/app/ui/android/widgets/home_carousal.dart';
// // import 'package:getx/app/ui/android/widgets/location_bar.dart';
// import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
// // import 'package:getx/app/ui/android/widgets/todays_events_list.dart';

// // import '../../../data/model/city_state.dart';
// // import '../widgets/gravity/batches_list_widget.dart';
// import '../widgets/gravity/previous_year_exam_list.dart';
// // import 'booking_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
  

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // detectLocation();
//     // await Get.put<HomeController>(HomeController());
//     // Get.find<HomeController>().cityState.listen((p0) {
//     //   setState(() {
//     //
//     //   });
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(color: appColors["background"]!, child: getBody());
//   }
//   //
//   // void detectLocation() async {
//   //   print(":location");
//   //   await getUserCityState();
//   // }

// //golu

//   Widget getBody() {
//     // var ncategories = categories.sublist(1);
//     return SafeArea(
//       child: Scaffold(
//           drawer: const MyDrawer(),
//           extendBodyBehindAppBar: true,
//           backgroundColor: appColors["background"]!,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//           ),
//           body: Container(
//             color: appColors["background"]!,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: clumsyTextLabel("Welcome",
//                               fontsize: 20, color: appColors['grey']),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     // child: HomeCarousal(),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                         Divider(),
// SizedBox(
//                   height: 10,
//                 ),
//                   Container(
//                     margin: EdgeInsets.all(0),
//                     padding: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               clumsyTextLabel("Previous Year Questions",
//                                   fontsize: 16, color: appColors['golu-grey']),
//                               Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   // Get.toNamed(Routes.My_Batches);

//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                             child: clumsyTextLabel("View All",fontsize: 12,color: appColors['golu-grey']),

//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: clumsyTextLabel("Session: 2023-2024",
//                               fontsize: 14, color: appColors['grey']),
//                         ),
//                         SizedBox(
//                           height: 150,
//                           child:
//                            ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: 1, // Since there's only one item
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.PREVIOUS_YEAR_QUESTIONS_PAGE);
//                                 },
//                                 customBorder: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20)),
//                                 splashColor: appColors["white"],
//                                 child: Expanded(
//                                   child: 
//                                      Card(
//                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
//                         elevation: .27,
//                         color: appColors['background'],
//                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
//                         side: BorderSide(color: appColors['golu-grey']!,
//                         width: .57,
//                         style: BorderStyle.solid)
//                         ),

//                         child: ListTile(
//                           // tileColor: appColors['background'],
//                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
//    leading: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 0),
                                
//  child:   Icon(
//                       Icons.padding_outlined,
//                       color: appColors['primary'],
//                     ),),
//                           title: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0.0, vertical: 0),
                                
//                             child: clumsyTextLabel(
//                                           ("previous year questions").toUpperCase(),
                            
                
//                                 fontsize: 12, color: appColors['primary']),
//                           ),
                         
//                           trailing: 
//                           Padding(
                                
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 8),
//                          child: Icon(
//                                         Icons.arrow_circle_right,
//                                         color: appColors['primary'],
//                                         size: 20,
                            
//                                 ),
//                           ),
//                         ),
//                                      ),

                             
//                                 ),
//                               );
//                             },
//                           ),
                       
//                         ),


                     
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 80,
//                   ),
//                         Divider(),

//               Container(
//                     margin: EdgeInsets.all(0),
//                     padding: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               clumsyTextLabel("Batches",
//                                   fontsize: 16, color: appColors['golu-grey']),
//                               Spacer(),
//                               InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.My_Batches);

//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                             child: clumsyTextLabel("View All",fontsize: 12,color: appColors['golu-grey']),

//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: clumsyTextLabel("Session: 2023-2024",
//                               fontsize: 14, color: appColors['grey']),
//                         ),


//                          SizedBox(
//                           height: 150,
//                           child:
//                            ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: 1, // Since there's only one item
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Get.toNamed(Routes.My_Batches);
//                                 },
//                                 customBorder: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20)),
//                                 splashColor: appColors["white"],
//                                 child: Expanded(
//                                   child: 
//                                      Card(
//                         margin: EdgeInsets.only(left: 8, right: 8, bottom: 6),
//                         elevation: .27,
//                         color: appColors['background'],
//                         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
//                         side: BorderSide(color: appColors['golu-grey']!,
//                         width: .57,
//                         style: BorderStyle.solid)
//                         ),

//                         child: ListTile(
//                           // tileColor: appColors['background'],
//                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
//    leading: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 0),
                                
//  child:   Icon(
//                       Icons.video_collection_outlined,
//                       color: appColors['primary'],
//                     ),),
//                           title: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0.0, vertical: 0),
                                
//                             child: clumsyTextLabel(
//                                           "IIT-JEE MAIN/ADVANCE/\nNEET",
                            
                
//                                 fontsize: 12, color: appColors['primary']),
//                           ),
                         
//                           trailing: 
//                           Padding(
                                
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 8),
//                          child: Icon(
//                                         Icons.arrow_circle_right,
//                                         color: appColors['primary'],
//                                         size: 20,
                            
//                                 ),
//                           ),
//                         ),
//                                      ),

//                                     // ListTile(
//                                     //  contentPadding: EdgeInsets.all(0), // to remove default padding of ListTile
                                  
//                                     //   leading: Column(
//                                     //     mainAxisAlignment:
//                                     //         MainAxisAlignment.center,
//                                     //         // crossAxisAlignment: CrossAxisAlignment.start,
//                                     //     children: [
//                                     //       // SizedBox(
//                                     //         // height: 20,
                                            
//                                     //         //  Image.asset(
//                                     //         //     'assets/images/glogoB.png', height: 14),
//                                     //       // ),
//                                     //     ],
//                                     //   ),
                                    

//                                     //   title: clumsyTextLabel(
//                                     //       "IIT-JEE MAIN/ADVANCE/\nNEET",
//                                     //       color: appColors['primary'], fontsize: 10
//                                     //       ),
//                                     //   subtitle: Icon(
//                                     //     Icons.arrow_circle_right,
//                                     //     color: appColors['primary'],
//                                     //     size: 20,
//                                       // ),
//                                     // ),
                               
//                                   // ),
//                                 ),
//                               );
//                             },
//                           ),
                       
//                         ),
                     
//                       ],
//                     ),
//                   ),
              
//                 const  SizedBox(
//                     height: 100,
//                   ),
              
//                  const SizedBox(
//                     height: 100,
//                   ),
          
            
                
//                   SizedBox(
//                     height: 100,
//                   ),
//                 ],
//               ),
//             ),
//           )

//           ),
//     );
//   }
// }

  
 


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/home/mydrawer.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';

import '../widgets/miscellaneous.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(color: appColors["background"]!, child: getBody());
  }

  Widget getBody() {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        extendBodyBehindAppBar: true,
        backgroundColor: appColors["background"]!,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          color: appColors["background"]!,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: clumsyTextLabel("Welcome",
                            fontsize: 20, color: appColors['grey']),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                // Previous Year Questions Section
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            clumsyTextLabel("Previous Year Questions",
                                fontsize: 16, color: appColors['golu-grey']),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                // Get.toNamed(Routes.PREVIOUS_YEAR_QUESTIONS_PAGE);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("View All",
                                    fontsize: 12,
                                    color: appColors['golu-grey']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        child: clumsyTextLabel("Session: 2023-2024",
                            fontsize: 14, color: appColors['grey']),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                    Routes.PREVIOUS_YEAR_QUESTIONS_PAGE);
                              },
                              customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              splashColor: appColors["white"],
                              child: Card(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 6),
                                elevation: .27,
                                color: appColors['background'],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: appColors['golu-grey']!,
                                        width: .57,
                                        style: BorderStyle.solid)),
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 0),
                                    child: Icon(
                                      Icons.padding_outlined,
                                      color: appColors['primary'],
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 0),
                                    child: clumsyTextLabel(
                                        ("previous year questions")
                                            .toUpperCase(),
                                        fontsize: 12,
                                        color: appColors['primary']),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: Icon(
                                      Icons.arrow_circle_right,
                                      color: appColors['primary'],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Divider(),
                // Batches Section
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            clumsyTextLabel("Batches",
                                fontsize: 16, color: appColors['golu-grey']),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.My_Batches);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("View All",
                                    fontsize: 12,
                                    color: appColors['golu-grey']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        child: clumsyTextLabel("Session: 2023-2024",
                            fontsize: 14, color: appColors['grey']),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.My_Batches);
                              },
                              customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              splashColor: appColors["white"],
                              child: Card(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 6),
                                elevation: .27,
                                color: appColors['background'],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: appColors['golu-grey']!,
                                        width: .57,
                                        style: BorderStyle.solid)),
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 0),
                                    child: Icon(
                                      Icons.video_collection_outlined,
                                      color: appColors['primary'],
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 0),
                                    child: clumsyTextLabel(
                                        "IIT-JEE MAIN/ADVANCE/\nNEET",
                                        fontsize: 12,
                                        color: appColors['primary']),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: Icon(
                                      Icons.arrow_circle_right,
                                      color: appColors['primary'],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
