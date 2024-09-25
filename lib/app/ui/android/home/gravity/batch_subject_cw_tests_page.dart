// import 'dart:io';

// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/data/model/gravity/batch_subject.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tab_container/tab_container.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../controller/gravity/student_controller.dart';
// import '../../../../controller/gravity/test_series/test_state_controller.dart';
// import '../../../../data/constants/miscellaneous.dart';
// import '../../../../data/model/api_response.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import '../../../../data/model/gravity/batch.dart';
// import '../../../../data/model/gravity/question.dart';
// import '../../widgets/gravity/quiz_question_widgets/question_widget.dart';
// import '../../widgets/miscellaneous.dart';

// class BatchSubjectCwTestsPage extends StatefulWidget {
//   BatchSubjectCwTestsPage({Key? key}) : super(key: key) {}
//   @override
//   State<BatchSubjectCwTestsPage> createState() => _State();
// }

// class _State extends State<BatchSubjectCwTestsPage> {
//   // late String testStateId;
//   late String batchId;
//   late String _localPath;

//   _State() {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.white));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     batchId = Get.arguments as String;
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.white));
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: AsyncBuilder<APIResponse>(
//         future: Get.find<StudentsController>().getBatchSubjectCwTests(batchId),
//         waiting: (context) {
//           return Center(
//             child: clumsyWaitingBar(),
//           );
//         },
//         builder: (context, apiResponse) {
//           if (apiResponse!.status == TextMessages.SUCCESS) {
//             List<BatchSubject> batchSubjects =
//                 apiResponse.data as List<BatchSubject>;
//             return SingleChildScrollView(
//               child: Container(
//                   margin: const EdgeInsets.all(0),
//                   padding: const EdgeInsets.all(0),
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       headerBar("Subjects", parent: true),
//                       ...List.generate(batchSubjects.length, (index) {
//                         return InkWell(
//                           onTap: () {
//                             print("chapterwiseTests");
//                             Get.toNamed(Routes.BATCH_SUBJECT_CONTENT_CW_TESTS_PAGE,
//                                 arguments: batchSubjects[index].id, );
//                           },
//                           child: Card(
//                             // elevation: 0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20)),

//                             child: ListTile(
//                               tileColor: appColors['background'],
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20)),

//                               title: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 28.0, vertical: 8),
//                                 child: clumsyTextLabel(
//                                     batchSubjects[index].name.toUpperCase(),
                                  

//                                     fontsize: 20,
//                                     color: appColors['primary']),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_circle_right,
//                                 color: appColors['primary'],
//                               ),

//                               // trailing: Padding(
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 8.0),
//                               //   child: clumsyTextLabel("Session: 2023-2024",
//                               //       fontsize: 14, color: appColors['primary']),
//                               // ),
//                               // subtitle: Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                               //   child: clumsyTextLabel(
//                               //       "Chapters: ${batchSubjects[index].chapters.length}",
//                               //       fontsize: 14,
//                               //       color: appColors['primary']),
//                               // ),
//                             ),
//                           ),
//                         );
//                       })
//                       // Card(
//                       //   elevation: 0,
//                       //   // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

//                       //   child: ListTile(
//                       //     tileColor: appColors['background'],
//                       //     // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

//                       //     title:Padding(
//                       //       padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
//                       //       child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
//                       //     ),
//                       //     trailing: Padding(
//                       //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       //         child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['primary']),
//                       //       ),
//                       //     subtitle:  Padding(
//                       //         padding: const EdgeInsets.all(8.0),
//                       //         child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                       //       ),
//                       //   ),
//                       // ),
//                     ],
//                   )),
//             );
//           } else {
//             // showSnackbar("Error", apiResponse!.info!);
//             print(apiResponse!.info!);
//             return Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Text(ErrorMessages.SOMETHINGS_WRONG),
//                 ClumsyFinalButton("Retry", Get.width * 0.6, () {
//                   setState(() {});
//                 }, false)
//                 // Text(error.toString()),
//               ],
//             ));
//           }
//         },
//         error: (context, error, stackTrace) {
//           return Container(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text("Some error Occured"),
//               Text(error.toString()),
//             ],
//           ));
//         },
//       )),
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



import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/batch_subject.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tab_container/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../data/model/gravity/batch.dart';
import '../../../../data/model/gravity/question.dart';
import '../../widgets/gravity/quiz_question_widgets/question_widget.dart';
import '../../widgets/miscellaneous.dart';

class BatchSubjectCwTestsPage extends StatefulWidget {
  BatchSubjectCwTestsPage({Key? key}) : super(key: key) {}
  @override
  State<BatchSubjectCwTestsPage> createState() => _State();
}

class _State extends State<BatchSubjectCwTestsPage> {
  // late String testStateId;
  late String batchId;
  late String _localPath;

  _State() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    batchId = Get.arguments as String;
  }

//   @override
// void initState() {
//   super.initState();
//   final args = Get.arguments as List<dynamic>;
//   batchId = args[0] as String;
// }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getBatchSubjectCwTests(batchId),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context, apiResponse) {
          if (apiResponse!.status == TextMessages.SUCCESS) {
            Batch batch =
                apiResponse.data as Batch;
            return SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerBar("Subjects", parent: true),
                      ...List.generate(batch.batchsubjects.length, (index) {
                        return InkWell(
                          onTap: () {
                            print("chapterwiseTests");
                            Get.toNamed(Routes.BATCH_SUBJECT_CONTENT_CW_TESTS_PAGE,
                                arguments: batch.batchsubjects[index].id, );
                          },
                          child: Card(
                            // elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),

                            child: ListTile(
                              tileColor: appColors['background'],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),

                              title: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0, vertical: 8),
                                child: clumsyTextLabel(
                                    batch.batchsubjects[index].name.toUpperCase(),
                                  

                                    fontsize: 20,
                                    color: appColors['primary']),
                              ),
                              trailing: Icon(
                                Icons.arrow_circle_right,
                                color: appColors['primary'],
                              ),

                              // trailing: Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child: clumsyTextLabel("Session: 2023-2024",
                              //       fontsize: 14, color: appColors['primary']),
                              // ),
                              // subtitle: Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: clumsyTextLabel(
                              //       "Chapters: ${batchSubjects[index].chapters.length}",
                              //       fontsize: 14,
                              //       color: appColors['primary']),
                              // ),
                            ),
                          ),
                        );
                      })
                      // Card(
                      //   elevation: 0,
                      //   // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                      //   child: ListTile(
                      //     tileColor: appColors['background'],
                      //     // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                      //     title:Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                      //       child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
                      //     ),
                      //     trailing: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['primary']),
                      //       ),
                      //     subtitle:  Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       ),
                      //   ),
                      // ),
                    ],
                  )),
            );
          } else {
            // showSnackbar("Error", apiResponse!.info!);
            print(apiResponse!.info!);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(ErrorMessages.SOMETHINGS_WRONG),
                ClumsyFinalButton("Retry", Get.width * 0.6, () {
                  setState(() {});
                }, false)
                // Text(error.toString()),
              ],
            ));
          }
        },
        error: (context, error, stackTrace) {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Some error Occured"),
              Text(error.toString()),
            ],
          ));
        },
      )),
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
