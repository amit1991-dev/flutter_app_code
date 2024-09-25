import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../data/model/gravity/batch.dart';
import '../../../../data/model/gravity/lecture.dart';
import '../../../../data/model/gravity/question.dart';
import '../../widgets/gravity/quiz_question_widgets/question_widget.dart';
import '../../widgets/miscellaneous.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key? key}):super(key: key){
  }
  @override
  State<VideoPage> createState() => _State();
}

class _State extends State<VideoPage> {
  late VideoPlayerController _controller;
  late String mediaUrl;

  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mediaUrl = Get.arguments as String;
    _controller = VideoPlayerController.network(
        mediaUrl,videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_) {
        // _controller.play();
        setState(() {

        });
      });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: RotatedBox(
        quarterTurns: 1,
        child: Container(
                  height: Get.width,
                  width: Get.height,
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                        children: [
                      Container(
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          // border:Border.all(color: appColors['primary']!,width: 3)
                        ),
                        // margin: EdgeInsets.all(20),
                          child: VideoPlayer(_controller),
                      ),
                      Positioned(
                        bottom: 10,
                        left:40,
                        child: Row(

                          children: [
                            Center(
                              child: InkWell(
                                onTap: (){
                                  _controller.play();
                                },
                            child: const Icon(Icons.play_circle,size: 040,)
                              ),
                            ),

                            Center(
                              child: InkWell(
                                  onTap: (){
                                    _controller.pause();
                                  },
                                  child: const Icon(Icons.pause_circle,size: 40,)
                              ),
                            ),
                            SizedBox(
                              width: Get.height*0.8,
                              child: SmoothVideoProgress(
                                controller: _controller,
                                builder: (context, position, duration, child) => Slider(
                                  activeColor: appColors["primary"],
                                  onChangeStart: (_) => _controller.pause(),
                                  onChangeEnd: (_) => _controller.play(),
                                  onChanged: (value) =>
                                      _controller.seekTo(Duration(milliseconds: value.toInt())),
                                  value: position.inMilliseconds.toDouble(),
                                  min: 0,
                                  max: duration.inMilliseconds.toDouble(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                          // Center(
                          //   child: Icon(Icons.play_circle),
                          // ),
                        ]),
                  ) : Container()
      ),
      )
    );
  }
}

