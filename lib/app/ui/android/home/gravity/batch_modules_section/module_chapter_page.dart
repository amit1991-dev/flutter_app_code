import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tab_container/tab_container.dart';
import '../../../../../controller/gravity/student_controller.dart';
import '../../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../../data/model/gravity/batch.dart';
import '../../../../../data/model/gravity/module_chapter.dart';
import '../../../../../data/model/gravity/question.dart';
import '../../../widgets/gravity/quiz_question_widgets/question_widget.dart';
import '../../../widgets/miscellaneous.dart';

class ModuleChapterPage extends StatefulWidget {
  ModuleChapterPage({Key? key}):super(key: key){
  }
  @override
  State<ModuleChapterPage> createState() => _State();
}

class _State extends State<ModuleChapterPage> {
  late String moduleChapterId;
  late String _localPath;

  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moduleChapterId = Get.arguments as String;


  }

  // Future prepareDownloads() async {
  //   bool _permissionReady = await _checkPermission();
  //   if (_permissionReady) {
  //     await _prepareSaveDir();
  //   }
  // }
  //
  // Future<String?> getDownloadPath() async {
  //   Directory? directory;
  //   try {
  //     if (Platform.isIOS) {
  //       directory = await getApplicationDocumentsDirectory();
  //     } else {
  //       directory = Directory('/storage/emulated/0/Download');
  //       // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
  //       // ignore: avoid_slow_async_io
  //       if (!await directory.exists()) directory = await getExternalStorageDirectory();
  //     }
  //   } catch (err, stack) {
  //     print("Cannot get download folder path");
  //   }
  //   return directory?.path;
  // }
  //
  // Future<void> _prepareSaveDir() async {
  //   _localPath = (await _getSavedDir())!;
  //   final savedDir = Directory(_localPath);
  //   if (!savedDir.existsSync()) {
  //     await savedDir.create();
  //   }
  // }
  //
  // Future<String?> _getSavedDir() async {
  //   String? externalStorageDirPath;
  //
  //   if (Platform.isAndroid) {
  //     try {
  //       externalStorageDirPath = await AndroidPathProvider.downloadsPath;
  //     } catch (err, st) {
  //       print('failed to get downloads path: $err, $st');
  //
  //       final directory = await getExternalStorageDirectory();
  //       externalStorageDirPath = directory?.path;
  //     }
  //   } else if (Platform.isIOS) {
  //     externalStorageDirPath =
  //         (await getApplicationDocumentsDirectory()).absolute.path;
  //   }
  //   return externalStorageDirPath;
  // }
  // Future<bool> _checkPermission() async {
  //   if (Platform.isIOS) {
  //     return true;
  //   }
  //
  //   if (Platform.isAndroid) {
  //     final info = await DeviceInfoPlugin().androidInfo;
  //     if (info.version.sdkInt > 28) {
  //       return true;
  //     }
  //
  //     final status = await Permission.storage.status;
  //     if (status == PermissionStatus.granted) {
  //       return true;
  //     }
  //
  //     final result = await Permission.storage.request();
  //     return result == PermissionStatus.granted;
  //   }
  //
  //   throw StateError('unknown platform');
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getModuleChapter(moduleChapterId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
            {
              ModuleChapter moduleChapter = apiResponse.data as ModuleChapter;
              // moduleChapter.
              return Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerBar("Chapter",parent:true),
                      Card(
                        elevation: 0,
                        // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                        child: ListTile(
                          tileColor: appColors['white'],
                          // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                          title:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                            child: clumsyTextLabel(moduleChapter.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
                          ),
                          trailing: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['primary']),
                            ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(18.0),

                        child: SizedBox(
                          height:Get.height*0.6,
                          child: TabContainer(
                            // selectedTextStyle: TextStyle(color:appColors['white'],fontSize: 14),
                            // unselectedTextStyle: TextStyle(color:appColors['primary']),
                            // colors: [
                            //   appColors['primary']!,
                            //   appColors['red']!,
                            //   appColors['blue']!,
                            // ],
                            isStringTabs: false,
                            color: Colors.lightGreenAccent,
                            tabs: [
                              // 'Lectures',
                              // 'Tests',
                              // 'Files',

                              clumsyTextLabel("Exercise 1",color: appColors['black']),
                              clumsyTextLabel("Exercise 2",color: appColors['black']),
                              clumsyTextLabel("Exercise 3",color: appColors['black']),
                            ],
                            // colors: [],
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if(moduleChapter.level_1.isEmpty) Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: clumsyTextLabel("Sorry, there are no Questions for this Exercise.",color: appColors["white"]),
                                    ),

                                    ...List.generate(moduleChapter.level_1.length, (index){
                                      return InkWell(
                                        onTap: (){
                                          print("yes");

                                        },
                                        child: Container(
                                          // height: 60,
                                          margin:const EdgeInsets.all(20) ,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              color: appColors['background'],
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  clumsyTextLabel("Question# :${index+1}",fontsize: 12),
                                                  // clumsyTextLabel(moduleChapter.level_1[index].topic??"-".toUpperCase(),fontsize: 12),
                                                  // clumsyTextLabel(questions[index].toic??"-".toUpperCase(),fontsize: 12),

                                                  clumsyTextLabel(moduleChapter.level_1[index].questionType.toUpperCase(),fontsize: 12),
                                                  ClumsyRealButton("Attempt", Get.width*0.2, () {
                                                    Get.toNamed(Routes.QUIZ_PAGE,arguments: moduleChapter.level_1[index]);
                                                  }, false),

                                                ],
                                              ),
                                              Divider(color:appColors['primary']),
                                              TeXView(
                                                child: TeXViewDocument(stringToBase64.decode(moduleChapter.level_1[index].question),
                                                  // style: const TeXViewStyle(textAlign: TeXViewTextAlign.left,),

                                                ),
                                                style: TeXViewStyle(
                                                    elevation: 10,
                                                    backgroundColor: appColors['white']!,
                                                    fontStyle: TeXViewFontStyle(fontWeight: TeXViewFontWeight.bolder)
                                                ),
                                              ),


                                            ],
                                          ),

                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if(moduleChapter.level_2.isEmpty) Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: clumsyTextLabel("Sorry, there are no Questions for this Exercise.",color: appColors["white"]),
                                    ),

                                    ...List.generate(moduleChapter.level_2.length, (index){
                                      return InkWell(
                                        onTap: (){
                                          print("yes");

                                        },
                                        child: Container(
                                          // height: 60,
                                          margin:const EdgeInsets.all(20) ,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              color: appColors['background'],
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  clumsyTextLabel("Question# :${index+1}",fontsize: 12),
                                                  // clumsyTextLabel(moduleChapter.level_1[index].topic??"-".toUpperCase(),fontsize: 12),
                                                  // clumsyTextLabel(questions[index].toic??"-".toUpperCase(),fontsize: 12),

                                                  clumsyTextLabel(moduleChapter.level_1[index].questionType.toUpperCase(),fontsize: 12),
                                                  ClumsyRealButton("Attempt", Get.width*0.2, () {
                                                    Get.toNamed(Routes.QUIZ_PAGE,arguments: moduleChapter.level_2[index]);
                                                  }, false),

                                                ],
                                              ),
                                              Divider(color:appColors['primary']),
                                              TeXView(
                                                child: TeXViewDocument(stringToBase64.decode(moduleChapter.level_2[index].question),
                                                ),
                                                style: TeXViewStyle(
                                                    elevation: 10,
                                                    backgroundColor: appColors['white']!,
                                                    fontStyle: TeXViewFontStyle(fontWeight: TeXViewFontWeight.bolder)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if(moduleChapter.level_3.isEmpty) Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: clumsyTextLabel("Sorry, there are no Questions for this Exercise.",color: appColors["white"]),
                                    ),

                                    ...List.generate(moduleChapter.level_3.length, (index){
                                      return InkWell(
                                        onTap: (){
                                          print("yes");

                                        },
                                        child: Container(
                                          // height: 60,
                                          margin:const EdgeInsets.all(20) ,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              color: appColors['background'],
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  clumsyTextLabel("Question# :${index+1}",fontsize: 12),
                                                  // clumsyTextLabel(moduleChapter.level_1[index].topic??"-".toUpperCase(),fontsize: 12),
                                                  // clumsyTextLabel(questions[index].toic??"-".toUpperCase(),fontsize: 12),

                                                  clumsyTextLabel(moduleChapter.level_1[index].questionType.toUpperCase(),fontsize: 12),
                                                  ClumsyRealButton("Attempt", Get.width*0.2, () {
                                                    Get.toNamed(Routes.QUIZ_PAGE,arguments: moduleChapter.level_3[index]);
                                                  }, false),

                                                ],
                                              ),
                                              Divider(color:appColors['primary']),
                                              TeXView(
                                                child: TeXViewDocument(stringToBase64.decode(moduleChapter.level_3[index].question),
                                                  // style: const TeXViewStyle(textAlign: TeXViewTextAlign.left,),

                                                ),
                                                style: TeXViewStyle(
                                                    elevation: 10,
                                                    backgroundColor: appColors['white']!,
                                                    fontStyle: TeXViewFontStyle(fontWeight: TeXViewFontWeight.bolder)
                                                ),
                                              ),


                                            ],
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
                  )
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

