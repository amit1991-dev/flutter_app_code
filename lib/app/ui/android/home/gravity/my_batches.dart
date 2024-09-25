import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tab_container/tab_container.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../data/model/gravity/batch.dart';
import '../../../../data/model/gravity/question.dart';
import '../../widgets/gravity/quiz_question_widgets/question_widget.dart';
import '../../widgets/miscellaneous.dart';

class MyBatches extends StatefulWidget {
  MyBatches({Key? key}) : super(key: key) {}
  @override
  State<MyBatches> createState() => _State();
}

class _State extends State<MyBatches> {
  // late String testStateId;
  // late String batchId;
  late String _localPath;

  _State() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        future: Get.find<StudentsController>().getMyBatches(),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context, apiResponse) {
          if (apiResponse!.status == TextMessages.SUCCESS) {
            // Batch batch = apiResponse.data as Batch;
            List<Batch> batches = apiResponse.data as List<Batch>;
            return Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // headerBar("Student Batches",parent:true),
Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: appColors['primary']),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        // Get.toNamed(Routes.HOME_PAGE);
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        size: 25,
                        color: appColors["white"]!,
                      )),
                  Container(
                      margin: const EdgeInsets.all(20),
                      // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
                      child: clumsyTextLabel("Student Batches",
                          color: appColors['white']!, fontsize: 20)),
                ],
              )),
      
      ],
    ),
  ),

       
                    // Container(
                    //   width: Get.width,
                    //   padding: EdgeInsets.all(10),
                    //   margin: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: appColors['primary']),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: clumsyTextLabel("Student Batches",
                    //         fontsize: 25, color: appColors['white']),
                    //   ),
                    // ),
                  
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28.0,),
                      child: clumsyTextLabel(
                          "Enrolled in ${batches.length} Batches",
                          fontsize: 14,
                          color: appColors['primary']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: clumsyTextLabel("Session: 2023-2024",
                          fontsize: 14, color: appColors['grey']),
                    ),
                    ...List.generate(batches.length, (index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.BATCH_PAGE,arguments: batches[index].id);
                          //golu;
                          // Get.toNamed(Routes.BATCH_SUBJECT_PAGE, arguments: batches[index].id);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                            color: appColors['white'],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              tileColor: appColors['white'],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: clumsyTextLabel(batches[index].name
                                  .toUpperCase(),
                                  fontsize: 14,
                                  color: appColors['primary']),
                              
                              subtitle: 
                              clumsyTextLabel(
                                  // "#Subjects: ${batches[index].lectures.length} #Tests: ${batches[index].tests.length}",
                                  
                                 (' ${batches[index].stream!.name}').toUpperCase(),
    
                                  fontsize: 10,
                                  // color: appColors['primary'],

                                  ),
                              trailing: Icon(
                                Icons.arrow_circle_right,
                                color: appColors['primary'],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: clumsyTextLabel("Lectures",fontsize: 20,color: appColors['primary']),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child:Row(
                    //     children: [
                    //       ...List.generate(batch.lectures.length, (index){
                    //         return  InkWell(
                    //           onTap: (){
                    //             // Get.toNamed("");
                    //             Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                    //           },
                    //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    //           splashColor: appColors["primary"],
                    //           child: Container(
                    //             width: Get.width*0.35,
                    //             height: 100,
                    //             margin: EdgeInsets.all(20),
                    //             padding: EdgeInsets.all(20),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(22),
                    //                 color: appColors['white'],
                    //                 // border: Border.all(color: appColors['primary']!),
                    //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
                    //             ),
                    //             child: Center(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 // crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Center(
                    //                     child: SizedBox(
                    //                         height:20,
                    //                         child: Image.asset('assets/images/glogoB.png')),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: clumsyTextLabel(batch.lectures[index].name,color: appColors['primary']),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       })
                    //     ],
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: clumsyTextLabel("Tests",fontsize: 20,color: appColors['primary']),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child:Row(
                    //     children: [
                    //       ...List.generate(batch.tests.length, (index){
                    //         return  InkWell(
                    //           onTap: (){
                    //             // Get.toNamed("");
                    //           },
                    //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    //           splashColor: appColors["primary"],
                    //           child: Container(
                    //             width: Get.width*0.35,
                    //             height: 100,
                    //             margin: EdgeInsets.all(20),
                    //             padding: EdgeInsets.all(20),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(22),
                    //                 color: appColors['white'],
                    //                 // border: Border.all(color: appColors['primary']!),
                    //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
                    //             ),
                    //             child: Center(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 // crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Center(
                    //                     child: SizedBox(
                    //                         height:20,
                    //                         child: Image.asset('assets/images/glogoB.png')),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       })
                    //     ],
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: clumsyTextLabel("Files",fontsize: 20,color: appColors['primary']),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child:Row(
                    //     children: [
                    //       ...List.generate(batch.files.length, (index){
                    //         return  InkWell(
                    //           onTap: (){
                    //             // Get.toNamed("");
                    //           },
                    //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    //           splashColor: appColors["primary"],
                    //           child: Container(
                    //             width: Get.width*0.35,
                    //             height: 100,
                    //             margin: EdgeInsets.all(20),
                    //             padding: EdgeInsets.all(20),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(22),
                    //                 color: appColors['white'],
                    //                 // border: Border.all(color: appColors['primary']!),
                    //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
                    //             ),
                    //             child: Center(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 // crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Center(
                    //                     child: SizedBox(
                    //                         height:20,
                    //                         child: Image.asset('assets/images/glogoB.png')),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: clumsyTextLabel(batch.files[index].name,color: appColors['primary']),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       })
                    //     ],
                    //   ),
                    // ),
                  ],
                ));
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
          return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
          const Text("Some error Occured"),
          Text(error.toString()),
                      ],
                    );
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
