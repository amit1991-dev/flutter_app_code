import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:video_player/video_player.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/user.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late String role;
  String img=  "assets/images/c_logo.png";
  double radius =  2;
  List<Color> colors =[Colors.red,appColors["primary"]!,Colors.lightBlue,appColors["primary"]!,appColors["white"]!,appColors["primary"]!,appColors["white"]!];
  double fontSize = 22;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    role = Get.arguments as String;
  }
  dynamic done(){
    if(role == "user")
      {
        Get.offNamed(Routes.HOME);
      }
    else if(role == "host")
      {
        Get.offNamed(Routes.HOST_HOME);
      }
    else if(role == "helper")
    {
      Get.offNamed(Routes.HELPER_HOME);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appColors["background"]!,
      child:SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: appColors["background"]!,
          height: Get.height,
          width: Get.width,
          child: IntroductionScreen(
            globalBackgroundColor: appColors["background"]!,
            showSkipButton: true,
            skip:  Icon(Icons.skip_next,color: appColors["primary"]!,),
            next: clumsyTextLabel("Next",color: appColors["primary"]!),
            done: clumsyTextLabel("Done",color: appColors["primary"]!),
            onDone: () {
              // On Done button pressed
              done();
            },
            onSkip: () {
              done();
              // On Skip button pressed
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: appColors["primary"]! ,
              color: appColors["grey"]!,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
            ),
            pages: [
              PageViewModel(
                titleWidget: clumsyTextBarookah("Welcome",color: appColors["primary"]!,fontSize: 30),
                // title: "Title of blue page",
                bodyWidget: ShaderMask(
                  shaderCallback: (rect){
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // radius: radius,
                      colors: [appColors["primary"]!,Colors.purple],
                      // stops: [
                      //   0.0,
                      //   0.7,
                      // ],
                      tileMode: TileMode.repeated,
                    ).createShader(rect);

                  },
                    child: Center(
                        child: clumsyTextLabelStylish(
                            "Education is the movement from darkness to light",
                            color: appColors["white"]!,
                            fontsize: fontSize+5.0
                        )
                    )
                ),
                // body: "Welcome to the app! This is a description on a page with a blue background.",
                image: Center(
                  child: Image.asset(img, width: Get.width*0.4,),
                ),
                decoration: PageDecoration(
                  pageColor: appColors["background"]!,
                ),
              ),
              PageViewModel(
                // titleWidget: clumsyTextLabel("Welcome to Clumsy-Vibe of the tribe",color: appColors["primary"]!,fontsize: 15),
                titleWidget: ShaderMask(
                    shaderCallback: (rect){
                      return LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // radius: radius,
                        colors: [appColors["green"]!,appColors["primary"]!],
                        // stops: [
                        //   0.0,
                        //   0.7,
                        // ],
                        tileMode: TileMode.repeated,
                      ).createShader(rect);

                    },
                    child: Center(
                        child: clumsyTextLabelStylish(
                            "Change is the end result of all true learning",
                            color: appColors["white"]!,
                            fontsize: fontSize
                        )
                    )
                ),
                bodyWidget:clumsyTextBarookah("Its Simple",color: appColors["primary"]!,fontSize: 30),
                // bodyWidget: Center(child: clumsyTextLabel(" It’s simple, Find the best parties in your city, choose the one of your liking and secure your place before it runs out. We know you like to party, Clumsy is here to ease your way to enjoy the time of your life.",color: appColors["grey"]!.shade500,fontsize: 22)),
                // body: "Welcome to the app! This is a description on a page with a blue background.",
                image: Center(
                  child: Image.asset(img, width: Get.width*0.4),
                ),
                decoration:  PageDecoration(
                  pageColor: appColors["background"]!,
                ),
              ),
              PageViewModel(
                titleWidget: ShaderMask(
                    shaderCallback: (rect){
                      return LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple,Colors.red,appColors["primary"]!],
                        tileMode: TileMode.repeated,
                      ).createShader(rect);

                    },
                    child: Center(
                        child: clumsyTextLabelStylish(
                            "The Best way to predict your Future is to create it",
                            color: appColors["white"]!,
                            fontsize: fontSize
                        )
                    )
                ),
                // title: "Title of blue page",
                // bodyWidget: Center(child: clumsyTextLabel("Stay ahead with a plethora of information. Type of music, selection of seats, favourite artist, best offers available, Clumsy helps you in enhancing your game when it comes to knowing the party culture in your city.",color: appColors["grey"]!.shade500,fontsize: 22)),
                // body: "Welcome to the app! This is a description on a page with a blue background.",
                bodyWidget:clumsyTextBarookah("Let's Go!!",color: appColors["primary"]!,fontSize: 30),
                image: Center(
                  child: Image.asset(img,width: Get.width*0.4,),
                ),
                decoration: PageDecoration(
                  pageColor: appColors["background"]!,
                ),
              ),



              // PageViewModel(
              //   title: "Title of blue page",
              //   body: "Welcome to the app! This is a description on a page with a blue background.",
              //   image: Center(
              //     child: Image.asset(img, height: 275.0),
              //   ),
              //   decoration: const PageDecoration(
              //     pageColor: appColors["background"]!,
              //   ),
              // )
            ],
          ),
        ),
      )
    );
  }
}
