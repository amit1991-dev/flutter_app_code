import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/event.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import 'miscellaneous.dart';


class TicketItem extends StatefulWidget {
  late String ticketId;
  late String categoryId;
  late int index;
  TicketItem({required this.ticketId,required this.index,required this.categoryId,Key? key}) : super(key: key);

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HostController>().getTicket(widget.ticketId),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          CategoryTicket ticket = apiResponse.data as CategoryTicket;
          return Container(
            margin: EdgeInsets.all(18),
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: appColors["white"]!,
                // border: Border.all(color: appColors["grey"]!),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 // clumsyTextLabel("${widget.index}.",color: appColors["background"]!,fontsize: 22),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    clumsyTextLabel("Ticket",color: appColors["background"]!,fontsize: 10),
                    clumsyTextLabel(ticket.name,color: appColors["background"]!,fontsize: 15),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    clumsyTextLabel("Price(Rs)",color: appColors["background"]!,fontsize: 10),
                    clumsyTextLabel("${ticket.price}",color: appColors["background"]!,fontsize: 15),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    clumsyTextLabel("Supply",color: appColors["background"]!,fontsize: 10),
                    clumsyTextLabel("${ticket.supply==-1?"No Limit":ticket.supply}",color: appColors["background"]!,fontsize: 15),
                  ],
                ),


                // InkWell(
                //     onTap: () async {
                //
                //       await callDialog("Are you sure?", Row(
                //         children: [
                //           ClumsyFinalButton("No", Get.width*0.3, () {
                //             Get.back();
                //           }, false),
                //           ClumsyFinalButton("Yes", Get.width*0.3, () async {
                //             Get.back();
                //             await attemptDeleteTicket();
                //
                //             setState(() {
                //
                //             });
                //
                //           }, false)
                //         ],
                //       )
                //       );
                //     },
                //     child: const Icon(Icons.delete,color: Colors.red,)
                // )
              ],
            ),
          );
        }
        else
        {
          // showSnackbar("Error", apiResponse!.info!);
          print(apiResponse!.info!);
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // headerBar("All Phases",parent: false),
                  Text(ErrorMessages.SOMETHINGS_WRONG),

                  ClumsyFinalButton("Retry", Get.width*0.6, () {
                    setState(() {

                    });
                  }, false)
                  // Text(error.toString()),
                ],
              )
          );
        }

      },
      error: (context, error, stackTrace) {
        return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Some error Occured"),
                Text(error.toString()),
              ],
            )
        );
      },
    );
  }

  Future<bool> attemptDeleteTicket() async {

    APIResponse res = await Get.find<HostController>().deleteTicket(widget.ticketId);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully deleted the ticket!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }

}
