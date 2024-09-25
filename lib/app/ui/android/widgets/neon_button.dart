import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/constants/miscellaneous.dart';

class NeonButton extends StatefulWidget {
  late String text;
   late Color c;
   double? fontSize=30;
   late Function onPressed=(){};
   NeonButton({Key? key,required String this.text,required Color this.c,required this.onPressed,this.fontSize}) : super(key: key);

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
   bool isPressed= false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        onPointerDown: (_) => setState(() {
          print("cpatured");
          isPressed=true;
        }),
        onPointerUp: (_) => setState(() {
          this.widget.onPressed();
          isPressed=false;
        }),
        child: Container(
          margin: EdgeInsets.all(20),
          // width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              for(double i=1;i< (isPressed?7:5);i++)
                BoxShadow(spreadRadius: 2, color:widget.c,blurRadius:i*2,blurStyle: BlurStyle.outer ),

              // for(double i=1;i< (isPressed?5:3);i++)
              //   BoxShadow(spreadRadius: -2, color:widget.c,blurRadius:i*3,blurStyle: BlurStyle.normal)
            ]
          ),
          child: TextButton(
            onPressed: (){},

            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              side: BorderSide(color:appColors["grey"]!,width: 1,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(this.widget.text.toUpperCase(),
                style: GoogleFonts.ubuntu(
                  fontSize: this.widget.fontSize,
                  color:appColors["white"]!,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    for(double i=1;i< (isPressed?5:3);i++)
                      Shadow(color:widget.c,blurRadius: i*10)
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}