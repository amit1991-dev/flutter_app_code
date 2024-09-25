// import 'dart:io';

// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
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

// class BatchPage extends StatefulWidget {
//   BatchPage({Key? key}):super(key: key){
//   }
//   @override
//   State<BatchPage> createState() => _State();
// }

// class _State extends State<BatchPage> {
//   // late String testStateId;
//   late String batchId;
//   late String _localPath;

//   _State(){
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     batchId = Get.arguments as String;

//   }

//   // Future prepareDownloads() async {
//   //   bool _permissionReady = await _checkPermission();
//   //   if (_permissionReady) {
//   //     await _prepareSaveDir();
//   //   }
//   // }
//   //
//   // Future<String?> getDownloadPath() async {
//   //   Directory? directory;
//   //   try {
//   //     if (Platform.isIOS) {
//   //       directory = await getApplicationDocumentsDirectory();
//   //     } else {
//   //       directory = Directory('/storage/emulated/0/Download');
//   //       // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
//   //       // ignore: avoid_slow_async_io
//   //       if (!await directory.exists()) directory = await getExternalStorageDirectory();
//   //     }
//   //   } catch (err, stack) {
//   //     print("Cannot get download folder path");
//   //   }
//   //   return directory?.path;
//   // }
//   //
//   // Future<void> _prepareSaveDir() async {
//   //   _localPath = (await _getSavedDir())!;
//   //   final savedDir = Directory(_localPath);
//   //   if (!savedDir.existsSync()) {
//   //     await savedDir.create();
//   //   }
//   // }
//   //
//   // Future<String?> _getSavedDir() async {
//   //   String? externalStorageDirPath;
//   //
//   //   if (Platform.isAndroid) {
//   //     try {
//   //       externalStorageDirPath = await AndroidPathProvider.downloadsPath;
//   //     } catch (err, st) {
//   //       print('failed to get downloads path: $err, $st');
//   //
//   //       final directory = await getExternalStorageDirectory();
//   //       externalStorageDirPath = directory?.path;
//   //     }
//   //   } else if (Platform.isIOS) {
//   //     externalStorageDirPath =
//   //         (await getApplicationDocumentsDirectory()).absolute.path;
//   //   }
//   //   return externalStorageDirPath;
//   // }
//   // Future<bool> _checkPermission() async {
//   //   if (Platform.isIOS) {
//   //     return true;
//   //   }
//   //
//   //   if (Platform.isAndroid) {
//   //     final info = await DeviceInfoPlugin().androidInfo;
//   //     if (info.version.sdkInt > 28) {
//   //       return true;
//   //     }
//   //
//   //     final status = await Permission.storage.status;
//   //     if (status == PermissionStatus.granted) {
//   //       return true;
//   //     }
//   //
//   //     final result = await Permission.storage.request();
//   //     return result == PermissionStatus.granted;
//   //   }
//   //
//   //   throw StateError('unknown platform');
//   // }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: AsyncBuilder<APIResponse>(
//           future: Get.find<StudentsController>().getBatch(batchId),
//           waiting: (context) {
//             return Center(
//               child: clumsyWaitingBar(),
//             );
//           },
//           builder: (context,apiResponse){
//             if(apiResponse!.status == TextMessages.SUCCESS)
//             {
//               Batch batch = apiResponse.data as Batch;
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
//                         headerBar("Batch",parent:true),
//                         Card(
//                           elevation: 0,
//                           // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

//                           child: ListTile(
//                             tileColor: appColors['background'],
//                             // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

//                             title:Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
//                               child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
//                             ),
//                             trailing: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['primary']),
//                               ),
//                             subtitle:  Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                               ),
//                           ),
//                         ),

//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
//                         //   child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         //   child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
//                         // ),

//                         //GOLU
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: clumsyTextLabel("Subject Wise"),
//                         ),

// //GOLU-EXPERIMENT
//                       //  Card(

//                       //     elevation: 2,
//                       //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                       //     color: appColors['primary'],
//                       //     child: Padding(
//                       //       padding: const EdgeInsets.all(8.0),
//                       //              ...List.generate(batch.tests.length, (index){
//                       //                   return  InkWell(
//                       //                     onTap: (){
//                       //                       Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: [batch.tests[index].id,batch.id]);
//                       //                     },
//                       //                     child: Container(
//                       //                       // padding:EdgeInsets.all(20),
//                       //                       margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
//                       //                         color: appColors['white'],
//                       //                         borderRadius: BorderRadius.circular(20),
//                       //                       ),
//                       //                       child: ListTile(
//                       //                         tileColor: appColors['white'],
//                       //                         trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
//                       //                         title: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
//                       //                         subtitle: clumsyTextLabel(batch.tests[index].test_type,color: appColors['primary'],fontsize: 10),
//                       //                       ),
//                       //                     ),
//                       //                   );
//                       //                 })

//                       //       //  ListTile(
//                       //       //   onTap: (){
//                       //       //     // Get.toNamed(Routes.BATCH_LECTURE_SUBJECTS_PAGE,arguments: batch.id);
//                       //       //                 Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: [batch.tests[index].id,batch.id]);

//                       //       //   },
//                       //       //   tileColor: appColors['white'],
//                       //       //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

//                       //       //   title:Padding(
//                       //       //     padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                       //       //     child: clumsyTextLabel("Tests".toUpperCase(),fontsize: 18,color: appColors['primary']),
//                       //       //   ),
//                       //       //   trailing: Padding(
//                       //       //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       //       //     child: Icon(Icons.arrow_circle_right,color: Colors.green,),
//                       //       //   ),
//                       //       //   // subtitle:  Padding(
//                       //       //   //   padding: const EdgeInsets.all(8.0),
//                       //       //   //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                       //       //   // ),
//                       //       // ),
//                       //     ),
//                       //   ),

//                         Card(

//                           elevation: 2,
//                           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                           color: appColors['primary'],
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               onTap: (){
//                                 Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments: batch.id);
//                               },
//                               tileColor: appColors['white'],
//                               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

//                               title:Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                                 child: clumsyTextLabel("Study".toUpperCase(),fontsize: 18,color: appColors['primary']),
//                               ),
//                               trailing: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Icon(Icons.arrow_circle_right,color: Colors.green,),
//                               ),
//                               // subtitle:  Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                               //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                               // ),
//                             ),
//                           ),
//                         ),

//                         Card(

//                           elevation: 2,
//                           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                           color: appColors['primary'],
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               onTap: (){
//                                 Get.toNamed(Routes.BATCH_MODULE_SUBJECTS_PAGE,arguments: batch.id);
//                               },
//                               tileColor: appColors['white'],
//                               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

//                               title:Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                                 child: clumsyTextLabel("Modules".toUpperCase(),fontsize: 18,color: appColors['primary']),
//                               ),
//                               trailing: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Icon(Icons.arrow_circle_right,color: Colors.green,),
//                               ),
//                               // subtitle:  Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                               //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                               // ),
//                             ),
//                           ),
//                         ),

//                         // Card(
//                         //
//                         //   elevation: 2,
//                         //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                         //   color: Colors.green,
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.all(8.0),
//                         //     child: ListTile(
//                         //       onTap: (){
//                         //         Get.toNamed(Routes.BATCH_MODULE_SUBJECTS_PAGE,arguments: batch.id);
//                         //       },
//                         //       tileColor: appColors['white'],
//                         //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                         //
//                         //       title:Padding(
//                         //         padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                         //         child: clumsyTextLabel("Tests".toUpperCase(),fontsize: 18,color: appColors['primary']),
//                         //       ),
//                         //       trailing: Padding(
//                         //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         //         child: Icon(Icons.arrow_circle_right,color: Colors.green,),
//                         //       ),
//                         //       // subtitle:  Padding(
//                         //       //   padding: const EdgeInsets.all(8.0),
//                         //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                         //       // ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Card(

//                           elevation: 2,
//                           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
//                           color: appColors['primary'],
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               onTap: (){
//                                 Get.toNamed(Routes.BATCH_FILE_SUBJECTS_PAGE,arguments: batch.id);
//                               },
//                               tileColor: appColors['white'],
//                               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

//                               title:Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                                 child: clumsyTextLabel("Documents".toUpperCase(),fontsize: 18,color: appColors['primary']),
//                               ),
//                               trailing: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: Icon(Icons.arrow_circle_right,color: Colors.green,),
//                               ),
//                             ),
//                           ),
//                         ),
// //GOLU

//                         Padding(
//                           padding: const EdgeInsets.all(18.0),

//                           child: SizedBox(
//                             height:Get.height*0.5,
//                             child: TabContainer(
//                               isStringTabs: false,
//                               color: Colors.grey.shade300,
//                               tabs: [
//                                 clumsyTextLabel("Tests",color: appColors['black']),
//                                 clumsyTextLabel("Study",color: appColors['black']),
//                                 clumsyTextLabel("Modules",color: appColors['black']),
//                                 clumsyTextLabel("Documents",color: appColors['black']),
//                               ],
//                               // colors: [],
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: appColors['primary'],
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: ListView(
//                                     // mainAxisAlignment:MainAxisAlignment.start,
//                                     children: [
//                                       if(batch.tests.isEmpty) Padding(
//                                         padding: const EdgeInsets.all(28.0),
//                                         child: clumsyTextLabel("Sorry, there are no tests for this batch.",color: appColors["white"]),
//                                       ),
//                                       ...List.generate(batch.tests.length, (index){
//                                         return  InkWell(
//                                           onTap: (){
//                                             Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: [batch.tests[index].id,batch.id]);
//                                           },
//                                           child: Container(
//                                             // padding:EdgeInsets.all(20),
//                                             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
//                                               color: appColors['white'],
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: ListTile(
//                                               tileColor: appColors['white'],
//                                               trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
//                                               title: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
//                                               subtitle: clumsyTextLabel(batch.tests[index].test_type,color: appColors['primary'],fontsize: 10),
//                                             ),
//                                           ),
//                                         );
//                                       })
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: appColors['primary'],
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: ListView(
//                                     // mainAxisAlignment:MainAxisAlignment.start,
//                                     children: [
//                                       if(batch.lectures.isEmpty) Padding(
//                                       // if(batch.lectures.isEmpty) Padding(

//                                         padding: const EdgeInsets.all(18.0),
//                                         child: clumsyTextLabel("Sorry, there are no lectures for this batch.",color: appColors["white"]),
//                                       ),

//                                       ...List.generate(batch.batchsubjects.length, (index){
//                                       // ...List.generate(batch.lectures.length, (index){

//                                         return  InkWell(
//                                           onTap: (){
//                                             // Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
//                                             Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments: [batch.id]);

//                                             // Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments:  [batch.batchsubjects[index].id,batch.id]);
//                                             // Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments: batch.id);

//                                           },
//                                           child: Container(
//                                             // padding:EdgeInsets.all(20),
//                                             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
//                                               color: appColors['white'],
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: ListTile(
//                                               tileColor: appColors['white'],
//                                               trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
//                                               title: clumsyTextLabel(batch.batchsubjects[index].name.toUpperCase(),color: appColors['primary']),
//                                               // subtitle: clumsyTextLabel(batch.lectures[index].description,color: appColors['primary'],fontsize: 12) ,
//                                             ),
//                                           ),
//                                         );
//                                       })
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: appColors['primary'],
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: ListView(
//                                     // mainAxisAlignment:MainAxisAlignment.start,
//                                     children: [
//                                       if(batch.modules.isEmpty) Padding(
//                                         padding: const EdgeInsets.all(28.0),
//                                         child: clumsyTextLabel("Sorry, there are no Modules for this batch.",color: appColors["white"]),
//                                       ),
//                                       ...List.generate(batch.modules.length, (index){
//                                         return  InkWell(
//                                           onTap: (){
//                                             Get.toNamed(Routes.MODULE_PAGE,arguments: batch.modules[index].id);
//                                           },
//                                           child: Container(
//                                             // padding:EdgeInsets.all(20),
//                                             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
//                                               color: appColors['white'],
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: ListTile(
//                                               tileColor: appColors['white'],
//                                               trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
//                                               title: clumsyTextLabel(batch.modules[index].name,color: appColors['primary']),
//                                               // subtitle: clumsyTextLabel(batch.modules[index].test_type,color: appColors['primary'],fontsize: 10),
//                                             ),
//                                           ),
//                                         );
//                                       })
//                                     ],
//                                   ),
//                                 ),

//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: appColors['primary'],
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: ListView(
//                                     // mainAxisAlignment:MainAxisAlignment.start,
//                                     children: [
//                                       if(batch.files.isEmpty) Padding(
//                                         padding: const EdgeInsets.all(28.0),
//                                         child: clumsyTextLabel("Sorry, there are no files for this batch.",color: appColors["white"]),
//                                       ),
//                                       // if(batch.files.isEmpty) clumsyTextLabel("Sorry, there are no files for this batch."),
//                                       ...List.generate(batch.files.length, (index){
//                                         return  InkWell(
//                                           onTap: () async {
//                                             // Uri uri = Uri.parse( batch.files[index].file.url);
//                                             // if (!await launchUrl(uri)) {
//                                             //   Get.snackbar("Error", "Could not open the link for the file");
//                                             // }

//                                             // final taskId = await FlutterDownloader.enqueue(
//                                             //   url: batch.files[index].file.url,
//                                             //   headers: {}, // optional: header send with url (auth token etc)
//                                             //   savedDir: '/storage/emulated/0/',
//                                             //   showNotification: true, // show download progress in status bar (for Android)
//                                             //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//                                             // );

//                                             // Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
//                                           },
//                                           child: Container(
//                                             // padding:EdgeInsets.all(20),
//                                             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
//                                               color: appColors['white'],
//                                               borderRadius: BorderRadius.circular(20),
//                                             ),
//                                             child: ListTile(
//                                               onTap: () async{
//                                                 await openLink(batch.files[index].file.url);
//                                               },
//                                               tileColor: appColors['white'],
//                                               trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
//                                               title: clumsyTextLabel(batch.files[index].name,color: appColors['primary']),
//                                               subtitle: clumsyTextLabel(batch.files[index].contentType,color: appColors['primary'],fontsize: 10) ,
//                                             ),
//                                           ),
//                                         );
//                                       })
//                                     ],
//                                   ),
//                                 ),
//                               ],

//                             ),
//                           ),
//                         ),
//                         // Divider(color:Colors.green),

//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: clumsyTextLabel("Lectures",fontsize: 20,color: appColors['primary']),
//                         // ),
//                         // SingleChildScrollView(
//                         //   scrollDirection: Axis.horizontal,
//                         //   child:Row(
//                         //     children: [
//                         //       ...List.generate(batch.lectures.length, (index){
//                         //         return  InkWell(
//                         //           onTap: (){
//                         //             // Get.toNamed("");
//                         //             Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
//                         //           },
//                         //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                         //           splashColor: appColors["primary"],
//                         //           child: Container(
//                         //             width: Get.width*0.35,
//                         //             height: 100,
//                         //             margin: EdgeInsets.all(20),
//                         //             padding: EdgeInsets.all(20),
//                         //             decoration: BoxDecoration(
//                         //                 borderRadius: BorderRadius.circular(22),
//                         //                 color: appColors['white'],
//                         //                 // border: Border.all(color: appColors['primary']!),
//                         //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
//                         //             ),
//                         //             child: Center(
//                         //               child: Column(
//                         //                 mainAxisAlignment: MainAxisAlignment.center,
//                         //                 // crossAxisAlignment: CrossAxisAlignment.start,
//                         //                 children: [
//                         //                   Center(
//                         //                     child: SizedBox(
//                         //                         height:20,
//                         //                         child: Image.asset('assets/images/glogoB.png')),
//                         //                   ),
//                         //                   Padding(
//                         //                     padding: const EdgeInsets.all(8.0),
//                         //                     child: clumsyTextLabel(batch.lectures[index].name,color: appColors['primary']),
//                         //                   ),
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         );
//                         //       })
//                         //     ],
//                         //   ),
//                         // ),
//                         //
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: clumsyTextLabel("Tests",fontsize: 20,color: appColors['primary']),
//                         // ),
//                         // SingleChildScrollView(
//                         //   scrollDirection: Axis.horizontal,
//                         //   child:Row(
//                         //     children: [
//                         //       ...List.generate(batch.tests.length, (index){
//                         //         return  InkWell(
//                         //           onTap: (){
//                         //             // Get.toNamed("");
//                         //           },
//                         //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                         //           splashColor: appColors["primary"],
//                         //           child: Container(
//                         //             width: Get.width*0.35,
//                         //             height: 100,
//                         //             margin: EdgeInsets.all(20),
//                         //             padding: EdgeInsets.all(20),
//                         //             decoration: BoxDecoration(
//                         //                 borderRadius: BorderRadius.circular(22),
//                         //                 color: appColors['white'],
//                         //                 // border: Border.all(color: appColors['primary']!),
//                         //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
//                         //             ),
//                         //             child: Center(
//                         //               child: Column(
//                         //                 mainAxisAlignment: MainAxisAlignment.center,
//                         //                 // crossAxisAlignment: CrossAxisAlignment.start,
//                         //                 children: [
//                         //                   Center(
//                         //                     child: SizedBox(
//                         //                         height:20,
//                         //                         child: Image.asset('assets/images/glogoB.png')),
//                         //                   ),
//                         //                   Padding(
//                         //                     padding: const EdgeInsets.all(8.0),
//                         //                     child: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
//                         //                   ),
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         );
//                         //       })
//                         //     ],
//                         //   ),
//                         // ),
//                         //
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: clumsyTextLabel("Files",fontsize: 20,color: appColors['primary']),
//                         // ),
//                         // SingleChildScrollView(
//                         //   scrollDirection: Axis.horizontal,
//                         //   child:Row(
//                         //     children: [
//                         //       ...List.generate(batch.files.length, (index){
//                         //         return  InkWell(
//                         //           onTap: (){
//                         //             // Get.toNamed("");
//                         //           },
//                         //           customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                         //           splashColor: appColors["primary"],
//                         //           child: Container(
//                         //             width: Get.width*0.35,
//                         //             height: 100,
//                         //             margin: EdgeInsets.all(20),
//                         //             padding: EdgeInsets.all(20),
//                         //             decoration: BoxDecoration(
//                         //                 borderRadius: BorderRadius.circular(22),
//                         //                 color: appColors['white'],
//                         //                 // border: Border.all(color: appColors['primary']!),
//                         //                 boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
//                         //             ),
//                         //             child: Center(
//                         //               child: Column(
//                         //                 mainAxisAlignment: MainAxisAlignment.center,
//                         //                 // crossAxisAlignment: CrossAxisAlignment.start,
//                         //                 children: [
//                         //                   Center(
//                         //                     child: SizedBox(
//                         //                         height:20,
//                         //                         child: Image.asset('assets/images/glogoB.png')),
//                         //                   ),
//                         //                   Padding(
//                         //                     padding: const EdgeInsets.all(8.0),
//                         //                     child: clumsyTextLabel(batch.files[index].name,color: appColors['primary']),
//                         //                   ),
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         );
//                         //       })
//                         //     ],
//                         //   ),
//                         // ),
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
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/screenshot_off.dart';
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

class BatchPage extends StatefulWidget {
  BatchPage({Key? key}) : super(key: key) {}
  @override
  State<BatchPage> createState() => _State();
}

class _State extends State<BatchPage> {
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
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return ProtectedPage(child:
    Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getBatch(batchId),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context, apiResponse) {
          if (apiResponse!.status == TextMessages.SUCCESS) {
            Batch batch = apiResponse.data as Batch;
            return SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerBar("Batch", parent: true),
                      Card(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 6),
                        elevation: .17,
                        color: appColors['background'],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: appColors['black']!,
                                width: 0.1,
                                style: BorderStyle.solid)),
                        child: ListTile(
                          // tileColor: appColors['background'],
                          // shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),

                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 8),
                            child: clumsyTextLabel(batch.name.toUpperCase(),
                                fontsize: 14, color: appColors['primary']),
                          ),
                          trailing: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: clumsyTextLabel("Session: 2023-2024",
                                fontsize: 14, color: appColors['primary']),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(batch.stream!.name,
                                fontsize: 14, color: appColors['primary']),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                      //   child: clumsyTextLabel(batch.name.toUpperCase(),fontsize: 30,color: appColors['primary']),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
                      // ),

                      //GOLU
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 18, right: 18),
                      //   child: clumsyTextLabel("Subject-Chapter Wise"),
                      // ),

//GOLU-EXPERIMENT
                      //  Card(

                      //     elevation: 2,
                      //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      //     color: appColors['primary'],
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //              ...List.generate(batch.tests.length, (index){
                      //                   return  InkWell(
                      //                     onTap: (){
                      //                       Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: [batch.tests[index].id,batch.id]);
                      //                     },
                      //                     child: Container(
                      //                       // padding:EdgeInsets.all(20),
                      //                       margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
                      //                         color: appColors['white'],
                      //                         borderRadius: BorderRadius.circular(20),
                      //                       ),
                      //                       child: ListTile(
                      //                         tileColor: appColors['white'],
                      //                         trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                      //                         title: clumsyTextLabel(batch.tests[index].name,color: appColors['primary']),
                      //                         subtitle: clumsyTextLabel(batch.tests[index].test_type,color: appColors['primary'],fontsize: 10),
                      //                       ),
                      //                     ),
                      //                   );
                      //                 })

                      //       //  ListTile(
                      //       //   onTap: (){
                      //       //     // Get.toNamed(Routes.BATCH_LECTURE_SUBJECTS_PAGE,arguments: batch.id);
                      //       //                 Get.toNamed(Routes.TEST_REPORT_PAGE,arguments: [batch.tests[index].id,batch.id]);

                      //       //   },
                      //       //   tileColor: appColors['white'],
                      //       //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                      //       //   title:Padding(
                      //       //     padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                      //       //     child: clumsyTextLabel("Tests".toUpperCase(),fontsize: 18,color: appColors['primary']),
                      //       //   ),
                      //       //   trailing: Padding(
                      //       //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //       //     child: Icon(Icons.arrow_circle_right,color: Colors.green,),
                      //       //   ),
                      //       //   // subtitle:  Padding(
                      //       //   //   padding: const EdgeInsets.all(8.0),
                      //       //   //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       //   // ),
                      //       // ),
                      //     ),
                      //   ),

                      // Card(
                      //   margin: EdgeInsets.only(left: 17, right: 17, bottom: 6),

                      //   // elevation: 2,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child:
                      //      ListTile(
                      //       onTap: () {
                      //         Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
                      //             arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),

                      //       title: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 8.0, vertical: 8),
                      //         child: clumsyTextLabel("Study".toUpperCase(),
                      //             fontsize: 18, color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(
                      //           Icons.arrow_circle_right,
                      //           color: Colors.green,
                      //         ),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),

                      //   ),
                      // ),

                      // Card(
                      //   margin: EdgeInsets.only(left: 17, right: 17, bottom: 6),

                      //   // elevation: 2,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: () {
                      //         Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
                      //             arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),

                      //       title: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 8.0, vertical: 8),
                      //         child: clumsyTextLabel("Dpp Tests".toUpperCase(),
                      //             fontsize: 18, color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(
                      //           Icons.arrow_circle_right,
                      //           color: Colors.green,
                      //         ),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),
                      //   ),
                      // ),

                      // Card(
                      //   margin: EdgeInsets.only(
                      //     left: 17,
                      //     right: 17,
                      //   ),
                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: () {
                      //         Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
                      //             arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),

                      //       title: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 8.0, vertical: 8),
                      //         child: clumsyTextLabel(
                      //             "Chapterwise Tests".toUpperCase(),
                      //             fontsize: 18,
                      //             color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(
                      //           Icons.arrow_circle_right,
                      //           color: Colors.green,
                      //         ),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),
                      //   ),
                      // ),

                      // Card(
                      //   margin: EdgeInsets.only(
                      //     left: 17,
                      //     right: 17,
                      //   ),
                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: () {
                      //         Get.toNamed(Routes.TEST_REPORT_PAGE,
                      //             arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),

                      //       title: Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 8.0, vertical: 8),
                      //         child: clumsyTextLabel(
                      //             "General Tests".toUpperCase(),
                      //             fontsize: 18,
                      //             color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(
                      //           Icons.arrow_circle_right,
                      //           color: Colors.green,
                      //         ),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),
                      //   ),
                      // ),

                      // Card(

                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: (){
                      //         Get.toNamed(Routes.BATCH_MODULE_SUBJECTS_PAGE,arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                      //       title:Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                      //         child: clumsyTextLabel("Modules".toUpperCase(),fontsize: 18,color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(Icons.arrow_circle_right,color: Colors.green,),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),
                      //   ),
                      // ),

                      // // Card(
                      //
                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      //   color: Colors.green,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: (){
                      //         Get.toNamed(Routes.BATCH_MODULE_SUBJECTS_PAGE,arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      //
                      //       title:Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                      //         child: clumsyTextLabel("Tests".toUpperCase(),fontsize: 18,color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(Icons.arrow_circle_right,color: Colors.green,),
                      //       ),
                      //       // subtitle:  Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                      //       // ),
                      //     ),
                      //   ),
                      // ),
                      // Card(

                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      //   color: appColors['primary'],
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ListTile(
                      //       onTap: (){
                      //         Get.toNamed(Routes.BATCH_FILE_SUBJECTS_PAGE,arguments: batch.id);
                      //       },
                      //       tileColor: appColors['white'],
                      //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                      //       title:Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                      //         child: clumsyTextLabel("Documents".toUpperCase(),fontsize: 18,color: appColors['primary']),
                      //       ),
                      //       trailing: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Icon(Icons.arrow_circle_right,color: Colors.green,),
                      //       ),
                      //     ),
                      //   ),
                      // ),

//GOLU

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          height: Get.height * .71,
                          child: TabContainer(
                            tabExtent: 70,
                            isStringTabs: false,
                            // color: Colors.grey.shade300,
                            color: appColors['primary'],

                            // color: Colors.green,

                            tabs: [
                              clumsyTextLabel("Study",
                                  color: appColors['blackgrey']),
                              clumsyTextLabel("Tests",
                                  color: appColors['blackgrey']),
                              clumsyTextLabel("Dpp Tests",
                                  color: appColors['blackgrey']),
                              clumsyTextLabel("CW Tests",
                                  color: appColors['blackgrey']),
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
                                    if (batch.batchsubjects.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel(
                                            "Sorry, there are no subjects for this batch.",
                                            color: appColors["white"]),
                                      ),
                                    ...List.generate(batch.batchsubjects.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.BATCH_SUBJECT_CHAPTER_PAGE,
                                              arguments: [
                                                batch.batchsubjects[index].id,
                                              ]);
                                        },
                                        child: Container(
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
                                                batch.batchsubjects[index].name,
                                                color: appColors['primary']),
                                            subtitle: clumsyTextLabel(
                                              'Lectures',
                                              color: appColors['primary'],
                                              fontsize: 10,
                                            ),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if (batch.tests.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel(
                                            "Sorry, there are no tests for this batch.",
                                            color: appColors["white"]),
                                      ),
                                    ...List.generate(batch.tests.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.TEST_REPORT_PAGE,
                                              arguments: [
                                                batch.tests[index].id,
                                                batch.id
                                              ]);
                                        },
                                        child: Container(
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
                                                batch.tests[index].name,
                                                color: appColors['primary']),
                                            subtitle: clumsyTextLabel(
                                                batch.tests[index].test_type,
                                                color: appColors['primary'],
                                                fontsize: 10),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),

                              // Container(
                              //         padding: EdgeInsets.all(0),
                              //         // margin: EdgeInsets.all(20),
                              //         decoration: BoxDecoration(
                              //           color: appColors['primary'],
                              //           borderRadius: BorderRadius.circular(10),

                              //         ),
                              //         child:

                              //          ListView.builder(
                              //     scrollDirection: Axis.vertical,
                              //     itemCount: 1, // Since there's only one item
                              //     itemBuilder: (context, index) {
                              //       return InkWell(
                              //         onTap: () {
                              //           Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
                              //               arguments: batch.id);
                              //         },
                              //         customBorder: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(10)),
                              //         splashColor: appColors["white"],
                              //         child: Expanded(
                              //           child: Container(
                              //             // width: Get.width * 0.41,
                              //             // width: 300,
                              //             // height: Get.height * 0.12,

                              //             // height: 100,
                              //             margin: EdgeInsets.only(right: 30,left: 30,top: 12),
                              //             padding: EdgeInsets.all(8),
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(20),
                              //               color: appColors['white'],
                              //               // boxShadow: const [
                              //               //   BoxShadow(
                              //               //       color: Colors.grey,
                              //               //       spreadRadius: 0,
                              //               //       blurRadius: 5,
                              //               //       offset: Offset(2, 2))
                              //               // ],
                              //             ),
                              //             child: ListTile(
                              //              contentPadding: EdgeInsets.all(4), // to remove default padding of ListTile

                              //               // leading: Column(
                              //                 // mainAxisAlignment:
                              //                     // MainAxisAlignment.center,
                              //                 // children: [
                              //                   // SizedBox(
                              //                     // height: 20,
                              //                     //  Image.asset(
                              //                         // 'assets/images/glogoB.png', height: 20),
                              //                   // ),
                              //                 // ],
                              //               // ),
                              //               title: clumsyTextLabel(
                              //                   "SUBJECTS",
                              //                   color: appColors['primary'], fontsize: 16
                              //                   ),
                              //               trailing: Icon(
                              //                 Icons.arrow_circle_right,
                              //                 color: appColors['primary'],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),

                              //       ),

                              //  Container(
                              //         padding: EdgeInsets.all(0),
                              //         decoration: BoxDecoration(
                              //           color: appColors['primary'],
                              //           borderRadius: BorderRadius.circular(10),

                              //         ),
                              //         child:

                              //          ListView.builder(
                              //     scrollDirection: Axis.vertical,
                              //     itemCount: 1, // Since there's only one item
                              //     itemBuilder: (context, index) {
                              //       return InkWell(
                              //         onTap: () {
                              //           Get.toNamed(Routes.BATCH_SUBJECT_DPP_TESTS_PAGE,
                              //               arguments: batch.id);
                              //         },
                              //         customBorder: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(20)),
                              //         splashColor: appColors["white"],
                              //         child: Expanded(
                              //           child: Container(
                              //             // width: Get.width * 0.41,
                              //             // width: 300,
                              //             // height: Get.height * 0.12,

                              //             // height: 100,
                              //             margin: EdgeInsets.only(right: 30,left: 30,top: 12),

                              //             padding: EdgeInsets.all(8),
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(20),
                              //               color: appColors['white'],
                              //               // boxShadow: const [
                              //               //   BoxShadow(
                              //               //       color: Colors.grey,
                              //               //       spreadRadius: 0,
                              //               //       blurRadius: 5,
                              //               //       offset: Offset(2, 2))
                              //               // ],
                              //             ),
                              //             child: ListTile(
                              //              contentPadding: EdgeInsets.all(4), // to remove default padding of ListTile

                              //               // leading: Column(
                              //                 // mainAxisAlignment:
                              //                     // MainAxisAlignment.center,
                              //                 // children: [
                              //                   // SizedBox(
                              //                     // height: 20,
                              //                     //  Image.asset(
                              //                         // 'assets/images/glogoB.png', height: 20),
                              //                   // ),
                              //                 // ],
                              //               // ),
                              //               title: clumsyTextLabel(
                              //                   "DPP TESTS",
                              //                   color: appColors['primary'], fontsize: 16
                              //                   ),
                              //               trailing: Icon(
                              //                 Icons.arrow_circle_right,
                              //                 color: appColors['primary'],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),

                              //       ),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: appColors['primary'],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if (batch.batchsubjects.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel(
                                            "Sorry, there are no tests for this batch.",
                                            color: appColors["white"]),
                                      ),
                                    ...List.generate(batch.batchsubjects.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes
                                                  .BATCH_SUBJECT_CHAPTER_DPP_TESTS_PAGE,
                                              arguments: [
                                                batch.batchsubjects[index].id,
                                              ]);
                                        },
                                        child: Container(
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
                                                batch.batchsubjects[index].name,
                                                color: appColors['primary']),
                                            subtitle: clumsyTextLabel(
                                              'dppTests',
                                              color: appColors['primary'],
                                              fontsize: 10,
                                            ),
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView(
                                  // mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    if (batch.batchsubjects.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: clumsyTextLabel(
                                            "Sorry, there are no tests for this batch.",
                                            color: appColors["white"]),
                                      ),
                                    ...List.generate(batch.batchsubjects.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes
                                                  .BATCH_SUBJECT_CONTENT_CW_TESTS_PAGE,
                                              arguments: [
                                                batch.batchsubjects[index].id,
                                              ]);
                                        },
                                        child: Container(
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
                                                batch.batchsubjects[index].name,
                                                color: appColors['primary']),
                                            subtitle: clumsyTextLabel(
                                              'ChapterWiseTests',
                                              color: appColors['primary'],
                                              fontsize: 10,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),

                              //  Container(
                              //         padding: EdgeInsets.all(0),
                              //         decoration: BoxDecoration(
                              //           color: appColors['primary'],
                              //           borderRadius: BorderRadius.circular(10),

                              //         ),
                              //         child:

                              //          ListView.builder(
                              //     scrollDirection: Axis.vertical,
                              //     itemCount: 1, // Since there's only one item
                              //     itemBuilder: (context, index) {
                              //       return InkWell(
                              //         onTap: () {
                              //           Get.toNamed(Routes.BATCH_SUBJECT_CW_TESTS_PAGE,
                              //               arguments: batch.id);
                              //         },
                              //         customBorder: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(20)),
                              //         splashColor: appColors["white"],
                              //         child: Expanded(
                              //           child: Container(
                              //             // width: Get.width * 0.41,
                              //             // width: 300,
                              //             // height: Get.height * 0.12,

                              //             // height: 100,
                              //             margin: EdgeInsets.only(right: 30,left: 30,top: 12),

                              //             padding: EdgeInsets.all(8),
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(20),
                              //               color: appColors['white'],
                              //               // boxShadow: const [
                              //               //   BoxShadow(
                              //               //       color: Colors.grey,
                              //               //       spreadRadius: 0,
                              //               //       blurRadius: 5,
                              //               //       offset: Offset(2, 2))
                              //               // ],
                              //             ),
                              //             child: ListTile(
                              //              contentPadding: EdgeInsets.all(4), // to remove default padding of ListTile

                              //               // leading: Column(
                              //                 // mainAxisAlignment:
                              //                     // MainAxisAlignment.center,
                              //                 // children: [
                              //                   // SizedBox(
                              //                     // height: 20,
                              //                     //  Image.asset(
                              //                         // 'assets/images/glogoB.png', height: 20),
                              //                   // ),
                              //                 // ],
                              //               // ),
                              //               title: clumsyTextLabel(
                              //                   "CHAPTERWISE TESTS",
                              //                   color: appColors['primary'], fontsize: 16
                              //                   ),
                              //               trailing: Icon(
                              //                 Icons.arrow_circle_right,
                              //                 color: appColors['primary'],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),

                              //       ),

                              //     Container(
                              //       padding: EdgeInsets.all(10),
                              //       decoration: BoxDecoration(
                              //         color: appColors['primary'],
                              //         borderRadius: BorderRadius.circular(20),

                              //       ),
                              //       child:  ListTile(
                              //   onTap: () {
                              //     Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
                              //         arguments: batch.id);
                              //   },
                              //   tileColor: appColors['white'],
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)),

                              //   title: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 8.0, vertical: 8),
                              //     child: clumsyTextLabel("Subjects".toUpperCase(),
                              //         fontsize: 18, color: appColors['white']),
                              //   ),
                              //   trailing: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 8.0),
                              //     child: Icon(
                              //       Icons.arrow_circle_right,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              //   // subtitle:  Padding(
                              //   //   padding: const EdgeInsets.all(8.0),
                              //   //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
                              //   // ),
                              // ),

                              //     ),

//  Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: appColors['primary'],
//                                   borderRadius: BorderRadius.circular(20),

//                                 ),
//                                 child:  ListTile(
//                             onTap: () {
//                               Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
//                                   arguments: batch.id);
//                             },
//                             tileColor: appColors['white'],
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),

//                             title: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0, vertical: 8),
//                               child: clumsyTextLabel("Dpp tests".toUpperCase(),
//                                   fontsize: 18, color: appColors['white']),
//                             ),
//                             trailing: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Icon(
//                                 Icons.arrow_circle_right,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             // subtitle:  Padding(
//                             //   padding: const EdgeInsets.all(8.0),
//                             //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                             // ),
//                           ),

//                               ),
//  Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: appColors['primary'],
//                                   borderRadius: BorderRadius.circular(20),

//                                 ),
//                                 child:  ListTile(
//                             onTap: () {
//                               Get.toNamed(Routes.BATCH_SUBJECT_PAGE,
//                                   arguments: batch.id);
//                             },
//                             tileColor: appColors['white'],
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),

//                             title: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0, vertical: 8),
//                               child: clumsyTextLabel("chapterwise tests".toUpperCase(),
//                                   fontsize: 18, color: appColors['white']),
//                             ),
//                             trailing: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Icon(
//                                 Icons.arrow_circle_right,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             // subtitle:  Padding(
//                             //   padding: const EdgeInsets.all(8.0),
//                             //   child: clumsyTextLabel(batch.stream.name,fontsize: 14,color: appColors['primary']),
//                             // ),
//                           ),

//                               ),

                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     color: appColors['primary'],
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: ListView(
                              //     // mainAxisAlignment:MainAxisAlignment.start,
                              //     children: [
                              //       if(batch.lectures.isEmpty) Padding(
                              //       // if(batch.lectures.isEmpty) Padding(

                              //         padding: const EdgeInsets.all(18.0),
                              //         child: clumsyTextLabel("Sorry, there are no lectures for this batch.",color: appColors["white"]),
                              //       ),

                              //       // ...List.generate(batch.batchsubjects.length, (index){
                              //       ...List.generate(batch.lectures.length, (index){

                              //         return  InkWell(
                              //           onTap: (){
                              //             Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                              //             // Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments: [batch.id]);

                              //             // Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments:  [batch.batchsubjects[index].id,batch.id]);
                              //             // Get.toNamed(Routes.BATCH_SUBJECT_PAGE,arguments: batch.id);

                              //           },
                              //           child: Container(
                              //             // padding:EdgeInsets.all(20),
                              //             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
                              //               color: appColors['white'],
                              //               borderRadius: BorderRadius.circular(20),
                              //             ),
                              //             child: ListTile(
                              //               tileColor: appColors['white'],
                              //               trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                              //               title: clumsyTextLabel(batch.batchsubjects[index].name.toUpperCase(),color: appColors['primary']),
                              //               // subtitle: clumsyTextLabel(batch.lectures[index].description,color: appColors['primary'],fontsize: 12) ,
                              //             ),
                              //           ),
                              //         );
                              //       })
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     color: appColors['primary'],
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: ListView(
                              //     // mainAxisAlignment:MainAxisAlignment.start,
                              //     children: [
                              //       if(batch.modules.isEmpty) Padding(
                              //         padding: const EdgeInsets.all(28.0),
                              //         child: clumsyTextLabel("Sorry, there are no Modules for this batch.",color: appColors["white"]),
                              //       ),
                              //       ...List.generate(batch.modules.length, (index){
                              //         return  InkWell(
                              //           onTap: (){
                              //             Get.toNamed(Routes.MODULE_PAGE,arguments: batch.modules[index].id);
                              //           },
                              //           child: Container(
                              //             // padding:EdgeInsets.all(20),
                              //             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
                              //               color: appColors['white'],
                              //               borderRadius: BorderRadius.circular(20),
                              //             ),
                              //             child: ListTile(
                              //               tileColor: appColors['white'],
                              //               trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                              //               title: clumsyTextLabel(batch.modules[index].name,color: appColors['primary']),
                              //               // subtitle: clumsyTextLabel(batch.modules[index].test_type,color: appColors['primary'],fontsize: 10),
                              //             ),
                              //           ),
                              //         );
                              //       })
                              //     ],
                              //   ),
                              // ),

                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     color: appColors['primary'],
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: ListView(
                              //     // mainAxisAlignment:MainAxisAlignment.start,
                              //     children: [
                              //       if(batch.files.isEmpty) Padding(
                              //         padding: const EdgeInsets.all(28.0),
                              //         child: clumsyTextLabel("Sorry, there are no files for this batch.",color: appColors["white"]),
                              //       ),
                              //       // if(batch.files.isEmpty) clumsyTextLabel("Sorry, there are no files for this batch."),
                              //       ...List.generate(batch.files.length, (index){
                              //         return  InkWell(
                              //           onTap: () async {
                              //             // Uri uri = Uri.parse( batch.files[index].file.url);
                              //             // if (!await launchUrl(uri)) {
                              //             //   Get.snackbar("Error", "Could not open the link for the file");
                              //             // }

                              //             // final taskId = await FlutterDownloader.enqueue(
                              //             //   url: batch.files[index].file.url,
                              //             //   headers: {}, // optional: header send with url (auth token etc)
                              //             //   savedDir: '/storage/emulated/0/',
                              //             //   showNotification: true, // show download progress in status bar (for Android)
                              //             //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                              //             // );

                              //             // Get.toNamed(Routes.LECTURE_PAGE,arguments: batch.lectures[index].id);
                              //           },
                              //           child: Container(
                              //             // padding:EdgeInsets.all(20),
                              //             margin:EdgeInsets.symmetric(horizontal: 20,vertical: 4),                                            decoration: BoxDecoration(
                              //               color: appColors['white'],
                              //               borderRadius: BorderRadius.circular(20),
                              //             ),
                              //             child: ListTile(
                              //               onTap: () async{
                              //                 await openLink(batch.files[index].file.url);
                              //               },
                              //               tileColor: appColors['white'],
                              //               trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
                              //               title: clumsyTextLabel(batch.files[index].name,color: appColors['primary']),
                              //               subtitle: clumsyTextLabel(batch.files[index].contentType,color: appColors['primary'],fontsize: 10) ,
                              //             ),
                              //           ),
                              //         );
                              //       })
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // Divider(color:Colors.green),
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
      ),
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
