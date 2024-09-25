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

class MyBatchPage extends StatefulWidget {
  MyBatchPage({Key? key}):super(key: key){
  }
  @override
  State<MyBatchPage> createState() => _State();
}

class _State extends State<MyBatchPage> {
  late String _localPath;

  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          future: Get.find<StudentsController>().getMyBatch(),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
            {
              Batch batch = apiResponse.data as Batch;
              return Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerBar("Batch",parent:true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),

                        child: SizedBox(
                          height:Get.height*0.5,
                          child: TabContainer(
                            isStringTabs: false,
                            color: appColors['primary'],
                            tabs: [
                              clumsyTextLabel("Lectures",color: appColors['black']),
                              clumsyTextLabel("Tests",color: appColors['black']),
                              clumsyTextLabel("Files",color: appColors['black']),
                            ],
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  children: [
                                    if(batch.lectures.isEmpty) Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: clumsyTextLabel("Sorry, there are no lectures for this batch.",color: appColors["white"]),
                                    ),

                                    ...List.generate(batch.lectures.length, (index){
                                      return  InkWell(
                                        onTap: (){
                                          Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                                        },
                                        child: Container(
                                          // padding:EdgeInsets.all(20),
                                          margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                          decoration: BoxDecoration(
                                            color: appColors['white'],
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ListTile(
                                            tileColor: appColors['white'],
                                            trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                            title: clumsyTextLabel(batch.lectures[index].name.toUpperCase(),color: appColors['primary']),
                                            subtitle: clumsyTextLabel(batch.lectures[index].description,color: appColors['primary'],fontsize: 12) ,
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
                                    if(batch.tests.isEmpty) Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: clumsyTextLabel("Sorry, there are no tests for this batch.",color: appColors["white"]),
                                    ),
                                    ...List.generate(batch.tests.length, (index){
                                      return  InkWell(
                                        onTap: (){
                                          Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: batch.tests[index].id);
                                        },
                                        child: Container(
                                          // padding:EdgeInsets.all(20),
                                          margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                          decoration: BoxDecoration(
                                            color: appColors['white'],
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ListTile(
                                            tileColor: appColors['white'],
                                            trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                            title: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
                                            subtitle: clumsyTextLabel(batch.tests[index].test_type,color: appColors['primary'],fontsize: 10),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),Container(
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if(batch.files.isEmpty) Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: clumsyTextLabel("Sorry, there are no files for this batch.",color: appColors["white"]),
                                    ),
                                    // if(batch.files.isEmpty) clumsyTextLabel("Sorry, there are no files for this batch."),
                                    ...List.generate(batch.files.length, (index){
                                      return  InkWell(
                                        onTap: () async {
                                          final taskId = await FlutterDownloader.enqueue(
                                            url: batch.files[index].file.url,
                                            headers: {}, // optional: header send with url (auth token etc)
                                            savedDir: '/storage/emulated/0/Downloads/',
                                            showNotification: true, // show download progress in status bar (for Android)
                                            openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                          );
                                          // Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                                        },
                                        child: Container(
                                          // padding:EdgeInsets.all(20),
                                          margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                          decoration: BoxDecoration(
                                            color: appColors['white'],
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ListTile(
                                            tileColor: appColors['white'],
                                            trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
                                            title: clumsyTextLabel(batch.files[index].name,color: appColors['primary']),
                                            subtitle: clumsyTextLabel(batch.files[index].contentType,color: appColors['primary'],fontsize: 10) ,
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

