import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:rive/rive.dart';

class SplashBoardingscreen extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      print("10 sec are up");
    });

    // ImageShader( Image.asset("assets/images/logo.png"), TileMode.clamp,TileMode.clamp,Matrix4.identity().storage);

    return Scaffold(
      body: Stack(

        alignment: Alignment.center,
        children:[
          RiveAnimation.asset(
            "assets/rive/rive_emoji_pack.riv",
            artboard: "Emoji_package",

          ),
          // ShaderMask(
          //   shaderCallback: (bounds){
          //     return RadialGradient(
          //       center: Alignment.topLeft,
          //       radius: 1.0,
          //       colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
          //       tileMode: TileMode.mirror,
          //     ).createShader(bounds);
          //   },
          //   child: Image.asset("assets/images/logo.png",width: Get.width-10,),
          // ),
        ]
      ),
    );
  }
}
