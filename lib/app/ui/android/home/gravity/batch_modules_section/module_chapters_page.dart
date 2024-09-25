// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx/app/data/model/gravity/module_chapter.dart';
// import 'package:getx/app/data/model/gravity/subject.dart';
// import 'package:getx/app/routes/app_pages.dart';
// import '../../../../../controller/gravity/student_controller.dart';
// import '../../../../../data/constants/errors.dart';
// import '../../../../../data/constants/miscellaneous.dart';
// import '../../../../../data/model/api_response.dart';
// import '../../../../../data/model/gravity/batch.dart';
// import '../../../../../data/model/gravity/module.dart';
// import '../../../../../data/model/gravity/test_with_sections.dart';
// import '../../../widgets/miscellaneous.dart';

// class ModuleChaptersPage extends StatefulWidget {
//   ModuleChaptersPage({Key? key}):super(key: key){
//     // Get.put<HostController>(HostController());
//   }
//   @override
//   State<ModuleChaptersPage> createState() => _State();
// }

// class _State extends State<ModuleChaptersPage> {
//   late String moduleId;
//   bool agreed = false;
//   _State(){
//     moduleId = Get.arguments;

//   }
//   @override
//   Widget build(BuildContext context) {
//     // printCity();
//     return SafeArea(
//       child: Material(
//         color: appColors["background"]!,
//         child: AsyncBuilder<APIResponse>(
//           // future: Get.find<StudentsController>().getTests(streamId),
//           future: Get.find<StudentsController>().getModule(moduleId),
//           waiting: (context) {
//             return  Center(
//               child: clumsyWaitingBar(),
//             );
//           },
//           builder: (context,apiResponse){
//             if(apiResponse!.status == TextMessages.SUCCESS)
//               {
//                 Module module = apiResponse.data as Module;
//                 List<ModuleChapter> modulechapters = module.moduleChapters;
//                 return Scaffold(
//                   backgroundColor: appColors["background"]!,
//                   extendBodyBehindAppBar: true,
//                   body: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Column(
//                       children: [
//                         headerBar("Chapters",parent: true),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 50,
//                                 ),
//                                 if(modulechapters.length==0) clumsyTextLabel("Sorry, there are currently no module chapters available in this Module!"),
//                                 ...List.generate(modulechapters.length, (index) {
//                                   // return gravityTestsListTile(subjects[index]);
//                                   return ListTile(
//                                     onTap: (){
//                                       Get.toNamed(Routes.MODULE_CHAPTER_PAGE,arguments: modulechapters[index].id);
//                                       // print("yes");
//                                     },
//                                     tileColor: appColors['white'],
//                                     trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
//                                     title: clumsyTextLabel(modulechapters[index].name.toUpperCase(),color: appColors['primary']),
//                                     // subtitle: clumsyTextLabel(modulechapters[index].id,color: appColors['primary'],fontsize: 12)
//                                   );
//                                 }),
//                                 SizedBox(
//                                   height: 50,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             else
//               {
//                 return Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         headerBar("Chapters",parent: true),
//                         clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
//                         clumsyTextLabel(apiResponse.info!,fontsize: 10),
//                         // Text(error.toString()),
//                       ],
//                     )
//                 );
//               }

//           },
//           error: (context, error, stackTrace) {
//             print(error.runtimeType);
//             print(error);
//             return Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [

//                     Text("Some error Occured"),
//                     Text(error.toString()),

//                   ],
//                 )
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

