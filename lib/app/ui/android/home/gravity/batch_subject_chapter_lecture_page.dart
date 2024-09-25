
import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/batch_chapter.dart';
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

class BatchSubjectChapterLecturePage extends StatefulWidget {
  BatchSubjectChapterLecturePage({Key? key}) : super(key: key) {}
  @override
  State<BatchSubjectChapterLecturePage> createState() => _State();
}

class _State extends State<BatchSubjectChapterLecturePage> {
  // late String testStateId;
  // late String batchId;
  late String batchChapterId;
  late String _localPath;

  _State() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    batchChapterId = Get.arguments as String;
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
          future: Get.find<StudentsController>().getBatchSubjectChapterLecture(batchChapterId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
            {
            Lecture lecture =apiResponse.data as Lecture;
              
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
                        headerBar("Topics",parent:true),
                    
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                        //   child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
                        // ),
                  

          
       Padding(
                          padding: const EdgeInsets.all(18.0),

                          child: SizedBox(
                            height:Get.height*0.5,
                            child: TabContainer(
                              isStringTabs: false,
                              color: Colors.grey.shade300,
                              tabs: [
                                // clumsyTextLabel("Tests",color: appColors['black']),
                                clumsyTextLabel("Lectures",color: appColors['black']),
                                clumsyTextLabel("Dpp",color: appColors['black']),
                                clumsyTextLabel("Module Files",color: appColors['black']),
                              ],
                              // colors: [],
                              children: [
                               
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: appColors['primary'],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView(
                                    // mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      if(lecture.lectures.isEmpty) Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: clumsyTextLabel("Sorry, there are no lectures for this batch.",color: appColors["white"]),
                                      ),

                                      ...List.generate(lecture.lectures.length, (index){
                                        return  InkWell(
                                          onTap: (){
                                            Get.toNamed(Routes.LECTURE_PAGE,arguments: lecture.lectures[index].id);
                                          },
                                          child: Container(
                                            // padding:EdgeInsets.all(20),
                                            margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                           
                                            decoration: BoxDecoration(
                                              color: appColors['white'],
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              tileColor: appColors['white'],
                                              trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                              title: clumsyTextLabel(lecture.lectures[index].name.toUpperCase(),color: appColors['primary'],fontsize: 14),
                                              subtitle: clumsyTextLabel(lecture.lectures[index].description,color: appColors['primary'],fontsize: 12) ,
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                                
                            Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: appColors['primary'],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView(
                                    // mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      if(lecture.files.isEmpty) Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel("Sorry, there are no files for this batch.",color: appColors["white"]),
                                      ),
                                      // if(batch.files.isEmpty) clumsyTextLabel("Sorry, there are no files for this batch."),
                                      ...List.generate(lecture.files.length, (index){
                                        return  InkWell(
                                          onTap: () async {
                                            // Uri uri = Uri.parse( batch.files[index].file.url);
                                            // if (!await launchUrl(uri)) {
                                            //   Get.snackbar("Error", "Could not open the link for the file");
                                            // }

                                            // final taskId = await FlutterDownloader.enqueue(
                                            //   url: batch.files[index].file.url,
                                            //   headers: {}, // optional: header send with url (auth token etc)
                                            //   savedDir: '/storage/emulated/0/',
                                            //   showNotification: true, // show download progress in status bar (for Android)
                                            //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                            // );


                                            // Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                                          },
                                          child: Container(
                                            // padding:EdgeInsets.all(20),
                                            margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),  
                                            decoration: BoxDecoration(
                                              color: appColors['white'],
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              onTap: () async{
                                                await openLink(lecture.files[index].file.url);
                                              },
                                              tileColor: appColors['white'],
                                              trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
                                              title: clumsyTextLabel(lecture.files[index].name,color: appColors['primary'],fontsize: 14),
                                              subtitle: clumsyTextLabel(lecture.files[index].contentType,color: appColors['primary'],fontsize: 12) ,
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              
                                    
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: appColors['primary'],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView(
                                    // mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      if(lecture.module_files.isEmpty) Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel("Sorry, there are no Modules for this batch.",color: appColors["white"]),
                                      ),
                                      ...List.generate(lecture.module_files.length, (index){
                                        return  InkWell(
                                          onTap: (){
                                            // Get.toNamed(Routes.LECTURE_PAGE,arguments: lecture.moduleFiles[index].id);
                                          },
                                          child: Container(
                                            // padding:EdgeInsets.all(20),
                                            margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                           
                                            decoration: BoxDecoration(
                                              color: appColors['white'],
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                                onTap: () async{
                                                await openLink(lecture.module_files[index].file.url);
                                              },
                                              tileColor: appColors['white'],
                                              trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
                                              title: clumsyTextLabel(lecture.module_files[index].name,color: appColors['primary'],fontsize: 14),
                                              subtitle: clumsyTextLabel(lecture.module_files[index].contentType,color: appColors['primary'],fontsize: 12),
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









































