import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../data/constants/miscellaneous.dart';

import '../../../data/model/user.dart';

class Splash extends StatefulWidget {

  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;
  late bool initialized=false;
  bool visibe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );
    _controller = VideoPlayerController.asset('assets/videos/ball.avi');

    // _controller.addListener(() {
    //   setState(() {});
    // });
    _controller.setLooping(true);
    _controller.initialize().then((value) =>
    {
      setState((){
        initialized = true;
      })
    });

    Future.delayed(Duration(seconds: 4),() async{
      await Get.find<Authentication>().initialize();
      if(Get.find<Authentication>().isLoggedIn.value)
        {
          print("found that logged in!");
          User u = Get.find<Authentication>().user!;
          print("found that role ${u.role}");
          if(u.role == "user")
            Get.offNamed(Routes.HOME);
          else if(u.role== "host")
            Get.offNamed(Routes.HOST_HOME);
          else if(u.role== "helper")
            Get.offNamed(Routes.HELPER_HOME);
        }
      else{
        print("found that Logged Out");
        Get.offNamed(Routes.LOGIN);
      }
    });
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Material(

      child:Container(
        decoration: BoxDecoration(
          color: appColors["background"]!
        ),
        alignment: Alignment.center,

        child: FadeIn(
            animate: true,
            duration: Duration(seconds: 2),

            child: FadeOut(
                animate: true,
                delay: Duration(seconds: 3),
                duration: Duration(seconds: 1),


                // Just change the Image.asset widget to anything you want to fade in/out:
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width*0.4,
                        child: Image.asset("assets/images/logo_title.png")
                    )
                    // AspectRatio(
                    //   aspectRatio: _controller.value.aspectRatio,
                    //   child: VideoPlayer(_controller),
                    // ),
                    // const Text("Clumsy",style: TextStyle(color: appColors["primary"]!,fontFamily: "Barokah",fontSize: 30),),
                  ],
                )

            ) // FadeOut
        ),
      )
    );
  }
}
