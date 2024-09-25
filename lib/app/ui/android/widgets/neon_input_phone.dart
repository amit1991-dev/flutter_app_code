import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonPhoneInput extends StatefulWidget {
  // late String text;
   late Color c;

  NeonPhoneInput({Key? key,required Color this.c}) : super(key: key);

  @override
  State<NeonPhoneInput> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonPhoneInput> {
   bool isPressed= false;

  @override
  Widget build(BuildContext context) {
    // return Text("LOGIN",
    //   style: GoogleFonts.ubuntu(
    //       fontSize: 30,
    //       color:appColors["white"]!,
    //       shadows: [
    //         for(double i=1;i< (isPressed?7:5);i++)
    //           Shadow(color:widget.c,blurRadius: i*2)
    //       ]
    //   ),
    // );
    // print(this.widget.text);
    return Center(
      child: Listener(
        onPointerDown: (_) => setState(() {
          print("cpatured");
          isPressed=true;
        }),
        onPointerUp: (_) => setState(() {
          // this.widget.onPressed();
          isPressed=false;
        }),
        child: Container(
          margin: EdgeInsets.all(20),
          // width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // for(double i=1;i< (isPressed?5:3);i++)
              //   BoxShadow(spreadRadius: 2, color:widget.c,blurRadius:i*2,blurStyle: BlurStyle.outer ),

              // for(double i=1;i< (isPressed?5:3);i++)
              //   BoxShadow(spreadRadius: 0, color:widget.c,blurRadius:i,blurStyle: BlurStyle.inner )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                  counter: Offstage(),
                  labelText: 'Phone Number',
                  labelStyle: GoogleFonts.ubuntu(),
                  border: InputBorder.none
              ),

              initialCountryCode: 'IN',
              // countries: ["IN"],
              showDropdownIcon: true,
              style: GoogleFonts.acme(fontSize: 20),
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
}
