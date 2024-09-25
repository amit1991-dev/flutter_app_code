import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/user_booking_list.dart';
import '../widgets/miscellaneous.dart';
import '../../../data/constants/miscellaneous.dart';

class BookingsPage extends StatefulWidget {
  BookingsPage({Key? key}):super(key: key){
  }
  @override
  State<BookingsPage> createState() => _State();
}

class _State extends State<BookingsPage> {
  late String UserId;
  _State(){
    print("building");
    UserId = Get.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColors["background"]!,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              headerBar("Bookings",parent: true),
              Expanded(child: UserBookingList()),
            ],
          ),
        )
      ),
    );

  }
}

