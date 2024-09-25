import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/event.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import 'miscellaneous.dart';


class HightlightItem extends StatefulWidget {
  late String highlight;
  HightlightItem({required this.highlight,Key? key}) : super(key: key);

  @override
  State<HightlightItem> createState() => _HightlightItemState();
}

class _HightlightItemState extends State<HightlightItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),

      decoration: BoxDecoration(
          // color: appColors["white"]!,
          // border: Border.all(color: appColors["grey"]!),
          borderRadius: BorderRadius.circular(20)
      ),
      child: clumsyTextLabel(widget.highlight,color: appColors["primary"]!),
    );
  }
}


