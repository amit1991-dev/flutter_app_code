import 'package:flutter/material.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/event.dart';
import 'phase_category.dart';

class EventPhaseWidget extends StatefulWidget {
  late final String phaseId;
  late EventPhase phase;
  // List<PhaseCategory> categories;
  EventPhaseWidget({super.key, required this.phase});

  @override
  State<EventPhaseWidget> createState() => _EventPhaseWidgetState();
}

class _EventPhaseWidgetState extends State<EventPhaseWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(widget.phase.categories.length, (index) {
            return PhaseCategoryWidget(category:widget.phase.categories[index]);
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
