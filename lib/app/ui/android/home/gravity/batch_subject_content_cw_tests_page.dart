
// import 'dart:io';

// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/data/model/gravity/batch_chapter.dart';
// import 'package:getx/app/data/model/gravity/batch_subject.dart';

// import 'package:getx/app/data/model/gravity/lecture.dart';
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

// class BatchSubjectContentCwTestsPage extends StatefulWidget {
//   BatchSubjectContentCwTestsPage({Key? key}) : super(key: key) {}
//   @override
//   State<BatchSubjectContentCwTestsPage> createState() => _State();
// }

// class _State extends State<BatchSubjectContentCwTestsPage> {
//   // late String testStateId;
//   // late String batchId;
//   late String batchSubjectId;
//   late String _localPath;

//   _State() {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.white));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     batchSubjectId= Get.arguments as String;
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
//         child: AsyncBuilder<APIResponse>(
//           future: Get.find<StudentsController>().getBatchSubjectContentCwTests(batchSubjectId),
//           waiting: (context) {
//             return Center(
//               child: clumsyWaitingBar(),
//             );
//           },
//           builder: (context,apiResponse){
//             if(apiResponse!.status == TextMessages.SUCCESS)
//             {
//             Batch batch =apiResponse.data as Batch;
              
//               return SingleChildScrollView(
//                 child: Container(
//                     margin: const EdgeInsets.all(0),
//                     padding: const EdgeInsets.all(0),

//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         headerBar("ChapterWise",parent:true),
                    
                     

          
//        Padding(
//                           padding: const EdgeInsets.all(18.0),

//                           child: SizedBox(
//                             height:Get.height*0.5,
//                             child: TabContainer(
//                               isStringTabs: false,
//                               color: Colors.grey.shade300,
//                               tabs: [
                              
//                                 clumsyTextLabel("chapterwise tests",color: appColors['black']),
                           
//                               ],
//                               // colors: [],
//                               children: [
                               
//                            Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: appColors['primary'],
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: ListView(
//                                   // mainAxisAlignment:MainAxisAlignment.start,
//                                   children: [
//                                     if (batch.chapterWiseTests.isEmpty)
//                                       Padding(
//                                         padding: const EdgeInsets.all(18.0),
//                                         child: clumsyTextLabel(
//                                             "Sorry, there are no tests for this chapter.",
//                                             color: appColors["white"]),
//                                       ),
//                                     ...List.generate(batch.chapterWiseTests.length,
//                                         (index) {
//                                       return InkWell(
//                                         onTap: () {
//                                           Get.toNamed(Routes.TEST_REPORT_PAGE,
//                                               arguments: [
//                                                 batch.chapterWiseTests[index].id,
//                                                 batch.id,
//                                               ]);
//                                         },
//                                         child:
                                        
//                                          Container(
//                                           // padding:EdgeInsets.all(20),
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 4),
//                                           decoration: BoxDecoration(
//                                             color: appColors['white'],
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: ListTile(
//                                             tileColor: appColors['white'],
//                                             trailing: Icon(
//                                               Icons.arrow_circle_right,
//                                               color: appColors['primary'],
//                                             ),
//                                             title: clumsyTextLabel(
//                                                 batch.chapterWiseTests[index].name,
//                                                 color: appColors['primary']),
//                                             subtitle: clumsyTextLabel(
//                                                 batch.chapterWiseTests[index].test_type,
//                                                 color: appColors['primary'],
//                                                 fontsize: 10),
//                                           ),
//                                         ),
                                    
//                                       );
//                                     })
//                                   ],
//                                 ),
//                               ),
                      
                              
//                               ],

//                             ),
//                           ),
//                         ),
                                
//                         // Divider(color:Colors.green),
//                       ],
//                     )
//                 ),
//               );
          
          
//             }
//             else
//             {
//               // showSnackbar("Error", apiResponse!.info!);
//               print(apiResponse!.info!);
//               return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Text(ErrorMessages.SOMETHINGS_WRONG),
//                       ClumsyFinalButton("Retry", Get.width*0.6, () {
//                         setState(() {

//                         });
//                       }, false)
//                       // Text(error.toString()),
//                     ],
//                   )
//               );
//             }
//           },
//           error: (context, error, stackTrace) {
//             return Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text("Some error Occured"),
//                     Text(error.toString()),
//                   ],
//                 )
//             );
//           },
//         )
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






































import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/batch_chapter.dart';
import 'package:getx/app/data/model/gravity/batch_subject.dart';

import 'package:getx/app/data/model/gravity/lecture.dart';
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

class BatchSubjectContentCwTestsPage extends StatefulWidget {
  BatchSubjectContentCwTestsPage({Key? key}) : super(key: key) {}
  @override
  State<BatchSubjectContentCwTestsPage> createState() => _State();
}

class _State extends State<BatchSubjectContentCwTestsPage> {
  // late String testStateId;
  // late String batchId;
  late String batchSubjectId;
  late String _localPath;

  _State() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   batchSubjectId= Get.arguments as String;
  // }

  @override
void initState() {
  super.initState();
  final args = Get.arguments as List<dynamic>;
  batchSubjectId = args[0] as String;
}


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
          future: Get.find<StudentsController>().getBatchSubjectContentCwTests(batchSubjectId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
            {
            Batch batch =apiResponse.data as Batch;
              
              return SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerBar("ChapterWise",parent:true),
                    
                     

          
       Padding(
                          padding: const EdgeInsets.all(18.0),

                          child: SizedBox(
                            height:Get.height*0.5,
                            child: TabContainer(
                              isStringTabs: false,
                              color: Colors.grey.shade300,
                              tabs: [
                              
                                clumsyTextLabel("chapterwise tests",color: appColors['black']),
                           
                              ],
                              // colors: [],
                              children: [
                               
                           Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if (batch.chapterWiseTests.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: clumsyTextLabel(
                                            "Sorry, there are no tests for this chapter.",
                                            color: appColors["white"]),
                                      ),
                                    ...List.generate(batch.chapterWiseTests.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.TEST_REPORT_PAGE,
                                              arguments: [
                                                batch.chapterWiseTests[index].id,
                                                batch.id,
                                              ]);
                                        },
                                        child:
                                        
                                         Container(
                                          // padding:EdgeInsets.all(20),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: appColors['white'],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ListTile(
                                            tileColor: appColors['white'],
                                            trailing: Icon(
                                              Icons.arrow_circle_right,
                                              color: appColors['primary'],
                                            ),
                                            title: clumsyTextLabel(
                                                batch.chapterWiseTests[index].name,
                                                color: appColors['primary']),
                                            subtitle: clumsyTextLabel(
                                                batch.chapterWiseTests[index].test_type,
                                                color: appColors['primary'],
                                                fontsize: 10),
                                          ),
                                        ),
                                    
                                      );
                                    })
                                  ],
                                ),
                              ),
                      
                              
                              ],

                            ),
                          ),
                        ),
                                
                        // Divider(color:Colors.green),
                      ],
                    )
                ),
              );
          
          
            }
            else
            {
              // showSnackbar("Error", apiResponse!.info!);
              print(apiResponse!.info!);
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(ErrorMessages.SOMETHINGS_WRONG),
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
                    const Text("Some error Occured"),
                    Text(error.toString()),
                  ],
                )
            );
          },
        )
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













































