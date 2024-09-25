import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/ui/android/home/event_type_events.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/booking.dart';
import '../../../routes/app_pages.dart';
import 'miscellaneous.dart';

class BookingItem extends StatefulWidget {
  late Booking booking;
  BookingItem({required this.booking,Key? key}) : super(key: key);

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  // TextEditingController categoryController = TextEditingController();
  bool bookingWait = false;
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: clientBookingListTile(widget.booking.event,widget.booking.id,showBook: false),
          );
  }

}