import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/provider/api.dart';
import '../../../routes/app_pages.dart';
import '../widgets/miscellaneous.dart';


class OTPVerification extends StatefulWidget {
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> with TickerProviderStateMixin {
  late APIProvider ap;
  String otpCode="";
  bool resendWaiting = false;
  bool continueWaiting = false;
  bool hostWaiting = false;
  bool helperWaiting = false;
  late String verificationId,signature;
  OtpFieldController otpController = OtpFieldController();
  late OTPTextEditController controller;
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  _OTPVerificationState(){
    ap = APIProvider();
    Map<String,dynamic> pageData =  Get.arguments;
    verificationId = pageData['verification_id'] as String;
    signature = pageData['signature'] as String;
    if (kDebugMode) {
      print(signature);
      print(verificationId);
    }

  }

  @override
  void initState() {
    super.initState();
    Authentication authController = Get.find<Authentication>();
    if(authController.isLoggedIn.value)
    {
      showSnackbar("Welcome","Already Loggin in...");
      if(authController.user!.role == "user")
      {
        Get.offAndToNamed(Routes.HOME);
      }
      else if(authController.user!.role == "host")
      {
        Get.offAndToNamed(Routes.HOST_HOME);
      }
      else if(authController.user!.role == "helper")
      {
        Get.offAndToNamed(Routes.HELPER_HOME);
      }
      return;
    }
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,

      duration: Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: 0.41, end: 0.81).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 40, end: 80).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.bounceIn,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();

    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
    );
    controller.startListenUserConsent( (code) {
        print(code);
        final exp = RegExp(r'(\d{6})');
        String otp = exp.stringMatch(code ?? '') ?? '';
        otpController.set(otp.characters.toList());
        showSnackbar("OTP", otp);
        return otp;
      },
    );
  }

  @override
  void dispose() {
    print("disposing now");
    controller1.dispose();
    controller2.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<bool> attemptResendOtp() async{
    String verificationId = Get.arguments as String;
    // if(verificationId == null)
    //   {
    //
    //     Get.back();
    //     return false;
    //   }
    var response = await ap.resendOtp(verificationId);
    if(response.status == TextMessages.SUCCESS)
    {
      String verificationId = response.data as String;
      Get.toNamed(Routes.OTP_VERIFICATION,arguments: verificationId);
      return true;
    }
    else
    {
      showSnackbar("Error", response.info!);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:appColors["background"]!,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset("assets/images/logo_title.png",width: Get.width/2.5,),
                      // const Text("Clumsy",style: TextStyle(color: appColors["primary"]!,fontFamily: "Barokah",fontSize: 30),),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          // border: Border.all(color: appColors["white"]!),
                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  // color: appColors["white"]!
                                ),
                                child: OTPTextField(
                                    controller: otpController,
                                    length: 6,
                                    keyboardType: TextInputType.number,
                                    width: Get.width*0.8,
                                    textFieldAlignment: MainAxisAlignment.spaceAround,
                                    fieldWidth: 45,
                                    fieldStyle: FieldStyle.box,
                                    otpFieldStyle: OtpFieldStyle(borderColor: appColors["primary"]!,enabledBorderColor: appColors["primary"]!,disabledBorderColor: appColors["primary"]!,backgroundColor: appColors['grey']!),
                                    outlineBorderRadius: 15,
                                    style: TextStyle(fontSize: 17),
                                    onChanged: (pin) {
                                      print("Changed: " + pin);
                                    },
                                    onCompleted: (pin) {
                                      print("Completed: " + pin);
                                      otpCode = pin;
                                    }
                                    ),
                              ),
                              // OtpTextField(
                              //   // handleControllers: (List<TextEditingController?> controllers){
                              //   //
                              //   // },
                              //   // handleControllers: ,
                              //   cursorColor: appColors["primary"]!,
                              //   fillColor: appColors["primary"]!,
                              //   numberOfFields: 6,
                              //
                              //   borderColor: appColors["primary"]!,
                              //   textStyle: GoogleFonts.ubuntu(
                              //     fontSize: 15,
                              //     color: appColors["primary"]!
                              //   ),
                              //
                              //   //set to true to show as box or false to show as dash
                              //   showFieldAsBox: false,
                              //   //runs when a code is typed in
                              //   onCodeChanged: (String code) {
                              //     //handle validation or checks here
                              //   },
                              //   //runs when every textfield is filled
                              //   onSubmit: (String verificationCode){
                              //     otpCode = verificationCode;
                              //   }, // end onSubmit
                              // ),


                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(18.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Text("Didnt Receive Code?",style:GoogleFonts.ubuntu(fontSize: 15,color:appColors["primary"]!)),
                      //       // NeonButton(text: "Resend", c: appColors["background"]!, onPressed: (){},fontSize: 10,)
                      //       ClumsyRealButton( 'Resend',Get.width*0.3,() async {
                      //         HapticFeedback.lightImpact();
                      //         if(otpCode.length != 6)
                      //         {
                      //           showSnackbar("Error", "Please enter all the OTP Digits");
                      //           return;
                      //         }
                      //         setState(() {
                      //           resendWaiting = true;
                      //         });
                      //
                      //         APIResponse sent = await ap.resendOtp(verificationId);
                      //
                      //         if(sent.status == TextMessages.SUCCESS)
                      //           {
                      //             showSnackbar("Success","OTP Sent");
                      //           }
                      //         else{
                      //           showSnackbar("Success",sent.info!);
                      //         }
                      //         setState(() {
                      //           resendWaiting = true;
                      //         });
                      //         },resendWaiting ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClumsyRealButton("Continue", Get.width*0.8, () async {
                                HapticFeedback.lightImpact();
                                if(otpCode.length != 6)
                                {
                                  showSnackbar("Error", "Please enter all the OTP Digits");
                                  return;
                                }
                                setState(() {
                                  continueWaiting = true;
                                });
                                APIResponse sent = await ap.verifyOTP(otpCode,verificationId,"user");

                                if(sent.status == TextMessages.SUCCESS)
                                {
                                  showSnackbar("Welcome","OTP Verified");
                                  // Get.offAllNamed(Routes.HOME);
                                  Get.offAllNamed(Routes.ONBOARDING,arguments: "user");
                                }
                                else{
                                  showSnackbar("Error",sent.info!);
                                }
                                setState(() {
                                  continueWaiting = false;
                                });
                              },continueWaiting),
                            ),
                            // Divider(),
                            // Text("-----OR-----",style:GoogleFonts.ubuntu(fontSize: 20,color:appColors["primary"]!)),
                            //
                            // Padding(padding: EdgeInsets.all(20),child:
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     ClumsyFinalButton( 'As Host',Get.width*0.4,() async {
                            //       HapticFeedback.lightImpact();
                            //       setState(() {
                            //         hostWaiting = true;
                            //       });
                            //       APIResponse sent = await ap.verifyOTP(otpCode,verificationId,"host");
                            //
                            //       if(sent.status == TextMessages.SUCCESS)
                            //       {
                            //         showSnackbar("Success","OTP Verified");
                            //
                            //         Get.offAllNamed(Routes.HOST_HOME,arguments: "host");
                            //       }
                            //       else{
                            //         showSnackbar("Error",sent.info!);
                            //       }
                            //       setState(() {
                            //         hostWaiting = false;
                            //       });
                            //     },hostWaiting ),
                            //     ClumsyFinalButton( 'As Helper',Get.width*0.4,() async {
                            //       HapticFeedback.lightImpact();
                            //       if(otpCode.length != 6)
                            //       {
                            //         showSnackbar("Error", "Please enter all the OTP Digits");
                            //         return;
                            //       }
                            //       setState(() {
                            //         helperWaiting = true;
                            //       });
                            //       APIResponse sent = await ap.verifyOTP(otpCode,verificationId,"helper");
                            //
                            //       if(sent.status == TextMessages.SUCCESS)
                            //       {
                            //         showSnackbar("Success","OTP Verified");
                            //         Get.offAllNamed(Routes.HELPER_HOME,arguments: "helper");
                            //         // Get.offAllNamed(Routes.HELPER_HOME);
                            //       }
                            //       else{
                            //         showSnackbar("Error",sent.info!);
                            //       }
                            //       setState(() {
                            //         helperWaiting = false;
                            //       });
                            //     },helperWaiting ),
                            //   ],
                            // )),

                            SizedBox(height: Get.height * .05),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 30,
          sigmaX: 30,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: appColors["white"]!.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            style: TextStyle(color: appColors["white"]!.withOpacity(.8)),
            cursorColor: appColors["white"]!,
            obscureText: isPassword,
            keyboardType:isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: appColors["white"]!.withOpacity(.2),
              ),
              // border: InputBorder(borderSide: BorderSide.),
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: appColors["white"]!.withOpacity(0.7)),
            ),
          ),
        ),
      ),
    );
  }

  Widget componentPhoneInput(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 30,
          sigmaX: 30,
        ),
        child: Container(
          // height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: appColors["white"]!.withOpacity(0.2),
            // borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                  counter: Offstage(),
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.ubuntu(),
                  border: InputBorder.none
              ),

              initialCountryCode: 'IN',
              // countries: const [Country(name: 'India', code: 'IN', dialCode: '+91', flag: 'in', nameTranslations: {}, minLength: 0, maxLength: 2)], // Explicitly list only India
              
              showDropdownIcon: true,
              style: GoogleFonts.ubuntu(fontSize: 20),
              dropdownIconPosition:IconPosition.trailing,
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
          ),
        ),
      ),
    );
  }


  Widget component2(String string, VoidCallback voidCallback,bool showProgress) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
          child: InkWell(

            // highlightColor: appColors["primary"]!,
            focusColor: appColors["primary"]!,
            splashColor: appColors["primary"]!,

            onTap: showProgress?(){showSnackbar("Progress", "Request is being processed");}:voidCallback,
            child: Container(
              // height: Get.width / 8,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColors["white"]!.withOpacity(.05),
                // borderRadius: BorderRadius.circular(15),
              ),
              child: showProgress?CircularProgressIndicator():Text(string,style: GoogleFonts.acme(fontSize: 15),),
            ),
          ),
        ),
      ),
    );
  }
}

Widget component3(String string, double width, VoidCallback voidCallback) {
  // Size size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.all(5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        child: InkWell(

          highlightColor: Colors.purple,
          focusColor: appColors["white"]!,
          splashColor: Colors.cyan,
          onTap: voidCallback,
          child: Container(
            height: Get.width / 12,
            width: Get.width*0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColors["white"]!.withOpacity(.1),
              // borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: GoogleFonts.ubuntu(
                  fontSize: 15
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget component4(Widget w, VoidCallback voidCallback) {
  // Size size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.all(5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        child: InkWell(

          highlightColor: Colors.purple,
          focusColor: appColors["white"]!,
          splashColor: Colors.cyan,
          onTap: voidCallback,
          child: Container(
            // height: Get.width / 12,
            // width: Get.width*0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColors["white"]!.withOpacity(.1),
              // borderRadius: BorderRadius.circular(15),
            ),
            child:w

          ),
        ),
      ),
    ),
  );
}
class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = RadialGradient(colors: [appColors["primary"]!!,appColors["background"]!!],).createShader(
        Rect.fromCircle(
          center: Offset(0, 0),
          radius: radius,
        ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 4),
          () => 'Your code is 54321',
    );
  }
}