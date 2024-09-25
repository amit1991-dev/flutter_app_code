// import 'package:async_builder/async_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import '../../../../../controller/gravity/student_controller.dart';
// import '../../../../../data/constants/miscellaneous.dart';
// import '../../../../../data/model/api_response.dart';
// import '../../../../../data/model/gravity/lecture.dart';
// import '../../../widgets/miscellaneous.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class LecturePage extends StatefulWidget {
//  const LecturePage({Key? key}) : super(key: key);
//   @override
//   State<LecturePage> createState() => _State();
// }

// class _State extends State<LecturePage> {
//   VideoPlayerController? _controller;
//   late String lectureId;
//   late YoutubePlayerController _youtube_controller;

//   _State();

//   @override
//   void initState() {
//     // TODO: implement initState

//   _youtube_controller = YoutubePlayerController(
//       initialVideoId: 'iLnmTe5Q2Qw',
//      flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//     super.initState();
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//     // SystemChrome.setEnabledSystemUIOverlays([]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.bottom]);
//     lectureId = Get.arguments as String;
//     // _controller = VideoPlayerController.network(,videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))..initialize().then((_) { setState(() {});});
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.white));
//     // _controller.dispose();
//     super.dispose();
//   }

//   void listener() {
//     print("listener got called");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: AsyncBuilder<APIResponse>(
//         future: Get.find<StudentsController>().getLecture(lectureId),
//         waiting: (context) {
//           return Center(
//             child: clumsyWaitingBar(),
//           );
//         },
//         builder: (context, apiResponse) {
//           if (apiResponse!.status == TextMessages.SUCCESS) {
//             Lecture lecture = apiResponse.data as Lecture;
//             if (!lecture.classTerminated && lecture.liveStatus) {
//               _controller = VideoPlayerController.network(
//                   lecture.liveLecturePath!,
//                   videoPlayerOptions:
//                       VideoPlayerOptions(allowBackgroundPlayback: true))
//                 ..initialize().then((_) {
//                   setState(() {});
//                 });
//             }
//             _youtube_controller = YoutubePlayerController(
//               initialVideoId: lecture.mediaURL,
//               flags: const YoutubePlayerFlags(
//                 autoPlay: false,
//                 mute: false,
//               ),

//             );

//             if (lecture.channelID.isNotEmpty) {
//               return YoutubePlayerBuilder(
//                 player: YoutubePlayer(
//                   controller: _youtube_controller,
//                   liveUIColor: Colors.amber,
//                   aspectRatio: 16 / 9,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.amber,
//                   progressColors: ProgressBarColors(
//                     playedColor: Colors.amber,
//                     handleColor: Colors.amberAccent,
//                   ),
//                   onReady: () {},
//                 ),
//                 builder: (BuildContext context, player) {
//                   return Column(
//                     children: [
//                       SizedBox(child: player),
//                     ],
//                   );
//                 },
//               );
//             }

//             return Container(
//                 margin: const  EdgeInsets.all(0),
//                 padding: const EdgeInsets.all(0),
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (!lecture.classTerminated &&
//                           lecture.liveStatus &&
//                           _controller != null)
//                         _controller!.value.isInitialized
//                             ? AspectRatio(
//                                 aspectRatio: _controller!.value.aspectRatio,
//                                 child: VideoPlayer(_controller!),
//                               )
//                             : Container(),

//                      const SizedBox(
//                         height: 30,
//                       ),

//                       if (!lecture.classTerminated &&
//                           lecture.liveStatus &&
//                           _controller != null)
//                         clumsyTextLabel("Live", color: appColors[5]),

//                      const SizedBox(
//                         height: 30,
//                       ),
//                       // headerBar("Lecture",parent:true),
//                       if (lecture.mediaURL != "-")
//                         YoutubePlayerBuilder(
//                           player: YoutubePlayer(
//                             controller: _youtube_controller,
//                             showVideoProgressIndicator: true,
//                             aspectRatio: Get.height / Get.width,
//                             // width: Get.width*0.95,
//                             onReady: () {},
//                           ),
//                         builder: (BuildContext context, player) {
//                             return Column(
//                               children: [
//                                 SizedBox(child: player),
//                               ],
//                             );
//                           },
//                         ),
//                       if (lecture.mediaURL == "-")
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: clumsyTextLabel(
//                               "Sorry this video is not present currently"),
//                         ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: clumsyTextLabel(lecture.name.toUpperCase(),
//                             fontsize: 22, color: appColors['primary']),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: clumsyTextLabel("Session: 2023-2024",
//                             fontsize: 14, color: appColors['grey']),
//                       ),

//                       // ClumsyRealButton("Play", Get.width*0.4, () {
//                       //   print("playing");
//                       //   _controller.play();
//                       //   // setState(() {
//                       //   //
//                       //   // });
//                       // }, false),
//                       // ClumsyRealButton("Pause", Get.width*0.4, () {
//                       //   print("pausinng");
//                       //   _controller.pause();
//                       //   // setState(() {
//                       //   //
//                       //   // });
//                       // }, false),
//                       // clumsyTextLabel(lecture.name),

//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: clumsyTextLabel("Description",
//                             fontsize: 22, color: appColors['primary']),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 28.0, vertical: 8),
//                         child: clumsyTextLabel(lecture.description),
//                       ),

//                       // Center(
//                       //   child:  _controller.value.isInitialized
//                       //       ? AspectRatio(
//                       //     aspectRatio: _controller.value.aspectRatio,
//                       //     child: Stack(
//                       //         children: [
//                       //
//                       //       InkWell(
//                       //         onTap:(){
//                       //           // print(1);
//                       //           Get.toNamed(Routes.VIDEO_PAGE,arguments: lecture.mediaURL);
//                       //         },
//                       //         child: ClipRRect(
//                       //           borderRadius: BorderRadius.circular(30),
//                       //           child: Container(
//                       //             decoration: BoxDecoration(
//                       //               // borderRadius: BorderRadius.circular(20),
//                       //               border:Border.all(color: appColors['primary']!,width: 3)
//                       //             ),
//                       //             // padding: EdgeInsets.all(20),
//                       //             margin: EdgeInsets.all(20),
//                       //               child: VideoPlayer(_controller)),
//                       //         ),
//                       //       ),
//                       //           Center(
//                       //             child: Icon(Icons.play_circle),
//                       //           ),
//                       //
//                       //         ]),
//                       //   )
//                       //       : Container(),
//                       // ),

//                       // Divider(color: appColors['primary'],),
//                       // Divider(color: appColors['primary'],),

//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: clumsyTextLabel("Files",
//                             fontsize: 20, color: appColors['primary']),
//                       ),

//                       if (lecture.files.isEmpty)
//                         Padding(
//                           padding: const EdgeInsets.all(28.0),
//                           child: clumsyTextLabel(
//                               "There are currently 0 files available"),
//                         ),
//                       Column(
//                         children: [
//                           ...List.generate(lecture.files.length, (index) {
//                             return InkWell(
//                               onTap: () {
//                                 // Get.toNamed(Routes.LECTURE_PAGE,arguments: lecture.id);
//                               },
//                               child: Container(
//                                 // padding:EdgeInsets.all(20),
//                                 margin: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   color: appColors['white'],
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Card(
//                                   elevation: 5,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: ListTile(
//                                     onTap: () async {
//                                       await openLink(
//                                           lecture.files[index].file.url);
//                                     },
//                                     tileColor: appColors['white'],
//                                     trailing: Icon(
//                                       Icons.download_for_offline,
//                                       color: appColors['primary'],
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     title: clumsyTextLabel(
//                                         lecture.files[index].name.toUpperCase(),
//                                         color: appColors['primary']),
//                                     subtitle: clumsyTextLabel(
//                                         lecture.files[index].contentType,
//                                         color: appColors['grey'],
//                                         fontsize: 12),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           })
//                         ],
//                       ),
//                     ],
//                   ),
//                 ));
//           } else {
//             // showSnackbar("Error", apiResponse!.info!);
//             print(apiResponse.info!);
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
//           return Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text("Some error Occured"),
//               Text(error.toString()),
//             ],
//           ));
//         },
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

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../controller/gravity/student_controller.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../data/model/gravity/lecture.dart';
import '../../../../../routes/app_pages.dart';
import '../../../widgets/miscellaneous.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class LecturePage extends StatefulWidget {
  const LecturePage({Key? key}) : super(key: key);
  @override
  State<LecturePage> createState() => _State();
}

class _State extends State<LecturePage> {
  VideoPlayerController? _controller;
  late String lectureId;
  late YoutubePlayerController _youtube_controller;

  _State();

  @override
  void initState() {
    // TODO: implement initState

    _youtube_controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); 
    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    lectureId = Get.arguments as String;
    // _controller = VideoPlayerController.network(,videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))..initialize().then((_) { setState(() {});});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    // _controller.dispose();
     BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  void listener() {
    print("listener got called");
  }

bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  // Get the current route name using Get.currentRoute
  String currentRoute = Get.currentRoute;
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft
  ]);

  // Check if the current route is your TestPage route
  if (currentRoute == Routes.LECTURE_PAGE) { // Compare to the route value
    // Show a dialog or a snackbar to confirm exit
     SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft
  ]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Leave Lecture?"),
        content: const Text("Are you sure you want to leave the lecture?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Stay on page
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Allow exit
              Get.offNamed(Routes.BATCH_SUBJECT_CHAPTER_LECTURE_PAGE); // Navigate to lecture list
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    // Prevent default back button action for now
    return true;
  } else {
    // Allow back navigation on other routes
    return false;
  }
}


// bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
//   // Get the current route name using Get.currentRoute
//   String currentRoute = Get.currentRoute;

//   // Check if the current route is your TestPage route
//   if (currentRoute == Routes.LECTURE_PAGE) { // Compare to the route value
//     showSnackbar("Cannot Go Back", "!");
    
//     stopDefaultButtonEvent = true; // Prevent back navigation
//     return stopDefaultButtonEvent;
//   } else {
//     // Allow back navigation on other routes
//     return false;
//   }
// }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getLecture(lectureId),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context, apiResponse) {
          if (apiResponse!.status == TextMessages.SUCCESS) {
            Lecture lecture = apiResponse.data as Lecture;
            if (!lecture.classTerminated && lecture.liveStatus) {
              _controller = VideoPlayerController.networkUrl(
                  lecture.liveLecturePath! as Uri,
                  videoPlayerOptions:
                      VideoPlayerOptions(allowBackgroundPlayback: true))
                ..initialize().then((_) {
                  setState(() {});
                });
            }
            
            _youtube_controller = YoutubePlayerController(
              initialVideoId: lecture.mediaURL,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            );

            if (lecture.channelID.isNotEmpty) {
              return YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _youtube_controller,
                  liveUIColor: Colors.amber,
                  aspectRatio: 16 / 9,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                ),
                builder: (BuildContext context, player) {
                  return Column(
                    children: [
                      SizedBox(child: player),
                    ],
                  );
                },
              );
            }

            return Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!lecture.classTerminated &&
                          lecture.liveStatus &&
                          _controller != null)
                        _controller!.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              )
                            : Container(),

                      const SizedBox(
                        height: 30,
                      ),

                      if (!lecture.classTerminated &&
                          lecture.liveStatus &&
                          _controller != null)
                        clumsyTextLabel("Live", color: appColors[5]),

                      const SizedBox(
                        height: 30,
                      ),
                      // headerBar("Lecture",parent:true),
                      if (lecture.mediaURL != "-")
                      YoutubePlayerBuilder(
                  player: YoutubePlayer(
                  controller: _youtube_controller,
                  liveUIColor: Colors.amber,
                  aspectRatio: 16 / 9,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                            // width: Get.width*0.95,
                            onReady: () {},
                          ),
                          builder: (BuildContext context, player) {
                            return Column(
                              children: [
                                SizedBox(child: player),
                              ],
                            );
                          },
                        ),
                      if (lecture.mediaURL == "-")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: clumsyTextLabel(
                              "Sorry this video is not present currently"),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: clumsyTextLabel(lecture.name.toUpperCase(),
                            fontsize: 22, color: appColors['primary']),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: clumsyTextLabel("Session: 2023-2024",
                            fontsize: 14, color: appColors['grey']),
                      ),

                      // ClumsyRealButton("Play", Get.width*0.4, () {
                      //   print("playing");
                      //   _controller.play();
                      //   // setState(() {
                      //   //
                      //   // });
                      // }, false),
                      // ClumsyRealButton("Pause", Get.width*0.4, () {
                      //   print("pausinng");
                      //   _controller.pause();
                      //   // setState(() {
                      //   //
                      //   // });
                      // }, false),
                      // clumsyTextLabel(lecture.name),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: clumsyTextLabel("Description",
                            fontsize: 22, color: appColors['primary']),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 8),
                        child: clumsyTextLabel(lecture.description),
                      ),

                      // Center(
                      //   child:  _controller.value.isInitialized
                      //       ? AspectRatio(
                      //     aspectRatio: _controller.value.aspectRatio,
                      //     child: Stack(
                      //         children: [
                      //
                      //       InkWell(
                      //         onTap:(){
                      //           // print(1);
                      //           Get.toNamed(Routes.VIDEO_PAGE,arguments: lecture.mediaURL);
                      //         },
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(30),
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //               // borderRadius: BorderRadius.circular(20),
                      //               border:Border.all(color: appColors['primary']!,width: 3)
                      //             ),
                      //             // padding: EdgeInsets.all(20),
                      //             margin: EdgeInsets.all(20),
                      //               child: VideoPlayer(_controller)),
                      //         ),
                      //       ),
                      //           Center(
                      //             child: Icon(Icons.play_circle),
                      //           ),
                      //
                      //         ]),
                      //   )
                      //       : Container(),
                      // ),

                      // Divider(color: appColors['primary'],),
                      // Divider(color: appColors['primary'],),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: clumsyTextLabel("Files",
                            fontsize: 20, color: appColors['primary']),
                      ),

                      if (lecture.files.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: clumsyTextLabel(
                              "There are currently 0 files available"),
                        ),
                      Column(
                        children: [
                          ...List.generate(lecture.files.length, (index) {
                            return InkWell(
                              onTap: () {
                                // Get.toNamed(Routes.LECTURE_PAGE,arguments: lecture.id);
                              },
                              child: Container(
                                // padding:EdgeInsets.all(20),
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: appColors['white'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    onTap: () async {
                                      await openLink(
                                          lecture.files[index].file.url);
                                    },
                                    tileColor: appColors['white'],
                                    trailing: Icon(
                                      Icons.download_for_offline,
                                      color: appColors['primary'],
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: clumsyTextLabel(
                                        lecture.files[index].name.toUpperCase(),
                                        color: appColors['primary']),
                                    subtitle: clumsyTextLabel(
                                        lecture.files[index].contentType,
                                        color: appColors['grey'],
                                        fontsize: 12),
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ],
                  ),
                ));
          } else {
            // showSnackbar("Error", apiResponse!.info!);
            print(apiResponse.info!);
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
          return Center(
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
