import 'package:flutter/material.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/event.dart';

class CategoryTicketWidget extends StatefulWidget {
  late CategoryTicket ticket;

  // late String id;
  // late String name;
  // late int price;
  CategoryTicketWidget({super.key, required this.ticket});

  @override
  State<CategoryTicketWidget> createState() => _CategoryTicketWidgetState();
}

class _CategoryTicketWidgetState extends State<CategoryTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: appColors["grey"]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
