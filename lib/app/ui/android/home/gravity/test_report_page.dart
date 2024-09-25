// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/controller/gravity/student_controller.dart';
// import 'package:getx/app/controller/home/home_controller.dart';
// import 'package:getx/app/controller/host_controller.dart';
// import 'package:getx/app/data/constants/errors.dart';
// import 'package:getx/app/data/constants/miscellaneous.dart';
// import 'package:getx/app/data/model/api_response.dart';
// import 'package:getx/app/data/model/event.dart';
// import 'package:getx/app/data/model/gravity/test_report.dart';
// import 'package:getx/app/data/model/gravity/test_context.dart';
// import 'package:getx/app/data/provider/host_api.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:getx/app/ui/android/widgets/event_phases.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../../data/model/gravity/test.dart';
// import '../../widgets/event_page_caraousal.dart';
// import '../../widgets/host_event_media_list.dart';
// import '../../widgets/miscellaneous.dart';

// class TestReportPage extends StatefulWidget {
//   TestReportPage({Key? key}) : super(key: key) {
//     // Get.put<HostController>(HostController());
//   }
//   @override
//   State<TestReportPage> createState() => _State();
// }

// class _State extends State<TestReportPage> {
//   late String testId;
//   late String batchId;
//   bool agreed = false;
//   _State() {
//     var data = Get.arguments;
//     testId = data[0];
//     batchId = data[1];
//     print("Test id on report page:$testId");
//   }
//   @override
//   Widget build(BuildContext context) {
//     // printCity();
//     return SafeArea(
//       child: Material(
//         color: appColors["background"]!,
//         child: AsyncBuilder<APIResponse>(
//           future: Get.find<StudentsController>().getTestReport(testId),
//           waiting: (context) {
//             return Center(
//               child: clumsyWaitingBar(),
//             );
//           },
//           builder: (context, apiResponse) {
//             if (apiResponse!.status == TextMessages.SUCCESS) {
//               TestReport testReport = apiResponse.data as TestReport;
//               return Column(
//                 children: [
//                   headerBar("Test Report", parent: true),
//                   testItemWidget2(testReport.test),
//                   if (testReport.test.startTime != null
//                       ? DateTime.parse(testReport.test.startTime!)
//                           .toLocal()
//                           .isBefore(DateTime.now())
//                       : true && testReport.test.endTime != null
//                           ? DateTime.parse(testReport.test.endTime!)
//                               .toLocal()
//                               .isAfter(DateTime.now())
//                           : true)
//                     ClumsyRealButton("Start", Get.width * 0.7, () async {
//                       APIResponse res = await Get.find<StudentsController>()
//                           .createNewTestState(testId,batchId);
//                       if (res.status != TextMessages.SUCCESS) {
//                         print(res.info!);
//                         showSnackbar("Error", res.info!);
//                         return;
//                       }
//                       // TestContext tc = res.data as TestContext;
//                       await Get.toNamed(Routes.TEST_PAGE, arguments: res.data);
//                       setState(() {});
//                     }, false),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           if ( testReport.testStates.length > 0)
//                             clumsyTextLabel("Pending Tests",
//                                 fontsize: 20, color: appColors['primary']),
//                           if (testReport.testStates.length > 0)
//                             ...List.generate(testReport.testStates.length,
//                                 (index) {
//                               return Container(
//                                 margin: EdgeInsets.all(10),
//                                 padding: EdgeInsets.all(10),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Get.toNamed(Routes.TEST_PAGE,arguments: {"test":testId,"test_state":testReport.testStates[index].id});
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Column(
//                                         children: [
//                                           clumsyTextLabel("Attempt#",
//                                               fontsize: 10),
//                                           clumsyTextLabel(testReport
//                                               .testStates[index].attemptNumber
//                                               .toString()),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Column(
//                                         children: [
//                                           clumsyTextLabel("Time Left(Minutes)",
//                                               fontsize: 10),
//                                           clumsyTextLabel((testReport
//                                                       .testStates[index]
//                                                       .timeLeft /
//                                                   60)
//                                               .toStringAsFixed(2)),
//                                         ],
//                                       ),
//                                       MaterialButton(
//                                         onPressed: () async {
//                                           await Get.toNamed(Routes.TEST_PAGE,
//                                               arguments: testReport
//                                                   .testStates[index].id);
//                                           setState(() {});
//                                           // Get.toNamed(Routes.BOOKINGS,arguments:Get.find<Authentication>().user!.id );
//                                         },
//                                         color: appColors["green"]!,
//                                         textColor: appColors["white"]!,
//                                         child: Column(
//                                           children: [
//                                             Icon(
//                                               Icons.start,
//                                               size: 24,
//                                             ),
//                                             clumsyTextLabel("Continue",
//                                                 fontsize: 10,
//                                                 color: appColors["white"]!)
//                                           ],
//                                         ),
//                                         padding: EdgeInsets.all(16),
//                                         shape: CircleBorder(),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                           SizedBox(
//                             height: 50,
//                           ),
//                           if (testReport.results.length > 0)
//                             clumsyTextLabel("Test Result Report",
//                                 fontsize: 20, color: appColors['primary']),
//                           ...List.generate(testReport.results.length, (index) {
//                             return Container(
//                               // margin: EdgeInsets.all(20),
//                               padding: EdgeInsets.all(20),
//                               child: InkWell(
//                                 onTap: () {
//                                   // Get.toNamed(Routes.TEST_RESULT_PAGE,arguments: {"test":testId,"test_state":testReport.results[index].id});
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         clumsyTextLabel("Attempt#",
//                                             fontsize: 10),
//                                         clumsyTextLabel(testReport
//                                             .results[index].attemptNumber
//                                             .toString()),
//                                       ],
//                                     ),
//                                   const  SizedBox(
//                                       height: 20,
//                                     ),
//                                     Column(
//                                       children: [
//                                         clumsyTextLabel("Marks#", fontsize: 10),
//                                         clumsyTextLabel(
//                                             "${testReport.results[index].total}/${testReport.results[index].maxMarks}"),
//                                       ],
//                                     ),
//                                    const SizedBox(
//                                       height: 20,
//                                     ),
//                                     MaterialButton(
//                                       onPressed: () {
//                                         Get.toNamed(Routes.TEST_RESULT_PAGE,
//                                             arguments:
//                                                 testReport.results[index].id);
//                                       },
//                                       color: appColors["blue"]!,
//                                       textColor: appColors["white"]!,
//                                       child: Column(
//                                         children: [
//                                           Icon(
//                                             Icons.done_all,
//                                             size: 24,
//                                           ),
//                                           clumsyTextLabel("Results",
//                                               fontsize: 10,
//                                               color: appColors["white"]!)
//                                         ],
//                                       ),
//                                       padding: EdgeInsets.all(16),
//                                       shape: CircleBorder(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   headerBar("Test Reports", parent: true),
//                   clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
//                   clumsyTextLabel(apiResponse.info!.toString(), fontsize: 10),
//                 ],
//               );
//             }
//           },
//           error: (context, error, stackTrace) {
//             if (kDebugMode) {
//               print(error.runtimeType);
//             }
//             if (kDebugMode) {
//               print(error);
//             }
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                const Text("Some error Occured"),
//                 Text(error.toString()),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//     // return Container(
//     //   child: Column(
//     //     children: [
//     //       ClumsyMediaList(event.medias),
//     //       EventPhasesWidget(eventId: event.id, phases: event.phases)
//     //     ],
//     //   )
//     // );
//   }
// }












// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:getx/app/controller/gravity/student_controller.dart';
// // import 'package:getx/app/data/constants/errors.dart';
// // import 'package:getx/app/data/constants/miscellaneous.dart';
// // import 'package:getx/app/data/model/api_response.dart';
// // import 'package:getx/app/data/model/gravity/test_report.dart';
// // import 'package:getx/app/routes/app_pages.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // import '../../../../data/model/gravity/test.dart';
// // import '../../widgets/miscellaneous.dart';

// // class TestReportPage extends StatefulWidget {
// //   TestReportPage({Key? key}) : super(key: key);
// //   @override
// //   State<TestReportPage> createState() => _State();
// // }

// // class _State extends State<TestReportPage> {
// //   late String testId;
// //   late String batchId;
// //   bool agreed = false;
// //   _State() {
// //     var data = Get.arguments;
// //     testId = data[0];
// //     batchId = data[1];
// //     print("Test id on report page:$testId");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Material(
// //         color: appColors["background"]!,
// //         child: GetBuilder<StudentsController>(
// //           builder: (controller) {
// //             return FutureBuilder<APIResponse>(
// //               future: controller.getTestReport(testId),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return Center(
// //                     child: clumsyWaitingBar(),
// //                   );
// //                 } else if (snapshot.hasError) {
// //                   return Container(
// //                       child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Text("Some error Occured"),
// //                       Text(snapshot.error.toString()),
// //                     ],
// //                   ));
// //                 } else if (snapshot.hasData) {
// //                   APIResponse apiResponse = snapshot.data!;
// //                   if (apiResponse.status == TextMessages.SUCCESS) {
// //                     TestReport testReport = apiResponse.data as TestReport;
// //                     return Column(
// //                       children: [
// //                         headerBar("Test Report", parent: true),
// //                         testItemWidget2(testReport.test),
// //                         // Check if the test is currently active
// //                         if (testReport.test.startTime != null &&
// //                             DateTime.parse(testReport.test.startTime!)
// //                                 .toLocal()
// //                                 .isBefore(DateTime.now()) &&
// //                             testReport.test.endTime != null &&
// //                             DateTime.parse(testReport.test.endTime!)
// //                                 .toLocal()
// //                                 .isAfter(DateTime.now()))
// //                           ClumsyRealButton("Start", Get.width * 0.7, () async {
// //                             APIResponse res = await controller
// //                                 .createNewTestState(testId, batchId);
// //                             if (res.status != TextMessages.SUCCESS) {
// //                               print(res.info!);
// //                               showSnackbar("Error", res.info!);
// //                               return;
// //                             }
// //                             // TestContext tc = res.data as TestContext;
// //                             await Get.toNamed(Routes.TEST_PAGE,
// //                                 arguments: res.data);
// //                             setState(() {});
// //                           }, false),
// //                         Expanded(
// //                           child: SingleChildScrollView(
// //                             child: Column(
// //                               children: [
// //                                 SizedBox(
// //                                   height: 20,
// //                                 ),
// //                                 // Display pending tests
// //                                 if (testReport.testStates.length > 0)
// //                                   clumsyTextLabel("Pending Tests",
// //                                       fontsize: 20,
// //                                       color: appColors['primary']),
// //                                 if (testReport.testStates.length > 0)
// //                                   ...List.generate(testReport.testStates.length,
// //                                       (index) {
// //                                     return Container(
// //                                       margin: EdgeInsets.all(10),
// //                                       padding: EdgeInsets.all(10),
// //                                       child: InkWell(
// //                                         onTap: () async {
// //                                           // Navigate to the test page with the test state ID
// //                                           await Get.toNamed(Routes.TEST_PAGE,
// //                                               arguments: testReport
// //                                                   .testStates[index].id);
// //                                           setState(() {});
// //                                         },
// //                                         child: Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceEvenly,
// //                                           children: [
// //                                             Column(
// //                                               children: [
// //                                                 clumsyTextLabel("Attempt#",
// //                                                     fontsize: 10),
// //                                                 clumsyTextLabel(testReport
// //                                                     .testStates[index]
// //                                                     .attemptNumber
// //                                                     .toString()),
// //                                               ],
// //                                             ),
// //                                             SizedBox(
// //                                               height: 20,
// //                                             ),
// //                                             Column(
// //                                               children: [
// //                                                 clumsyTextLabel(
// //                                                     "Time Left(Minutes)",
// //                                                     fontsize: 10),
// //                                                 clumsyTextLabel(
// //                                                     (testReport
// //                                                             .testStates[index]
// //                                                             .timeLeft /
// //                                                         60)
// //                                                         .toStringAsFixed(2)),
// //                                               ],
// //                                             ),
// //                                             MaterialButton(
// //                                               onPressed: () async {
// //                                                 // Navigate to the test page with the test state ID
// //                                                 await Get.toNamed(
// //                                                     Routes.TEST_PAGE,
// //                                                     arguments: testReport
// //                                                         .testStates[index].id);
// //                                                 setState(() {});
// //                                               },
// //                                               color: appColors["green"]!,
// //                                               textColor: appColors["white"]!,
// //                                               child: Column(
// //                                                 children: [
// //                                                   Icon(
// //                                                     Icons.start,
// //                                                     size: 24,
// //                                                   ),
// //                                                   clumsyTextLabel("Continue",
// //                                                       fontsize: 10,
// //                                                       color:
// //                                                           appColors["white"]!)
// //                                                 ],
// //                                               ),
// //                                               padding: EdgeInsets.all(16),
// //                                               shape: CircleBorder(),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ),
// //                                     );
// //                                   }),
// //                                 SizedBox(
// //                                   height: 50,
// //                                 ),
// //                                 // Display test results
// //                                 if (testReport.results.length > 0)
// //                                   clumsyTextLabel("Test Result Report",
// //                                       fontsize: 20,
// //                                       color: appColors['primary']),
// //                                 ...List.generate(testReport.results.length,
// //                                     (index) {
// //                                   return Container(
// //                                     // margin: EdgeInsets.all(20),
// //                                     padding: EdgeInsets.all(20),
// //                                     child: InkWell(
// //                                       onTap: () {
// //                                         // Navigate to the test result page with the test state ID
// //                                         Get.toNamed(Routes.TEST_RESULT_PAGE,
// //                                             arguments: testReport
// //                                                 .results[index].id);
// //                                       },
// //                                       child: Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceEvenly,
// //                                         children: [
// //                                           Column(
// //                                             children: [
// //                                               clumsyTextLabel("Attempt#",
// //                                                   fontsize: 10),
// //                                               clumsyTextLabel(testReport
// //                                                   .results[index]
// //                                                   .attemptNumber
// //                                                   .toString()),
// //                                             ],
// //                                           ),
// //                                           SizedBox(
// //                                             height: 20,
// //                                           ),
// //                                           Column(
// //                                             children: [
// //                                               clumsyTextLabel("Marks#",
// //                                                   fontsize: 10),
// //                                               clumsyTextLabel(
// //                                                   "${testReport.results[index].total}/${testReport.results[index].maxMarks}"),
// //                                             ],
// //                                           ),
// //                                           SizedBox(
// //                                             height: 20,
// //                                           ),
// //                                           MaterialButton(
// //                                             onPressed: () {
// //                                               // Navigate to the test result page with the test state ID
// //                                               Get.toNamed(
// //                                                   Routes.TEST_RESULT_PAGE,
// //                                                   arguments: testReport
// //                                                       .results[index].id);
// //                                             },
// //                                             color: appColors["blue"]!,
// //                                             textColor: appColors["white"]!,
// //                                             child: Column(
// //                                               children: [
// //                                                 Icon(
// //                                                   Icons.done_all,
// //                                                   size: 24,
// //                                                 ),
// //                                                 clumsyTextLabel("Results",
// //                                                     fontsize: 10,
// //                                                     color:
// //                                                         appColors["white"]!)
// //                                               ],
// //                                             ),
// //                                             padding: EdgeInsets.all(16),
// //                                             shape: CircleBorder(),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   );
// //                                 }),
// //                               ],
// //                             ),
// //                           ),
// //                         )
// //                       ],
// //                     );
// //                   } else {
// //                     return Container(
// //                         child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         headerBar("Test Reports", parent: true),
// //                         clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
// //                         clumsyTextLabel(apiResponse.info!.toString(),
// //                             fontsize: 10),
// //                       ],
// //                     ));
// //                   }
// //                 } else {
// //                   return Container(
// //                       child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Text("Some error Occured"),
// //                       Text(snapshot.error.toString()),
// //                     ],
// //                   ));
// //                 }
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/gravity/test_report.dart';
import 'package:getx/app/data/model/gravity/test_context.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/model/gravity/test.dart';
import '../../widgets/event_page_caraousal.dart';
import '../../widgets/host_event_media_list.dart';
import '../../widgets/miscellaneous.dart';

class TestReportPage extends StatefulWidget {
  TestReportPage({Key? key}) : super(key: key) {
    // Get.put<HostController>(HostController());
  }
  @override
  State<TestReportPage> createState() => _State();
}

class _State extends State<TestReportPage> {
  late String testId;
  late String batchId;
  bool agreed = false;
  _State() {
    var data = Get.arguments;
    testId = data[0];
    batchId = data[1];
    print("Test id on report page:$testId");
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getTestReport(testId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context, apiResponse) {
            if (apiResponse!.status == TextMessages.SUCCESS) {
              TestReport testReport = apiResponse.data as TestReport;
              return Column(
                children: [
                  headerBar("Test Report", parent: true),
                  testItemWidget2(testReport.test),
                  if (testReport.test.startTime != null
                      ? DateTime.parse(testReport.test.startTime!)
                          .toLocal()
                          .isBefore(DateTime.now())
                      : true && testReport.test.endTime != null
                          ? DateTime.parse(testReport.test.endTime!)
                              .toLocal()
                              .isAfter(DateTime.now())
                          : true)
                    ClumsyRealButton("Start", Get.width * 0.7, () async {
                      APIResponse res = await Get.find<StudentsController>()
                          .createNewTestState(testId,batchId);
                      if (res.status != TextMessages.SUCCESS) {
                        print(res.info!);
                        showSnackbar("Error", res.info!);
                        return;
                      }
                      // TestContext tc = res.data as TestContext;
                      await Get.toNamed(Routes.TEST_PAGE, arguments: res.data);
                      setState(() {});
                    }, false),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          if (testReport.testStates.length > 0)
                            clumsyTextLabel("Pending Tests",
                                fontsize: 20, color: appColors['primary']),
                          if (testReport.testStates.length > 0)
                            ...List.generate(testReport.testStates.length,
                                (index) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    // Get.toNamed(Routes.TEST_PAGE,arguments: {"test":testId,"test_state":testReport.testStates[index].id});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          clumsyTextLabel("Attempt#",
                                              fontsize: 10),
                                          clumsyTextLabel(testReport
                                              .testStates[index].attemptNumber
                                              .toString()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          clumsyTextLabel("Time Left(Minutes)",
                                              fontsize: 10),
                                          clumsyTextLabel((testReport
                                                      .testStates[index]
                                                      .timeLeft /
                                                  60)
                                              .toStringAsFixed(2)),
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await Get.toNamed(Routes.TEST_PAGE,
                                              arguments: testReport
                                                  .testStates[index].id);
                                          setState(() {});
                                          // Get.toNamed(Routes.BOOKINGS,arguments:Get.find<Authentication>().user!.id );
                                        },
                                        color: appColors["green"]!,
                                        textColor: appColors["white"]!,
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.start,
                                              size: 24,
                                            ),
                                            clumsyTextLabel("Continue",
                                                fontsize: 10,
                                                color: appColors["white"]!)
                                          ],
                                        ),
                                        padding: EdgeInsets.all(16),
                                        shape: CircleBorder(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          SizedBox(
                            height: 50,
                          ),
                          if (testReport.results.length > 0)
                            clumsyTextLabel("Test Result Report",
                                fontsize: 20, color: appColors['primary']),
                          ...List.generate(testReport.results.length, (index) {
                            return Container(
                              // margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              child: InkWell(
                                onTap: () {
                                  // Get.toNamed(Routes.TEST_RESULT_PAGE,arguments: {"test":testId,"test_state":testReport.results[index].id});
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        clumsyTextLabel("Attempt#",
                                            fontsize: 10),
                                        clumsyTextLabel(testReport
                                            .results[index].attemptNumber
                                            .toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        clumsyTextLabel("Marks#", fontsize: 10),
                                        clumsyTextLabel(
                                            "${testReport.results[index].total}/${testReport.results[index].maxMarks}"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.TEST_RESULT_PAGE,
                                            arguments:
                                                testReport.results[index].id);
                                      },
                                      color: appColors["blue"]!,
                                      textColor: appColors["white"]!,
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.done_all,
                                            size: 24,
                                          ),
                                          clumsyTextLabel("Results",
                                              fontsize: 10,
                                              color: appColors["white"]!)
                                        ],
                                      ),
                                      padding: EdgeInsets.all(16),
                                      shape: CircleBorder(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  headerBar("Test Reports", parent: true),
                  clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                  clumsyTextLabel(apiResponse.info!.toString(), fontsize: 10),
                ],
              ));
            }
          },
          error: (context, error, stackTrace) {
            print(error.runtimeType);
            print(error);
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Some error Occured"),
                Text(error.toString()),
              ],
            ));
          },
        ),
      ),
    );
    // return Container(
    //   child: Column(
    //     children: [
    //       ClumsyMediaList(event.medias),
    //       EventPhasesWidget(eventId: event.id, phases: event.phases)
    //     ],
    //   )
    // );
  }
}


