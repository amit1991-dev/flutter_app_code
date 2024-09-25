import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/academic_file.dart';
import 'package:getx/app/data/model/gravity/lecture.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tab_container/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';
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

class FileChapterPage extends StatefulWidget {
  FileChapterPage({Key? key}):super(key: key){
  }
  @override
  State<FileChapterPage> createState() => _State();
}

class _State extends State<FileChapterPage> {
  late String subjectId,batchId,chapterId;

  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,String> data = Get.arguments;
    subjectId = data['subject']!;
    batchId = data['batch']!;
    chapterId =data['chapter']!;
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
          future: Get.find<StudentsController>().getChapterFiles(batchId,subjectId,chapterId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
            {
              List<AcademicFile> academicFiles = apiResponse.data as List<AcademicFile> ;
              print("Academic Files");
              print(academicFiles);
              return Container(
                  margin: const EdgeInsets.all(20),
                  // padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerBar("Academic Files",parent:true),
                      if(academicFiles.isEmpty) Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: clumsyTextLabel("Sorry, there are no Questions for this Exercise.",color: appColors["white"]),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              if(academicFiles.isEmpty) clumsyTextLabel("Sorry, there are currently no Files available in this Chapter!"),
                              ...List.generate(academicFiles.length, (index) {
                                // return gravityTestsListTile(subjects[index]);
                                return ListTile(
                                  onTap: () async {
                                    Uri uri = Uri.parse(academicFiles[index].file.url);
                                    if (!await launchUrl(uri)) {
                                      Get.snackbar("Error", "Could not open the link for the file");
                                    }
                                  },
                                  tileColor: appColors['white'],
                                  trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                  title: clumsyTextLabel(academicFiles[index].name.toUpperCase(),color: appColors['primary']),
                                );
                              }),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              );
            }
            else
            {
              print(apiResponse!.info!);
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClumsyFinalButton("Retry", Get.width*0.6, () {
                        setState(() {

                        });
                      }, false)
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

