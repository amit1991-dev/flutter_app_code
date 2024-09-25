import 'package:flutter/material.dart';

import '../../../data/model/event.dart';
import 'category_ticket.dart';
import '../../../data/constants/miscellaneous.dart';

class PhaseCategoryWidget extends StatefulWidget {
  // late final String phaseId;
  late PhaseCategory category;
  // List<PhaseCategory> categories;
  PhaseCategoryWidget({required this.category});

  @override
  State<PhaseCategoryWidget> createState() => _PhaseCategoryWidgetState();
}

class _PhaseCategoryWidgetState extends State<PhaseCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ...List.generate(widget.category.tickets.length, (index) {
            return CategoryTicketWidget(ticket:widget.category.tickets[index]);
          }),
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
