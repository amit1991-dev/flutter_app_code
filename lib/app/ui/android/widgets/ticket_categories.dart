import 'package:async_builder/async_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:getx/app/ui/android/widgets/phase_item.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../routes/app_pages.dart';
import 'event_phase.dart';

class TicketCategories extends StatefulWidget {
  final Event event;
  const TicketCategories({super.key, required this.event });

  @override
  State<TicketCategories> createState() => _TicketCategoriesState();
}

class _TicketCategoriesState extends State<TicketCategories> {

  @override
  Widget build(BuildContext context) {
    EventPhase phase = widget.event.currentPhase!;
    List<PhaseCategory> categories = phase.categories;
      return Column(
      children: [
        Center(
          child: clumsyTextLabel("Ticket Categories",color: appColors["primary"]!),
        ),
        if(categories.isNotEmpty)
        ...List.generate(categories.length, (index){
          return CategoryItem(event: widget.event,category:categories[index],index: (index+1),);
        }),
        if(categories.isEmpty)
          const Text("Seems like that the tickets shall be available soon for booking!!"),
      ],
    );

  }

  // Future<bool> attemptCreatePhase(String text) async {
  //   Map<String,dynamic> eventJson = {};
  //   if(text.isEmpty)
  //   {
  //     showSnackbar("Error", "Please enter a NAME for the event");
  //     return false;
  //   }
  //   eventJson['name'] = text;
  //   // eventJson['event_id'] = widget.eventId;
  //
  //   APIResponse res = await Get.find<HostController>().createPhase(eventJson,widget.eventId);
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //     showSnackbar(TextMessages.SUCCESS,"Successfully created the Phase!");
  //     return true;
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     return false;
  //   }
  //   if (kDebugMode) {
  //     print("finished creating the the phase");
  //   }
  //
  // }
}

class CategoryItem extends StatefulWidget {
  final PhaseCategory category;
  final Event event;
  final int index;
  const CategoryItem({required this.event,required this.category,required this.index,Key? key}) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    var tickets = widget.category.tickets;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider(color: appColors["white"]!,),
          if(tickets.isNotEmpty) Center(child: clumsyTextLabel("#${widget.index} ${widget.category.name}",fontsize: 20)),
          if(tickets.isNotEmpty)
            ...List.generate(tickets.length, (index) =>
              TicketItem(event:widget.event,ticket:tickets[index])
            )
        ],
      ),
    );
  }
}


class TicketItem extends StatefulWidget {
  final CategoryTicket ticket;
  final Event event;
  const TicketItem({required this.event,required this.ticket,Key? key}) : super(key: key);

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: widget.ticket.totalAvailable>0?appColors["primary"]!:appColors["grey"]!,
            borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  clumsyTextLabel(widget.ticket.name.toUpperCase(),color: appColors["background"]!,fontsize: 15),
                  clumsyTextLabel("#Available:${widget.ticket.totalAvailable}",color: appColors["background"]!,fontsize: 10),
                ],
              ),

              clumsyTextLabel("Rs. ${widget.ticket.price}",color: appColors["background"]!,fontsize: 15),
            ],
          ),
          Divider(color: appColors["background"]!,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  Get.find<HomeController>().decrementCart(widget.ticket.id, widget.event);
                },
                color: appColors["background"]!,
                textColor: appColors["primary"]!,
                child: Column(
                  children: [
                    Icon(
                      Icons.remove_circle_outline,
                      size: 24,
                    ),
                    // clumsyTextLabel("ADD",fontsize: 10,color: appColors["background"]!)
                  ],
                ),
                padding: EdgeInsets.all(6),
                shape: CircleBorder(),
              ),
              GetBuilder<HomeController>(builder: ( controller){
                return Text("${controller.cartGetQuantity(widget.ticket.id, widget.event)} Tickets",style: TextStyle(fontSize: 20,color: appColors["background"]!),);
              }, ),
              MaterialButton(
                onPressed: () {
                  Get.find<HomeController>().incrementCart(widget.ticket, widget.event,widget.ticket.totalAvailable);
                },
                color: appColors["background"]!,
                textColor: appColors["primary"]!,
                child: Column(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 24,
                    ),
                    // clumsyTextLabel("REM",fontsize: 10,color: appColors["background"]!)
                  ],
                ),
                padding: EdgeInsets.all(6),
                shape: CircleBorder(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
